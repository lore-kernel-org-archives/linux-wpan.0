Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50925 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936AbcAYH7A (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jan 2016 02:59:00 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 1/2] 6lowpan: iphc: add support for stateful compression
Date: Mon, 25 Jan 2016 08:58:54 +0100
Message-Id: <1453708735-29931-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1453708735-29931-1-git-send-email-aar@pengutronix.de>
References: <1453708735-29931-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, Alexander Aring <aar@pengutronix.de>

This patch introduce support for IPHC stateful address compression. It
will offer the context table via one debugfs entry.
This debugfs has and directory for each cid entry for the context table.
Inside each cid directory there exists the following files:

 - "active": If the entry is added or deleted. The context table is
   original a list implementation, this flag will indicate if the
   context is part of list or not.
 - "prefix": The ipv6 prefix.
 - "prefix_length": The prefix length for the prefix.
 - "compression": The compression flag according RFC6775.

This part should be moved into sysfs after some testing time.

Also the debugfs entry contains a "show" file which is a pretty-printout
for the current context table information.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h |  32 ++++
 net/6lowpan/core.c    |  39 ++++-
 net/6lowpan/debugfs.c | 247 ++++++++++++++++++++++++++++++
 net/6lowpan/iphc.c    | 414 +++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 674 insertions(+), 58 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 2f6a3f2..da3a77d 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -75,6 +75,8 @@
 #define LOWPAN_IPHC_MAX_HC_BUF_LEN	(sizeof(struct ipv6hdr) +	\
 					 LOWPAN_IPHC_MAX_HEADER_LEN +	\
 					 LOWPAN_NHC_MAX_HDR_LEN)
+/* SCI/DCI is 4 bit width, so we have maximum 16 entries */
+#define LOWPAN_IPHC_CTX_TABLE_SIZE	(1 << 4)
 
 #define LOWPAN_DISPATCH_IPV6		0x41 /* 01000001 = 65 */
 #define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
@@ -98,9 +100,39 @@ enum lowpan_lltypes {
 	LOWPAN_LLTYPE_IEEE802154,
 };
 
