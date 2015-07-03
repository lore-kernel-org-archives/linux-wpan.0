Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:55757 "EHLO
	ironport02.nordicsemi.no" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754136AbbGCNXp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Jul 2015 09:23:45 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [RFC 1/2] 6lowpan: Add stateful compression for IPHC
Date: Fri, 3 Jul 2015 15:23:37 +0200
Message-ID: <1435929818-6044-2-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

The patch adds stateful compression (context ids based compression) to the
6lowpan module [RFC6282]. The code does not impact current stateless
compression but only introducing a new feature for IPHC.

Stateful Compression users allocate context tables through the functions in
the context.c using public APIs declared in 6lowpan.h. The context.c is
extending the 6lowpan module and not created as a separate module.

A debugfs for maintaining the context tables is implemented
(/sys/kernel/debug/6lowpan/context).

As context.c is not a separate module the logical place to put this is in the
iphc.c. In the long term this is not needed and can be removed.
(See the discussion section below).

Command usage for the debugfs:

echo "<COMMAND> <INTERFACE> <CONTEXT_ID> <CONTEXT_PREFIX> <CONTEXT_PREFIX_LENGTH> <COMPRESSION_ENABLE_FLAG" > /sys/kernel/debug/6lowpan/context

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
 include/net/6lowpan.h |  37 ++++
 net/6lowpan/Makefile  |   2 +-
 net/6lowpan/context.c | 523 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/context.h |  13 ++
 net/6lowpan/iphc.c    | 259 +++++++++++++++++++++----
 5 files changed, 791 insertions(+), 43 deletions(-)
 create mode 100644 net/6lowpan/context.c
 create mode 100644 net/6lowpan/context.h

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index dc03d77..27dc870 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -197,6 +197,28 @@
 #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
 #define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
 
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
+
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
@@ -335,6 +357,10 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	if (!(iphc0 & 0x03))
 		ret++;
 
+	if (iphc1 & LOWPAN_IPHC_CID) {
+		ret++;
+	}
+
 	ret += lowpan_addr_mode_size((iphc1 & LOWPAN_IPHC_SAM) >>
 				     LOWPAN_IPHC_SAM_BIT);
 
