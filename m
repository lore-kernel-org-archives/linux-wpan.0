Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34063 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbbGWGwO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Jul 2015 02:52:14 -0400
Date: Thu, 23 Jul 2015 08:52:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC v2 2/4] 6lowpan: Add stateful compression component of
 6lowpan module
Message-ID: <20150723065209.GB1941@omega>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
 <1436788233-13960-3-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1436788233-13960-3-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Hi,

On Mon, Jul 13, 2015 at 01:50:31PM +0200, Lukasz Duda wrote:
> The patch adds stateful compression (context ids based compression) to
> the 6lowpan module [RFC6282].
> 
> Stateful Compression users allocate context tables through the functions
> in the context.c using public APIs declared in 6lowpan.h. The context.c
> is extending the 6lowpan module and not created as a separate module.
> 
> A debugfs entry for maintaining the context tables is implemented
> (/sys/kernel/debug/6lowpan/context).
> 
> Example usage of the 6lowpan debugfs interface:
> 
> echo "<CMD> <IFACE> <CID> <CID_PREFIX> <CID_PREFIX_LENGTH>
> <COMPRESSION_ENABLE_FLAG>" > /sys/kernel/debug/6lowpan/context
> 
> Examples:
> 
> echo "add bt0 3 2001:db8:: 64 1" > /sys/kernel/debug/6lowpan/context
> 
> echo "remove bt0 3" > /sys/kernel/debug/6lowpan/context
> 
> cat /sys/kernel/debug/6lowpan/context
> 
> e.g.
> Context table of interface bt0
> 
> CID Prefix      Len CF
> 3   2001:db8::  64  1
> 4   2001:db8::1 128 1
> 

I tried to test it and I got a:

[  132.092412] =================================
[  132.096976] [ INFO: inconsistent lock state ]
[  132.101545] 4.1.0-268283-gca74796 #9 Tainted: G        W      
[  132.107650] ---------------------------------
[  132.112214] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  132.118506] sh/1254 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  132.123525]  (module_lock){+.?...}, at: [<bf07e6e4>] get_table+0x14/0x5c [6lowpan]
[  132.131536] {IN-SOFTIRQ-W} state was registered at:
[  132.136645]   [<c06c1d30>] _raw_spin_lock+0x30/0x40
[  132.141785]   [<bf07e6e4>] get_table+0x14/0x5c [6lowpan]
[  132.147372]   [<bf07f418>] lowpan_context_compress+0x24/0x1d8 [6lowpan]
[  132.154324]   [<bf07d36c>] lowpan_header_compress+0x68/0x6c0 [6lowpan]
[  132.161175]   [<bf0a1648>] lowpan_header+0x84/0x250 [ieee802154_6lowpan]
[  132.168220]   [<bf0a1a98>] lowpan_xmit+0x68/0x344 [ieee802154_6lowpan]
[  132.175070]   [<c04fdeb8>] dev_hard_start_xmit+0x2a8/0x498
[  132.180829]   [<c04fe84c>] __dev_queue_xmit+0x660/0x798
[  132.186315]   [<bf0024c0>] ip6_finish_output2+0x320/0xbb0 [ipv6]
[  132.192845]   [<bf00805c>] ip6_output+0x6c/0x2c8 [ipv6]
[  132.198412]   [<bf02e880>] mld_sendpack+0x32c/0x89c [ipv6]
[  132.204318]   [<bf02f678>] mld_ifc_timer_expire+0x1d4/0x304 [ipv6]
[  132.210929]   [<c00aa9e0>] call_timer_fn+0x7c/0x180
[  132.216055]   [<c00aac54>] run_timer_softirq+0x170/0x2b4
[  132.221626]   [<c00440c8>] __do_softirq+0x138/0x340
[  132.226755]   [<c00445f0>] irq_exit+0xbc/0x130
[  132.231417]   [<c009a618>] __handle_domain_irq+0x6c/0xe0
[  132.237004]   [<c00094ac>] omap_intc_handle_irq+0xa8/0xb8
[  132.242673]   [<c06c2824>] __irq_svc+0x44/0x5c
[  132.247340]   [<c06bffa8>] __mutex_unlock_slowpath+0x10c/0x1a4
[  132.253462]   [<c06bffa8>] __mutex_unlock_slowpath+0x10c/0x1a4
[  132.259586]   [<c01556a8>] unlock_rename+0x18/0x40
[  132.264630]   [<c015c128>] SyS_renameat2+0x258/0x4d0
[  132.269844]   [<c015c3e4>] SyS_rename+0x28/0x30
[  132.274601]   [<c000f5e0>] ret_fast_syscall+0x0/0x54
[  132.279821] irq event stamp: 76337
[  132.283380] hardirqs last  enabled at (76337): [<c000f60c>] ret_fast_syscall+0x2c/0x54
[  132.291686] hardirqs last disabled at (76336): [<c000f5ec>] ret_fast_syscall+0xc/0x54
[  132.299896] softirqs last  enabled at (75714): [<c004422c>] __do_softirq+0x29c/0x340
[  132.308017] softirqs last disabled at (75709): [<c00445f0>] irq_exit+0xbc/0x130
[  132.315683] 
[  132.315683] other info that might help us debug this:
[  132.322515]  Possible unsafe locking scenario:
[  132.322515] 
[  132.328712]        CPU0
[  132.331274]        ----
[  132.333833]   lock(module_lock);
[  132.337228]   <Interrupt>
[  132.339970]     lock(module_lock);
[  132.343547] 
[  132.343547]  *** DEADLOCK ***
[  132.343547] 
[  132.349752] 1 lock held by sh/1254:
[  132.353401]  #0:  (sb_writers#9){.+.+.+}, at: [<c014cff0>] vfs_write+0x13c/0x164
[  132.361210] 
[  132.361210] stack backtrace:
[  132.365788] CPU: 0 PID: 1254 Comm: sh Tainted: G        W       4.1.0-268283-gca74796 #9
[  132.374257] Hardware name: Generic AM33XX (Flattened Device Tree)
[  132.380663] [<c00168c4>] (unwind_backtrace) from [<c00133c0>] (show_stack+0x10/0x14)
[  132.388777] [<c00133c0>] (show_stack) from [<c06ba0b8>] (dump_stack+0x84/0x9c)
[  132.396363] [<c06ba0b8>] (dump_stack) from [<c008beb0>] (print_usage_bug+0x1d8/0x2cc)
[  132.404572] [<c008beb0>] (print_usage_bug) from [<c008c180>] (mark_lock+0x1dc/0x6c4)
[  132.412690] [<c008c180>] (mark_lock) from [<c008d48c>] (__lock_acquire+0x860/0x2048)
[  132.420809] [<c008d48c>] (__lock_acquire) from [<c008f4fc>] (lock_acquire+0xa8/0x124)
[  132.429016] [<c008f4fc>] (lock_acquire) from [<c06c1d30>] (_raw_spin_lock+0x30/0x40)
[  132.437147] [<c06c1d30>] (_raw_spin_lock) from [<bf07e6e4>] (get_table+0x14/0x5c [6lowpan])
[  132.445922] [<bf07e6e4>] (get_table [6lowpan]) from [<bf07ebc0>] (lowpan_context_dbgfs_write+0x128/0x4ec [6lowpan])
[  132.456860] [<bf07ebc0>] (lowpan_context_dbgfs_write [6lowpan]) from [<c014c6a8>] (__vfs_write+0x20/0xd8)
[  132.466884] [<c014c6a8>] (__vfs_write) from [<c014cf44>] (vfs_write+0x90/0x164)
[  132.474540] [<c014cf44>] (vfs_write) from [<c014d76c>] (SyS_write+0x44/0x9c)
[  132.481931] [<c014d76c>] (SyS_write) from [<c000f5e0>] (ret_fast_syscall+0x0/0x54)