+enum lowpan_iphc_ctx_flags {
+	LOWPAN_IPHC_CTX_FLAG_ACTIVE,
+	LOWPAN_IPHC_CTX_FLAG_COMPRESSION,
+};
+
+struct lowpan_iphc_ctx {
+	u8 id;
+	struct in6_addr pfx;
+	u8 plen;
+	unsigned long flags;
+};
+
+struct lowpan_iphc_ctx_table {
+	spinlock_t lock;
+	const struct lowpan_iphc_ctx_ops *ops;
+	struct lowpan_iphc_ctx table[LOWPAN_IPHC_CTX_TABLE_SIZE];
+};
+
+static inline bool lowpan_iphc_ctx_is_active(const struct lowpan_iphc_ctx *ctx)
+{
+	return test_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE, &ctx->flags);
+}
+
+static inline bool
+lowpan_iphc_ctx_is_compression(const struct lowpan_iphc_ctx *ctx)
+{
+	return test_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
+}
+
 struct lowpan_priv {
 	enum lowpan_lltypes lltype;
 	struct dentry *iface_debugfs;
+	struct lowpan_iphc_ctx_table ctx;
 
 	/* must be last */
 	u8 priv[0] __aligned(sizeof(void *));
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index faf65ba..34e44c0 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -20,7 +20,7 @@
 int lowpan_register_netdevice(struct net_device *dev,
 			      enum lowpan_lltypes lltype)
 {
-	int ret;
+	int i, ret;
 
 	dev->addr_len = EUI64_ADDR_LEN;
 	dev->type = ARPHRD_6LOWPAN;
@@ -29,6 +29,10 @@ int lowpan_register_netdevice(struct net_device *dev,
 
 	lowpan_priv(dev)->lltype = lltype;
 
+	spin_lock_init(&lowpan_priv(dev)->ctx.lock);
+	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
+		lowpan_priv(dev)->ctx.table[i].id = i;
+
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		return ret;
@@ -68,6 +72,32 @@ void lowpan_unregister_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(lowpan_unregister_netdev);
 
+static int lowpan_event(struct notifier_block *unused,
+			unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	int i;
+
+	if (dev->type != ARPHRD_6LOWPAN)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_DOWN:
+		for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
+			clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
+				  &lowpan_priv(dev)->ctx.table[i].flags);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block lowpan_notifier = {
+	.notifier_call = lowpan_event,
+};
+
 static int __init lowpan_module_init(void)
 {
 	int ret;
@@ -76,6 +106,12 @@ static int __init lowpan_module_init(void)
 	if (ret < 0)
 		return ret;
 
+	ret = register_netdevice_notifier(&lowpan_notifier);
+	if (ret < 0) {
+		lowpan_debugfs_exit();
+		return ret;
+	}
+
 	request_module_nowait("ipv6");
 
 	request_module_nowait("nhc_dest");
@@ -92,6 +128,7 @@ static int __init lowpan_module_init(void)
 static void __exit lowpan_module_exit(void)
 {
 	lowpan_debugfs_exit();
+	unregister_netdevice_notifier(&lowpan_notifier);
 }
 
 module_init(lowpan_module_init);
diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 88eef84..aa49ff4 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -16,19 +16,266 @@
 
 #include "6lowpan_i.h"
 
+#define LOWPAN_DEBUGFS_CTX_PFX_NUM_ARGS	8
+
 static struct dentry *lowpan_debugfs;
 
+static int lowpan_ctx_flag_active_set(void *data, u64 val)
+{
+	struct lowpan_iphc_ctx *ctx = data;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val)
+		set_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE, &ctx->flags);
+	else
+		clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE, &ctx->flags);
+
+	return 0;
+}
+
+static int lowpan_ctx_flag_active_get(void *data, u64 *val)
+{
+	*val = lowpan_iphc_ctx_is_active(data);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(lowpan_ctx_flag_active_fops,
+			lowpan_ctx_flag_active_get,
+			lowpan_ctx_flag_active_set, "%llu\n");
+
+static int lowpan_ctx_flag_c_set(void *data, u64 val)
+{
+	struct lowpan_iphc_ctx *ctx = data;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val)
+		set_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
+	else
+		clear_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
+
+	return 0;
+}
+
+static int lowpan_ctx_flag_c_get(void *data, u64 *val)
+{
+	*val = lowpan_iphc_ctx_is_compression(data);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(lowpan_ctx_flag_c_fops, lowpan_ctx_flag_c_get,
+			lowpan_ctx_flag_c_set, "%llu\n");
+
+static int lowpan_ctx_plen_set(void *data, u64 val)
+{
+	struct lowpan_iphc_ctx *ctx = data;
+	struct lowpan_iphc_ctx_table *t =
+		container_of(ctx, struct lowpan_iphc_ctx_table, table[ctx->id]);
+
+	if (val > 128)
+		return -EINVAL;
+
+	spin_lock_bh(&t->lock);
+	ctx->plen = val;
+	spin_unlock_bh(&t->lock);
+
+	return 0;
+}
+
+static int lowpan_ctx_plen_get(void *data, u64 *val)
+{
+	struct lowpan_iphc_ctx *ctx = data;
+	struct lowpan_iphc_ctx_table *t =
+		container_of(ctx, struct lowpan_iphc_ctx_table, table[ctx->id]);
+
+	spin_lock_bh(&t->lock);
+	*val = ctx->plen;
+	spin_unlock_bh(&t->lock);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(lowpan_ctx_plen_fops, lowpan_ctx_plen_get,
+			lowpan_ctx_plen_set, "%llu\n");
+
+static int lowpan_ctx_pfx_show(struct seq_file *file, void *offset)
+{
+	struct lowpan_iphc_ctx *ctx = file->private;
+	struct lowpan_iphc_ctx_table *t =
+		container_of(ctx, struct lowpan_iphc_ctx_table, table[ctx->id]);
+
+	spin_lock_bh(&t->lock);
+	seq_printf(file, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+		   be16_to_cpu(ctx->pfx.s6_addr16[0]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[1]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[2]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[3]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[4]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[5]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[6]),
+		   be16_to_cpu(ctx->pfx.s6_addr16[7]));
+	spin_unlock_bh(&t->lock);
+
+	return 0;
+}
+
+static int lowpan_ctx_pfx_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lowpan_ctx_pfx_show, inode->i_private);
+}
+
+static ssize_t lowpan_ctx_pfx_write(struct file *fp,
+				    const char __user *user_buf, size_t count,
+				    loff_t *ppos)
+{
+	char buf[128] = {};
+	struct seq_file *file = fp->private_data;
+	struct lowpan_iphc_ctx *ctx = file->private;
+	struct lowpan_iphc_ctx_table *t =
+		container_of(ctx, struct lowpan_iphc_ctx_table, table[ctx->id]);
+	int status = count, n, i;
+	unsigned int addr[8];
+
+	if (copy_from_user(&buf, user_buf, min_t(size_t, sizeof(buf) - 1,
+						 count))) {
+		status = -EFAULT;
+		goto out;
+	}
+
+	n = sscanf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+		   &addr[0], &addr[1], &addr[2], &addr[3], &addr[4],
+		   &addr[5], &addr[6], &addr[7]);
+	if (n != LOWPAN_DEBUGFS_CTX_PFX_NUM_ARGS) {
+		status = -EINVAL;
+		goto out;
+	}
+
+	spin_lock_bh(&t->lock);
+	for (i = 0; i < 8; i++)
+		ctx->pfx.s6_addr16[i] = cpu_to_be16(addr[i] & 0xffff);
+	spin_unlock_bh(&t->lock);
+
+out:
+	return status;
+}
+
+const struct file_operations lowpan_ctx_pfx_fops = {
+	.open		= lowpan_ctx_pfx_open,
+	.read		= seq_read,
+	.write		= lowpan_ctx_pfx_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int lowpan_dev_debugfs_ctx_init(struct net_device *dev,
+				       struct dentry *ctx, u8 id)
+{
+	struct lowpan_priv *lpriv = lowpan_priv(dev);
+	struct dentry *dentry, *root;
+	char buf[32];
+
+	WARN_ON_ONCE(id > LOWPAN_IPHC_CTX_TABLE_SIZE);
+
+	sprintf(buf, "%d", id);
+
+	root = debugfs_create_dir(buf, ctx);
+	if (!root)
+		return -EINVAL;
+
+	dentry = debugfs_create_file("active", 0644, root,
+				     &lpriv->ctx.table[id],
+				     &lowpan_ctx_flag_active_fops);
+	if (!dentry)
+		return -EINVAL;
+
+	dentry = debugfs_create_file("compression", 0644, root,
+				     &lpriv->ctx.table[id],
+				     &lowpan_ctx_flag_c_fops);
+	if (!dentry)
+		return -EINVAL;
+
+	dentry = debugfs_create_file("prefix", 0644, root,
+				     &lpriv->ctx.table[id],
+				     &lowpan_ctx_pfx_fops);
+	if (!dentry)
+		return -EINVAL;
+
+	dentry = debugfs_create_file("prefix_len", 0644, root,
+				     &lpriv->ctx.table[id],
+				     &lowpan_ctx_plen_fops);
+	if (!dentry)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int lowpan_context_show(struct seq_file *file, void *offset)
+{
+	struct lowpan_iphc_ctx_table *t = file->private;
+	int i;
+
+	seq_printf(file, "%3s|%-43s|%c\n", "cid", "prefix", 'C');
+	seq_puts(file, "-------------------------------------------------\n");
+
+	spin_lock_bh(&t->lock);
+	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++) {
+		if (!lowpan_iphc_ctx_is_active(&t->table[i]))
+			continue;
+
+		seq_printf(file, "%3d|%39pI6c/%-3d|%d\n", t->table[i].id,
+			   &t->table[i].pfx, t->table[i].plen,
+			   lowpan_iphc_ctx_is_compression(&t->table[i]));
+	}
+	spin_unlock_bh(&t->lock);
+
+	return 0;
+}
+
+static int lowpan_context_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lowpan_context_show, inode->i_private);
+}
+
+const struct file_operations lowpan_context_fops = {
+	.open		= lowpan_context_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 int lowpan_dev_debugfs_init(struct net_device *dev)
 {
 	struct lowpan_priv *lpriv = lowpan_priv(dev);
+	struct dentry *contexts, *dentry;
+	int ret, i;
 
 	/* creating the root */
 	lpriv->iface_debugfs = debugfs_create_dir(dev->name, lowpan_debugfs);
 	if (!lpriv->iface_debugfs)
 		goto fail;
 
+	contexts = debugfs_create_dir("contexts", lpriv->iface_debugfs);
+	if (!contexts)
+		goto remove_root;
+
+	dentry = debugfs_create_file("show", 0644, contexts,
+				     &lowpan_priv(dev)->ctx,
+				     &lowpan_context_fops);
+	if (!dentry)
+		goto remove_root;
+
+	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++) {
+		ret = lowpan_dev_debugfs_ctx_init(dev, contexts, i);
+		if (ret < 0)
+			goto remove_root;
+	}
+
 	return 0;
 
+remove_root:
+	lowpan_dev_debugfs_exit(dev);
 fail:
 	return -EINVAL;
 }
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 346b5c1..d2a565c 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -56,6 +56,7 @@
 /* special link-layer handling */
 #include <net/mac802154.h>
 
