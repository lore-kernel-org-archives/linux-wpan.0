Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53364 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaIKIcd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Sep 2014 04:32:33 -0400
Message-ID: <54115E14.8010005@xsilon.com>
Date: Thu, 11 Sep 2014 09:32:20 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH][linux-bluetooth 1/3] 6lowpan: skb freed locally from
 lowpan_rcv
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com> <1410357968-27051-3-git-send-email-martin.townsend@xsilon.com> <20140911075830.GA19178@omega>
In-Reply-To: <20140911075830.GA19178@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

Thanks for reviewing,  this patch is part of the solution with the next patch, please take this into consideration.  Sorry I should have put this in the cover letter.
The idea is to finally split skb delivery out of IPHC so the iphc decompress function(s) just return an error code at which point we can free skb and return from lowpan_rcv.  If IPHC is successful then skb delivery is done from receive function removing the need for all these mixed return codes.  I think this will make the code simpler, ... hopefully :)

- Martin. 

On 11/09/14 08:58, Alexander Aring wrote:
> Hi Martin,
>
> On Wed, Sep 10, 2014 at 03:06:06PM +0100, Martin Townsend wrote:
>> Currently there are a number of error paths in the lowpan_rcv function that
>> free the skb before returning, this patch simplifies the receive path by
>> ensuring that the skb is only freed from this function.
>>
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
>> ---
>>  include/net/6lowpan.h         |  2 +-
>>  net/6lowpan/iphc.c            | 27 +++++++++++++++------------
>>  net/bluetooth/6lowpan.c       | 12 ++++++++----
>>  net/ieee802154/6lowpan_rtnl.c | 12 ++++++------
>>  4 files changed, 30 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
>> index d184df1..883e7a2 100644
>> --- a/include/net/6lowpan.h
>> +++ b/include/net/6lowpan.h
>> @@ -374,7 +374,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>>  
>>  typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
>>  
>> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
>>  		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
>>  		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
>>  		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
>> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
>> index 142eef5..eca24bf 100644
>> --- a/net/6lowpan/iphc.c
>> +++ b/net/6lowpan/iphc.c
>> @@ -179,11 +179,11 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>>  
>>  	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
>>  			      GFP_ATOMIC);
>> -	kfree_skb(skb);
>> -
>>  	if (!new)
>>  		return -ENOMEM;
>>  
>> +	kfree_skb(skb);
>> +
>>  	skb_push(new, sizeof(struct ipv6hdr));
>>  	skb_reset_network_header(new);
>>  	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
>> @@ -196,6 +196,8 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>>  		       new->data, new->len);
>>  
>>  	stat = deliver_skb(new, dev);
>> +	if (stat < 0)
>> +		stat = NET_RX_DROP;
>>  
> We should be ensure that "lowpan_process_data" return an errno not
> NET_RX_DROP which is 1, so the usual check on error with if (err < 0)
> doesn't work here.
>
> Now the skb_deliver function returns the return value of skb_deliver and
> we should not returning NET_RX_DROP here.
>
> The deliver_skb variable is a callback, so please be sure that all existsing
> functionpointer make a conversion from NET_RX_DROP to errno (maybe -EIO).
> The thing is that netif_rx returns NET_RX_DROP and we should directly convert
> it to an errno after calling.
>
>>  	kfree_skb(new);
>>  
>> @@ -332,7 +334,7 @@ err:
>>  /* TTL uncompression values */
>>  static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
>>  
>> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
>>  			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
>>  			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
>>  			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
>> @@ -340,6 +342,8 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  	struct ipv6hdr hdr = {};
>>  	u8 tmp, num_context = 0;
>>  	int err;
>> +	int err_ret = -EINVAL;
> simple, use err here? No more variables to putting on the stack.
ok.
>
>> +	struct sk_buff *skb = *skb_inout;
>>  
>>  	raw_dump_table(__func__, "raw skb data dump uncompressed",
>>  		       skb->data, skb->len);
>> @@ -460,7 +464,6 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  	/* UDP data uncompression */
>>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
>>  		struct udphdr uh;
>> -		struct sk_buff *new;
>>  
>>  		if (uncompress_udp_header(skb, &uh))
>>  			goto drop;
>> @@ -468,14 +471,15 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  		/* replace the compressed UDP head by the uncompressed UDP
>>  		 * header
>>  		 */
>> -		new = skb_copy_expand(skb, sizeof(struct udphdr),
>> +		skb = skb_copy_expand(skb, sizeof(struct udphdr),
>>  				      skb_tailroom(skb), GFP_ATOMIC);
>> -		kfree_skb(skb);
>> -
>> -		if (!new)
>> -			return -ENOMEM;
>> +		if (!skb) {
>> +			err_ret = -ENOMEM;
>> +			goto drop;
>> +		}
>>  
>> -		skb = new;
>> +		kfree_skb(*skb_inout);
>> +		*skb_inout = skb;
>>  
>>  		skb_push(skb, sizeof(struct udphdr));
>>  		skb_reset_transport_header(skb);
>> @@ -502,8 +506,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  	return skb_deliver(skb, &hdr, dev, deliver_skb);
>>  
>>  drop:
>> -	kfree_skb(skb);
>> -	return -EINVAL;
>> +	return err_ret;
> return err; - when you remove the err_ret variable. Then we always
> return the right indicator for the error. Sometimes useful for
> debugging.
>
>>  }
>>  EXPORT_SYMBOL_GPL(lowpan_process_data);
>>  
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index 206b65c..f5f7ee0 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -215,7 +215,7 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
>>  	return ret;
>>  }
>>  
>> -static int process_data(struct sk_buff *skb, struct net_device *netdev,
>> +static int process_data(struct sk_buff **skb_inout, struct net_device *netdev,
>>  			struct l2cap_chan *chan)
>>  {
>>  	const u8 *saddr, *daddr;
>> @@ -223,6 +223,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
>>  	struct lowpan_dev *dev;
>>  	struct lowpan_peer *peer;
>>  	unsigned long flags;
>> +	struct sk_buff *skb = *skb_inout;
>>  
>>  	dev = lowpan_dev(netdev);
>>  
>> @@ -245,13 +246,12 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
>>  	if (lowpan_fetch_skb_u8(skb, &iphc1))
>>  		goto drop;
>>  
>> -	return lowpan_process_data(skb, netdev,
>> +	return lowpan_process_data(skb_inout, netdev,
>>  				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>>  				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>>  				   iphc0, iphc1, give_skb_to_upper);
>>  
>>  drop:
>> -	kfree_skb(skb);
>>  	return -EINVAL;
>>  }
>>  
>> @@ -300,7 +300,11 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>  			if (!local_skb)
>>  				goto drop;
>>  
>> -			ret = process_data(local_skb, dev, chan);
>> +			ret = process_data(&local_skb, dev, chan);
>> +			if (ret < 0) {
>> +				kfree_skb(local_skb);
>> +				goto drop;
>> +			}
>>  			if (ret != NET_RX_SUCCESS)
>>  				goto drop;
> remove checking on NET_RX_SUCCESS. Exactly at this place we should
> convert the errno again to the NET_RX_DROP, because we are in the packet
> layer receive function. You already did that in if (ret < 0), but ret !=
> NET_RX_SUCCESS should never occur then.
>
>>  
>> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
>> index 6591d27..fdb6c10 100644
>> --- a/net/ieee802154/6lowpan_rtnl.c
>> +++ b/net/ieee802154/6lowpan_rtnl.c
>> @@ -167,11 +167,12 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
>>  	return stat;
>>  }
>>  
>> -static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
>> +static int process_data(struct sk_buff **skb_inout, const struct ieee802154_hdr *hdr)
>>  {
>>  	u8 iphc0, iphc1;
>>  	struct ieee802154_addr_sa sa, da;
>>  	void *sap, *dap;
>> +	struct sk_buff *skb = *skb_inout;
>>  
>>  	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
>>  	/* at least two bytes will be used for the encoding */
>> @@ -197,13 +198,12 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
>>  	else
>>  		dap = &da.hwaddr;
>>  
>> -	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
>> +	return lowpan_process_data(skb_inout, skb->dev, sap, sa.addr_type,
>>  				   IEEE802154_ADDR_LEN, dap, da.addr_type,
>>  				   IEEE802154_ADDR_LEN, iphc0, iphc1,
>>  				   lowpan_give_skb_to_devices);
>>  
>>  drop:
>> -	kfree_skb(skb);
>>  	return -EINVAL;
>>  }
>>  
>> @@ -490,14 +490,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>>  	} else {
>>  		switch (skb->data[0] & 0xe0) {
>>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
>> -			ret = process_data(skb, &hdr);
>> +			ret = process_data(&skb, &hdr);
>>  			if (ret == NET_RX_DROP)
>>  				goto drop;
> the conversion from errno to NET_RX_DROP here.
>
> if (ret < 0)
>         goto drop;
>
>>  			break;
>>  		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
>>  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
>>  			if (ret == 1) {
>> -				ret = process_data(skb, &hdr);
>> +				ret = process_data(&skb, &hdr);
>>  				if (ret == NET_RX_DROP)
>>  					goto drop;
> same here.
>
>>  			}
>> @@ -505,7 +505,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>>  		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
>>  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
>>  			if (ret == 1) {
>> -				ret = process_data(skb, &hdr);
>> +				ret = process_data(&skb, &hdr);
>>  				if (ret == NET_RX_DROP)
>>  					goto drop;
> same here.
>
> Frag handling for freeing skb's on error is different here... which
> makes me lot of thinking currently. If we have a error in lowpan_frag_rcv,
> the return value is -1 but skb already freed. We should return NET_RX_DROP
> here. Need to think about that..., for now also check on else if (ret == -1)
> and start conversion to NET_RX_DROP. Please make this as an new patch
> after that. Also send it to bluetooth (simple because it's a bug and depends
> on this then).
>
> - Alex

