Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35047 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaHITCm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:42 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:16 +0200
Message-Id: <1407610943-27701-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 1/8] 6lowpan: add generic nhc layer interface
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch adds a generic next header compression layer interface. There
exists various methods to do a header compression after 6LoWPAN header
to save payload. This introduce a generic nhc header which allow a
simple adding of a new header compression format instead of a static
implementation inside the 6LoWPAN header compression and uncompression
function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/Makefile     |   1 +
 net/6lowpan/nhc/Makefile |   3 +
 net/6lowpan/nhc/core.c   | 180 +++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/core.h   | 122 ++++++++++++++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 net/6lowpan/nhc/Makefile
 create mode 100644 net/6lowpan/nhc/core.c
 create mode 100644 net/6lowpan/nhc/core.h

diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index 415886b..d23d569 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_6LOWPAN) := 6lowpan.o
+obj-$(CONFIG_6LOWPAN) += nhc/
 
 6lowpan-y := iphc.o
diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
new file mode 100644
index 0000000..5fe76e47
--- /dev/null
+++ b/net/6lowpan/nhc/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_6LOWPAN) += nhc.o
+
+nhc-y := core.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
new file mode 100644
index 0000000..0bf103d
--- /dev/null
+++ b/net/6lowpan/nhc/core.c
@@ -0,0 +1,180 @@
+/*	6LoWPAN next header compression
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
+#include "core.h"
+
+static struct rb_root rb_root = RB_ROOT;
+static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
+
+static int lowpan_insert_nhc(struct lowpan_nhc *nhc)
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
+static void lowpan_remove_nhc(struct lowpan_nhc *nhc)
+{
+	rb_erase(&nhc->node, &rb_root);
+}
+
+struct lowpan_nhc *lowpan_search_nhc_by_nhcid(const struct sk_buff *skb)
+{
+	struct rb_node *node = rb_root.rb_node;
+	const u8 *nhcid_skb_ptr = skb->data;
+
+	while (node) {
+		struct lowpan_nhc *nhc = container_of(node, struct lowpan_nhc,
+						      node);
+		u8 nhcid_skb_ptr_masked[nhc->idlen];
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
+
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
+EXPORT_SYMBOL(lowpan_search_nhc_by_nhcid);
+
+struct lowpan_nhc *lowpan_search_nhc_by_nexthdr(const u8 nexthdr)
+{
+	return lowpan_nexthdr_nhcs[nexthdr];
+}
+EXPORT_SYMBOL(lowpan_search_nhc_by_nexthdr);
+
+int lowpan_nhc_do_compression(struct lowpan_nhc *nhc, struct sk_buff *skb,
+			      u8 **hc_ptr, u8 *iphc0)
+{
+	int ret = 0;
+
+	if (!nhc)
+		return 0;
+
+	ret = nhc->compress(skb, hc_ptr);
+	if (!ret)
+		*iphc0 |= LOWPAN_IPHC_NH_C;
+	else if (ret == -ENOTSUPP)
+		return 0;
+
+	return ret;
+}
+EXPORT_SYMBOL(lowpan_nhc_do_compression);
+
+int lowpan_nhc_do_uncompression(struct sk_buff **skb, struct ipv6hdr *hdr)
+{
+	struct lowpan_nhc *nhc;
+	int ret = 0;
+
+	nhc = lowpan_search_nhc_by_nhcid(*skb);
+	if (nhc) {
+		ret = nhc->uncompress(skb);
+		if (!ret) {
+			skb_reset_transport_header(*skb);
+			hdr->nexthdr = nhc->nexthdr;
+		} else if (ret == -ENOTSUPP) {
+			net_warn_ratelimited("%s received %s which is not supported.\n",
+					     (*skb)->dev->name, nhc->name);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(lowpan_nhc_do_uncompression);
+
+int lowpan_add_nhc(struct lowpan_nhc *nhc)
+{
+	int ret = -ENOMEM;
+
+	if (!nhc->uncompress || !nhc->idlen || !nhc->idsetup || !nhc->compress)
+		return -EINVAL;
+
+	nhc->idsetup(nhc);
+
+	if (lowpan_nexthdr_nhcs[nhc->nexthdr])
+		return -EEXIST;
+
+	ret = lowpan_insert_nhc(nhc);
+	if (ret < 0)
+		goto out;
+
+	lowpan_nexthdr_nhcs[nhc->nexthdr] = nhc;
+out:
+	return ret;
+}
+EXPORT_SYMBOL(lowpan_add_nhc);
+
+void lowpan_del_nhc(struct lowpan_nhc *nhc)
+{
+	lowpan_remove_nhc(nhc);
+	lowpan_nexthdr_nhcs[nhc->nexthdr] = NULL;
+
+	synchronize_net();
+}
+EXPORT_SYMBOL(lowpan_del_nhc);
+
+int lowpan_init_nhc(void)
+{
+	return 0;
+}
+
+void lowpan_cleanup_nhc(void)
+{
+}
diff --git a/net/6lowpan/nhc/core.h b/net/6lowpan/nhc/core.h
new file mode 100644
index 0000000..5613fae
--- /dev/null
+++ b/net/6lowpan/nhc/core.h
@@ -0,0 +1,122 @@
+#ifndef __6LOWPAN_NHC_H
+#define __6LOWPAN_NHC_H
+
+#include <linux/skbuff.h>
+#include <linux/rbtree.h>
+#include <linux/list.h>
+
+#include <net/6lowpan.h>
+#include <net/ipv6.h>
+
+/**
+ * LOWPAN_NHC - helper macro to generate nh id fields and lowpan_nhc struct
+ *
+ * @varname: variable name of the lowpan_nhc struct.
+ * @nhcname: const char * of common header compression name.
+ * @nexthdr: ipv6 nexthdr field for the header compression.
+ * @nhidsetup: callback to setup id and mask values.
+ * @nhidlen: len for the next header id and mask, should be always the same.
+ * @nhuncompress: callback for uncompression call.
+ * @nhcompress: callback for compression call.
+ */
+#define LOWPAN_NHC(varname, nhcname, nhnexthdr,	\
+		   nhidsetup, nhidlen,		\
+		   nhuncompress, nhcompress)	\
+	static u8 name##_val[nhidlen];		\
+	static u8 name##_mask[nhidlen];		\
+	static struct lowpan_nhc varname = {	\
+		.name		= nhcname,	\
+		.nexthdr	= nhnexthdr,	\
+		.id		= name##_val,	\
+		.idmask		= name##_mask,	\
+		.idlen		= nhidlen,	\
+		.idsetup	= nhidsetup,	\
+		.uncompress	= nhuncompress,	\
+		.compress	= nhcompress,	\
+	}
+
+/**
+ * struct lowpan_nhc - hold 6lowpan next hdr compression ifnformation
+ *
+ * @node: holder for the rbtree.
+ * @name: name of the specific next header compression
+ * @nexthdr: next header value of the protocol which should be compressed.
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
+	u8		*id;
+	u8		*idmask;
+	const size_t	idlen;
+
+	void		(*idsetup)(struct lowpan_nhc *nhc);
+	int		(*uncompress)(struct sk_buff **skb);
+	int		(*compress)(struct sk_buff *skb, u8 **hc_ptr);
+};
+
+/**
+ * lowpan_search_nhc_by_nhcid - returns the 6lowpan nhc by nhcid
+ *
+ * @skb: skb with skb->data which is pointed to 6lowpan nhc id.
+ */
+struct lowpan_nhc *lowpan_search_nhc_by_nhcid(const struct sk_buff *skb);
+
+/**
+ * lowpan_search_nhc_by_nexthdr - return the 6lowpan nhc by ipv6 nexthdr.
+ *
+ * @nexthdr: ipv6 nexthdr value.
+ */
+struct lowpan_nhc *lowpan_search_nhc_by_nexthdr(const u8 nexthdr);
+
+/**
+ * lowpan_add_nhc - register a next header compression to framework
+ *
+ * @nhc: nhc which should be add.
+ */
+int lowpan_add_nhc(struct lowpan_nhc *nhc);
+
+/**
+ * lowpan_del_nhc - delete a next header compression from framework
+ *
+ * @nhc: nhc which should be delete.
+ */
+void lowpan_del_nhc(struct lowpan_nhc *nhc);
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
+int lowpan_nhc_do_uncompression(struct sk_buff **skb, struct ipv6hdr *hdr);
+
+/**
+ * lowpan_init_nhc - init all nhcs
+ */
+int lowpan_init_nhc(void);
+
+/**
+ * lowpan_cleanup_nhc - cleanup all registered nhcs
+ */
+void lowpan_cleanup_nhc(void);
+
+#endif /* __6LOWPAN_NHC_H */
-- 
2.0.3