+#include "6lowpan_i.h"
 #include "nhc.h"
 
 /* Values of fields within the IPHC encoding first byte */
@@ -147,6 +148,9 @@
 	 (((a)->s6_addr16[6]) == 0) &&		\
 	 (((a)->s6_addr[14]) == 0))
 
+#define LOWPAN_IPHC_CID_DCI(cid)	(cid & 0x0f)
+#define LOWPAN_IPHC_CID_SCI(cid)	((cid & 0xf0) >> 4)
+
 static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
 						const void *lladdr)
 {
@@ -195,6 +199,98 @@ static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 	}
 }
 
+static struct lowpan_iphc_ctx *
+lowpan_iphc_ctx_get_by_id(const struct net_device *dev, u8 id)
+{
+	struct lowpan_iphc_ctx *ret = &lowpan_priv(dev)->ctx.table[id];
+
+	if (!lowpan_iphc_ctx_is_active(ret))
+		return NULL;
+
+	return ret;
+}
+
+static struct lowpan_iphc_ctx *
+lowpan_iphc_ctx_get_by_addr(const struct net_device *dev,
+			    const struct in6_addr *addr)
+{
+	struct lowpan_iphc_ctx *table = lowpan_priv(dev)->ctx.table;
+	struct lowpan_iphc_ctx *ret = NULL;
+	struct in6_addr addr_pfx;
+	u8 addr_plen;
+	int i;
+
+	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++) {
+		/* Check if context is valid. A context that is not valid
+		 * MUST NOT be used for compression.
+		 */
+		if (!lowpan_iphc_ctx_is_active(&table[i]) ||
+		    !lowpan_iphc_ctx_is_compression(&table[i]))
+			continue;
+
+		ipv6_addr_prefix(&addr_pfx, addr, table[i].plen);
+
+		/* if prefix len < 64, the remaining bits until 64th bit is
+		 * zero. Otherwise we use table[i]->plen.
+		 */
+		if (table[i].plen < 64)
+			addr_plen = 64;
+		else
+			addr_plen = table[i].plen;
+
+		if (ipv6_prefix_equal(&addr_pfx, &table[i].pfx, addr_plen)) {
+			/* remember first match */
+			if (!ret) {
+				ret = &table[i];
+				continue;
+			}
+
+			/* get the context with longest prefix len */
+			if (table[i].plen > ret->plen)
+				ret = &table[i];
+		}
+	}
+
+	return ret;
+}
+
+static struct lowpan_iphc_ctx *
+lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
+				  const struct in6_addr *addr)
+{
+	struct lowpan_iphc_ctx *table = lowpan_priv(dev)->ctx.table;
+	struct lowpan_iphc_ctx *ret = NULL;
+	struct in6_addr addr_mcast, network_pfx = {};
+	int i;
+
+	/* init mcast address with  */
+	memcpy(&addr_mcast, addr, sizeof(*addr));
+
+	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++) {
+		/* Check if context is valid. A context that is not valid
+		 * MUST NOT be used for compression.
+		 */
+		if (!lowpan_iphc_ctx_is_active(&table[i]) ||
+		    !lowpan_iphc_ctx_is_compression(&table[i]))
+			continue;
+
+		/* setting plen */
+		addr_mcast.s6_addr[3] = table[i].plen;
+		/* get network prefix to copy into multicast address */
+		ipv6_addr_prefix(&network_pfx, &table[i].pfx,
+				 table[i].plen);
+		/* setting network prefix */
+		memcpy(&addr_mcast.s6_addr[4], &network_pfx, 8);
+
+		if (ipv6_addr_equal(addr, &addr_mcast)) {
+			ret = &table[i];
+			break;
+		}
+	}
+
+	return ret;
+}
+
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
@@ -259,30 +355,59 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 /* Uncompress address function for source context
  * based address(non-multicast).
  */
