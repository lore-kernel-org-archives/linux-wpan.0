Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:37255 "EHLO
	ironport02.nordicsemi.no" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751646AbbGMLui (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 13 Jul 2015 07:50:38 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [RFC v2 2/4] 6lowpan: Add stateful compression component of 6lowpan module
Date: Mon, 13 Jul 2015 13:50:31 +0200
Message-ID: <1436788233-13960-3-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

The patch adds stateful compression (context ids based compression) to
the 6lowpan module [RFC6282].

Stateful Compression users allocate context tables through the functions
in the context.c using public APIs declared in 6lowpan.h. The context.c
is extending the 6lowpan module and not created as a separate module.

A debugfs entry for maintaining the context tables is implemented
(/sys/kernel/debug/6lowpan/context).

Example usage of the 6lowpan debugfs interface:

echo "<CMD> <IFACE> <CID> <CID_PREFIX> <CID_PREFIX_LENGTH>
<COMPRESSION_ENABLE_FLAG>" > /sys/kernel/debug/6lowpan/context

Examples:

echo "add bt0 3 2001:db8:: 64 1" > /sys/kernel/debug/6lowpan/context

echo "remove bt0 3" > /sys/kernel/debug/6lowpan/context

cat /sys/kernel/debug/6lowpan/context

e.g.
Context table of interface bt0

CID Prefix      Len CF
3   2001:db8::  64  1
4   2001:db8::1 128 1

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 include/net/6lowpan.h |  35 ++++
 net/6lowpan/Makefile  |   2 +-
 net/6lowpan/context.c | 551 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/context.h |   7 +
 4 files changed, 594 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/context.c
 create mode 100644 net/6lowpan/context.h

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 37ddbdf..ee3a455 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -199,6 +199,27 @@
 
 extern struct dentry *lowpan_debugfs;
 
+struct lowpan_context_table {
+	struct list_head list;
+
+	/* Context entries */
+	struct net_device *netdev;
+	struct list_head context_entries;
+	atomic_t context_count;
+};
+
+struct lowpan_context_entry {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct lowpan_context_table *ctx_table;
+
+	/* Context parameters */
+	u8 cid;
+	struct in6_addr prefix;
+	unsigned int prefix_len;
+	bool compression_flag;
+};
+
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
@@ -337,6 +358,9 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	if (!(iphc0 & 0x03))
 		ret++;
 
+	if (iphc1 & LOWPAN_IPHC_CID)
+		ret++;
+
 	ret += lowpan_addr_mode_size((iphc1 & LOWPAN_IPHC_SAM) >>
 				     LOWPAN_IPHC_SAM_BIT);
 
@@ -374,6 +398,17 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
+int lowpan_context_table_alloc(struct net_device *netdev);
+int lowpan_context_table_free(struct net_device *netdev);
+int lowpan_context_free_all(void);
+int lowpan_context_add(struct net_device *netdev,
+		       struct lowpan_context_entry *entry);
+int lowpan_context_remove(struct lowpan_context_entry *entry);
+struct lowpan_context_entry *
+lowpan_context_decompress(struct net_device *netdev, u8 cid);
+struct lowpan_context_entry *
+lowpan_context_compress(struct net_device *netdev, struct in6_addr *addr);
+
 int
 lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 			 const u8 *saddr, const u8 saddr_type,
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index eb8baa7..bda5be0 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_6LOWPAN) += 6lowpan.o
 
-6lowpan-y := iphc.o nhc.o
+6lowpan-y := iphc.o nhc.o context.o
 
 #rfc6282 nhcs
 obj-$(CONFIG_6LOWPAN_NHC_DEST) += nhc_dest.o
