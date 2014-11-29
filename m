Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53605 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaK2OsF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 29 Nov 2014 09:48:05 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 1/2] 6lowpan: add generic nhc layer interface
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417271082-10068-2-git-send-email-alex.aring@gmail.com>
Date: Sat, 29 Nov 2014 15:47:57 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <FB346BA3-CBC9-42DC-8D49-220A6B8A9371@holtmann.org>
References: <1417271082-10068-1-git-send-email-alex.aring@gmail.com> <1417271082-10068-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

Hi Alex,

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
> net/6lowpan/Makefile |   4 +-
> net/6lowpan/nhc.c    | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++
> net/6lowpan/nhc.h    | 128 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 313 insertions(+), 1 deletion(-)
> create mode 100644 net/6lowpan/nhc.c
> create mode 100644 net/6lowpan/nhc.h
> 
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index 415886b..ba6bf47 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -1,3 +1,5 @@
> obj-$(CONFIG_6LOWPAN) := 6lowpan.o
> 
> -6lowpan-y := iphc.o
> +6lowpan-y := \
> +	iphc.o \
> +	nhc.o
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> new file mode 100644
> index 0000000..e0b2bd1
> --- /dev/null
> +++ b/net/6lowpan/nhc.c
> @@ -0,0 +1,182 @@
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
> +	int ret = -ENOTSUPP;
> +
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
> +int lowpan_nhc_add(struct lowpan_nhc *nhc)
> +{
> +	int ret;
> +
> +	if (!nhc->idlen || !nhc->idsetup || !nhc->compress || !nhc->uncompress)
> +		return -EINVAL;
> +
> +	WARN_ONCE(nhc->idlen > LOWPAN_NHC_MAX_ID_LEN,
> +		  "LOWPAN_NHC_MAX_ID_LEN should be updated to %d.\n",
> +		  nhc->idlen);
> +
> +	nhc->idsetup(nhc);
> +
> +	if (lowpan_nexthdr_nhcs[nhc->nexthdr])
> +		return -EEXIST;
> +
> +	ret = lowpan_nhc_insert(nhc);
> +	if (ret < 0)
> +		goto out;
> +
> +	lowpan_nexthdr_nhcs[nhc->nexthdr] = nhc;
> +out:
> +	return ret;
> +}
> +
> +void lowpan_nhc_del(struct lowpan_nhc *nhc)
> +{
> +	lowpan_nhc_remove(nhc);
> +	lowpan_nexthdr_nhcs[nhc->nexthdr] = NULL;
> +
> +	synchronize_net();
> +}
> +
> +int lowpan_nhc_init(void)
> +{
> +	return 0;
> +}
> +
> +void lowpan_nhc_cleanup(void)
> +{
> +}
> diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
> new file mode 100644
> index 0000000..f83f06e
> --- /dev/null
> +++ b/net/6lowpan/nhc.h
> @@ -0,0 +1,128 @@
> +#ifndef __6LOWPAN_NHC_H
> +#define __6LOWPAN_NHC_H
> +
> +#include <linux/skbuff.h>
> +#include <linux/rbtree.h>
> +
> +#include <net/6lowpan.h>
> +#include <net/ipv6.h>
> +
> +#define LOWPAN_NHC_MAX_ID_LEN	1
> +
> +/**
> + * LOWPAN_NHC - helper macro to generate nh id fields and lowpan_nhc struct
> + *
> + * @__nhc: variable name of the lowpan_nhc struct.
> + * @_name: const char * of common header compression name.
> + * @_nexthdr: ipv6 nexthdr field for the header compression.
> + * @_nexthdrlen: ipv6 nexthdr len for the reserved space.
> + * @_idsetup: callback to setup id and mask values.
> + * @_idlen: len for the next header id and mask, should be always the same.
> + * @_uncompress: callback for uncompression call.
> + * @_compress: callback for compression call.
> + */
> +#define LOWPAN_NHC(__nhc, _name, _nexthdr,	\
> +		   _nexthdrlen, _idsetup,	\
> +		   _idlen, _uncompress,		\
> +		   _compress)			\
> +	static u8 __nhc##_val[_idlen];		\
> +	static u8 __nhc##_mask[_idlen];		\
> +	static struct lowpan_nhc __nhc = {	\

any reason why these are not declared as static const?

> +		.name		= _name,	\
> +		.nexthdr	= _nexthdr,	\
> +		.nexthdrlen	= _nexthdrlen,	\
> +		.id		= __nhc##_val,	\
> +		.idmask		= __nhc##_mask,	\
> +		.idlen		= _idlen,	\
> +		.idsetup	= _idsetup,	\
> +		.uncompress	= _uncompress,	\
> +		.compress	= _compress,	\
> +	}

I also wonder if we should mix lowpan_nhc_add and lowpan_nhc_del handling into this macro as well. If the next header compression would be auto-loadable modules, then creating a module_lowpan_nhc() macro similar to module_usb_driver() etc. would help. We could in theory use module aliases to auto-load compression modules once needed. However it might be a bit too much overhead.

Regards

Marcel

