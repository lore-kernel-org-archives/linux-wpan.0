Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62259 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbaIPLjP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 07:39:15 -0400
Message-ID: <5418215F.5050308@xsilon.com>
Date: Tue, 16 Sep 2014 12:39:11 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
References: <1410865319-16310-1-git-send-email-martin.townsend@xsilon.com> <1410865319-16310-2-git-send-email-martin.townsend@xsilon.com> <20140916113614.GC4969@omega>
In-Reply-To: <20140916113614.GC4969@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,
On 16/09/14 12:36, Alexander Aring wrote:
> On Tue, Sep 16, 2014 at 12:01:59PM +0100, Martin Townsend wrote:
>> Currently there are a number of error paths in the lowpan_rcv function that
>> free the skb before returning, the patch simplifies the receive path by
>> ensuring that the skb is only freed from this function.
>>
>> Passing the skb from 6lowpan up to the higher layers is not a
>> function of IPHC.  By moving it out of IPHC we also remove the
>> need to support error code returns with NET_RX codes.
>> It also makes the lowpan_rcv function more extendable as we
>> can support more compression schemes.
>>
>> With the above 2 lowpan_rcv is refacored so eliminate incorrect return values.
>>
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
>> ---
>>  include/net/6lowpan.h         |  9 +++--
>>  net/6lowpan/iphc.c            | 88 +++++++++++++++++--------------------------
>>  net/bluetooth/6lowpan.c       | 38 ++++++++++---------
>>  net/ieee802154/6lowpan_rtnl.c | 61 ++++++++++++++++--------------
>>  4 files changed, 94 insertions(+), 102 deletions(-)
>>
>> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
>> index d184df1..c28fadb 100644
>> --- a/include/net/6lowpan.h
>> +++ b/include/net/6lowpan.h
> ...
>> -static int process_data(struct sk_buff *skb, struct net_device *netdev,
>> -			struct l2cap_chan *chan)
>> +static struct sk_buff *
>> +process_data(struct sk_buff *skb, struct net_device *netdev,
>> +	     struct l2cap_chan *chan)
>>  {
>>  	const u8 *saddr, *daddr;
>>  	u8 iphc0, iphc1;
>> @@ -230,36 +231,31 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
>>  	peer = peer_lookup_chan(dev, chan);
>>  	read_unlock_irqrestore(&devices_lock, flags);
>>  	if (!peer)
>> -		goto drop;
>> +		return ERR_PTR(-EINVAL);
>>  
>>  	saddr = peer->eui64_addr;
>>  	daddr = dev->netdev->dev_addr;
>>  
>>  	/* at least two bytes will be used for the encoding */
>>  	if (skb->len < 2)
>> -		goto drop;
>> +		return ERR_PTR(-EINVAL);
>>  
>>  	if (lowpan_fetch_skb_u8(skb, &iphc0))
>> -		goto drop;
>> +		return ERR_PTR(-EINVAL);
>>  
>>  	if (lowpan_fetch_skb_u8(skb, &iphc1))
>> -		goto drop;
>> +		return ERR_PTR(-EINVAL);
>>  
>>  	return lowpan_process_data(skb, netdev,
>>  				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>>  				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>> -				   iphc0, iphc1, give_skb_to_upper);
>> -
>> -drop:
>> -	kfree_skb(skb);
>> -	return -EINVAL;
>> +				   iphc0, iphc1);
>>  }
>>  
>>  static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>  		    struct l2cap_chan *chan)
>>  {
>>  	struct sk_buff *local_skb;
>> -	int ret;
>>  
>>  	if (!netif_running(dev))
>>  		goto drop;
>> @@ -280,9 +276,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>  		local_skb->protocol = htons(ETH_P_IPV6);
>>  		local_skb->pkt_type = PACKET_HOST;
>>  
>> -		skb_reset_network_header(local_skb);
>> -		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
>> -
>>  		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
>>  			kfree_skb(local_skb);
>>  			goto drop;
>> @@ -300,9 +293,20 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>  			if (!local_skb)
>>  				goto drop;
>>  
>> -			ret = process_data(local_skb, dev, chan);
>> -			if (ret != NET_RX_SUCCESS)
>> +			skb = process_data(local_skb, dev, chan);
>> +			if (IS_ERR(skb)) {
>> +				kfree_skb(local_skb);
>>  				goto drop;
>> +			}
>> +
>> +			local_skb->protocol = htons(ETH_P_IPV6);
>> +			local_skb->pkt_type = PACKET_HOST;
> this is the wrong skb here, the new one is skb. I don't know maybe there
> is some optimization to call skb = process_data(skb, ...);
yes you are right, my mistake, I'll fix in next series.
>
>> +
>> +			if (give_skb_to_upper(local_skb, dev)
> also here local_skb should be skb, or?
>
> - Alex

- Martin.
