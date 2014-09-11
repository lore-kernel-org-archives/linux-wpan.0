Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47551 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbaIKIx6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Sep 2014 04:53:58 -0400
Date: Thu, 11 Sep 2014 10:53:54 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH][linux-bluetooth 3/3] 6lowpan: Refactored lowpan_rcv so
 it's RFC compliant
Message-ID: <20140911085353.GB19675@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
 <1410357968-27051-5-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410357968-27051-5-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Wed, Sep 10, 2014 at 03:06:08PM +0100, Martin Townsend wrote:
> Currently we support uncompressed IPv6 headers after performing fragmentation.
> 

This patch is for wpan-next.

> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  include/net/6lowpan.h         | 17 ++++++++++++
>  net/ieee802154/6lowpan_rtnl.c | 63 +++++++++++++++++++++++--------------------
>  2 files changed, 51 insertions(+), 29 deletions(-)
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index d71c062..71b1bf0 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -126,11 +126,28 @@
>  	 (((a)[6]) == 0xFF) &&	\
>  	 (((a)[7]) == 0xFF))
>  
> +#define lowpan_dispatch_is_nalp(a)	\
> +	(((a) & LOWPAN_DISPATCH_MAJOR) == 0x00)
> +
> +#define lowpan_dispatch_is_mesh(a)	\
> +	(((a) & LOWPAN_DISPATCH_MAJOR) == 0x80)
> +

don't use the MINOR MAJOR thing here, I can't see that this follow any
structure at RFC4944.

Simple add more mask and values like:

#define lowpan_dispatch_is_mesh(a)	\
	(((a) & LOWPAN_DISPATCH_MESH_MASK) == LOWPAN_DISPATCH_MESH)

Please see the note below that we don't put this stuff into genetic 6lowpan.

> +#define lowpan_dispatch_is_broadcast(a)	\
> +	((a) == LOWPAN_DISPATCH_BCAST)
> +
> +#define lowpan_dispatch_is_frag(a)	\
> +	(((a) & LOWPAN_DISPATCH_MASK) == LOWPAN_DISPATCH_FRAG1 || \
> +	 ((a) & LOWPAN_DISPATCH_MASK) == LOWPAN_DISPATCH_FRAGN)
> +
> +#define LOWPAN_DISPATCH_MAJOR	0xc0
> +#define LOWPAN_DISPATCH_MINOR	0x3f
> +
>  #define LOWPAN_DISPATCH_IPV6	0x41 /* 01000001 = 65 */
>  #define LOWPAN_DISPATCH_HC1	0x42 /* 01000010 = 66 */
>  #define LOWPAN_DISPATCH_IPHC	0x60 /* 011xxxxx = ... */
>  #define LOWPAN_DISPATCH_FRAG1	0xc0 /* 11000xxx */
>  #define LOWPAN_DISPATCH_FRAGN	0xe0 /* 11100xxx */
> +#define LOWPAN_DISPATCH_BCAST	0x50 /* 01010000 */
>  

hehe... yea another big issue is also that much stoff from ieee802154
foo is inside the include/net/6lowpan header. We should not make this
problem bigger. Only IPHC stuff there, which is used by bluetooth and
802154.

For ieee802154 6lowpan, we don't need a global header file.

Simple create one "net/ieee802154/6lowpan_i.h" - underscore means that's
internal header. These defines are only related to 802.15.4, e.g.
fragmentation on bluetooth is done at some mac mechanism (L2CAP, or
something else, that's what 6lowpan bluetooth draft says). So 6lowpan
fragmentation have nothing to do with bluetooth 6lowpan.

>  #define LOWPAN_DISPATCH_MASK	0xf8 /* 11111000 */
>  
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 4f4b02d..1557ece 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -477,41 +477,46 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
>  		goto drop_skb;
>  
> -	/* check that it's our buffer */
> +	/* First off if frame is Not A LoWPAN Packet (NALP) then chuck away */
> +	if (lowpan_dispatch_is_nalp(skb->data[0]))
> +		goto drop_skb;
> +
> +	/* The 6LoWPAN header stack comprimises of the following (in order)
> +	 *   Mesh
> +	 *   Broadcast
> +	 *   Fragmentation
> +	 */
> +	if (lowpan_dispatch_is_mesh(skb->data[0]))

better is:

lowpan_dispatch_is_mesh(*skb_network_header(skb))

the network_header should be pointed to the beginng of 6LoWPAN header.

> +		/* Not supported */
> +		goto drop_skb;
> +
> +	if (lowpan_dispatch_is_broadcast(skb->data[0]))
> +		/* Not supported */
> +		goto drop_skb;
> +
> +	if (lowpan_dispatch_is_frag(skb->data[0])) {
> +		u8 frag_dispatch = skb->data[0] & 0xe0;
> +
> +		ret = lowpan_frag_rcv(skb, frag_dispatch);
> +		if (ret != 1) {
> +			/* more frags to process */
> +			return NET_RX_SUCCESS;
> +		}
> +	}

I know this issue and we should not do that in this way.

Why?

Because this works only for fragmentation with IPHC, for example if we
support mesh or Broadcast or HC1 compression. We should call after
successfully reassembled "means lowpan_frag_rcv returns 1" the lowpan_rcv again.
So this is a recursion and we don't should use recursion to much, but it
should only be one recursion, so I think that's okay. :-)

After successfully reassemble we simple evaluate the DISPATCH value
again, this is also more a bug (because we don't handle LOWPAN_DISPATCH_IPV6
with fragmentation, and this can happen... We already talk about the
issue "don't use IPHC if compressed header size don't fit in a single
frame" and this is handled if we simple calll lowpan_frag_rcv again
after successful reassembling. But I don't will take this as bugfix,
because new support of handling xy, so wpan-next should be okay.

Please separate also this from the "introduce new handling of dispatch
values".

> +
> +	/* We should now have an IPv6 Header (Compressed or Uncompressed) */
>  	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
> -		/* Pull off the 1-byte of 6lowpan header. */
> +		/* Uncompressed, Pull off the dispatch byte */
>  		skb_pull(skb, 1);
> -
> -		ret = NET_RX_SUCCESS;
>  	} else {
> -		switch (skb->data[0] & 0xe0) {
> -		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> +		if ((skb->data[0] & 0xe0) == LOWPAN_DISPATCH_IPHC) {
> +			/* Compressed with IPHC - RFC 6282 */
>  			ret = iphc_uncompress_hdr(&skb, &hdr);
>  			if (ret < 0)
>  				goto drop;
> -			break;
> -		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
> -			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
> -			if (ret == 1) {
> -				ret = iphc_uncompress_hdr(&skb, &hdr);
> -				if (ret < 0)
> -					goto drop;
> -			} else {
> -				return NET_RX_SUCCESS;
> -			}
> -			break;
> -		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
> -			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
> -			if (ret == 1) {
> -				ret = iphc_uncompress_hdr(&skb, &hdr);
> -				if (ret < 0)
> -					goto drop;
> -			} else {
> -				return NET_RX_SUCCESS;
> -			}
> -			break;
> -		default:
> -			break;
> +		} else {
> +			/* TODO: other compression formats to follow */

don't know why we check at first for some types which we don't support
and drop it and then we have this here and drop also unknown types.

I would like it to check on all RFC4944 types here. And then we know
here that it was some invalid frame.

- Alex
