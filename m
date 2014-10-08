Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:64920 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbaJHHzI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 03:55:08 -0400
Date: Wed, 8 Oct 2014 09:55:00 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141008075458.GA32554@omega>
References: <1412753745-6469-1-git-send-email-martin.townsend@xsilon.com>
 <1412753745-6469-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412753745-6469-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Wed, Oct 08, 2014 at 08:35:45AM +0100, Martin Townsend wrote:
> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> pskb_expand_head.  It also checks to see if there is enough headroom
> first to ensure it's only done if necessary.
> As pskb_expand_head must only have one reference the calling code
> now ensures this.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  net/6lowpan/iphc.c            | 51 +++++++++++++++++++++----------------------
>  net/bluetooth/6lowpan.c       | 12 ++++++----
>  net/ieee802154/6lowpan_rtnl.c |  5 +++++
>  3 files changed, 38 insertions(+), 30 deletions(-)
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

Just a hint, don't do that in this patch or send a patch series.
I would in a future move:

skb_push(skb, sizeof(struct ipv6hdr));
skb_reset_network_header(skb);
skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));

into the end of iphc decompression, because we do the same thing for
transport header in iphc decompression.

> -	new->protocol = htons(ETH_P_IPV6);
> -	new->pkt_type = PACKET_HOST;
> -	new->dev = dev;
> +	skb->protocol = htons(ETH_P_IPV6);
> +	skb->pkt_type = PACKET_HOST;
> +	skb->dev = dev;

This we should leave here. Then bluetooth/802.15.4 can set different
things here.

...
>  	hdr.payload_len = htons(skb->len);
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index c2e0d14..bd85edf 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -343,13 +343,17 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  		kfree_skb(local_skb);
>  		kfree_skb(skb);
>  	} else {
> +		/* Decompression may use pskb_expand_head, ensure skb unique */
> +		skb = skb_unshare(skb, GFP_ATOMIC);
> +		if (!skb) {
> +			dev->stats.rx_dropped++;
> +			return NET_RX_DROP;
> +		}
> +

What I meant here in my previous review notes is that kfree_skb(skb);
was correct but in this case we can't do it, we need a temp variable.

skb = skb_unshare(skb, GFP_ATOMIC);

here we lost the skb reference from parameter if failed and I don't see
that skb_unshare free it on failing (maybe I am wrong here).

foo(any name for a tmp skb name, I see a lot of nskb names for a tmp skb
name. Maybe this is a usual name convention) = skb_unshare(skb, GFP_ATOMIC);

Then we don't lost the "skb" parameter reference and can free it with
kfree_skb(skb).

If all is fine we can run a skb = foo.

I think that skb_unshare and the buffer is NOT shared then (skb == foo),
but I am not sure about this. If it's NOT the same then we have some
memory leaking here.

- Alex