-static int uncompress_context_based_src_addr(struct sk_buff *skb,
-					     struct in6_addr *ipaddr,
-					     u8 address_mode)
+static int uncompress_ctx_addr(struct sk_buff *skb,
+			       const struct net_device *dev,
+			       const struct lowpan_iphc_ctx *ctx,
+			       struct in6_addr *ipaddr, u8 address_mode,
+			       const void *lladdr)
 {
+	bool fail;
+
 	switch (address_mode) {
-	case LOWPAN_IPHC_SAM_00:
-		/* unspec address ::
+	/* SAM and DAM are the same here */
+	case LOWPAN_IPHC_DAM_00:
+		fail = false;
+		/* SAM_00 -> unspec address ::
 		 * Do nothing, address is already ::
+		 *
+		 * DAM 00 -> reserved should never occur.
 		 */
 		break;
 	case LOWPAN_IPHC_SAM_01:
-		/* TODO */
+	case LOWPAN_IPHC_DAM_01:
+		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[8], 8);
+		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
+		break;
 	case LOWPAN_IPHC_SAM_10:
-		/* TODO */
+	case LOWPAN_IPHC_DAM_10:
+		ipaddr->s6_addr[11] = 0xFF;
+		ipaddr->s6_addr[12] = 0xFE;
+		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[14], 2);
+		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
+		break;
 	case LOWPAN_IPHC_SAM_11:
-		/* TODO */
-		netdev_warn(skb->dev, "SAM value 0x%x not supported\n",
-			    address_mode);
-		return -EINVAL;
+	case LOWPAN_IPHC_DAM_11:
+		fail = false;
+		switch (lowpan_priv(dev)->lltype) {
+		case LOWPAN_LLTYPE_IEEE802154:
+			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
+			break;
+		default:
+			iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
+			break;
+		}
+		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
+		break;
 	default:
 		pr_debug("Invalid sam value: 0x%x\n", address_mode);
 		return -EINVAL;
 	}
 
+	if (fail) {
+		pr_debug("Failed to fetch skb data\n");
+		return -EIO;
+	}
+
 	raw_dump_inline(NULL,
 			"Reconstructed context based ipv6 src addr is",
 			ipaddr->s6_addr, 16);
@@ -346,6 +471,30 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 	return 0;
 }
 
+static int lowpan_uncompress_multicast_ctx_daddr(struct sk_buff *skb,
+						 struct lowpan_iphc_ctx *ctx,
+						 struct in6_addr *ipaddr,
+						 u8 address_mode)
+{
+	struct in6_addr network_pfx = {};
+	bool fail;
+
+	ipaddr->s6_addr[0] = 0xFF;
+	fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[1], 2);
+	fail |= lowpan_fetch_skb(skb, &ipaddr->s6_addr[12], 4);
+	if (fail < 0)
+		return -EIO;
+
+	/* take prefix_len and network prefix from the context */
+	ipaddr->s6_addr[3] = ctx->plen;
+	/* get network prefix to copy into multicast address */
+	ipv6_addr_prefix(&network_pfx, &ctx->pfx, ctx->plen);
+	/* setting network prefix */
+	memcpy(&ipaddr->s6_addr[4], &network_pfx, 8);
+
+	return 0;
+}
+
 /* get the ecn values from iphc tf format and set it to ipv6hdr */
 static inline void lowpan_iphc_tf_set_ecn(struct ipv6hdr *hdr, const u8 *tf)
 {
@@ -459,7 +608,8 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 			     const void *daddr, const void *saddr)
 {
 	struct ipv6hdr hdr = {};
-	u8 iphc0, iphc1;
+	struct lowpan_iphc_ctx *ci;
+	u8 iphc0, iphc1, cid = 0;
 	int err;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
@@ -469,12 +619,14 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	    lowpan_fetch_skb(skb, &iphc1, sizeof(iphc1)))
 		return -EINVAL;
 