You should see the same by enable "CONFIG_PROVE_LOCKING". I think it's
because "spin_lock(&module_lock);" inside of "get_table" function. This
is called by lowpan_xmit which has a softirq context (I think the
experts says here bh (?bottom half?) are disabled). Anyway, you need to
call spin_lock_bh/spin_unlock_bh.

Linux device drivers says something similar:

"Finally, spin_lock_bh disables software interrupts before taking the
lock, but leaves hardware interrupts enabled." Without bh software
interrupts are still enabled.

> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
>  include/net/6lowpan.h |  35 ++++
>  net/6lowpan/Makefile  |   2 +-
>  net/6lowpan/context.c | 551 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/6lowpan/context.h |   7 +
>  4 files changed, 594 insertions(+), 1 deletion(-)
>  create mode 100644 net/6lowpan/context.c
>  create mode 100644 net/6lowpan/context.h
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index 37ddbdf..ee3a455 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -199,6 +199,27 @@
>  
>  extern struct dentry *lowpan_debugfs;
>  
> +struct lowpan_context_table {
> +	struct list_head list;
> +
> +	/* Context entries */
> +	struct net_device *netdev;
> +	struct list_head context_entries;
> +	atomic_t context_count;
> +};
> +
> +struct lowpan_context_entry {
> +	struct list_head list;
> +	struct rcu_head rcu;
> +	struct lowpan_context_table *ctx_table;
> +
> +	/* Context parameters */
> +	u8 cid;
> +	struct in6_addr prefix;
> +	unsigned int prefix_len;
> +	bool compression_flag;
> +};
> +

Is a list really necessary here? I assume that a context-id (one byte
long) with a maximum value of 255. And then it's splitted into sci and
dci, so we have a maximum of 16 and you already introduced nicely an
LOWPAN_CONTEXT_TABLE_SIZE for that.

Can't we simple to some array to have a fast lookup for lowpan_context_table[cid]
and if it's not null then we have an entry for that?

To lookup the CID by an ipv6 address, then we need to iterate the array
and using ipv6_prefix_equal.

>  #ifdef DEBUG
>  /* print data in line */
>  static inline void raw_dump_inline(const char *caller, char *msg,
> @@ -337,6 +358,9 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>  	if (!(iphc0 & 0x03))
>  		ret++;
>  
> +	if (iphc1 & LOWPAN_IPHC_CID)
> +		ret++;
> +
>  	ret += lowpan_addr_mode_size((iphc1 & LOWPAN_IPHC_SAM) >>
>  				     LOWPAN_IPHC_SAM_BIT);
>  
> @@ -374,6 +398,17 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>  	return skb->len + uncomp_header - ret;
>  }
>  
> +int lowpan_context_table_alloc(struct net_device *netdev);
> +int lowpan_context_table_free(struct net_device *netdev);
> +int lowpan_context_free_all(void);
> +int lowpan_context_add(struct net_device *netdev,
> +		       struct lowpan_context_entry *entry);
> +int lowpan_context_remove(struct lowpan_context_entry *entry);
> +struct lowpan_context_entry *
> +lowpan_context_decompress(struct net_device *netdev, u8 cid);
> +struct lowpan_context_entry *
> +lowpan_context_compress(struct net_device *netdev, struct in6_addr *addr);
> +
>  int
>  lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
>  			 const u8 *saddr, const u8 saddr_type,
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index eb8baa7..bda5be0 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -1,6 +1,6 @@
>  obj-$(CONFIG_6LOWPAN) += 6lowpan.o
>  
> -6lowpan-y := iphc.o nhc.o
> +6lowpan-y := iphc.o nhc.o context.o
>  
>  #rfc6282 nhcs
>  obj-$(CONFIG_6LOWPAN_NHC_DEST) += nhc_dest.o
> diff --git a/net/6lowpan/context.c b/net/6lowpan/context.c
> new file mode 100644
> index 0000000..00cd5af
> --- /dev/null
> +++ b/net/6lowpan/context.c
> @@ -0,0 +1,551 @@
> +/*
> + * Copyright (c)  2015 Nordic Semiconductor. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/if_arp.h>
> +#include <linux/netdevice.h>
> +#include <linux/module.h>
> +#include <linux/debugfs.h>
> +#include <linux/inet.h>
> +#include <linux/atomic.h>
> +
> +#include <net/ipv6.h>
> +#include <net/addrconf.h>
> +#include <net/6lowpan.h>
> +
> +#define LOWPAN_DBG(fmt, ...)  pr_debug(fmt "\n", ##__VA_ARGS__)
> +
> +#define LOWPAN_CONTEXT_TABLE_SIZE     16
> +#define LOWPAN_CONTEXT_COMMAND_ADD    "add"
> +#define LOWPAN_CONTEXT_COMMAND_REMOVE "remove"
> +
> +#define CHECK_CID_RANGE(cid) ((cid) > 0 && (cid) < LOWPAN_CONTEXT_TABLE_SIZE)
> +#define CHECK_PREFIX_RANGE(len) ((len) > 0 && (len) <= 128)
> +
> +static struct dentry *lowpan_context_debugfs;
> +
> +static LIST_HEAD(context_tables);
> +static DEFINE_SPINLOCK(module_lock);
> +
> +static inline void entry_update(struct lowpan_context_entry *entry,

please add lowpan prefix here to this function.

> +				u8 cid,
> +				struct in6_addr prefix,
> +				unsigned int prefix_len,
> +				bool compression_flag)
> +{
> +	/* Fill context entry. */
> +	entry->cid = cid;
> +	entry->compression_flag = compression_flag;
> +	entry->prefix = prefix;
> +	entry->prefix_len = prefix_len;
> +}
> +
> +static inline void entry_free(struct lowpan_context_entry *entry)

