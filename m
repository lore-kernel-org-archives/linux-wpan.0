Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61392 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbaJHH3h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 03:29:37 -0400
Message-ID: <5434E7DA.3000107@xsilon.com>
Date: Wed, 08 Oct 2014 08:29:30 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412711549-24653-1-git-send-email-martin.townsend@xsilon.com> <1412711549-24653-2-git-send-email-martin.townsend@xsilon.com> <20141007201442.GB12298@omega>
In-Reply-To: <20141007201442.GB12298@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Alex,

On 07/10/14 21:14, Alexander Aring wrote:
> Hi Martin,
>
> looks fine for me now only some little tiny hint which cames in v2.
>
> On Tue, Oct 07, 2014 at 08:52:29PM +0100, Martin Townsend wrote:
>> Currently there are potentially 2 skb_copy_expand calls in IPHC
>> decompression.  This patch replaces this with one call to
>> pskb_expand_head.  It also checks to see if there is enough headroom
>> first to ensure it's only done if necessary.
>> As pskb_expand_head must only have one reference the calling code
>> now ensures this.
>>
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
>> ---
>>  net/6lowpan/iphc.c            | 51 +++++++++++++++++++++----------------------
>>  net/bluetooth/6lowpan.c       | 13 +++++++----
>>  net/ieee802154/6lowpan_rtnl.c |  5 +++++
>>  3 files changed, 39 insertions(+), 30 deletions(-)
>>
>> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
>> index 142eef5..853b4b8 100644
>> --- a/net/6lowpan/iphc.c
>> +++ b/net/6lowpan/iphc.c
>> @@ -174,30 +174,22 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
>>  static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>>  		       struct net_device *dev, skb_delivery_cb deliver_skb)
>>  {
>> -	struct sk_buff *new;
>>  	int stat;
>>  
>> -	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
>> -			      GFP_ATOMIC);
>> -	kfree_skb(skb);
>> -
>> -	if (!new)
>> -		return -ENOMEM;
>> -
>> -	skb_push(new, sizeof(struct ipv6hdr));
>> -	skb_reset_network_header(new);
>> -	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
>> +	skb_push(skb, sizeof(struct ipv6hdr));
>> +	skb_reset_network_header(skb);
>> +	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
>>  
>> -	new->protocol = htons(ETH_P_IPV6);
>> -	new->pkt_type = PACKET_HOST;
>> -	new->dev = dev;
>> +	skb->protocol = htons(ETH_P_IPV6);
>> +	skb->pkt_type = PACKET_HOST;
>> +	skb->dev = dev;
>>  
>>  	raw_dump_table(__func__, "raw skb data dump before receiving",
>> -		       new->data, new->len);
>> +		       skb->data, skb->len);
>>  
>> -	stat = deliver_skb(new, dev);
>> +	stat = deliver_skb(skb, dev);
>>  
>> -	kfree_skb(new);
>> +	consume_skb(skb);
>>  
>>  	return stat;
>>  }
>> @@ -460,7 +452,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  	/* UDP data uncompression */
>>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
>>  		struct udphdr uh;
>> -		struct sk_buff *new;
>> +		const int needed = sizeof(struct udphdr) + sizeof(hdr);
>>  
>>  		if (uncompress_udp_header(skb, &uh))
>>  			goto drop;
>> @@ -468,14 +460,13 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  		/* replace the compressed UDP head by the uncompressed UDP
>>  		 * header
>>  		 */
>> -		new = skb_copy_expand(skb, sizeof(struct udphdr),
>> -				      skb_tailroom(skb), GFP_ATOMIC);
>> -		kfree_skb(skb);
>> -
>> -		if (!new)
>> -			return -ENOMEM;
>> -
>> -		skb = new;
>> +		if (skb_headroom(skb) < needed) {
>> +			err = pskb_expand_head(skb, needed, 0, GFP_ATOMIC);
>> +			if (unlikely(err)) {
>> +				kfree_skb(skb);
>> +				return err;
>> +			}
>> +		}
>>  
>>  		skb_push(skb, sizeof(struct udphdr));
>>  		skb_reset_transport_header(skb);
>> @@ -485,6 +476,14 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>  			       (u8 *)&uh, sizeof(uh));
>>  
>>  		hdr.nexthdr = UIP_PROTO_UDP;
>> +	} else {
>> +		if (skb_headroom(skb) < sizeof(hdr)) {
>> +			err = pskb_expand_head(skb, sizeof(hdr), 0, GFP_ATOMIC);
>> +			if (unlikely(err)) {
>> +				kfree_skb(skb);
>> +				return err;
>> +			}
>> +		}
>>  	}
>>  
>>  	hdr.payload_len = htons(skb->len);
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index c2e0d14..7714f4b 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -343,13 +343,18 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>  		kfree_skb(local_skb);
>>  		kfree_skb(skb);
>>  	} else {
>> +		/* Decompression may use pskb_expand_head, ensure skb unique */
>> +		skb = skb_unshare(skb, GFP_ATOMIC);
>> +		if (!skb) {
>> +			dev->stats.rx_dropped++;
>> +			kfree_skb(skb);
> skb is always NULL here. kfree_skb is null proofed. It's no-op.
Well spotted, will remove.
>
>> +			return NET_RX_DROP;
>> +		}
> wee need something like:
>
> foo = skb_unshare(skb, GFP_ATOMIC);
> if (!foo) {
> 	... do whatever you want to do like "dev->stats.rx_dropped++;"
> 	kfree_skb(skb);
> 	return NET_RX_DROP;
> }
> skb = foo;
>
>> +
>>  		switch (skb->data[0] & 0xe0) {
>>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
>> -			local_skb = skb_clone(skb, GFP_ATOMIC);
>> -			if (!local_skb)
>> -				goto drop;
>>  
>> -			ret = process_data(local_skb, dev, chan);
>> +			ret = process_data(skb, dev, chan);
>>  			if (ret != NET_RX_SUCCESS)
>>  				goto drop;
>>  
>> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
>> index c7e07b8..a87caa3 100644
>> --- a/net/ieee802154/6lowpan_rtnl.c
>> +++ b/net/ieee802154/6lowpan_rtnl.c
>> @@ -537,6 +537,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>>  		if (ret == NET_RX_DROP)
>>  			goto drop;
>>  	} else {
>> +		/* Decompression may use pskb_expand_head, ensure skb unique */
>> +		skb = skb_unshare(skb, GFP_ATOMIC);
>> +		if (!skb)
>> +			goto drop_skb;
>> +
v3 coming up.
> Same here. I know the surrounding code have similar issues... it's
> already on TODO list but if you like you can fix it.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
- Martin.