-	/* another if the CID flag is set */
-	if (iphc1 & LOWPAN_IPHC_CID)
-		return -ENOTSUPP;
-
 	hdr.version = 6;
 
+	/* default CID = 0, another if the CID flag is set */
+	if (iphc1 & LOWPAN_IPHC_CID) {
+		if (lowpan_fetch_skb(skb, &cid, sizeof(cid)))
+			return -EINVAL;
+	}
+
 	err = lowpan_iphc_tf_decompress(skb, &hdr,
 					iphc0 & LOWPAN_IPHC_TF_MASK);
 	if (err < 0)
@@ -500,10 +652,17 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	}
 
 	if (iphc1 & LOWPAN_IPHC_SAC) {
-		/* Source address context based uncompression */
+		spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_SCI(cid));
+		if (!ci) {
+			spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+			return -EINVAL;
+		}
+
 		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = uncompress_context_based_src_addr(skb, &hdr.saddr,
-							iphc1 & LOWPAN_IPHC_SAM_MASK);
+		err = uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
+					  iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
+		spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
@@ -515,27 +674,52 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	if (err)
 		return -EINVAL;
 
-	/* check for Multicast Compression */
-	if (iphc1 & LOWPAN_IPHC_M) {
-		if (iphc1 & LOWPAN_IPHC_DAC) {
-			pr_debug("dest: context-based mcast compression\n");
-			/* TODO: implement this */
-		} else {
-			err = lowpan_uncompress_multicast_daddr(skb, &hdr.daddr,
-								iphc1 & LOWPAN_IPHC_DAM_MASK);
+	switch (iphc1 & (LOWPAN_IPHC_M | LOWPAN_IPHC_DAC)) {
+	case LOWPAN_IPHC_M | LOWPAN_IPHC_DAC:
+		spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
+		if (!ci) {
+			spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+			return -EINVAL;
+		}
 
-			if (err)
-				return -EINVAL;
+		/* multicast with context */
+		pr_debug("dest: context-based mcast compression\n");
+		err = lowpan_uncompress_multicast_ctx_daddr(skb, ci,
+							    &hdr.daddr,
+							    iphc1 & LOWPAN_IPHC_DAM_MASK);
+		spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+		break;
+	case LOWPAN_IPHC_M:
+		/* multicast */
+		err = lowpan_uncompress_multicast_daddr(skb, &hdr.daddr,
+							iphc1 & LOWPAN_IPHC_DAM_MASK);
+		break;
+	case LOWPAN_IPHC_DAC:
+		spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
+		if (!ci) {
+			spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+			return -EINVAL;
 		}
-	} else {
+
+		/* Destination address context based uncompression */
+		pr_debug("DAC bit is set. Handle context based destination address.\n");
+		err = uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
+					  iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
+		spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+		break;
+	default:
 		err = uncompress_addr(skb, dev, &hdr.daddr,
 				      iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
 			 iphc1 & LOWPAN_IPHC_DAM_MASK, &hdr.daddr);
-		if (err)
-			return -EINVAL;
+		break;
 	}
 
+	if (err)
+		return -EINVAL;
+
 	/* Next header data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH) {
 		err = lowpan_nhc_do_uncompression(skb, dev, &hdr);
@@ -585,6 +769,58 @@ static const u8 lowpan_iphc_dam_to_sam_value[] = {
 	[LOWPAN_IPHC_DAM_11] = LOWPAN_IPHC_SAM_11,
 };
 
+static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct in6_addr *ipaddr,
+				   const struct lowpan_iphc_ctx *ctx,
+				   const unsigned char *lladdr, bool sam)
+{
+	struct in6_addr tmp = {};
+	u8 dam;
+
+	/* check for SAM/DAM = 11 */
+	memcpy(&tmp.s6_addr[8], lladdr, 8);
+	/* second bit-flip (Universe/Local) is done according RFC2464 */
+	tmp.s6_addr[8] ^= 0x02;
+	/* context information are always used */
+	ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
+	if (ipv6_addr_equal(&tmp, ipaddr)) {
+		dam = LOWPAN_IPHC_DAM_11;
+		goto out;
+	}
+
+	memset(&tmp, 0, sizeof(tmp));
+	/* check for SAM/DAM = 01 */
+	tmp.s6_addr[11] = 0xFF;
+	tmp.s6_addr[12] = 0xFE;
+	memcpy(&tmp.s6_addr[14], &ipaddr->s6_addr[14], 2);
+	/* context information are always used */
+	ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
+	if (ipv6_addr_equal(&tmp, ipaddr)) {
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[14], 2);
+		dam = LOWPAN_IPHC_DAM_10;
+		goto out;
+	}
+
+	memset(&tmp, 0, sizeof(tmp));
+	/* check for SAM/DAM = 10, should always match */
+	memcpy(&tmp.s6_addr[8], &ipaddr->s6_addr[8], 8);
+	/* context information are always used */
+	ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
+	if (ipv6_addr_equal(&tmp, ipaddr)) {
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[8], 8);
+		dam = LOWPAN_IPHC_DAM_01;
+		goto out;
+	}
+
+	WARN_ON_ONCE("context found but no address mode matched\n");
+	return -EINVAL;
+out:
+
+	if (sam)
+		return lowpan_iphc_dam_to_sam_value[dam];
+	else
+		return dam;
+}
+
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct in6_addr *ipaddr,
 				  const unsigned char *lladdr, bool sam)
 {
@@ -708,6 +944,21 @@ static u8 lowpan_iphc_tf_compress(u8 **hc_ptr, const struct ipv6hdr *hdr)
 	return val;
 }
 