@@ -372,6 +398,17 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
+int lowpan_context_table_alloc(struct net_device *netdev);
+int lowpan_context_table_free(struct net_device *netdev);
+int lowpan_context_free_all(void);
+int lowpan_context_add(struct net_device *netdev,
+		       struct lowpan_context_entry *entry);
+int lowpan_context_remove(struct lowpan_context_entry *entry);
+struct lowpan_context_entry *lowpan_context_decompress(struct net_device *netdev,
+						       u8 cid);
+struct lowpan_context_entry *lowpan_context_compress(struct net_device *netdev,
+						     struct in6_addr *addr);
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
index 0000000..b38dcf3
--- /dev/null
+++ b/net/6lowpan/context.c
@@ -0,0 +1,523 @@
+/**
+   Copyright (c)  2015 Nordic Semiconductor. All Rights Reserved.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+ */
+
+#include <linux/if_arp.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/inet.h>
+
+#include <net/ipv6.h>
+#include <net/addrconf.h>
+#include <net/6lowpan.h>
+
+#include <asm/atomic.h>
+
+#define LOWPAN_DBG(fmt, ...)  pr_debug(fmt "\n", ##__VA_ARGS__)
+
+#define LOWPAN_CONTEXT_TABLE_MAX_SIZE 16
+#define LOWPAN_CONTEXT_COMMAND_ADD    "add"
+#define LOWPAN_CONTEXT_COMMAND_REMOVE "remove"
+
+#define CHECK_CID_RANGE(cid) ((cid) > 0 && (cid) < LOWPAN_CONTEXT_TABLE_MAX_SIZE)
+#define CHECK_PREFIX_RANGE(len) ((len) > 0 && (len) <= 128)
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
+		    u8 cid,
+		    struct in6_addr prefix,
+		    unsigned int prefix_len,
+		    bool compression_flag)
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
+		list_for_each_entry_rcu(entry, &ctx_table->context_entries, list) {
+			entry_free(entry);
+		}
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
+
+	spin_lock(&module_lock);
+
+	list_for_each_entry(entry, &context_tables, list) {
+			if (entry->netdev == netdev) {
+				/* Table has been found. */
+				spin_unlock(&module_lock);
+				return entry;
+			}
+	}
+
+	spin_unlock(&module_lock);
+
+	return NULL;
+}
+
+static struct lowpan_context_entry *get_ctx_by_cid(struct lowpan_context_table *table,
+						   u8 cid)
+{
+	struct lowpan_context_entry *entry = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(entry, &table->context_entries, list) {
+		if (entry->cid == cid) {
+			/* Context entry has been found. */
+			rcu_read_unlock();
+			return entry;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+static struct lowpan_context_entry *get_ctx_by_addr(struct lowpan_context_table *table,
+						    struct in6_addr *addr)
+{
+	struct lowpan_context_entry *entry;
+	struct lowpan_context_entry *best_match = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(entry, &table->context_entries, list) {
+		if (entry->compression_flag) {
+			if (ipv6_prefix_equal(addr, &entry->prefix,
+					(entry->prefix_len >= 64) ? entry->prefix_len : 64)) {
+				/* Valid context entry has been found. Check if prefix can cover
+				 * more bytes than previous one.
+				 */
+				if (!best_match || (best_match->prefix_len < entry->prefix_len)) {
+					best_match = entry;
+				}
+			}
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
+	char buf[128], str_operation[16], str_interface[16], str_ipv6addr[40];
+	size_t buf_size = min(count, sizeof(buf) - 1);
+	int n, ret;
+	u8 cid;
+	unsigned int prefix_length, c_flag;
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
+			str_operation, str_interface, &cid, str_ipv6addr,
+			&prefix_length, &c_flag);
+
+	/* Look up for net device. */
+	if (!(netdev = find_netdev(str_interface))) {
+		LOWPAN_DBG("Cannot find given interface");
+		return -EINVAL;
+	}
+
+	if (!CHECK_CID_RANGE(cid)) {
+		LOWPAN_DBG("CID value is out of range");
+		return -EINVAL;
+	}
+
+	if (!(ctx_table = get_table(netdev))){
+		LOWPAN_DBG("Cannot find context table for %s interface",
+				str_interface);
+		return -EINVAL;
+	}
+
+	entry = get_ctx_by_cid(ctx_table, cid);
+
+	/* Execute command. */
+	if (memcmp(str_operation, LOWPAN_CONTEXT_COMMAND_ADD,
+			sizeof(LOWPAN_CONTEXT_COMMAND_ADD)) == 0) {
+		/* Parse IPv6 address. */
+		in6_pton(str_ipv6addr,
+			 sizeof(str_ipv6addr),
+			 ctx_prefix.s6_addr,
+			 '\0',
+			 NULL);
+
+		/* Check parameters. */
+		if(ipv6_addr_any(&ctx_prefix) || !CHECK_PREFIX_RANGE(prefix_length)) {
+			LOWPAN_DBG("Given parameters are not valid");
+			return -EINVAL;
+		}
+
+		LOWPAN_DBG("Got new add request: I:%s CID:%d Prefix:%pI6c/%d C:%d",
+				str_interface, cid, &ctx_prefix, prefix_length, c_flag);
+
+		/* Check if entry for given CID already exists. */
+		if (entry) {
+			/* Just update parameters. */
+			rcu_read_lock();
+			entry_update(entry, cid, ctx_prefix, prefix_length,
+					(bool)c_flag);
+			rcu_read_unlock();
+		}
+		else {
+			/* Create a new entry. */
+			if((ret = entry_add(ctx_table, cid, ctx_prefix, prefix_length,
+					(bool)c_flag)) < 0) {
+				LOWPAN_DBG("Cannot add context entry");
+				return ret;
+			}
+		}
+	}
+	else if (memcmp(str_operation, LOWPAN_CONTEXT_COMMAND_REMOVE,
+			sizeof(LOWPAN_CONTEXT_COMMAND_REMOVE)) == 0) {
+		LOWPAN_DBG("Got new remove request: I:%s CID:%d",
+				str_interface, cid);
+
+		if (!entry) {
+			LOWPAN_DBG("Cannot find context entry");
+			return -EINVAL;
+		}
+
+		rcu_read_lock();
+		entry_free(entry);
+		rcu_read_unlock();
+	}
+	else {
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
+	spin_lock(&module_lock);
+
+	list_for_each_entry(table, &context_tables, list) {
+		if (atomic_read(&table->context_count)) {
+			seq_printf(f, "Context table of interface %s\r\n\r\n",
+					table->netdev->name);
+			seq_printf(f, "%-3s %-39s %-3s %-3s \r\n",
+					"CID", "Prefix", "Len", "CF");
+
+			list_for_each_entry_rcu(entry, &table->context_entries, list) {
+				seq_printf(f, "%-3d %-39pI6c %-3d %-3s \r\n",
+					entry->cid,
+					&entry->prefix,
+					entry->prefix_len,
+					entry->compression_flag ? "1" : "0");
+			}
+
+			seq_printf(f, "\r\n\r\n");
+		}
+	}
+
+	spin_unlock(&module_lock);
+
+	return 0;
+}
+
+int lowpan_context_dbgfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lowpan_context_show, inode->i_private);
+}
+
+int lowpan_context_free_all(void)
+{
+	struct lowpan_context_table *entry = NULL;
+
+	spin_lock(&module_lock);
+
+	list_for_each_entry(entry, &context_tables, list) {
+		table_free(entry);
+	}
+
+	spin_unlock(&module_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_free_all);
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
+				netdev->name, ctx_table);
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
+				netdev->name);
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
+	if (!(ctx_table = get_table(netdev))){
+		LOWPAN_DBG("Cannot find context table for %s interface", netdev->name);
+		return -EINVAL;
+	}
+
+	stored_entry = get_ctx_by_cid(ctx_table, entry->cid);
+
+	/* Check if entry for given CID already exists. */
+	if (entry) {
+		/* Just update parameters. */
+		rcu_read_lock();
+		entry_update(stored_entry,
+			     entry->cid,
+			     entry->prefix,
+			     entry->prefix_len,
+			     entry->compression_flag);
+		rcu_read_unlock();
+	}
+	else {
+		/* Create a new entry. */
+		if ((ret = entry_add(ctx_table, entry->cid, entry->prefix,
+				entry->prefix_len, entry->compression_flag)) < 0) {
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
+struct lowpan_context_entry *lowpan_context_decompress(struct net_device *netdev,
+						       u8 cid)
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
+		LOWPAN_DBG("Cannot find context table for interface %s", netdev->name);
+		return NULL;
+	}
+
+	/* Search for given CID. */
+	entry = get_ctx_by_cid(ctx_table, cid);
+	if (!entry) {
+		LOWPAN_DBG("There is no context of id:%d for interface %s",
+				cid, netdev->name);
+		return NULL;
+	}
+
+	LOWPAN_DBG("Found context prefix for context of id:%d - %pI6c",
+			entry->cid, &entry->prefix);
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
+	}
+
+	/* Get proper interface table. */
+	ctx_table = get_table(netdev);
+	if (!ctx_table) {
+		LOWPAN_DBG("Cannot find context table for interface %s",
+				netdev->name);
+		return NULL;
+	}
+
+	/* Search for given address. */
+	entry = get_ctx_by_addr(ctx_table, addr);
+	if (!entry) {
+		LOWPAN_DBG("There is no context for address %pI6c for interface %s",
+				addr, netdev->name);
+		return NULL;
+	}
+
+	LOWPAN_DBG("Found context of id:%d", entry->cid);
+
+	/* Return null in case no compression capability in found context */
+	return entry;
+}
+EXPORT_SYMBOL_GPL(lowpan_context_compress);
diff --git a/net/6lowpan/context.h b/net/6lowpan/context.h
new file mode 100644
index 0000000..b9e26e5
--- /dev/null
+++ b/net/6lowpan/context.h
@@ -0,0 +1,13 @@
+#ifndef __6LOWPAN_CONTEXT_H
+#define __6LOWPAN_CONTEXT_H
+
+#include <linux/debugfs.h>
+
+ssize_t lowpan_context_dbgfs_write(struct file *fp,
+				   const char __user *user_buffer,
+				   size_t count,
+				   loff_t *position);
+
+int lowpan_context_dbgfs_open(struct inode *inode, struct file *file);
+
+#endif /* __6LOWPAN_CONTEXT_H */
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 9055d7b..b777fd3 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -55,6 +55,62 @@
 #include <net/af_ieee802154.h>
 
 #include "nhc.h"
+#include "context.h"
+
+#define CTX_SRC(context)  ((context & 0xf0) >> 4)
+#define CTX_DEST(context) (context & 0x0f)
+#define CID_NOT_USED      0xff
+
+static struct dentry *lowpan_debugfs;
+static struct dentry *lowpan_context_debugfs;
+
+/* Add context prefix into given IPv6 address.
+ * Context prefix is always used, therefore any original bits can be overwritten.
+ */
+static inline void add_cid_prefix(struct in6_addr *ipaddr,
+				  struct lowpan_context_entry *ctx_entry)
+{
+	int o = ctx_entry->prefix_len >> 3,
+		b = ctx_entry->prefix_len & 0x7;
+
+	memcpy(ipaddr->s6_addr, ctx_entry->prefix.s6_addr, o);
+	if (b != 0) {
+		ipaddr->s6_addr[o] = ctx_entry->prefix.s6_addr[o] & (0xff00 >> b);
+	}
+}
+
+/* Check if address can be fully compressed with stateful compression. */
+static inline bool lowpan_address_is_covered_by_cid(struct in6_addr *ipaddr,
+						    struct in6_addr *ctx_addr,
+						    unsigned int ctx_length,
+						    u8 *lladdr)
+{
+	unsigned int start_byte, offset;
+
+	/* Context covers IPv6 address by its size. */
+	if (ctx_length == 128) {
+		return true;
+	}
+
+	/* Check if IID can be retrieved in case of longer prefix than 64 bits. */
+	if (ctx_length > 64) {
+	/* Check only IID fields that are not covered by context prefix. */
+		start_byte = ctx_length << 3;
+		offset = ctx_length % 8;
+
+		/* Check all bytes from the second one. */
+		if (start_byte == 15 ||
+		    0 == memcmp(&ipaddr->s6_addr[start_byte+1],
+				&lladdr[start_byte-7],
+				15-start_byte)) {
+			/* Then check first byte. */
+			return (u8)(ipaddr->s6_addr[start_byte] << offset) ==
+				(u8)(lladdr[start_byte] << offset);
+		}
+	}
+
+	return false;
+}
 
 /* Uncompress address function for source and
  * destination address(non-multicast).
@@ -137,39 +193,84 @@ static int uncompress_addr(struct sk_buff *skb,
 	return 0;
 }
 
-/* Uncompress address function for source context
- * based address(non-multicast).
- */
-static int uncompress_context_based_src_addr(struct sk_buff *skb,
-					     struct in6_addr *ipaddr,
-					     const u8 sam)
+/* Uncompress address after stateful compression. */
+static int uncompress_context_based_addr(struct sk_buff *skb, struct net_device *dev,
+					 struct in6_addr *ipaddr, const u8 address_mode,
+					 const u8 *lladdr, const u8 addr_type,
+					 const u8 addr_len, const u8 context_id)
 {
-	switch (sam) {
-	case LOWPAN_IPHC_ADDR_00:
-		/* unspec address ::
+	bool fail = false;
+	struct lowpan_context_entry *ctx_entry;
+
+	if (address_mode == LOWPAN_IPHC_ADDR_00) {
+		/* Unspecified address ::
 		 * Do nothing, address is already ::
 		 */
-		break;
-	case LOWPAN_IPHC_ADDR_01:
-		/* TODO */
-	case LOWPAN_IPHC_ADDR_02:
-		/* TODO */
-	case LOWPAN_IPHC_ADDR_03:
-		/* TODO */
-		netdev_warn(skb->dev, "SAM value 0x%x not supported\n", sam);
-		return -EINVAL;
-	default:
-		pr_debug("Invalid sam value: 0x%x\n", sam);
-		return -EINVAL;
+	} else {
+		/* Look for prefix assigned to given context id. */
+		ctx_entry = lowpan_context_decompress(dev, context_id);
+		if (!ctx_entry) {
+			pr_debug("Unknown Context ID. Unable to decompress the address\n");
+			return -EINVAL;
+		}
+
+		switch (address_mode) {
+			case LOWPAN_IPHC_ADDR_01:
+				/* CID Prefix + 64-bits in-line. */
+				fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[8], 8);
+			break;
+			case LOWPAN_IPHC_ADDR_02:
+				/* CID Prefix + 16-bits in-line. */
+				ipaddr->s6_addr[11] = 0xFF;
+				ipaddr->s6_addr[12] = 0xFE;
+				fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[14], 2);
+			break;
+			case LOWPAN_IPHC_ADDR_03:
+				switch (addr_type) {
+				case IEEE802154_ADDR_LONG:
+					/* CID Prefix + 64-bits from LL Address. */
+					memcpy(&ipaddr->s6_addr[8],
+					       lladdr,
+					       addr_len);
+
+					/* Second bit-flip (Universe/Local)
+					* is done according RFC2464
+					*/
+					ipaddr->s6_addr[8] ^= 0x02;
+					break;
+				case IEEE802154_ADDR_SHORT:
+					/* CID Prefix + 16-bits from LL Address. */
+					ipaddr->s6_addr[11] = 0xFF;
+					ipaddr->s6_addr[12] = 0xFE;
+					ipaddr->s6_addr16[7] = htons(*((u16 *)lladdr));
+					break;
+				default:
+					pr_debug("Invalid addr_type set\n");
+					return -EINVAL;
+				}
+			break;
+			default:
+				pr_debug("Invalid address mode value: 0x%x\n",
+						address_mode);
+				return -EINVAL;
+		}
+
+		if (fail) {
+			pr_debug("Failed to fetch skb data\n");
+			return -EIO;
+		}
+
+		/* Add context prefix to IPv6 address. Context bits are always used. */
+		add_cid_prefix(ipaddr, ctx_entry);
 	}
 