lowpan prefix.

> +{
> +	/* Increase number of available contexts. */
> +	atomic_dec(&entry->ctx_table->context_count);
> +
> +	list_del_rcu(&entry->list);
> +	kfree_rcu(entry, rcu);
> +}
> +
> +static int entry_add(struct lowpan_context_table *ctx_table,

lowpan prefix.

> +		     u8 cid,
> +		     struct in6_addr prefix,
> +		     unsigned int prefix_len,
> +		     bool compression_flag)
> +{
> +	struct lowpan_context_entry *new_entry = NULL;
> +
> +	new_entry = kzalloc(sizeof(*new_entry), GFP_ATOMIC);
> +	if (!new_entry)
> +		return -ENOMEM;
> +
> +	/* Fill context entry. */
> +	new_entry->ctx_table = ctx_table;
> +	entry_update(new_entry, cid, prefix, prefix_len, compression_flag);
> +
> +	INIT_LIST_HEAD(&new_entry->list);
> +	list_add_rcu(&new_entry->list, &ctx_table->context_entries);
> +
> +	/* Increase number of available contexts. */
> +	atomic_inc(&ctx_table->context_count);
> +
> +	return 0;
> +}
> +
> +static void table_free(struct lowpan_context_table *ctx_table)

lowpan prefix.

> +{
> +	struct lowpan_context_entry *entry = NULL;
> +
> +	rcu_read_lock();
> +
> +	/* Clear context table. */
> +	if (atomic_read(&ctx_table->context_count)) {
> +		list_for_each_entry_rcu(entry,
> +					&ctx_table->context_entries,
> +					list)
> +			entry_free(entry);
> +	}
> +
> +	rcu_read_unlock();
> +
> +	/* Remove context table. */
> +	list_del(&ctx_table->list);
> +	kfree(ctx_table);
> +}
> +
> +static inline struct net_device *find_netdev(const char *name)

lowpan prefix.