+static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
+					      const struct lowpan_iphc_ctx *ctx,
+					      const struct in6_addr *ipaddr)
+{
+	u8 data[6];
+
+	/* flags/scope, reserved (RIID) */
+	memcpy(data, &ipaddr->s6_addr[1], 2);
+	/* group ID */
+	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
+	lowpan_push_hc_data(hc_ptr, data, 6);
+
+	return LOWPAN_IPHC_DAM_00;
+}
+
 static u8 lowpan_iphc_mcast_addr_compress(u8 **hc_ptr,
 					  const struct in6_addr *ipaddr)
 {
@@ -742,10 +993,11 @@ static u8 lowpan_iphc_mcast_addr_compress(u8 **hc_ptr,
 int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 			   const void *daddr, const void *saddr)
 {
-	u8 iphc0, iphc1, *hc_ptr;
+	u8 iphc0, iphc1, *hc_ptr, cid = 0;
 	struct ipv6hdr *hdr;
 	u8 head[LOWPAN_IPHC_MAX_HC_BUF_LEN] = {};
-	int ret, addr_type;
+	struct lowpan_iphc_ctx *dci, *sci, dci_entry, sci_entry;
+	int ret, ipv6_daddr_type, ipv6_saddr_type;
 
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
@@ -769,14 +1021,38 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	iphc0 = LOWPAN_DISPATCH_IPHC;
 	iphc1 = 0;
 
-	/* TODO: context lookup */
-
 	raw_dump_inline(__func__, "saddr", saddr, EUI64_ADDR_LEN);
 	raw_dump_inline(__func__, "daddr", daddr, EUI64_ADDR_LEN);
 
 	raw_dump_table(__func__, "sending raw skb network uncompressed packet",
 		       skb->data, skb->len);
 
+	ipv6_daddr_type = ipv6_addr_type(&hdr->daddr);
+	spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+	if (ipv6_daddr_type & IPV6_ADDR_MULTICAST)
+		dci = lowpan_iphc_ctx_get_by_mcast_addr(dev, &hdr->daddr);
+	else
+		dci = lowpan_iphc_ctx_get_by_addr(dev, &hdr->daddr);
+	if (dci) {
+		memcpy(&dci_entry, dci, sizeof(*dci));
+		cid |= dci->id;
+	}
+	spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+
+	spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+	sci = lowpan_iphc_ctx_get_by_addr(dev, &hdr->saddr);
+	if (sci) {
+		memcpy(&sci_entry, sci, sizeof(*sci));
+		cid |= (sci->id << 4);
+	}
+	spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+
+	/* if cid is zero it will be compressed */
+	if (cid) {
+		iphc1 |= LOWPAN_IPHC_CID;
+		lowpan_push_hc_data(&hc_ptr, &cid, sizeof(cid));
+	}
+
 	/* Traffic Class, Flow Label compression */
 	iphc0 |= lowpan_iphc_tf_compress(&hc_ptr, hdr);
 
@@ -813,39 +1089,63 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 				    sizeof(hdr->hop_limit));
 	}
 