-	raw_dump_inline(NULL,
-			"Reconstructed context based ipv6 src addr is",
-			ipaddr->s6_addr, 16);
+	raw_dump_inline(NULL, "Reconstructed ipv6 addr is",
+		ipaddr->s6_addr, 16);
 
-	return 0;
+    return 0;
 }
 
+
 /* Uncompress function for multicast destination address,
  * when M bit is set.
  */
@@ -320,7 +421,8 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	if (iphc1 & LOWPAN_IPHC_SAC) {
 		/* Source address context based uncompression */
 		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = uncompress_context_based_src_addr(skb, &hdr.saddr, tmp);
+		err = uncompress_context_based_addr(skb, dev, &hdr.saddr, tmp,
+			saddr, saddr_type, saddr_len, CTX_SRC(num_context));
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
@@ -348,10 +450,18 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 				return -EINVAL;
 		}
 	} else {
-		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
-				      daddr_type, daddr_len);
-		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
-			 tmp, &hdr.daddr);
+		if (iphc1 & LOWPAN_IPHC_DAC) {
+			/* Destination address context based uncompression */
+			pr_debug("DAC bit is set. Handle context based source address.\n");
+			err = uncompress_context_based_addr(skb, dev, &hdr.daddr, tmp,
+				daddr, daddr_type, daddr_len, CTX_DEST(num_context));
+		} else {
+			/* Destination address uncompression */
+			pr_debug("destination address stateless compression\n");
+			err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
+				daddr_type, daddr_len);
+		}
+
 		if (err)
 			return -EINVAL;
 	}
