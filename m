Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62132 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbaLAOew (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Dec 2014 09:34:52 -0500
Date: Mon, 1 Dec 2014 15:34:45 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/2] 6lowpan: add generic nhc layer
 interface
Message-ID: <20141201143441.GA996@omega>
References: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
 <1417295683-22682-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1417295683-22682-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

On Sat, Nov 29, 2014 at 10:14:42PM +0100, Alexander Aring wrote:
> This patch adds a generic next header compression layer interface. There
> exists various methods to do a header compression after 6LoWPAN header
> to save payload. This introduce a generic nhc header which allow a
> simple adding of a new header compression format instead of a static
> implementation inside the 6LoWPAN header compression and uncompression
> function.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: Martin Townsend <mtownsend1973@gmail.com>
> ---
>  net/6lowpan/Makefile |   2 +-
>  net/6lowpan/nhc.c    | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/6lowpan/nhc.h    | 130 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+), 1 deletion(-)
>  create mode 100644 net/6lowpan/nhc.c
>  create mode 100644 net/6lowpan/nhc.h
> 
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index 415886b..4215602 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_6LOWPAN) := 6lowpan.o
>  
> -6lowpan-y := iphc.o
> +6lowpan-y := iphc.o nhc.o
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> new file mode 100644
> index 0000000..f64b244
> --- /dev/null
> +++ b/net/6lowpan/nhc.c
> @@ -0,0 +1,175 @@
> +/*
> + *	6LoWPAN next header compression
> + *
> + *
> + *	Authors:
> + *	Alexander Aring		<aar@pengutronix.de>
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/netdevice.h>
> +
> +#include <net/ipv6.h>
> +
> +#include "nhc.h"
> +
> +static struct rb_root rb_root = RB_ROOT;
> +static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
> +
> +static int lowpan_nhc_insert(struct lowpan_nhc *nhc)
> +{
> +	struct rb_node **new = &rb_root.rb_node, *parent = NULL;
> +
> +	/* Figure out where to put new node */
> +	while (*new) {
> +		struct lowpan_nhc *this = container_of(*new, struct lowpan_nhc,
> +						       node);
> +		int result, len_dif, len;
> +
> +		len_dif = nhc->idlen - this->idlen;
> +
> +		if (nhc->idlen < this->idlen)
> +			len = nhc->idlen;
> +		else
> +			len = this->idlen;
> +
> +		result = memcmp(nhc->id, this->id, len);
> +		if (!result)
> +			result = len_dif;
> +
> +		parent = *new;
> +		if (result < 0)
> +			new = &((*new)->rb_left);
> +		else if (result > 0)
> +			new = &((*new)->rb_right);
> +		else
> +			return -EEXIST;
> +	}
> +
> +	/* Add new node and rebalance tree. */
> +	rb_link_node(&nhc->node, parent, new);
> +	rb_insert_color(&nhc->node, &rb_root);
> +
> +	return 0;
> +}
> +
> +static void lowpan_nhc_remove(struct lowpan_nhc *nhc)
> +{
> +	rb_erase(&nhc->node, &rb_root);
> +}
> +
> +struct lowpan_nhc *lowpan_nhc_by_nhcid(const struct sk_buff *skb)
> +{
> +	struct rb_node *node = rb_root.rb_node;
> +	const u8 *nhcid_skb_ptr = skb->data;
> +
> +	while (node) {
> +		struct lowpan_nhc *nhc = container_of(node, struct lowpan_nhc,
> +						      node);
> +		u8 nhcid_skb_ptr_masked[LOWPAN_NHC_MAX_ID_LEN];
> +		int result, i;
> +
> +		if (nhcid_skb_ptr + nhc->idlen > skb->data + skb->len)
> +			return NULL;
> +
> +		/* copy and mask afterwards the nhid value from skb */
> +		memcpy(nhcid_skb_ptr_masked, nhcid_skb_ptr, nhc->idlen);
> +		for (i = 0; i < nhc->idlen; i++)
> +			nhcid_skb_ptr_masked[i] &= nhc->idmask[i];
> +
> +		result = memcmp(nhcid_skb_ptr_masked, nhc->id, nhc->idlen);
> +		if (result < 0)
> +			node = node->rb_left;
> +		else if (result > 0)
> +			node = node->rb_right;
> +		else
> +			return nhc;
> +	}
> +
> +	return NULL;
> +}
> +
> +struct lowpan_nhc *lowpan_nhc_by_nexthdr(u8 nexthdr)
> +{
> +	return lowpan_nexthdr_nhcs[nexthdr];
> +}
> +
> +int lowpan_nhc_do_compression(struct lowpan_nhc *nhc, struct sk_buff *skb,
> +			      u8 **hc_ptr, u8 *iphc0)
> +{
> +	int ret;
> +
> +	if (!nhc)
> +		return 0;
> +
> +	ret = nhc->compress(skb, hc_ptr);
> +	if (ret == 0)
> +		*iphc0 |= LOWPAN_IPHC_NH_C;
> +
> +	return ret;
> +}
> +
> +int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct ipv6hdr *hdr)
> +{
> +	struct lowpan_nhc *nhc;
> +	/* default dropping if nothing found */
> +	int ret = 0;
> +

this should be ret = -ENOENT; 

To avoid sending garbage to next higher layer. I changed this is here
from -EINVAL to 0. Sorry some mistake is happend here, now it's real
dropped afterwards.

> +	nhc = lowpan_nhc_by_nhcid(skb);
> +	if (nhc) {
> +		ret = nhc->uncompress(skb, sizeof(*hdr) + nhc->nexthdrlen);
> +		if (ret == 0) {
> +			hdr->nexthdr = nhc->nexthdr;
> +			skb_reset_transport_header(skb);
> +			raw_dump_table(__func__, "raw transport header dump",
> +				       skb_transport_header(skb),
> +				       nhc->nexthdrlen);
> +		} else if (ret == -ENOTSUPP) {
> +			netdev_warn(skb->dev, "received %s which is not supported for uncompression.\n",
> +				    nhc->name);
> +		}
> +	} else {
> +		netdev_warn(skb->dev, "received nhc which is not supported. Dropping.\n");
> +	}
> +
> +	return ret;
> +}
> +

- Alex
