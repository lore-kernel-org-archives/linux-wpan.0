Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56490 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbaJGPh3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 11:37:29 -0400
Message-ID: <543408B2.1070309@xsilon.com>
Date: Tue, 07 Oct 2014 16:37:22 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com> <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com

I should also mention this has only been compile tested as I currently don't have a way of testing it easily.  So I would appreciate any testing on real HW.

 Jukka, I would be very interested to see if you see that locking error message you were seeing previously.

- Martin.


On 07/10/14 16:33, Martin Townsend wrote:
> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> pskb_expand_head.  It also checks to see if there is enough headroom
> first to ensure it's only done if necessary.
> As pskb_expand_head must only have one reference the calling code
> now ensures this.
>
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  net/6lowpan/iphc.c            | 53 ++++++++++++++++++++++---------------------
>  net/bluetooth/6lowpan.c       | 19 ++++++++++++----
>  net/ieee802154/6lowpan_rtnl.c | 13 +++++++++++
>  3 files changed, 55 insertions(+), 30 deletions(-)
>
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 142eef5..fa8f348 100644
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
> +	kfree_skb(skb);
>  
>  	return stat;
>  }
> @@ -460,7 +452,6 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  	/* UDP data uncompression */
>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
>  		struct udphdr uh;
> -		struct sk_buff *new;
>  
>  		if (uncompress_udp_header(skb, &uh))
>  			goto drop;
> @@ -468,14 +459,15 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
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
> +		if (skb_headroom(skb) < sizeof(struct udphdr) + sizeof(hdr)) {
> +			int n = sizeof(struct udphdr) + sizeof(hdr);
> +
> +			err = pskb_expand_head(skb, n, 0, GFP_ATOMIC);
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
> +				return err;
> +			}
> +		}
>  
>  		skb_push(skb, sizeof(struct udphdr));
>  		skb_reset_transport_header(skb);
> @@ -485,6 +477,15 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  			       (u8 *)&uh, sizeof(uh));
>  
>  		hdr.nexthdr = UIP_PROTO_UDP;
> +	} else {
> +		if (skb_headroom(skb) < sizeof(hdr)) {
> +			err = pskb_expand_head(skb, sizeof(hdr), 0, GFP_ATOMIC);
> +
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
> +				return err;
> +			}
> +		}
>  	}
>  
>  	hdr.payload_len = htons(skb->len);
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index c2e0d14..ab51e16 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -343,13 +343,24 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  		kfree_skb(local_skb);
>  		kfree_skb(skb);
>  	} else {
> +		/* Decompression may use pskb_expand_head, ensure skb unique */
> +		if (skb_cloned(skb)) {
> +			struct sk_buff *new;
> +			int new_headroom = sizeof(struct ipv6hdr) +
> +					   sizeof(struct udphdr);
> +
> +			new = skb_copy_expand(skb, new_headroom,
> +					      skb_tailroom(skb), GFP_ATOMIC);
> +			if (!new)
> +				goto drop;
> +			consume_skb(skb);
> +			skb = new;
> +		}
> +
>  		switch (skb->data[0] & 0xe0) {
>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> -			local_skb = skb_clone(skb, GFP_ATOMIC);
> -			if (!local_skb)
> -				goto drop;
>  
> -			ret = process_data(local_skb, dev, chan);
> +			ret = process_data(skb, dev, chan);
>  			if (ret != NET_RX_SUCCESS)
>  				goto drop;
>  
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index c7e07b8..2ccea84 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -537,6 +537,19 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  		if (ret == NET_RX_DROP)
>  			goto drop;
>  	} else {
> +		/* Decompression may use pskb_expand_head, ensure skb unique */
> +		if (skb_cloned(skb)) {
> +			struct sk_buff *new;
> +			int new_headroom = sizeof(struct ipv6hdr) +
> +					   sizeof(struct udphdr);
> +
> +			new = skb_copy_expand(skb, new_headroom,
> +					      skb_tailroom(skb), GFP_ATOMIC);
> +			if (!new)
> +				goto drop_skb;
> +			consume_skb(skb);
> +			skb = new;
> +		}
>  		switch (skb->data[0] & 0xe0) {
>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
>  			ret = process_data(skb, &hdr);