@@ -389,11 +499,12 @@ EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 				  const struct in6_addr *ipaddr,
-				  const unsigned char *lladdr)
+				  const unsigned char *lladdr,
+				  bool cover_by_context)
 {
 	u8 val = 0;
 
-	if (is_addr_mac_addr_based(ipaddr, lladdr)) {
+	if (is_addr_mac_addr_based(ipaddr, lladdr) || cover_by_context) {
 		val = 3; /* 0-bits */
 		pr_debug("address compression 0 bits\n");
 	} else if (lowpan_is_iid_16_bit_compressable(ipaddr)) {
@@ -418,9 +529,13 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			   const void *_saddr, unsigned int len)
 {
 	u8 tmp, iphc0, iphc1, *hc_ptr;
+	u8 cid = 0;
 	struct ipv6hdr *hdr;
 	u8 head[100] = {};
 	int ret, addr_type;
+	struct lowpan_context_entry *entry;
+	bool scid_used = false, dcid_used = false,
+	 scid_cover = false, dcid_cover = false;
 
 	if (type != ETH_P_IPV6)
 		return -EINVAL;
@@ -444,7 +559,26 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	iphc0 = LOWPAN_DISPATCH_IPHC;
 	iphc1 = 0;
 
-	/* TODO: context lookup */
+	/* Look for source context. */
+	entry = lowpan_context_compress(dev, &hdr->saddr);
+	if (entry) {
+		cid = entry->cid << 4;
+		scid_used = true;
+	}
+
+	/* Look for destination context. */
+	entry = lowpan_context_compress(dev, &hdr->daddr);
+	if (entry) {
+		cid |= entry->cid;
+		dcid_used = true;
+	}
+
+	if (scid_used || dcid_used) {
+		/* Add CID flag. */
+		iphc1 |= LOWPAN_IPHC_CID;
+
+		lowpan_push_hc_data(&hc_ptr, &cid, 1);
+	}
 
 	raw_dump_inline(__func__, "saddr",
 			(unsigned char *)_saddr, IEEE802154_ADDR_LEN);
@@ -531,12 +665,20 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		pr_debug("source address is unspecified, setting SAC\n");
 		iphc1 |= LOWPAN_IPHC_SAC;
 	} else {
-		if (addr_type & IPV6_ADDR_LINKLOCAL) {
+		if ((addr_type & IPV6_ADDR_LINKLOCAL) || scid_used) {
+			/* In case of stateful source address compression, set SAC bit. */
+			if (scid_used) {
+				iphc1 |= LOWPAN_IPHC_SAC;
+				scid_cover = lowpan_address_is_covered_by_cid(&hdr->saddr,
+					&entry->prefix, entry->prefix_len, (u8 *)_saddr);
+			}
+
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 							 LOWPAN_IPHC_SAM_BIT,
-							 &hdr->saddr, _saddr);
-			pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
-				 &hdr->saddr, iphc1);
+							 &hdr->saddr, _saddr,
+							 scid_cover);
+			pr_debug("source ipv6 address %pI6c iphc1 0x%02x\n",
+				&hdr->saddr, iphc1);
 		} else {
 			pr_debug("send the full source address\n");
 			lowpan_push_hc_data(&hc_ptr, hdr->saddr.s6_addr, 16);
@@ -576,12 +718,20 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
 		}
 	} else {
-		if (addr_type & IPV6_ADDR_LINKLOCAL) {
-			/* TODO: context lookup */
+		if (addr_type & IPV6_ADDR_LINKLOCAL || dcid_used) {
+			/* In case of stateful destination address compression, set DAC bit. */
+			if (dcid_used) {
+				iphc1 |= LOWPAN_IPHC_DAC;
+				dcid_cover = lowpan_address_is_covered_by_cid(&hdr->daddr,
+					&entry->prefix, entry->prefix_len, (u8 *)_daddr);
+			}
+
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
-				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, _daddr);
-			pr_debug("dest address unicast link-local %pI6c "
-				 "iphc1 0x%02x\n", &hdr->daddr, iphc1);
+							 LOWPAN_IPHC_DAM_BIT,
+							 &hdr->daddr, _daddr,
+							 dcid_cover);
+			pr_debug("destination ipv6 address %pI6c iphc1 0x%02x\n",
+				&hdr->daddr, iphc1);
 		} else {
 			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
 			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
@@ -611,8 +761,23 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(lowpan_header_compress);
 
+const struct file_operations lowpan_context_fops = {
+	.open	= lowpan_context_dbgfs_open,
+	.read	= seq_read,
+	.write   = lowpan_context_dbgfs_write,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
 static int __init lowpan_module_init(void)
 {
+
+	lowpan_debugfs = debugfs_create_dir("6lowpan", NULL);
+
+	lowpan_context_debugfs = debugfs_create_file("context", 0644,
+						     lowpan_debugfs, NULL,
+						     &lowpan_context_fops);
+
 	request_module_nowait("ipv6");
 
 	request_module_nowait("nhc_dest");
@@ -625,6 +790,16 @@ static int __init lowpan_module_init(void)
 
 	return 0;
 }
+
+static void __exit lowpan_module_exit(void)
+{
+	debugfs_remove(lowpan_context_debugfs);
+	debugfs_remove(lowpan_debugfs);
+
+	lowpan_context_free_all();
+}
+
 module_init(lowpan_module_init);
+module_exit(lowpan_module_exit);
 
 MODULE_LICENSE("GPL");
-- 
2.1.4