> +{
> +	struct net_device *netdev;
> +
> +	rcu_read_lock();
> +	netdev = dev_get_by_name_rcu(&init_net, name);
> +	rcu_read_unlock();
> +
> +	return netdev;
> +}
> +
> +static struct lowpan_context_table *get_table(struct net_device *netdev)
> +{
> +	struct lowpan_context_table *entry;
> +	struct lowpan_context_table *net_table = NULL;
> +
> +	spin_lock(&module_lock);
> +
> +	list_for_each_entry(entry, &context_tables, list) {
> +		if (entry->netdev == netdev) {
> +			/* Table has been found. */
> +			net_table = entry;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock(&module_lock);
> +

I know why you need such functionality. This is okay for now. But I
already thought about a nicer handling for that (which is also useful
for other mechanism). The idea is:

The netdev structure has some private pointer "netdev->priv". Currently
bluetooth 6lowpan/802.15.4 6lowpan do their own stuff inside this struct
which is okay. But we should provide some "upper class" struct for all
ARPHRD_6LOWPAN, which looks like:

-----------------------------
|   6LOWPAN_ARPHRD_STRUCT   | <-- All ARPHRD_6LOWPAN have this struct as first
-----------------------------
|        PRIVATE_DATA       | <-- 802.15.4/btle own stuff (private struct of subsystem) simple a
|                           |     "u8 priv __aligned(sizeof(void *));" inside ARPHRD_6LOWPAN which need to be at last
-----------------------------

Then you can put the net_table into the "6LOWPAN_ARPHRD_STRUCT" and cast
the "netdev->priv" pointer to "6LOWPAN_ARPHRD_STRUCT".

We really need such thing to avoid the above search&found functionality.
We should introduce such behaviour at first, then you can rebase your
stuff on it.

Also we need some functionality lowpan_alloc_netdev which ensure the
priv size is "sizeof(6LOWPAN_ARPHRD_STRUCT) + sizeof(PRIVATE_DATA)".

In upper layers like IPv6 you can do the following then:

if (dev->type == ARPHRD_6LOWPAN) {
	6LOWPAN_ARPHRD_STRUCT foobar = (struct 6LOWPAN_ARPHRD_STRUCT *)dev->priv;

	...do great cid handling here...
}

I hope this will also help you by implementing 6CO.

btw: (struct 6LOWPAN_ARPHRD_STRUCT *) should be implemented by a macro.


So please begin at first to add such functionality, please. Is that okay
for you?

> +	return net_table;
> +}
> +
> +static struct lowpan_context_entry *
> +get_ctx_by_cid(struct lowpan_context_table *table, u8 cid)
> +{
> +	struct lowpan_context_entry *entry;
> +	struct lowpan_context_entry *context = NULL;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(entry, &table->context_entries, list) {
> +		if (entry->cid == cid) {
> +			/* Context entry has been found. */
> +			context = entry;
> +			break;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return context;
> +}
> +
> +static struct lowpan_context_entry *
> +get_ctx_by_addr(struct lowpan_context_table *table, struct in6_addr *addr)
> +{
> +	struct lowpan_context_entry *entry;
> +	struct lowpan_context_entry *best_match = NULL;
> +	unsigned int compare_len;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(entry, &table->context_entries, list) {
> +		if (!entry->compression_flag)
> +			continue;
> +
> +		compare_len = entry->prefix_len >= 64 ? entry->prefix_len : 64;
> +		if (ipv6_prefix_equal(addr, &entry->prefix, compare_len)) {
> +			/* Valid context entry has been found. Check if prefix
> +			 * can cover more bytes than previous one.
> +			 */
> +			if (!best_match ||
> +			    (best_match->prefix_len < entry->prefix_len))
> +				best_match = entry;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return best_match;
> +}
> +
> +ssize_t lowpan_context_dbgfs_write(struct file *fp,
> +				   const char __user *user_buffer,
> +				   size_t count,
> +				   loff_t *position)
> +{
> +	char buf[128];
> +	char str_operation[16];
> +	char str_interface[16];
> +	char str_ipv6addr[40];
> +	size_t buf_size = min(count, sizeof(buf) - 1);
> +	int n;
> +	int ret;
> +	u8 cid;
> +	unsigned int prefix_length;
> +	unsigned int c_flag;
> +	struct in6_addr ctx_prefix;
> +	struct net_device *netdev;
> +	struct lowpan_context_table *ctx_table;
> +	struct lowpan_context_entry *entry;
> +
> +	memset(&ctx_prefix, 0, sizeof(ctx_prefix));
> +
> +	if (copy_from_user(buf, user_buffer, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +
> +	/* Parse input parameters. */
> +	n = sscanf(buf, "%s %s %hhd %s %d %d",
> +		   str_operation, str_interface, &cid, str_ipv6addr,
> +		   &prefix_length, &c_flag);
> +
> +	netdev = find_netdev(str_interface);
> +	/* Look up for net device. */
> +	if (!netdev) {
> +		LOWPAN_DBG("Cannot find given interface");
> +		return -EINVAL;
> +	}
> +
> +	if (!CHECK_CID_RANGE(cid)) {
> +		LOWPAN_DBG("CID value is out of range");
> +		return -EINVAL;
> +	}
> +
> +	/* Get context table. */
> +	ctx_table = get_table(netdev);
> +
> +	if (!ctx_table) {
> +		LOWPAN_DBG("Cannot find context table for %s interface",
> +			   str_interface);
> +		return -EINVAL;
> +	}
> +
> +	entry = get_ctx_by_cid(ctx_table, cid);
> +
> +	/* Execute command. */
> +	if (!memcmp(str_operation, LOWPAN_CONTEXT_COMMAND_ADD,
> +		    sizeof(LOWPAN_CONTEXT_COMMAND_ADD))) {
> +		/* Parse IPv6 address. */
> +		in6_pton(str_ipv6addr,
> +			 sizeof(str_ipv6addr),
> +			 ctx_prefix.s6_addr,
> +			 '\0',
> +			 NULL);
> +
> +		/* Check parameters. */
> +		if (ipv6_addr_any(&ctx_prefix) ||
> +		    !CHECK_PREFIX_RANGE(prefix_length)) {
> +			LOWPAN_DBG("Given parameters are not valid");
> +			return -EINVAL;
> +		}
> +
> +		LOWPAN_DBG("Got request: I:%s CID:%d Prefix:%pI6c/%d C:%d",
> +			   str_interface, cid, &ctx_prefix, prefix_length,
> +			   !!c_flag);
> +
> +		/* Check if entry for given CID already exists. */
> +		if (entry) {
> +			/* Just update parameters. */
> +			rcu_read_lock();
> +			entry_update(entry, cid, ctx_prefix, prefix_length,
> +				     !!c_flag);
> +			rcu_read_unlock();
> +		} else {
> +			/* Create a new entry. */
> +			ret = entry_add(ctx_table, cid, ctx_prefix,
> +					prefix_length, !!c_flag);
> +			if (ret < 0) {
> +				LOWPAN_DBG("Cannot add context entry");
> +				return ret;
> +			}
> +		}
> +	} else if (memcmp(str_operation, LOWPAN_CONTEXT_COMMAND_REMOVE,
> +			  sizeof(LOWPAN_CONTEXT_COMMAND_REMOVE)) == 0) {
> +		LOWPAN_DBG("Got new remove request: I:%s CID:%d",
> +			   str_interface, cid);
> +
> +		if (!entry) {
> +			LOWPAN_DBG("Cannot find context entry");
> +			return -EINVAL;
> +		}
> +
> +		rcu_read_lock();
> +		entry_free(entry);
> +		rcu_read_unlock();
> +	} else {
> +		LOWPAN_DBG("Invalid command - Cannot process the request");
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static int lowpan_context_show(struct seq_file *f, void *ptr)
> +{
> +	struct lowpan_context_table *table;
> +	struct lowpan_context_entry *entry;
> +
> +	list_for_each_entry(table, &context_tables, list) {
> +		if (!atomic_read(&table->context_count))
> +			break;
> +
> +		seq_printf(f, "Context table of interface %s\r\n\r\n",
> +			   table->netdev->name);
> +		seq_printf(f, "%-3s %-39s %-3s %-3s \r\n",
> +			   "CID", "Prefix", "Len", "CF");
> +
> +		list_for_each_entry_rcu(entry, &table->context_entries, list)
> +			seq_printf(f, "%-3d %-39pI6c %-3d %-3s \r\n",
> +				   entry->cid,
> +				   &entry->prefix,
> +				   entry->prefix_len,
> +				   entry->compression_flag ? "1" : "0");
> +		seq_puts(f, "\r\n\r\n");
> +	}
> +
> +	return 0;
> +}
> +
> +int lowpan_context_dbgfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, lowpan_context_show, inode->i_private);
> +}
> +
> +int lowpan_context_table_alloc(struct net_device *netdev)
> +{
> +	struct lowpan_context_table *ctx_table = NULL;
> +
> +	if (!netdev) {
> +		LOWPAN_DBG("Network device has to be specified");
> +		return -EPERM;
> +	}
> +
> +	/* Look for context table. */
> +	ctx_table = get_table(netdev);
> +
> +	if (ctx_table) {
> +		LOWPAN_DBG("Context table already exists for interface %s %p",
> +			   netdev->name, ctx_table);
> +		return -EEXIST;
> +	}
> +
> +	ctx_table = kzalloc(sizeof(*ctx_table), GFP_ATOMIC);
> +	if (!ctx_table)
> +		return -ENOMEM;
> +
> +	/* Assign network device to context table. */
> +	ctx_table->netdev = netdev;
> +
> +	/* Initialize contexts list. */
> +	INIT_LIST_HEAD(&ctx_table->context_entries);
> +
> +	spin_lock(&module_lock);
> +	INIT_LIST_HEAD(&ctx_table->list);
> +	list_add_rcu(&ctx_table->list, &context_tables);
> +	spin_unlock(&module_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_table_alloc);
> +
> +int lowpan_context_table_free(struct net_device *netdev)
> +{
> +	struct lowpan_context_table *ctx_table = NULL;
> +
> +	if (!netdev) {
> +		LOWPAN_DBG("Network device has to be specified");
> +		return -EPERM;
> +	}
> +
> +	/* Look for context table. */
> +	ctx_table = get_table(netdev);
> +	if (!ctx_table) {
> +		LOWPAN_DBG("Cannot find context table for interface %s",
> +			   netdev->name);
> +		return -ENOENT;
> +	}
> +
> +	spin_lock(&module_lock);
> +	table_free(ctx_table);
> +	spin_unlock(&module_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_table_free);
> +
> +int lowpan_context_add(struct net_device *netdev,
> +		       struct lowpan_context_entry *entry)
> +{
> +	int ret;
> +	struct lowpan_context_table *ctx_table = NULL;
> +	struct lowpan_context_entry *stored_entry = NULL;
> +
> +	if (!entry || !netdev) {
> +		LOWPAN_DBG("Parameters are incorrect");
> +		return -EPERM;
> +	}
> +
> +	/* Get context table.  */
> +	ctx_table = get_table(netdev);
> +	if (!ctx_table) {
> +		LOWPAN_DBG("Cannot find context table for %s interface",
> +			   netdev->name);
> +		return -EINVAL;
> +	}
> +
> +	stored_entry = get_ctx_by_cid(ctx_table, entry->cid);
> +
> +	/* Check if entry for given CID already exists. */
> +	if (entry) {
> +		/* Just update parameters. */
> +		rcu_read_lock();
> +		entry_update(stored_entry, entry->cid, entry->prefix,
> +			     entry->prefix_len, entry->compression_flag);
> +		rcu_read_unlock();
> +	} else {
> +		/* Create a new entry. */
> +		ret  = entry_add(ctx_table, entry->cid, entry->prefix,
> +				 entry->prefix_len, entry->compression_flag);
> +
> +		if (ret < 0) {
> +			LOWPAN_DBG("Cannot add context entry");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_add);
> +

Don't export function which isn't used by other modules. Maybe you
prepared for using this function for the 6CO field in ipv6. If yes, we
can do that later.

> +int lowpan_context_remove(struct lowpan_context_entry *entry)
> +{
> +	if (!entry) {
> +		LOWPAN_DBG("Given entry is NULL");
> +		return -EPERM;
> +	}
> +
> +	/* Free given entry. */
> +	rcu_read_lock();
> +	entry_free(entry);
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_remove);
> +

same here.

> +struct lowpan_context_entry *
> +lowpan_context_decompress(struct net_device *netdev, u8 cid)
> +{
> +	struct lowpan_context_table *ctx_table = NULL;
> +	struct lowpan_context_entry *entry = NULL;
> +
> +	if (!netdev) {
> +		LOWPAN_DBG("Network device has to be specified");
> +		return NULL;
> +	}
> +
> +	/* Get proper interface table. */
> +	ctx_table = get_table(netdev);
> +	if (!ctx_table) {
> +		LOWPAN_DBG("Cannot find context table for interface %s",
> +			   netdev->name);
> +		return NULL;
> +	}
> +
> +	/* Search for given CID. */
> +	entry = get_ctx_by_cid(ctx_table, cid);
> +	if (!entry) {
> +		LOWPAN_DBG("There is no context of id:%d for interface %s",
> +			   cid, netdev->name);
> +		return NULL;
> +	}
> +
> +	LOWPAN_DBG("Found context prefix for context of id:%d - %pI6c",
> +		   entry->cid, &entry->prefix);
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_decompress);
> +

same here.

> +struct lowpan_context_entry *lowpan_context_compress(struct net_device *netdev,
> +						     struct in6_addr *addr)
> +{
> +	struct lowpan_context_table *ctx_table = NULL;
> +	struct lowpan_context_entry *entry = NULL;
> +
> +	if (!netdev || !addr) {
> +		LOWPAN_DBG("Network device and address has to be specified");
> +		return NULL;
> +	}
> +
> +	/* Get proper interface table. */
> +	ctx_table = get_table(netdev);
> +	if (!ctx_table) {
> +		LOWPAN_DBG("Cannot find context table for interface %s",
> +			   netdev->name);
> +		return NULL;
> +	}
> +
> +	/* Search for given address. */
> +	entry = get_ctx_by_addr(ctx_table, addr);
> +	if (!entry) {
> +		LOWPAN_DBG("No context for address %pI6c for interface %s",
> +			   addr, netdev->name);
> +		return NULL;
> +	}
> +
> +	LOWPAN_DBG("Found context of id:%d", entry->cid);
> +
> +	/* Return null in case no compression capability in found context */
> +	return entry;
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_compress);
> +

same here.

> +const struct file_operations lowpan_context_fops = {
> +	.open	 = lowpan_context_dbgfs_open,
> +	.read	 = seq_read,
> +	.write	 = lowpan_context_dbgfs_write,
> +	.llseek	 = seq_lseek,
> +	.release = single_release
> +};
> +
> +void lowpan_context_init(void)
> +{
> +	lowpan_context_debugfs = debugfs_create_file("context", 0664,
> +						     lowpan_debugfs, NULL,
> +						     &lowpan_context_fops);
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_init);
> +

same here.

> +void lowpan_context_uninit(void)
> +{
> +	struct lowpan_context_table *entry = NULL;
> +
> +	spin_lock(&module_lock);
> +
> +	list_for_each_entry(entry, &context_tables, list)
> +		table_free(entry);
> +
> +	spin_unlock(&module_lock);
> +
> +	debugfs_remove(lowpan_context_debugfs);
> +}
> +EXPORT_SYMBOL_GPL(lowpan_context_uninit);

same here.

> diff --git a/net/6lowpan/context.h b/net/6lowpan/context.h
> new file mode 100644
> index 0000000..88303b5
> --- /dev/null
> +++ b/net/6lowpan/context.h
> @@ -0,0 +1,7 @@
> +#ifndef __6LOWPAN_CONTEXT_H
> +#define __6LOWPAN_CONTEXT_H
> +
> +void lowpan_context_init(void);
> +void lowpan_context_uninit(void);
> +
> +#endif /* __6LOWPAN_CONTEXT_H */
> -- 
> 2.1.4
> 
