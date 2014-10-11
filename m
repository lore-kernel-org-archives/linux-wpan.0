Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63239 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbaJKHg3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Oct 2014 03:36:29 -0400
Date: Sat, 11 Oct 2014 09:36:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v5 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141011073620.GA28500@omega>
References: <1412840794-17283-1-git-send-email-martin.townsend@xsilon.com>
 <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

This is only a summarize what we should now to try to do here for next
version.

I know... this patch ends in a global debate on principles how we deal
with the replacement of 6LoWPAN -> IPv6 header. Current behaviour is
more a hack.

On Thu, Oct 09, 2014 at 08:46:34AM +0100, Martin Townsend wrote:
> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> pskb_expand_head.  It also checks to see if there is enough headroom
> first to ensure it's only done if necessary.
> As pskb_expand_head must only have one reference the calling code
> now ensures this.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  net/6lowpan/iphc.c      | 51 ++++++++++++++++++++++++-------------------------
>  net/bluetooth/6lowpan.c |  7 +++++++
>  2 files changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 142eef5..853b4b8 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -174,30 +174,22 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
>  static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>  		       struct net_device *dev, skb_delivery_cb deliver_skb)
>  {
> -	struct sk_buff *new;
>  	int stat;
>  
> -	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
> -			      GFP_ATOMIC);
> -	kfree_skb(skb);
> -
> -	if (!new)
> -		return -ENOMEM;
> -
> -	skb_push(new, sizeof(struct ipv6hdr));
> -	skb_reset_network_header(new);
> -	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
> +	skb_push(skb, sizeof(struct ipv6hdr));
> +	skb_reset_network_header(skb);
> +	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
>  
> -	new->protocol = htons(ETH_P_IPV6);
> -	new->pkt_type = PACKET_HOST;
> -	new->dev = dev;
> +	skb->protocol = htons(ETH_P_IPV6);
> +	skb->pkt_type = PACKET_HOST;
> +	skb->dev = dev;
>  
>  	raw_dump_table(__func__, "raw skb data dump before receiving",
> -		       new->data, new->len);
> +		       skb->data, skb->len);
>  
> -	stat = deliver_skb(new, dev);
> +	stat = deliver_skb(skb, dev);
>  
> -	kfree_skb(new);
> +	consume_skb(skb);
>  
>  	return stat;
>  }
> @@ -460,7 +452,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  	/* UDP data uncompression */
>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
>  		struct udphdr uh;
> -		struct sk_buff *new;
> +		const int needed = sizeof(struct udphdr) + sizeof(hdr);
>  
>  		if (uncompress_udp_header(skb, &uh))
>  			goto drop;
> @@ -468,14 +460,13 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  		/* replace the compressed UDP head by the uncompressed UDP
>  		 * header
>  		 */
> -		new = skb_copy_expand(skb, sizeof(struct udphdr),
> -				      skb_tailroom(skb), GFP_ATOMIC);
> -		kfree_skb(skb);
> -
> -		if (!new)
> -			return -ENOMEM;
> -
> -		skb = new;
> +		if (skb_headroom(skb) < needed) {
> +			err = pskb_expand_head(skb, needed, 0, GFP_ATOMIC);
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
> +				return err;
> +			}
> +		}

use skb_cow_head here.

>  
>  		skb_push(skb, sizeof(struct udphdr));
>  		skb_reset_transport_header(skb);
> @@ -485,6 +476,14 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  			       (u8 *)&uh, sizeof(uh));
>  
>  		hdr.nexthdr = UIP_PROTO_UDP;
> +	} else {
> +		if (skb_headroom(skb) < sizeof(hdr)) {
> +			err = pskb_expand_head(skb, sizeof(hdr), 0, GFP_ATOMIC);
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
> +				return err;
> +			}
> +		}

same here.

>  	}
>  
>  	hdr.payload_len = htons(skb->len);
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index c2e0d14..6643a7c 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -343,6 +343,13 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  		kfree_skb(local_skb);
>  		kfree_skb(skb);
>  	} else {
> +		/* Decompression may use pskb_expand_head so no shared skb's */
> +		skb = skb_share_check(skb, GFP_ATOMIC);
> +		if (!skb) {
> +			dev->stats.rx_dropped++;
> +			return NET_RX_DROP;
> +		}
> +

I see now that case LOWPAN_DISPATCH_IPHC: runs a "local_skb =
skb_clone(skb, GFP_ATOMIC);" and send the local_skb to process_data. So
is the share_check really needed? In my opinion there are several things
wrong.

What bluetooth should do here is:

Always run skb = skb_share_check(skb, GFP_ATOMIC); at first of this function.

In if (skb->data[0] == LOWPAN_DISPATCH_IPV6):

 - only run a skb_pull (doesn't change the data buffer, only skb attribute)
   for the one byte dispatch.
 - run other things like skb_reset_network_header, etc...

 -> Currently this works because we run a complete skb_copy_expand here.
    But this is not needed, we need a clone because we don't modify the
    data buffer.

 -> To Jukka: I don't see a skb_pull for the one byte dispatch value?
    What's happend here? Also IPv6 dispatch is part of rfc4944 and btle
    6LoWPAN is only realted to rfc6282 (IPHC). I think you don't need handling
    for this here.



In "case LOWPAN_DISPATCH_IPHC:" we should remove the skb_clone, because
this is already handled by "skb_share_check" then.

- Alex
