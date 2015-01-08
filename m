Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51163 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbbAHMbx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Jan 2015 07:31:53 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv4 bluetooth-next 1/3] 6lowpan: add generic nhc layer interface
Date: Thu,  8 Jan 2015 13:31:36 +0100
Message-Id: <1420720298-1995-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420720298-1995-1-git-send-email-alex.aring@gmail.com>
References: <1420720298-1995-1-git-send-email-alex.aring@gmail.com>
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
 net/6lowpan/nhc.c    | 241 +++++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc.h    | 146 +++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+), 1 deletion(-)
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
index 0000000..3c0dc77b0
--- /dev/null
+++ b/net/6lowpan/nhc.c
@@ -0,0 +1,241 @@
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
+static DEFINE_SPINLOCK(lowpan_nhc_lock);
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
+static struct lowpan_nhc *lowpan_nhc_by_nhcid(const struct sk_buff *skb)
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
+int lowpan_nhc_check_compression(struct sk_buff *skb,
+				 const struct ipv6hdr *hdr, u8 **hc_ptr,
+				 u8 *iphc0)
+{
+	struct lowpan_nhc *nhc;
+
+	spin_lock_bh(&lowpan_nhc_lock);
+
+	nhc = lowpan_nexthdr_nhcs[hdr->nexthdr];
+	if (nhc && nhc->compress)
+		*iphc0 |= LOWPAN_IPHC_NH_C;
+	else
+		lowpan_push_hc_data(hc_ptr, &hdr->nexthdr,
+				    sizeof(hdr->nexthdr));
+
+	spin_unlock_bh(&lowpan_nhc_lock);
+
+	return 0;
+}
+
+int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
+			      u8 **hc_ptr)
+{
+	int ret;
+	struct lowpan_nhc *nhc;
+
+	spin_lock_bh(&lowpan_nhc_lock);
+
+	nhc = lowpan_nexthdr_nhcs[hdr->nexthdr];
+	/* check if the nhc module was removed in unlocked part.
+	 * TODO: this is a workaround we should prevent unloading
+	 * of nhc modules while unlocked part, this will always drop
+	 * the lowpan packet but it's very unlikely.
+	 *
+	 * Solution isn't easy because we need to decide at
+	 * lowpan_nhc_check_compression if we do a compression or not.
+	 * Because the inline data which is added to skb, we can't move this
+	 * handling.
+	 */
+	if (unlikely(!nhc || !nhc->compress)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* In the case of RAW sockets the transport header is not set by
+	 * the ip6 stack so we must set it ourselves
+	 */
+	if (skb->transport_header == skb->network_header)
+		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+
+	ret = nhc->compress(skb, hc_ptr);
+	if (ret < 0)
+		goto out;
+
+	/* skip the transport header */
+	skb_pull(skb, nhc->nexthdrlen);
+
+out:
+	spin_unlock_bh(&lowpan_nhc_lock);
+
+	return ret;
+}
+
+int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct net_device *dev,
+				struct ipv6hdr *hdr)
+{
+	struct lowpan_nhc *nhc;
+	int ret;
+
+	spin_lock_bh(&lowpan_nhc_lock);
+
+	nhc = lowpan_nhc_by_nhcid(skb);
+	if (nhc) {
+		if (nhc->uncompress) {
+			ret = nhc->uncompress(skb, sizeof(struct ipv6hdr) +
+					      nhc->nexthdrlen);
+			if (ret < 0) {
+				spin_unlock_bh(&lowpan_nhc_lock);
+				return ret;
+			}
+		} else {
+			spin_unlock_bh(&lowpan_nhc_lock);
+			netdev_warn(dev, "received nhc id for %s which is not implemented.\n",
+				    nhc->name);
+			return -ENOTSUPP;
+		}
+	} else {
+		spin_unlock_bh(&lowpan_nhc_lock);
+		netdev_warn(dev, "received unknown nhc id which was not found.\n");
+		return -ENOENT;
+	}
+
+	hdr->nexthdr = nhc->nexthdr;
+	skb_reset_transport_header(skb);
+	raw_dump_table(__func__, "raw transport header dump",
+		       skb_transport_header(skb), nhc->nexthdrlen);
+
+	spin_unlock_bh(&lowpan_nhc_lock);
+
+	return 0;
+}
+
+int lowpan_nhc_add(struct lowpan_nhc *nhc)
+{
+	int ret;
+
+	if (!nhc->idlen || !nhc->idsetup)
+		return -EINVAL;
+
+	WARN_ONCE(nhc->idlen > LOWPAN_NHC_MAX_ID_LEN,
+		  "LOWPAN_NHC_MAX_ID_LEN should be updated to %d.\n",
+		  nhc->idlen);
+
+	nhc->idsetup(nhc);
+
+	spin_lock_bh(&lowpan_nhc_lock);
+
+	if (lowpan_nexthdr_nhcs[nhc->nexthdr]) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	ret = lowpan_nhc_insert(nhc);
+	if (ret < 0)
+		goto out;
+
+	lowpan_nexthdr_nhcs[nhc->nexthdr] = nhc;
+out:
+	spin_unlock_bh(&lowpan_nhc_lock);
+	return ret;
+}
+EXPORT_SYMBOL(lowpan_nhc_add);
+
+void lowpan_nhc_del(struct lowpan_nhc *nhc)
+{
+	spin_lock_bh(&lowpan_nhc_lock);
+
+	lowpan_nhc_remove(nhc);
+	lowpan_nexthdr_nhcs[nhc->nexthdr] = NULL;
+
+	spin_unlock_bh(&lowpan_nhc_lock);
+
+	synchronize_net();
+}
+EXPORT_SYMBOL(lowpan_nhc_del);
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
new file mode 100644
index 0000000..ed44938
--- /dev/null
+++ b/net/6lowpan/nhc.h
@@ -0,0 +1,146 @@
+#ifndef __6LOWPAN_NHC_H
+#define __6LOWPAN_NHC_H
+
+#include <linux/skbuff.h>
+#include <linux/rbtree.h>
+#include <linux/module.h>
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
+		   _hdrlen, _idsetup, _idlen,	\
+		   _uncompress, _compress)	\
+static u8 __nhc##_val[_idlen];			\
+static u8 __nhc##_mask[_idlen];			\
+static struct lowpan_nhc __nhc = {		\
+	.name		= _name,		\
+	.nexthdr	= _nexthdr,		\
+	.nexthdrlen	= _hdrlen,		\
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
+ * lowpan_nhc_by_nexthdr - return the 6lowpan nhc by ipv6 nexthdr.
+ *
+ * @nexthdr: ipv6 nexthdr value.
+ */
+struct lowpan_nhc *lowpan_nhc_by_nexthdr(u8 nexthdr);
+
+/**
+ * lowpan_nhc_check_compression - checks if we support compression format. If
+ *	we support the nhc by nexthdr field, the 6LoWPAN iphc NHC bit will be
+ *	set. If we don't support nexthdr will be added as inline data to the
+ *	6LoWPAN header.
+ *
+ * @skb: skb of 6LoWPAN header to read nhc and replace header.
+ * @hdr: ipv6hdr to check the nexthdr value
+ * @hc_ptr: pointer for 6LoWPAN header which should increment at the end of
+ *	    replaced header.
+ * @iphc0: iphc0 pointer to set the 6LoWPAN NHC bit
+ */
+int lowpan_nhc_check_compression(struct sk_buff *skb,
+				 const struct ipv6hdr *hdr, u8 **hc_ptr,
+				 u8 *iphc0);
+
+/**
+ * lowpan_nhc_do_compression - calling compress callback for nhc
+ *
+ * @skb: skb of 6LoWPAN header to read nhc and replace header.
+ * @hdr: ipv6hdr to set the nexthdr value
+ * @hc_ptr: pointer for 6LoWPAN header which should increment at the end of
+ *	    replaced header.
+ */
+int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
+			      u8 **hc_ptr);
+
+/**
+ * lowpan_nhc_do_uncompression - calling uncompress callback for nhc
+ *
+ * @nhc: 6LoWPAN nhc context, get by lowpan_nhc_by_ functions.
+ * @skb: skb of 6LoWPAN header, skb->data should be pointed to nhc id value.
+ * @dev: netdevice for print logging information.
+ * @hdr: ipv6hdr for setting nexthdr value.
+ */
+int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct net_device *dev,
+				struct ipv6hdr *hdr);
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
+/**
+ * lowpan_nhc_init - adding all default nhcs
+ */
+void lowpan_nhc_init(void);
+
+#endif /* __6LOWPAN_NHC_H */
-- 
2.2.1

