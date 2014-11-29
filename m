Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38497 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaK2VPM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 29 Nov 2014 16:15:12 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/2] 6lowpan: add generic nhc layer interface
Date: Sat, 29 Nov 2014 22:14:42 +0100
Message-Id: <1417295683-22682-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
References: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

This patch adds a generic next header compression layer interface. There
exists various methods to do a header compression after 6LoWPAN header
to save payload. This introduce a generic nhc header which allow a
simple adding of a new header compression format instead of a static
implementation inside the 6LoWPAN header compression and uncompression
function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>
---
 net/6lowpan/Makefile |   2 +-
 net/6lowpan/nhc.c    | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc.h    | 130 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/nhc.c
 create mode 100644 net/6lowpan/nhc.h

diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index 415886b..4215602 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_6LOWPAN) := 6lowpan.o
 
-6lowpan-y := iphc.o
+6lowpan-y := iphc.o nhc.o
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
new file mode 100644
index 0000000..f64b244
--- /dev/null
+++ b/net/6lowpan/nhc.c
@@ -0,0 +1,175 @@
+/*
+ *	6LoWPAN next header compression
+ *
+ *
+ *	Authors:
+ *	Alexander Aring		<aar@pengutronix.de>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/netdevice.h>
+
+#include <net/ipv6.h>
+
+#include "nhc.h"
+
+static struct rb_root rb_root = RB_ROOT;
+static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
+
+static int lowpan_nhc_insert(struct lowpan_nhc *nhc)
+{
+	struct rb_node **new = &rb_root.rb_node, *parent = NULL;
+
+	/* Figure out where to put new node */
+	while (*new) {
+		struct lowpan_nhc *this = container_of(*new, struct lowpan_nhc,
+						       node);
+		int result, len_dif, len;
+
+		len_dif = nhc->idlen - this->idlen;
+
+		if (nhc->idlen < this->idlen)
+			len = nhc->idlen;
+		else
+			len = this->idlen;
+
+		result = memcmp(nhc->id, this->id, len);
+		if (!result)
+			result = len_dif;
+
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0)
+			new = &((*new)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&nhc->node, parent, new);
+	rb_insert_color(&nhc->node, &rb_root);
+
+	return 0;
+}
+
+static void lowpan_nhc_remove(struct lowpan_nhc *nhc)
+{
+	rb_erase(&nhc->node, &rb_root);
+}
+
+struct lowpan_nhc *lowpan_nhc_by_nhcid(const struct sk_buff *skb)
+{
+	struct rb_node *node = rb_root.rb_node;
+	const u8 *nhcid_skb_ptr = skb->data;
+
+	while (node) {
+		struct lowpan_nhc *nhc = container_of(node, struct lowpan_nhc,
+						      node);
+		u8 nhcid_skb_ptr_masked[LOWPAN_NHC_MAX_ID_LEN];
+		int result, i;
+
+		if (nhcid_skb_ptr + nhc->idlen > skb->data + skb->len)
+			return NULL;
+
+		/* copy and mask afterwards the nhid value from skb */
+		memcpy(nhcid_skb_ptr_masked, nhcid_skb_ptr, nhc->idlen);
+		for (i = 0; i < nhc->idlen; i++)
+			nhcid_skb_ptr_masked[i] &= nhc->idmask[i];
+
+		result = memcmp(nhcid_skb_ptr_masked, nhc->id, nhc->idlen);
+		if (result < 0)
+			node = node->rb_left;
+		else if (result > 0)
+			node = node->rb_right;
+		else
+			return nhc;
+	}
+
+	return NULL;
+}
+
+struct lowpan_nhc *lowpan_nhc_by_nexthdr(u8 nexthdr)
+{
+	return lowpan_nexthdr_nhcs[nexthdr];
+}
+
+int lowpan_nhc_do_compression(struct lowpan_nhc *nhc, struct sk_buff *skb,
+			      u8 **hc_ptr, u8 *iphc0)
+{
+	int ret;
+
+	if (!nhc)
+		return 0;
+
+	ret = nhc->compress(skb, hc_ptr);
+	if (ret == 0)
+		*iphc0 |= LOWPAN_IPHC_NH_C;
+
+	return ret;
+}
+
+int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct ipv6hdr *hdr)
+{
+	struct lowpan_nhc *nhc;
+	/* default dropping if nothing found */
+	int ret = 0;
+
+	nhc = lowpan_nhc_by_nhcid(skb);
+	if (nhc) {
+		ret = nhc->uncompress(skb, sizeof(*hdr) + nhc->nexthdrlen);
+		if (ret == 0) {
+			hdr->nexthdr = nhc->nexthdr;
+			skb_reset_transport_header(skb);
+			raw_dump_table(__func__, "raw transport header dump",
+				       skb_transport_header(skb),
+				       nhc->nexthdrlen);
+		} else if (ret == -ENOTSUPP) {
+			netdev_warn(skb->dev, "received %s which is not supported for uncompression.\n",
+				    nhc->name);
+		}
+	} else {
+		netdev_warn(skb->dev, "received nhc which is not supported. Dropping.\n");
+	}
+
+	return ret;
+}
+
+int lowpan_nhc_add(struct lowpan_nhc *nhc)
+{
+	int ret;
+
+	if (!nhc->idlen || !nhc->idsetup || !nhc->compress || !nhc->uncompress)
+		return -EINVAL;
+
+	WARN_ONCE(nhc->idlen > LOWPAN_NHC_MAX_ID_LEN,
+		  "LOWPAN_NHC_MAX_ID_LEN should be updated to %d.\n",
+		  nhc->idlen);
+
+	nhc->idsetup(nhc);
+
+	if (lowpan_nexthdr_nhcs[nhc->nexthdr])
+		return -EEXIST;
+
+	ret = lowpan_nhc_insert(nhc);
+	if (ret < 0)
+		goto out;
+
+	lowpan_nexthdr_nhcs[nhc->nexthdr] = nhc;
+out:
+	return ret;
+}
+EXPORT_SYMBOL(lowpan_nhc_add);
+
+void lowpan_nhc_del(struct lowpan_nhc *nhc)
+{
+	lowpan_nhc_remove(nhc);
+	lowpan_nexthdr_nhcs[nhc->nexthdr] = NULL;
+
+	synchronize_net();
+}
+EXPORT_SYMBOL(lowpan_nhc_del);
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
new file mode 100644
index 0000000..416a85f
--- /dev/null
+++ b/net/6lowpan/nhc.h
@@ -0,0 +1,130 @@
+#ifndef __6LOWPAN_NHC_H
+#define __6LOWPAN_NHC_H
+
+#include <linux/skbuff.h>
+#include <linux/rbtree.h>
+
+#include <net/6lowpan.h>
+#include <net/ipv6.h>
+
+#define LOWPAN_NHC_MAX_ID_LEN	1
+
+/**
+ * LOWPAN_NHC - helper macro to generate nh id fields and lowpan_nhc struct
+ *
+ * @__nhc: variable name of the lowpan_nhc struct.
+ * @_name: const char * of common header compression name.
+ * @_nexthdr: ipv6 nexthdr field for the header compression.
+ * @_nexthdrlen: ipv6 nexthdr len for the reserved space.
+ * @_idsetup: callback to setup id and mask values.
+ * @_idlen: len for the next header id and mask, should be always the same.
+ * @_uncompress: callback for uncompression call.
+ * @_compress: callback for compression call.
+ */
+#define LOWPAN_NHC(__nhc, _name, _nexthdr,	\
+		   _nexthdrlen, _idsetup,	\
+		   _idlen, _uncompress,		\
+		   _compress)			\
+static u8 __nhc##_val[_idlen];			\
+static u8 __nhc##_mask[_idlen];			\
+static struct lowpan_nhc __nhc = {		\
+	.name		= _name,		\
+	.nexthdr	= _nexthdr,		\
+	.nexthdrlen	= _nexthdrlen,		\
+	.id		= __nhc##_val,		\
+	.idmask		= __nhc##_mask,		\
+	.idlen		= _idlen,		\
+	.idsetup	= _idsetup,		\
+	.uncompress	= _uncompress,		\
+	.compress	= _compress,		\
+}
+
+#define module_lowpan_nhc(__nhc)		\
+static int __init __nhc##_init(void)		\
+{						\
+	return lowpan_nhc_add(&(__nhc));	\
+}						\
+module_init(__nhc##_init);			\
+static void __exit __nhc##_exit(void)		\
+{						\
+	lowpan_nhc_del(&(__nhc));		\
+}						\
+module_exit(__nhc##_exit);
+
+/**
+ * struct lowpan_nhc - hold 6lowpan next hdr compression ifnformation
+ *
+ * @node: holder for the rbtree.
+ * @name: name of the specific next header compression
+ * @nexthdr: next header value of the protocol which should be compressed.
+ * @nexthdrlen: ipv6 nexthdr len for the reserved space.
+ * @id: array for nhc id. Note this need to be in network byteorder.
+ * @mask: array for nhc id mask. Note this need to be in network byteorder.
+ * @len: the length of the next header id and mask.
+ * @setup: callback to setup fill the next header id value and mask.
+ * @compress: callback to do the header compression.
+ * @uncompress: callback to do the header uncompression.
+ */
+struct lowpan_nhc {
+	struct rb_node	node;
+	const char	*name;
+	const u8	nexthdr;
+	const size_t	nexthdrlen;
+	u8		*id;
+	u8		*idmask;
+	const size_t	idlen;
+
+	void		(*idsetup)(struct lowpan_nhc *nhc);
+	int		(*uncompress)(struct sk_buff *skb, size_t needed);
+	int		(*compress)(struct sk_buff *skb, u8 **hc_ptr);
+};
+
+/**
+ * lowpan_nhc_by_nhcid - returns the 6lowpan nhc by nhcid
+ *
+ * @skb: skb with skb->data which is pointed to 6lowpan nhc id.
+ */
+struct lowpan_nhc *lowpan_nhc_by_nhcid(const struct sk_buff *skb);
+
+/**
+ * lowpan_nhc_by_nexthdr - return the 6lowpan nhc by ipv6 nexthdr.
+ *
+ * @nexthdr: ipv6 nexthdr value.
+ */
+struct lowpan_nhc *lowpan_nhc_by_nexthdr(u8 nexthdr);
+
+/**
+ * lowpan_nhc_do_compression - wrapper for calling compress callback
+ *
+ * @nhc: 6LoWPAN nhc context, get by lowpan_search_nhc_*.
+ * @skb: skb of 6LoWPAN header to read nhc and replace header.
+ * @hc_ptr: pointer for 6LoWPAN header which should increment at the end of
+ *	    replaced header.
+ * @iphc0: First iphc byte, to set NHC bit.
+ */
+int lowpan_nhc_do_compression(struct lowpan_nhc *nhc, struct sk_buff *skb,
+			      u8 **hc_ptr, u8 *iphc0);
+
+/**
+ * lowpan_nhc_do_uncompression - wrapper for calling uncompress callback
+ *
+ * @skb: skb of 6LoWPAN header, skb->data should be pointed to nhc id value.
+ * @hdr: ipv6 header to set the according nexthdr value.
+ */
+int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct ipv6hdr *hdr);
+
+/**
+ * lowpan_nhc_add - register a next header compression to framework
+ *
+ * @nhc: nhc which should be add.
+ */
+int lowpan_nhc_add(struct lowpan_nhc *nhc);
+
+/**
+ * lowpan_nhc_del - delete a next header compression from framework
+ *
+ * @nhc: nhc which should be delete.
+ */
+void lowpan_nhc_del(struct lowpan_nhc *nhc);
+
+#endif /* __6LOWPAN_NHC_H */
-- 
2.1.3

