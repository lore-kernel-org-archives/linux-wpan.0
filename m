Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36342 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbaJJTl0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Oct 2014 15:41:26 -0400
Date: Fri, 10 Oct 2014 21:41:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v5 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141010194116.GA31843@omega>
References: <1412840794-17283-1-git-send-email-martin.townsend@xsilon.com>
 <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>, werner@almesberger.net

Hi Martin,

I reconsider these steps which we do here now and saw some new
improvements/issues.

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

What we here try to do is a usual sk_buff principle.

There exist a function skb_cow [0]:

<qoute>
static inline int __skb_cow(struct sk_buff *skb, unsigned int headroom,
                            int cloned)
{
        int delta = 0;

        if (headroom > skb_headroom(skb))
                delta = headroom - skb_headroom(skb);

        if (delta || cloned)
                return pskb_expand_head(skb, ALIGN(delta, NET_SKB_PAD), 0,
                                        GFP_ATOMIC);
        return 0;
}
</qoute>

This is the wrapper call which is called by skb_cow. I see here much
similarity and also more performance. It calculates a delta size and do
also a NET_SKB_PAD which is a align to the cache_lines and I think they
try do some "false sharing" here. [1]

We should use this function, if you agree here.



There exist also some skb_cow_head function [2].

code commentar:
<qoute>
It should be used when you only need to push on some header and do not
need to modify the data.
</qoute>

I am not sure about if we can use skb_cow_head here, because we modify
the data. I mean we run skb_pull and then skb_cow_head and run skb_push
with different data buffer. (IPv6 header).

Currently I am not sure if this works.

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
>  		switch (skb->data[0] & 0xe0) {
>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
>  			local_skb = skb_clone(skb, GFP_ATOMIC);


Now we come to this function.

There exist two global rules here:

1.

If we change only the skb pointers head/tail with e.g. skb_push then we
need a cloned skb only. We don't change the skb data buffer here.

We need this in LOWPAN_DISPATCH_IPV6, here we run only one skb_pull for
one byte, and the FRAGN and FRAG1 dispatches in 802.15.4 6LoWPAN.

skb_share_check do this, we have surely a clone afterwards and the
sk_buff attributes are not changed elsewhere, which means we are
allowed to manipulate the skb attributes.

2.

If we touch the data buffer, then we need a skb_copy. We need this at
LOWPAN_DISPATCH_IPHC because here we replacing the data buffer.

skb_unshare do this for us.

If we can use skb_cow_head like above, I think then we don't need a
skb_unshare here. But I am not 100% sure if we really can use
skb_cow_head here. We don't need skb_unshare then because, skb_cow_head
makes the head writeable only, this should something similar like a
private copy of headroom then.


Summary:

We need always a skb_share_check at begin of evaluate the dispatch, for
the LOWPAN_DISPATCH_IPHC we need a skb_unshare before. That's fine for
now, maybe later we can do some tricks with skb_cow_head.

skb_share_check:

We always have a cloned skb and we can manipulate sk_buff attributes.

skb_unshare:

We have a private copy of data buffer and can replace 6LoWPAN header
with IPv6 header.

Do you agree here?

- Alex

[0] http://lxr.free-electrons.com/source/include/linux/skbuff.h#L2316
[1] http://en.wikipedia.org/wiki/False_sharing
[2] http://lxr.free-electrons.com/source/include/linux/skbuff.h#L2331 