-	addr_type = ipv6_addr_type(&hdr->saddr);
+	ipv6_saddr_type = ipv6_addr_type(&hdr->saddr);
 	/* source address compression */
-	if (addr_type == IPV6_ADDR_ANY) {
+	if (ipv6_saddr_type == IPV6_ADDR_ANY) {
 		pr_debug("source address is unspecified, setting SAC\n");
 		iphc1 |= LOWPAN_IPHC_SAC;
 	} else {
-		if (addr_type & IPV6_ADDR_LINKLOCAL) {
-			iphc1 |= lowpan_compress_addr_64(&hc_ptr, &hdr->saddr,
-							 saddr, true);
-			pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
-				 &hdr->saddr, iphc1);
+		if (sci) {
+			iphc1 |= lowpan_compress_ctx_addr(&hc_ptr, &hdr->saddr,
+							  &sci_entry, saddr,
+							  true);
+			iphc1 |= LOWPAN_IPHC_SAC;
 		} else {
-			pr_debug("send the full source address\n");
-			lowpan_push_hc_data(&hc_ptr, hdr->saddr.s6_addr, 16);
+			if (ipv6_saddr_type & IPV6_ADDR_LINKLOCAL) {
+				iphc1 |= lowpan_compress_addr_64(&hc_ptr,
+								 &hdr->saddr,
+								 saddr, true);
+				pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
+					 &hdr->saddr, iphc1);
+			} else {
+				pr_debug("send the full source address\n");
+				lowpan_push_hc_data(&hc_ptr,
+						    hdr->saddr.s6_addr, 16);
+			}
 		}
 	}
 
-	addr_type = ipv6_addr_type(&hdr->daddr);
 	/* destination address compression */
-	if (addr_type & IPV6_ADDR_MULTICAST) {
+	if (ipv6_daddr_type & IPV6_ADDR_MULTICAST) {
 		pr_debug("destination address is multicast: ");
-		iphc1 |= LOWPAN_IPHC_M;
-		iphc1 |= lowpan_iphc_mcast_addr_compress(&hc_ptr, &hdr->daddr);
+		if (dci) {
+			iphc1 |= lowpan_iphc_mcast_ctx_addr_compress(&hc_ptr,
+								     &dci_entry,
+								     &hdr->daddr);
+		} else {
+			iphc1 |= LOWPAN_IPHC_M;
+			iphc1 |= lowpan_iphc_mcast_addr_compress(&hc_ptr,
+								 &hdr->daddr);
+		}
 	} else {
-		if (addr_type & IPV6_ADDR_LINKLOCAL) {
-			/* TODO: context lookup */
-			iphc1 |= lowpan_compress_addr_64(&hc_ptr, &hdr->daddr,
-							 daddr, false);
-			pr_debug("dest address unicast link-local %pI6c "
-				 "iphc1 0x%02x\n", &hdr->daddr, iphc1);
+		if (dci) {
+			iphc1 |= lowpan_compress_ctx_addr(&hc_ptr, &hdr->daddr,
+							  &dci_entry, daddr,
+							  false);
+			iphc1 |= LOWPAN_IPHC_DAC;
 		} else {
-			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
-			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
+			if (ipv6_daddr_type & IPV6_ADDR_LINKLOCAL) {
+				iphc1 |= lowpan_compress_addr_64(&hc_ptr,
+								 &hdr->daddr,
+								 daddr, false);
+				pr_debug("dest address unicast link-local %pI6c iphc1 0x%02x\n",
+					 &hdr->daddr, iphc1);
+			} else {
+				pr_debug("dest address unicast %pI6c\n",
+					 &hdr->daddr);
+				lowpan_push_hc_data(&hc_ptr,
+						    hdr->daddr.s6_addr, 16);
+			}
 		}
 	}
 
-- 
2.7.0

