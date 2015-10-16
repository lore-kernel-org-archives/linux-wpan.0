Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6929 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbbJPMib (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 16 Oct 2015 08:38:31 -0400
Message-ID: <1444999102.3652.8.camel@linux.intel.com>
Subject: Re: [PATCH bluetooth-next 2/6] bluetooth: 6lowpan: use lowpan
 dispatch helpers
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Fri, 16 Oct 2015 15:38:22 +0300
In-Reply-To: <1444736579-27826-2-git-send-email-alex.aring@gmail.com>
References: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
	 <1444736579-27826-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org

Hi Alex,

the fixes in this patchset are fine and I verified with real hw that
everything works ok. The fix in this patch did not fix the skb poison
overwritten problem I am seeing and that needs more investigation.


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka



On ti, 2015-10-13 at 13:42 +0200, Alexander Aring wrote:
> This patch adds a check if the dataroom of skb contains a dispatch value
> by checking if skb->len != 0. This patch also change the dispatch
> evaluation by the recently introduced helpers for checking the common
> 6LoWPAN dispatch values for IPv6 and IPHC header.
> 
> There was also a forgotten else branch which should drop the packet if
> no matching dispatch is available.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> Jukka,
> 
> there seems something wrong or I don't get it. There is a skb_share_check but
> inside the lowpan_is_iphc branch there is a skb_clone again. From my
> understanding skb_share_check will check if the skb (structure) is used
> somewhere else by looking at some refcounts, if yes then clone it.
> 
> So after that the skb is always a clone, which means the skb (structure only)
> is not used somewhere else. Also IPHC will manipulate the skb (buffer) as well,
> so we need somewhere to be sure that the buffer isn't shared. There exists a
> function "skb_unshare" which is identically like skb_share_check just for the
> buffer.
> 
> It could be that you ensure that the buffer is not shared somewhere else. Anyway
> I think the solution with checking the "refcounts" is a very low cost operation.
> 
> btw:
> In case of IPv6 dispatch this is something else, because we move pointers there
> only (adjust skb->headroom with skb->data), not manipulate the buffer, so clone
> is enough there.
> 
>  net/bluetooth/6lowpan.c | 57 +++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index db73b8a..665bf38 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -314,15 +314,17 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  	if (!netif_running(dev))
>  		goto drop;
>  
> -	if (dev->type != ARPHRD_6LOWPAN)
> +	if (dev->type != ARPHRD_6LOWPAN || !skb->len)
>  		goto drop;
>  
> +	skb_reset_network_header(skb);
> +
>  	skb = skb_share_check(skb, GFP_ATOMIC);
>  	if (!skb)
>  		goto drop;
>  
>  	/* check that it's our buffer */
> -	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
> +	if (lowpan_is_ipv6(*skb_network_header(skb))) {
>  		/* Copy the packet so that the IPv6 header is
>  		 * properly aligned.
>  		 */
> @@ -334,7 +336,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  		local_skb->protocol = htons(ETH_P_IPV6);
>  		local_skb->pkt_type = PACKET_HOST;
>  
> -		skb_reset_network_header(local_skb);
>  		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
>  
>  		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
> @@ -347,38 +348,34 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  
>  		consume_skb(local_skb);
>  		consume_skb(skb);
> -	} else {
> -		switch (skb->data[0] & 0xe0) {
> -		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> -			local_skb = skb_clone(skb, GFP_ATOMIC);
> -			if (!local_skb)
> -				goto drop;
> +	} else if (lowpan_is_iphc(*skb_network_header(skb))) {
> +		local_skb = skb_clone(skb, GFP_ATOMIC);
> +		if (!local_skb)
> +			goto drop;
>  
> -			ret = iphc_decompress(local_skb, dev, chan);
> -			if (ret < 0) {
> -				kfree_skb(local_skb);
> -				goto drop;
> -			}
> +		ret = iphc_decompress(local_skb, dev, chan);
> +		if (ret < 0) {
> +			kfree_skb(local_skb);
> +			goto drop;
> +		}
>  
> -			local_skb->protocol = htons(ETH_P_IPV6);
> -			local_skb->pkt_type = PACKET_HOST;
> -			local_skb->dev = dev;
> +		local_skb->protocol = htons(ETH_P_IPV6);
> +		local_skb->pkt_type = PACKET_HOST;
> +		local_skb->dev = dev;
>  
> -			if (give_skb_to_upper(local_skb, dev)
> -					!= NET_RX_SUCCESS) {
> -				kfree_skb(local_skb);
> -				goto drop;
> -			}
> +		if (give_skb_to_upper(local_skb, dev)
> +				!= NET_RX_SUCCESS) {
> +			kfree_skb(local_skb);
> +			goto drop;
> +		}
>  
> -			dev->stats.rx_bytes += skb->len;
> -			dev->stats.rx_packets++;
> +		dev->stats.rx_bytes += skb->len;
> +		dev->stats.rx_packets++;
>  
> -			consume_skb(local_skb);
> -			consume_skb(skb);
> -			break;
> -		default:
> -			break;
> -		}
> +		consume_skb(local_skb);
> +		consume_skb(skb);
> +	} else {
> +		goto drop;
>  	}
>  
>  	return NET_RX_SUCCESS;