diff --git a/net/6lowpan/context.c b/net/6lowpan/context.c
new file mode 100644
index 0000000..00cd5af
--- /dev/null
+++ b/net/6lowpan/context.c
@@ -0,0 +1,551 @@
+/*
+ * Copyright (c)  2015 Nordic Semiconductor. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/if_arp.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/inet.h>
+#include <linux/atomic.h>
+
+#include <net/ipv6.h>
+#include <net/addrconf.h>
+#include <net/6lowpan.h>
+
+#define LOWPAN_DBG(fmt, ...)  pr_debug(fmt "\n", ##__VA_ARGS__)
+
+#define LOWPAN_CONTEXT_TABLE_SIZE     16
+#define LOWPAN_CONTEXT_COMMAND_ADD    "add"
+#define LOWPAN_CONTEXT_COMMAND_REMOVE "remove"
+
+#define CHECK_CID_RANGE(cid) ((cid) > 0 && (cid) < LOWPAN_CONTEXT_TABLE_SIZE)
+#define CHECK_PREFIX_RANGE(len) ((len) > 0 && (len) <= 128)
+
+static struct dentry *lowpan_context_debugfs;
+
+static LIST_HEAD(context_tables);
+static DEFINE_SPINLOCK(module_lock);
+
+static inline void entry_update(struct lowpan_context_entry *entry,
+				u8 cid,
+				struct in6_addr prefix,
+				unsigned int prefix_len,
+				bool compression_flag)
+{
+	/* Fill context entry. */
+	entry->cid = cid;
+	entry->compression_flag = compression_flag;
+	entry->prefix = prefix;
+	entry->prefix_len = prefix_len;
+}
+
+static inline void entry_free(struct lowpan_context_entry *entry)
+{
+	/* Increase number of available contexts. */
+	atomic_dec(&entry->ctx_table->context_count);
+
+	list_del_rcu(&entry->list);
+	kfree_rcu(entry, rcu);
+}
+
+static int entry_add(struct lowpan_context_table *ctx_table,
+		     u8 cid,
+		     struct in6_addr prefix,
+		     unsigned int prefix_len,
+		     bool compression_flag)
+{
+	struct lowpan_context_entry *new_entry = NULL;
+
+	new_entry = kzalloc(sizeof(*new_entry), GFP_ATOMIC);
+	if (!new_entry)
+		return -ENOMEM;
+
+	/* Fill context entry. */
+	new_entry->ctx_table = ctx_table;
+	entry_update(new_entry, cid, prefix, prefix_len, compression_flag);
+
+	INIT_LIST_HEAD(&new_entry->list);
+	list_add_rcu(&new_entry->list, &ctx_table->context_entries);
+
+	/* Increase number of available contexts. */
+	atomic_inc(&ctx_table->context_count);
+
+	return 0;
+}
+
+static void table_free(struct lowpan_context_table *ctx_table)
+{
+	struct lowpan_context_entry *entry = NULL;
+
+	rcu_read_lock();
+
+	/* Clear context table. */
+	if (atomic_read(&ctx_table->context_count)) {
+		list_for_each_entry_rcu(entry,
+					&ctx_table->context_entries,
+					list)
+			entry_free(entry);
+	}
+
+	rcu_read_unlock();
+
+	/* Remove context table. */
+	list_del(&ctx_table->list);
+	kfree(ctx_table);
+}
+
+static inline struct net_device *find_netdev(const char *name)
+{
+	struct net_device *netdev;
+
+	rcu_read_lock();
+	netdev = dev_get_by_name_rcu(&init_net, name);
+	rcu_read_unlock();
+
+	return netdev;
+}
+
+static struct lowpan_context_table *get_table(struct net_device *netdev)
+{
+	struct lowpan_context_table *entry;
+	struct lowpan_context_table *net_table = NULL;
+
+	spin_lock(&module_lock);
+
+	list_for_each_entry(entry, &context_tables, list) {
+		if (entry->netdev == netdev) {
+			/* Table has been found. */
+			net_table = entry;
+			break;
+		}
+	}
+
+	spin_unlock(&module_lock);
+
+	return net_table;
+}
+
+static struct lowpan_context_entry *
+get_ctx_by_cid(struct lowpan_context_table *table, u8 cid)
+{
+	struct lowpan_context_entry *entry;
+	struct lowpan_context_entry *context = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(entry, &table->context_entries, list) {
+		if (entry->cid == cid) {
+			/* Context entry has been found. */
+			context = entry;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return context;
+}
+
+static struct lowpan_context_entry *
+get_ctx_by_addr(struct lowpan_context_table *table, struct in6_addr *addr)
+{
+	struct lowpan_context_entry *entry;
+	struct lowpan_context_entry *best_match = NULL;
+	unsigned int compare_len;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(entry, &table->context_entries, list) {
+		if (!entry->compression_flag)
+			continue;
+
+		compare_len = entry->prefix_len >= 64 ? entry->prefix_len : 64;
+		if (ipv6_prefix_equal(addr, &entry->prefix, compare_len)) {
+			/* Valid context entry has been found. Check if prefix
+			 * can cover more bytes than previous one.
+			 */
+			if (!best_match ||
+			    (best_match->prefix_len < entry->prefix_len))
+				best_match = entry;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return best_match;
+}
+
+ssize_t lowpan_context_dbgfs_write(struct file *fp,
+				   const char __user *user_buffer,
+				   size_t count,
+				   loff_t *position)
+{
+	char buf[128];
+	char str_operation[16];
+	char str_interface[16];
+	char str_ipv6addr[40];
+	size_t buf_size = min(count, sizeof(buf) - 1);
+	int n;
+	int ret;
+	u8 cid;
+	unsigned int prefix_length;
+	unsigned int c_flag;
+	struct in6_addr ctx_prefix;
+	struct net_device *netdev;
+	struct lowpan_context_table *ctx_table;
+	struct lowpan_context_entry *entry;
+
+	memset(&ctx_prefix, 0, sizeof(ctx_prefix));
+
+	if (copy_from_user(buf, user_buffer, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+
+	/* Parse input parameters. */
+	n = sscanf(buf, "%s %s %hhd %s %d %d",
+		   str_operation, str_interface, &cid, str_ipv6addr,
+		   &prefix_length, &c_flag);
+
+	netdev = find_netdev(str_interface);
+	/* Look up for net device. */
+	if (!netdev) {
+		LOWPAN_DBG("Cannot find given interface");
+		return -EINVAL;
+	}
+
+	if (!CHECK_CID_RANGE(cid)) {
+		LOWPAN_DBG("CID value is out of range");
+		return -EINVAL;
+	}
+
+	/* Get context table. */
+	ctx_table = get_table(netdev);
+
+	if (!ctx_table) {
+		LOWPAN_DBG("Cannot find context table for %s interface",
+			   str_interface);
+		return -EINVAL;
+	}
+
+	entry = get_ctx_by_cid(ctx_table, cid);
+
+	/* Execute command. */
+	if (!memcmp(str_operation, LOWPAN_CONTEXT_COMMAND_ADD,
+		    sizeof(LOWPAN_CONTEXT_COMMAND_ADD))) {
+		/* Parse IPv6 address. */
+		in6_pton(str_ipv6addr,
+			 sizeof(str_ipv6addr),
+			 ctx_prefix.s6_addr,
+			 '\0',
+			 NULL);
+
+		/* Check parameters. */
+		if (ipv6_addr_any(&ctx_prefix) ||
+		    !CHECK_PREFIX_RANGE(prefix_length)) {
+			LOWPAN_DBG("Given parameters are not valid");
+			return -EINVAL;
+		}
+
+		LOWPAN_DBG("Got request: I:%s CID:%d Prefix:%pI6c/%d C:%d",
+			   str_interface, cid, &ctx_prefix, prefix_length,
+			   !!c_flag);
+
+		/* Check if entry for given CID already exists. */
+		if (entry) {
+			/* Just update parameters. */
+			rcu_read_lock();
+			entry_update(entry, cid, ctx_prefix, prefix_length,
+				     !!c_flag);
+			rcu_read_unlock();
+		} else {
+			/* Create a new entry. */
+			ret = entry_add(ctx_table, cid, ctx_prefix,
+					prefix_length, !!c_flag);
+			if (ret < 0) {
+				LOWPAN_DBG("Cannot add context entry");
+				return ret;
+			}
+		}
+	} else if (memcmp(str_operation, LOWPAN_CONTEXT_COMMAND_REMOVE,
+			  sizeof(LOWPAN_CONTEXT_COMMAND_REMOVE)) == 0) {
+		LOWPAN_DBG("Got new remove request: I:%s CID:%d",
+			   str_interface, cid);
+
+		if (!entry) {
+			LOWPAN_DBG("Cannot find context entry");
+			return -EINVAL;
+		}
+
+		rcu_read_lock();
+		entry_free(entry);
+		rcu_read_unlock();
+	} else {
+		LOWPAN_DBG("Invalid command - Cannot process the request");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static int lowpan_context_show(struct seq_file *f, void *ptr)
+{
+	struct lowpan_context_table *table;
+	struct lowpan_context_entry *entry;
+
+	list_for_each_entry(table, &context_tables, list) {
+		if (!atomic_read(&table->context_count))
+			break;
+
+		seq_printf(f, "Context table of interface %s\r\n\r\n",
+			   table->netdev->name);
+		seq_printf(f, "%-3s %-39s %-3s %-3s \r\n",
+			   "CID", "Prefix", "Len", "CF");
+
+		list_for_each_entry_rcu(entry, &table->context_entries, list)
+			seq_printf(f, "%-3d %-39pI6c %-3d %-3s \r\n",
+				   entry->cid,
+				   &entry->prefix,
+				   entry->prefix_len,
+				   entry->compression_flag ? "1" : "0");
+		seq_puts(f, "\r\n\r\n");
+	}
+
+	return 0;
+}
+
+int lowpan_context_dbgfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lowpan_context_show, inode->i_private);
+}
+
+int lowpan_context_table_alloc(struct net_device *netdev)
+{
+	struct lowpan_context_table *ctx_table = NULL;
+
+	if (!netdev) {
+		LOWPAN_DBG("Network device has to be specified");
+		return -EPERM;
+	}
+
+	/* Look for context table. */
+	ctx_table = get_table(netdev);
+
+	if (ctx_table) {
+		LOWPAN_DBG("Context table already exists for interface %s %p",
+			   netdev->name, ctx_table);
+		return -EEXIST;
+	}
+
+	ctx_table = kzalloc(sizeof(*ctx_table), GFP_ATOMIC);
+	if (!ctx_table)
+		return -ENOMEM;
+
+	/* Assign network device to context table. */
+	ctx_table->netdev = netdev;
+
+	/* Initialize contexts list. */
+	INIT_LIST_HEAD(&ctx_table->context_entries);
+
+	spin_lock(&module_lock);
+	INIT_LIST_HEAD(&ctx_table->list);
+	list_add_rcu(&ctx_table->list, &context_tables);
+	spin_unlock(&module_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_table_alloc);
+
+int lowpan_context_table_free(struct net_device *netdev)
+{
+	struct lowpan_context_table *ctx_table = NULL;
+
+	if (!netdev) {
+		LOWPAN_DBG("Network device has to be specified");
+		return -EPERM;
+	}
+
+	/* Look for context table. */
+	ctx_table = get_table(netdev);
+	if (!ctx_table) {
+		LOWPAN_DBG("Cannot find context table for interface %s",
+			   netdev->name);
+		return -ENOENT;
+	}
+
+	spin_lock(&module_lock);
+	table_free(ctx_table);
+	spin_unlock(&module_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_table_free);
+
+int lowpan_context_add(struct net_device *netdev,
+		       struct lowpan_context_entry *entry)
+{
+	int ret;
+	struct lowpan_context_table *ctx_table = NULL;
+	struct lowpan_context_entry *stored_entry = NULL;
+
+	if (!entry || !netdev) {
+		LOWPAN_DBG("Parameters are incorrect");
+		return -EPERM;
+	}
+
+	/* Get context table.  */
+	ctx_table = get_table(netdev);
+	if (!ctx_table) {
+		LOWPAN_DBG("Cannot find context table for %s interface",
+			   netdev->name);
+		return -EINVAL;
+	}
+
+	stored_entry = get_ctx_by_cid(ctx_table, entry->cid);
+
+	/* Check if entry for given CID already exists. */
+	if (entry) {
+		/* Just update parameters. */
+		rcu_read_lock();
+		entry_update(stored_entry, entry->cid, entry->prefix,
+			     entry->prefix_len, entry->compression_flag);
+		rcu_read_unlock();
+	} else {
+		/* Create a new entry. */
+		ret  = entry_add(ctx_table, entry->cid, entry->prefix,
+				 entry->prefix_len, entry->compression_flag);
+
+		if (ret < 0) {
+			LOWPAN_DBG("Cannot add context entry");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_add);
+
+int lowpan_context_remove(struct lowpan_context_entry *entry)
+{
+	if (!entry) {
+		LOWPAN_DBG("Given entry is NULL");
+		return -EPERM;
+	}
+
+	/* Free given entry. */
+	rcu_read_lock();
+	entry_free(entry);
+	rcu_read_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_remove);
+
+struct lowpan_context_entry *
+lowpan_context_decompress(struct net_device *netdev, u8 cid)
+{
+	struct lowpan_context_table *ctx_table = NULL;
+	struct lowpan_context_entry *entry = NULL;
+
+	if (!netdev) {
+		LOWPAN_DBG("Network device has to be specified");
+		return NULL;
+	}
+
+	/* Get proper interface table. */
+	ctx_table = get_table(netdev);
+	if (!ctx_table) {
+		LOWPAN_DBG("Cannot find context table for interface %s",
+			   netdev->name);
+		return NULL;
+	}
+
+	/* Search for given CID. */
+	entry = get_ctx_by_cid(ctx_table, cid);
+	if (!entry) {
+		LOWPAN_DBG("There is no context of id:%d for interface %s",
+			   cid, netdev->name);
+		return NULL;
+	}
+
+	LOWPAN_DBG("Found context prefix for context of id:%d - %pI6c",
+		   entry->cid, &entry->prefix);
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_decompress);
+
+struct lowpan_context_entry *lowpan_context_compress(struct net_device *netdev,
+						     struct in6_addr *addr)
+{
+	struct lowpan_context_table *ctx_table = NULL;
+	struct lowpan_context_entry *entry = NULL;
+
+	if (!netdev || !addr) {
+		LOWPAN_DBG("Network device and address has to be specified");
+		return NULL;
+	}
+
+	/* Get proper interface table. */
+	ctx_table = get_table(netdev);
+	if (!ctx_table) {
+		LOWPAN_DBG("Cannot find context table for interface %s",
+			   netdev->name);
+		return NULL;
+	}
+
+	/* Search for given address. */
+	entry = get_ctx_by_addr(ctx_table, addr);
+	if (!entry) {
+		LOWPAN_DBG("No context for address %pI6c for interface %s",
+			   addr, netdev->name);
+		return NULL;
+	}
+
+	LOWPAN_DBG("Found context of id:%d", entry->cid);
+
+	/* Return null in case no compression capability in found context */
+	return entry;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_compress);
+
+const struct file_operations lowpan_context_fops = {
+	.open	 = lowpan_context_dbgfs_open,
+	.read	 = seq_read,
+	.write	 = lowpan_context_dbgfs_write,
+	.llseek	 = seq_lseek,
+	.release = single_release
+};
+
+void lowpan_context_init(void)
+{
+	lowpan_context_debugfs = debugfs_create_file("context", 0664,
+						     lowpan_debugfs, NULL,
+						     &lowpan_context_fops);
+}
+EXPORT_SYMBOL_GPL(lowpan_context_init);
+
+void lowpan_context_uninit(void)
+{
+	struct lowpan_context_table *entry = NULL;
+
+	spin_lock(&module_lock);
+
+	list_for_each_entry(entry, &context_tables, list)
+		table_free(entry);
+
+	spin_unlock(&module_lock);
+
+	debugfs_remove(lowpan_context_debugfs);
+}
+EXPORT_SYMBOL_GPL(lowpan_context_uninit);
diff --git a/net/6lowpan/context.h b/net/6lowpan/context.h
new file mode 100644
index 0000000..88303b5
--- /dev/null
+++ b/net/6lowpan/context.h
@@ -0,0 +1,7 @@
+#ifndef __6LOWPAN_CONTEXT_H
+#define __6LOWPAN_CONTEXT_H
+
+void lowpan_context_init(void);
+void lowpan_context_uninit(void);
+
+#endif /* __6LOWPAN_CONTEXT_H */
-- 
2.1.4

