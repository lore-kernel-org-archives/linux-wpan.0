Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:60017 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbaLaSpg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:45:36 -0500
Received: by mail-we0-f170.google.com with SMTP id w61so2719980wes.1
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:45:34 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/6] ieee802154: socket: put handling into one file
Date: Wed, 31 Dec 2014 19:39:10 +0100
Message-Id: <1420051153-8673-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch puts all related socket handling into one file. This is just
a cleanup to do all socket handling stuff inside of one implementation
file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile        |   2 +-
 net/ieee802154/af802154.h      |  33 --
 net/ieee802154/af_ieee802154.c | 762 ++++++++++++++++++++++++++++++++++++++++-
 net/ieee802154/dgram.c         | 549 -----------------------------
 net/ieee802154/raw.c           | 270 ---------------
 5 files changed, 760 insertions(+), 856 deletions(-)
 delete mode 100644 net/ieee802154/af802154.h
 delete mode 100644 net/ieee802154/dgram.c
 delete mode 100644 net/ieee802154/raw.c

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 19b2bec..e6ddfcd 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
-ieee802154_socket-y := af_ieee802154.o raw.o dgram.o
+ieee802154_socket-y := af_ieee802154.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/ieee802154/af802154.h b/net/ieee802154/af802154.h
deleted file mode 100644
index 343b63e..0000000
--- a/net/ieee802154/af802154.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Internal interfaces for ieee 802.15.4 address family.
- *
- * Copyright 2007, 2008, 2009 Siemens AG
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Written by:
- * Sergey Lapin <slapin@ossfans.org>
- * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
- */
-
-#ifndef AF802154_H
-#define AF802154_H
-
-struct sk_buff;
-struct net_device;
-struct ieee802154_addr;
-extern struct proto ieee802154_raw_prot;
-extern struct proto ieee802154_dgram_prot;
-void ieee802154_raw_deliver(struct net_device *dev, struct sk_buff *skb);
-int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb);
-struct net_device *ieee802154_get_dev(struct net *net,
-				      const struct ieee802154_addr *addr);
-
-#endif
diff --git a/net/ieee802154/af_ieee802154.c b/net/ieee802154/af_ieee802154.c
index d0a1282..64beb0b 100644
--- a/net/ieee802154/af_ieee802154.c
+++ b/net/ieee802154/af_ieee802154.c
@@ -34,10 +34,8 @@
 #include <net/af_ieee802154.h>
 #include <net/ieee802154_netdev.h>
 
-#include "af802154.h"
-
 /* Utility function for families */
-struct net_device*
+static struct net_device*
 ieee802154_get_dev(struct net *net, const struct ieee802154_addr *addr)
 {
 	struct net_device *dev = NULL;
@@ -182,6 +180,248 @@ static int ieee802154_sock_ioctl(struct socket *sock, unsigned int cmd,
 	}
 }
 
+/* RAW Sockets (802.15.4 created in userspace) */
+static HLIST_HEAD(raw_head);
+static DEFINE_RWLOCK(raw_lock);
+
+static void raw_hash(struct sock *sk)
+{
+	write_lock_bh(&raw_lock);
+	sk_add_node(sk, &raw_head);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+	write_unlock_bh(&raw_lock);
+}
+
+static void raw_unhash(struct sock *sk)
+{
+	write_lock_bh(&raw_lock);
+	if (sk_del_node_init(sk))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	write_unlock_bh(&raw_lock);
+}
+
+static void raw_close(struct sock *sk, long timeout)
+{
+	sk_common_release(sk);
+}
+
+static int raw_bind(struct sock *sk, struct sockaddr *_uaddr, int len)
+{
+	struct ieee802154_addr addr;
+	struct sockaddr_ieee802154 *uaddr = (struct sockaddr_ieee802154 *)_uaddr;
+	int err = 0;
+	struct net_device *dev = NULL;
+
+	if (len < sizeof(*uaddr))
+		return -EINVAL;
+
+	uaddr = (struct sockaddr_ieee802154 *)_uaddr;
+	if (uaddr->family != AF_IEEE802154)
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	ieee802154_addr_from_sa(&addr, &uaddr->addr);
+	dev = ieee802154_get_dev(sock_net(sk), &addr);
+	if (!dev) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	if (dev->type != ARPHRD_IEEE802154) {
+		err = -ENODEV;
+		goto out_put;
+	}
+
+	sk->sk_bound_dev_if = dev->ifindex;
+	sk_dst_reset(sk);
+
+out_put:
+	dev_put(dev);
+out:
+	release_sock(sk);
+
+	return err;
+}
+
+static int raw_connect(struct sock *sk, struct sockaddr *uaddr,
+		       int addr_len)
+{
+	return -ENOTSUPP;
+}
+
+static int raw_disconnect(struct sock *sk, int flags)
+{
+	return 0;
+}
+
+static int raw_sendmsg(struct kiocb *iocb, struct sock *sk,
+		       struct msghdr *msg, size_t size)
+{
+	struct net_device *dev;
+	unsigned int mtu;
+	struct sk_buff *skb;
+	int hlen, tlen;
+	int err;
+
+	if (msg->msg_flags & MSG_OOB) {
+		pr_debug("msg->msg_flags = 0x%x\n", msg->msg_flags);
+		return -EOPNOTSUPP;
+	}
+
+	lock_sock(sk);
+	if (!sk->sk_bound_dev_if)
+		dev = dev_getfirstbyhwtype(sock_net(sk), ARPHRD_IEEE802154);
+	else
+		dev = dev_get_by_index(sock_net(sk), sk->sk_bound_dev_if);
+	release_sock(sk);
+
+	if (!dev) {
+		pr_debug("no dev\n");
+		err = -ENXIO;
+		goto out;
+	}
+
+	mtu = dev->mtu;
+	pr_debug("name = %s, mtu = %u\n", dev->name, mtu);
+
+	if (size > mtu) {
+		pr_debug("size = %Zu, mtu = %u\n", size, mtu);
+		err = -EINVAL;
+		goto out_dev;
+	}
+
+	hlen = LL_RESERVED_SPACE(dev);
+	tlen = dev->needed_tailroom;
+	skb = sock_alloc_send_skb(sk, hlen + tlen + size,
+				  msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		goto out_dev;
+
+	skb_reserve(skb, hlen);
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+
+	err = memcpy_from_msg(skb_put(skb, size), msg, size);
+	if (err < 0)
+		goto out_skb;
+
+	skb->dev = dev;
+	skb->sk  = sk;
+	skb->protocol = htons(ETH_P_IEEE802154);
+
+	dev_put(dev);
+
+	err = dev_queue_xmit(skb);
+	if (err > 0)
+		err = net_xmit_errno(err);
+
+	return err ?: size;
+
+out_skb:
+	kfree_skb(skb);
+out_dev:
+	dev_put(dev);
+out:
+	return err;
+}
+
+static int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+		       size_t len, int noblock, int flags, int *addr_len)
+{
+	size_t copied = 0;
+	int err = -EOPNOTSUPP;
+	struct sk_buff *skb;
+
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
+		goto out;
+
+	copied = skb->len;
+	if (len < copied) {
+		msg->msg_flags |= MSG_TRUNC;
+		copied = len;
+	}
+
+	err = skb_copy_datagram_msg(skb, 0, msg, copied);
+	if (err)
+		goto done;
+
+	sock_recv_ts_and_drops(msg, sk, skb);
+
+	if (flags & MSG_TRUNC)
+		copied = skb->len;
+done:
+	skb_free_datagram(sk, skb);
+out:
+	if (err)
+		return err;
+	return copied;
+}
+
+static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
+	if (sock_queue_rcv_skb(sk, skb) < 0) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+
+	return NET_RX_SUCCESS;
+}
+
+static void ieee802154_raw_deliver(struct net_device *dev, struct sk_buff *skb)
+{
+	struct sock *sk;
+
+	read_lock(&raw_lock);
+	sk_for_each(sk, &raw_head) {
+		bh_lock_sock(sk);
+		if (!sk->sk_bound_dev_if ||
+		    sk->sk_bound_dev_if == dev->ifindex) {
+			struct sk_buff *clone;
+
+			clone = skb_clone(skb, GFP_ATOMIC);
+			if (clone)
+				raw_rcv_skb(sk, clone);
+		}
+		bh_unlock_sock(sk);
+	}
+	read_unlock(&raw_lock);
+}
+
+static int raw_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	return -EOPNOTSUPP;
+}
+
+static int raw_setsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, unsigned int optlen)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct proto ieee802154_raw_prot = {
+	.name		= "IEEE-802.15.4-RAW",
+	.owner		= THIS_MODULE,
+	.obj_size	= sizeof(struct sock),
+	.close		= raw_close,
+	.bind		= raw_bind,
+	.sendmsg	= raw_sendmsg,
+	.recvmsg	= raw_recvmsg,
+	.hash		= raw_hash,
+	.unhash		= raw_unhash,
+	.connect	= raw_connect,
+	.disconnect	= raw_disconnect,
+	.getsockopt	= raw_getsockopt,
+	.setsockopt	= raw_setsockopt,
+};
+
 static const struct proto_ops ieee802154_raw_ops = {
 	.family		   = PF_IEEE802154,
 	.owner		   = THIS_MODULE,
@@ -207,6 +447,522 @@ static const struct proto_ops ieee802154_raw_ops = {
 #endif
 };
 
+/* DGRAM Sockets (802.15.4 dataframes) */
+static HLIST_HEAD(dgram_head);
+static DEFINE_RWLOCK(dgram_lock);
+
+struct dgram_sock {
+	struct sock sk;
+
+	struct ieee802154_addr src_addr;
+	struct ieee802154_addr dst_addr;
+
+	unsigned int bound:1;
+	unsigned int connected:1;
+	unsigned int want_ack:1;
+	unsigned int secen:1;
+	unsigned int secen_override:1;
+	unsigned int seclevel:3;
+	unsigned int seclevel_override:1;
+};
+
+static inline struct dgram_sock *dgram_sk(const struct sock *sk)
+{
+	return container_of(sk, struct dgram_sock, sk);
+}
+
+static void dgram_hash(struct sock *sk)
+{
+	write_lock_bh(&dgram_lock);
+	sk_add_node(sk, &dgram_head);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+	write_unlock_bh(&dgram_lock);
+}
+
+static void dgram_unhash(struct sock *sk)
+{
+	write_lock_bh(&dgram_lock);
+	if (sk_del_node_init(sk))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	write_unlock_bh(&dgram_lock);
+}
+
+static int dgram_init(struct sock *sk)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+
+	ro->want_ack = 1;
+	return 0;
+}
+
+static void dgram_close(struct sock *sk, long timeout)
+{
+	sk_common_release(sk);
+}
+
+static int dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
+{
+	struct sockaddr_ieee802154 *addr = (struct sockaddr_ieee802154 *)uaddr;
+	struct ieee802154_addr haddr;
+	struct dgram_sock *ro = dgram_sk(sk);
+	int err = -EINVAL;
+	struct net_device *dev;
+
+	lock_sock(sk);
+
+	ro->bound = 0;
+
+	if (len < sizeof(*addr))
+		goto out;
+
+	if (addr->family != AF_IEEE802154)
+		goto out;
+
+	ieee802154_addr_from_sa(&haddr, &addr->addr);
+	dev = ieee802154_get_dev(sock_net(sk), &haddr);
+	if (!dev) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	if (dev->type != ARPHRD_IEEE802154) {
+		err = -ENODEV;
+		goto out_put;
+	}
+
+	ro->src_addr = haddr;
+
+	ro->bound = 1;
+	err = 0;
+out_put:
+	dev_put(dev);
+out:
+	release_sock(sk);
+
+	return err;
+}
+
+static int dgram_ioctl(struct sock *sk, int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case SIOCOUTQ:
+	{
+		int amount = sk_wmem_alloc_get(sk);
+
+		return put_user(amount, (int __user *)arg);
+	}
+
+	case SIOCINQ:
+	{
+		struct sk_buff *skb;
+		unsigned long amount;
+
+		amount = 0;
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
+		if (skb != NULL) {
+			/* We will only return the amount
+			 * of this packet since that is all
+			 * that will be read.
+			 */
+			amount = skb->len - ieee802154_hdr_length(skb);
+		}
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		return put_user(amount, (int __user *)arg);
+	}
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+/* FIXME: autobind */
+static int dgram_connect(struct sock *sk, struct sockaddr *uaddr,
+			 int len)
+{
+	struct sockaddr_ieee802154 *addr = (struct sockaddr_ieee802154 *)uaddr;
+	struct dgram_sock *ro = dgram_sk(sk);
+	int err = 0;
+
+	if (len < sizeof(*addr))
+		return -EINVAL;
+
+	if (addr->family != AF_IEEE802154)
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	if (!ro->bound) {
+		err = -ENETUNREACH;
+		goto out;
+	}
+
+	ieee802154_addr_from_sa(&ro->dst_addr, &addr->addr);
+	ro->connected = 1;
+
+out:
+	release_sock(sk);
+	return err;
+}
+
+static int dgram_disconnect(struct sock *sk, int flags)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+
+	lock_sock(sk);
+	ro->connected = 0;
+	release_sock(sk);
+
+	return 0;
+}
+
+static int dgram_sendmsg(struct kiocb *iocb, struct sock *sk,
+			 struct msghdr *msg, size_t size)
+{
+	struct net_device *dev;
+	unsigned int mtu;
+	struct sk_buff *skb;
+	struct ieee802154_mac_cb *cb;
+	struct dgram_sock *ro = dgram_sk(sk);
+	struct ieee802154_addr dst_addr;
+	int hlen, tlen;
+	int err;
+
+	if (msg->msg_flags & MSG_OOB) {
+		pr_debug("msg->msg_flags = 0x%x\n", msg->msg_flags);
+		return -EOPNOTSUPP;
+	}
+
+	if (!ro->connected && !msg->msg_name)
+		return -EDESTADDRREQ;
+	else if (ro->connected && msg->msg_name)
+		return -EISCONN;
+
+	if (!ro->bound)
+		dev = dev_getfirstbyhwtype(sock_net(sk), ARPHRD_IEEE802154);
+	else
+		dev = ieee802154_get_dev(sock_net(sk), &ro->src_addr);
+
+	if (!dev) {
+		pr_debug("no dev\n");
+		err = -ENXIO;
+		goto out;
+	}
+	mtu = dev->mtu;
+	pr_debug("name = %s, mtu = %u\n", dev->name, mtu);
+
+	if (size > mtu) {
+		pr_debug("size = %Zu, mtu = %u\n", size, mtu);
+		err = -EMSGSIZE;
+		goto out_dev;
+	}
+
+	hlen = LL_RESERVED_SPACE(dev);
+	tlen = dev->needed_tailroom;
+	skb = sock_alloc_send_skb(sk, hlen + tlen + size,
+				  msg->msg_flags & MSG_DONTWAIT,
+				  &err);
+	if (!skb)
+		goto out_dev;
+
+	skb_reserve(skb, hlen);
+
+	skb_reset_network_header(skb);
+
+	cb = mac_cb_init(skb);
+	cb->type = IEEE802154_FC_TYPE_DATA;
+	cb->ackreq = ro->want_ack;
+
+	if (msg->msg_name) {
+		DECLARE_SOCKADDR(struct sockaddr_ieee802154*,
+				 daddr, msg->msg_name);
+
+		ieee802154_addr_from_sa(&dst_addr, &daddr->addr);
+	} else {
+		dst_addr = ro->dst_addr;
+	}
+
+	cb->secen = ro->secen;
+	cb->secen_override = ro->secen_override;
+	cb->seclevel = ro->seclevel;
+	cb->seclevel_override = ro->seclevel_override;
+
+	err = dev_hard_header(skb, dev, ETH_P_IEEE802154, &dst_addr,
+			      ro->bound ? &ro->src_addr : NULL, size);
+	if (err < 0)
+		goto out_skb;
+
+	err = memcpy_from_msg(skb_put(skb, size), msg, size);
+	if (err < 0)
+		goto out_skb;
+
+	skb->dev = dev;
+	skb->sk  = sk;
+	skb->protocol = htons(ETH_P_IEEE802154);
+
+	dev_put(dev);
+
+	err = dev_queue_xmit(skb);
+	if (err > 0)
+		err = net_xmit_errno(err);
+
+	return err ?: size;
+
+out_skb:
+	kfree_skb(skb);
+out_dev:
+	dev_put(dev);
+out:
+	return err;
+}
+
+static int dgram_recvmsg(struct kiocb *iocb, struct sock *sk,
+			 struct msghdr *msg, size_t len, int noblock,
+			 int flags, int *addr_len)
+{
+	size_t copied = 0;
+	int err = -EOPNOTSUPP;
+	struct sk_buff *skb;
+	DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_name);
+
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
+		goto out;
+
+	copied = skb->len;
+	if (len < copied) {
+		msg->msg_flags |= MSG_TRUNC;
+		copied = len;
+	}
+
+	/* FIXME: skip headers if necessary ?! */
+	err = skb_copy_datagram_msg(skb, 0, msg, copied);
+	if (err)
+		goto done;
+
+	sock_recv_ts_and_drops(msg, sk, skb);
+
+	if (saddr) {
+		saddr->family = AF_IEEE802154;
+		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
+		*addr_len = sizeof(*saddr);
+	}
+
+	if (flags & MSG_TRUNC)
+		copied = skb->len;
+done:
+	skb_free_datagram(sk, skb);
+out:
+	if (err)
+		return err;
+	return copied;
+}
+
+static int dgram_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
+	if (sock_queue_rcv_skb(sk, skb) < 0) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+
+	return NET_RX_SUCCESS;
+}
+
+static inline bool
+ieee802154_match_sock(__le64 hw_addr, __le16 pan_id, __le16 short_addr,
+		      struct dgram_sock *ro)
+{
+	if (!ro->bound)
+		return true;
+
+	if (ro->src_addr.mode == IEEE802154_ADDR_LONG &&
+	    hw_addr == ro->src_addr.extended_addr)
+		return true;
+
+	if (ro->src_addr.mode == IEEE802154_ADDR_SHORT &&
+	    pan_id == ro->src_addr.pan_id &&
+	    short_addr == ro->src_addr.short_addr)
+		return true;
+
+	return false;
+}
+
+static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
+{
+	struct sock *sk, *prev = NULL;
+	int ret = NET_RX_SUCCESS;
+	__le16 pan_id, short_addr;
+	__le64 hw_addr;
+
+	/* Data frame processing */
+	BUG_ON(dev->type != ARPHRD_IEEE802154);
+
+	pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	short_addr = ieee802154_mlme_ops(dev)->get_short_addr(dev);
+	hw_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
+
+	read_lock(&dgram_lock);
+	sk_for_each(sk, &dgram_head) {
+		if (ieee802154_match_sock(hw_addr, pan_id, short_addr,
+					  dgram_sk(sk))) {
+			if (prev) {
+				struct sk_buff *clone;
+
+				clone = skb_clone(skb, GFP_ATOMIC);
+				if (clone)
+					dgram_rcv_skb(prev, clone);
+			}
+
+			prev = sk;
+		}
+	}
+
+	if (prev) {
+		dgram_rcv_skb(prev, skb);
+	} else {
+		kfree_skb(skb);
+		ret = NET_RX_DROP;
+	}
+	read_unlock(&dgram_lock);
+
+	return ret;
+}
+
+static int dgram_getsockopt(struct sock *sk, int level, int optname,
+			    char __user *optval, int __user *optlen)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+
+	int val, len;
+
+	if (level != SOL_IEEE802154)
+		return -EOPNOTSUPP;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(int));
+
+	switch (optname) {
+	case WPAN_WANTACK:
+		val = ro->want_ack;
+		break;
+	case WPAN_SECURITY:
+		if (!ro->secen_override)
+			val = WPAN_SECURITY_DEFAULT;
+		else if (ro->secen)
+			val = WPAN_SECURITY_ON;
+		else
+			val = WPAN_SECURITY_OFF;
+		break;
+	case WPAN_SECURITY_LEVEL:
+		if (!ro->seclevel_override)
+			val = WPAN_SECURITY_LEVEL_DEFAULT;
+		else
+			val = ro->seclevel;
+		break;
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &val, len))
+		return -EFAULT;
+	return 0;
+}
+
+static int dgram_setsockopt(struct sock *sk, int level, int optname,
+			    char __user *optval, unsigned int optlen)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+	struct net *net = sock_net(sk);
+	int val;
+	int err = 0;
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case WPAN_WANTACK:
+		ro->want_ack = !!val;
+		break;
+	case WPAN_SECURITY:
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
+		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
+			err = -EPERM;
+			break;
+		}
+
+		switch (val) {
+		case WPAN_SECURITY_DEFAULT:
+			ro->secen_override = 0;
+			break;
+		case WPAN_SECURITY_ON:
+			ro->secen_override = 1;
+			ro->secen = 1;
+			break;
+		case WPAN_SECURITY_OFF:
+			ro->secen_override = 1;
+			ro->secen = 0;
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+		break;
+	case WPAN_SECURITY_LEVEL:
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
+		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
+			err = -EPERM;
+			break;
+		}
+
+		if (val < WPAN_SECURITY_LEVEL_DEFAULT ||
+		    val > IEEE802154_SCF_SECLEVEL_ENC_MIC128) {
+			err = -EINVAL;
+		} else if (val == WPAN_SECURITY_LEVEL_DEFAULT) {
+			ro->seclevel_override = 0;
+		} else {
+			ro->seclevel_override = 1;
+			ro->seclevel = val;
+		}
+		break;
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
+static struct proto ieee802154_dgram_prot = {
+	.name		= "IEEE-802.15.4-MAC",
+	.owner		= THIS_MODULE,
+	.obj_size	= sizeof(struct dgram_sock),
+	.init		= dgram_init,
+	.close		= dgram_close,
+	.bind		= dgram_bind,
+	.sendmsg	= dgram_sendmsg,
+	.recvmsg	= dgram_recvmsg,
+	.hash		= dgram_hash,
+	.unhash		= dgram_unhash,
+	.connect	= dgram_connect,
+	.disconnect	= dgram_disconnect,
+	.ioctl		= dgram_ioctl,
+	.getsockopt	= dgram_getsockopt,
+	.setsockopt	= dgram_setsockopt,
+};
+
 static const struct proto_ops ieee802154_dgram_ops = {
 	.family		   = PF_IEEE802154,
 	.owner		   = THIS_MODULE,
diff --git a/net/ieee802154/dgram.c b/net/ieee802154/dgram.c
deleted file mode 100644
index d1930b7..0000000
--- a/net/ieee802154/dgram.c
+++ /dev/null
@@ -1,549 +0,0 @@
-/*
- * IEEE 802.15.4 dgram socket interface
- *
- * Copyright 2007, 2008 Siemens AG
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Written by:
- * Sergey Lapin <slapin@ossfans.org>
- * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
- */
-
-#include <linux/capability.h>
-#include <linux/net.h>
-#include <linux/module.h>
-#include <linux/if_arp.h>
-#include <linux/list.h>
-#include <linux/slab.h>
-#include <linux/ieee802154.h>
-#include <net/sock.h>
-#include <net/af_ieee802154.h>
-#include <net/ieee802154_netdev.h>
-
-#include <asm/ioctls.h>
-
-#include "af802154.h"
-
-static HLIST_HEAD(dgram_head);
-static DEFINE_RWLOCK(dgram_lock);
-
-struct dgram_sock {
-	struct sock sk;
-
-	struct ieee802154_addr src_addr;
-	struct ieee802154_addr dst_addr;
-
-	unsigned int bound:1;
-	unsigned int connected:1;
-	unsigned int want_ack:1;
-	unsigned int secen:1;
-	unsigned int secen_override:1;
-	unsigned int seclevel:3;
-	unsigned int seclevel_override:1;
-};
-
-static inline struct dgram_sock *dgram_sk(const struct sock *sk)
-{
-	return container_of(sk, struct dgram_sock, sk);
-}
-
-static void dgram_hash(struct sock *sk)
-{
-	write_lock_bh(&dgram_lock);
-	sk_add_node(sk, &dgram_head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-	write_unlock_bh(&dgram_lock);
-}
-
-static void dgram_unhash(struct sock *sk)
-{
-	write_lock_bh(&dgram_lock);
-	if (sk_del_node_init(sk))
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-	write_unlock_bh(&dgram_lock);
-}
-
-static int dgram_init(struct sock *sk)
-{
-	struct dgram_sock *ro = dgram_sk(sk);
-
-	ro->want_ack = 1;
-	return 0;
-}
-
-static void dgram_close(struct sock *sk, long timeout)
-{
-	sk_common_release(sk);
-}
-
-static int dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
-{
-	struct sockaddr_ieee802154 *addr = (struct sockaddr_ieee802154 *)uaddr;
-	struct ieee802154_addr haddr;
-	struct dgram_sock *ro = dgram_sk(sk);
-	int err = -EINVAL;
-	struct net_device *dev;
-
-	lock_sock(sk);
-
-	ro->bound = 0;
-
-	if (len < sizeof(*addr))
-		goto out;
-
-	if (addr->family != AF_IEEE802154)
-		goto out;
-
-	ieee802154_addr_from_sa(&haddr, &addr->addr);
-	dev = ieee802154_get_dev(sock_net(sk), &haddr);
-	if (!dev) {
-		err = -ENODEV;
-		goto out;
-	}
-
-	if (dev->type != ARPHRD_IEEE802154) {
-		err = -ENODEV;
-		goto out_put;
-	}
-
-	ro->src_addr = haddr;
-
-	ro->bound = 1;
-	err = 0;
-out_put:
-	dev_put(dev);
-out:
-	release_sock(sk);
-
-	return err;
-}
-
-static int dgram_ioctl(struct sock *sk, int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case SIOCOUTQ:
-	{
-		int amount = sk_wmem_alloc_get(sk);
-
-		return put_user(amount, (int __user *)arg);
-	}
-
-	case SIOCINQ:
-	{
-		struct sk_buff *skb;
-		unsigned long amount;
-
-		amount = 0;
-		spin_lock_bh(&sk->sk_receive_queue.lock);
-		skb = skb_peek(&sk->sk_receive_queue);
-		if (skb != NULL) {
-			/* We will only return the amount
-			 * of this packet since that is all
-			 * that will be read.
-			 */
-			amount = skb->len - ieee802154_hdr_length(skb);
-		}
-		spin_unlock_bh(&sk->sk_receive_queue.lock);
-		return put_user(amount, (int __user *)arg);
-	}
-	}
-
-	return -ENOIOCTLCMD;
-}
-
-/* FIXME: autobind */
-static int dgram_connect(struct sock *sk, struct sockaddr *uaddr,
-			 int len)
-{
-	struct sockaddr_ieee802154 *addr = (struct sockaddr_ieee802154 *)uaddr;
-	struct dgram_sock *ro = dgram_sk(sk);
-	int err = 0;
-
-	if (len < sizeof(*addr))
-		return -EINVAL;
-
-	if (addr->family != AF_IEEE802154)
-		return -EINVAL;
-
-	lock_sock(sk);
-
-	if (!ro->bound) {
-		err = -ENETUNREACH;
-		goto out;
-	}
-
-	ieee802154_addr_from_sa(&ro->dst_addr, &addr->addr);
-	ro->connected = 1;
-
-out:
-	release_sock(sk);
-	return err;
-}
-
-static int dgram_disconnect(struct sock *sk, int flags)
-{
-	struct dgram_sock *ro = dgram_sk(sk);
-
-	lock_sock(sk);
-	ro->connected = 0;
-	release_sock(sk);
-
-	return 0;
-}
-
-static int dgram_sendmsg(struct kiocb *iocb, struct sock *sk,
-			 struct msghdr *msg, size_t size)
-{
-	struct net_device *dev;
-	unsigned int mtu;
-	struct sk_buff *skb;
-	struct ieee802154_mac_cb *cb;
-	struct dgram_sock *ro = dgram_sk(sk);
-	struct ieee802154_addr dst_addr;
-	int hlen, tlen;
-	int err;
-
-	if (msg->msg_flags & MSG_OOB) {
-		pr_debug("msg->msg_flags = 0x%x\n", msg->msg_flags);
-		return -EOPNOTSUPP;
-	}
-
-	if (!ro->connected && !msg->msg_name)
-		return -EDESTADDRREQ;
-	else if (ro->connected && msg->msg_name)
-		return -EISCONN;
-
-	if (!ro->bound)
-		dev = dev_getfirstbyhwtype(sock_net(sk), ARPHRD_IEEE802154);
-	else
-		dev = ieee802154_get_dev(sock_net(sk), &ro->src_addr);
-
-	if (!dev) {
-		pr_debug("no dev\n");
-		err = -ENXIO;
-		goto out;
-	}
-	mtu = dev->mtu;
-	pr_debug("name = %s, mtu = %u\n", dev->name, mtu);
-
-	if (size > mtu) {
-		pr_debug("size = %Zu, mtu = %u\n", size, mtu);
-		err = -EMSGSIZE;
-		goto out_dev;
-	}
-
-	hlen = LL_RESERVED_SPACE(dev);
-	tlen = dev->needed_tailroom;
-	skb = sock_alloc_send_skb(sk, hlen + tlen + size,
-				  msg->msg_flags & MSG_DONTWAIT,
-				  &err);
-	if (!skb)
-		goto out_dev;
-
-	skb_reserve(skb, hlen);
-
-	skb_reset_network_header(skb);
-
-	cb = mac_cb_init(skb);
-	cb->type = IEEE802154_FC_TYPE_DATA;
-	cb->ackreq = ro->want_ack;
-
-	if (msg->msg_name) {
-		DECLARE_SOCKADDR(struct sockaddr_ieee802154*,
-				 daddr, msg->msg_name);
-
-		ieee802154_addr_from_sa(&dst_addr, &daddr->addr);
-	} else {
-		dst_addr = ro->dst_addr;
-	}
-
-	cb->secen = ro->secen;
-	cb->secen_override = ro->secen_override;
-	cb->seclevel = ro->seclevel;
-	cb->seclevel_override = ro->seclevel_override;
-
-	err = dev_hard_header(skb, dev, ETH_P_IEEE802154, &dst_addr,
-			      ro->bound ? &ro->src_addr : NULL, size);
-	if (err < 0)
-		goto out_skb;
-
-	err = memcpy_from_msg(skb_put(skb, size), msg, size);
-	if (err < 0)
-		goto out_skb;
-
-	skb->dev = dev;
-	skb->sk  = sk;
-	skb->protocol = htons(ETH_P_IEEE802154);
-
-	dev_put(dev);
-
-	err = dev_queue_xmit(skb);
-	if (err > 0)
-		err = net_xmit_errno(err);
-
-	return err ?: size;
-
-out_skb:
-	kfree_skb(skb);
-out_dev:
-	dev_put(dev);
-out:
-	return err;
-}
-
-static int dgram_recvmsg(struct kiocb *iocb, struct sock *sk,
-			 struct msghdr *msg, size_t len, int noblock,
-			 int flags, int *addr_len)
-{
-	size_t copied = 0;
-	int err = -EOPNOTSUPP;
-	struct sk_buff *skb;
-	DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_name);
-
-	skb = skb_recv_datagram(sk, flags, noblock, &err);
-	if (!skb)
-		goto out;
-
-	copied = skb->len;
-	if (len < copied) {
-		msg->msg_flags |= MSG_TRUNC;
-		copied = len;
-	}
-
-	/* FIXME: skip headers if necessary ?! */
-	err = skb_copy_datagram_msg(skb, 0, msg, copied);
-	if (err)
-		goto done;
-
-	sock_recv_ts_and_drops(msg, sk, skb);
-
-	if (saddr) {
-		saddr->family = AF_IEEE802154;
-		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
-		*addr_len = sizeof(*saddr);
-	}
-
-	if (flags & MSG_TRUNC)
-		copied = skb->len;
-done:
-	skb_free_datagram(sk, skb);
-out:
-	if (err)
-		return err;
-	return copied;
-}
-
-static int dgram_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!skb)
-		return NET_RX_DROP;
-
-	if (sock_queue_rcv_skb(sk, skb) < 0) {
-		kfree_skb(skb);
-		return NET_RX_DROP;
-	}
-
-	return NET_RX_SUCCESS;
-}
-
-static inline bool
-ieee802154_match_sock(__le64 hw_addr, __le16 pan_id, __le16 short_addr,
-		      struct dgram_sock *ro)
-{
-	if (!ro->bound)
-		return true;
-
-	if (ro->src_addr.mode == IEEE802154_ADDR_LONG &&
-	    hw_addr == ro->src_addr.extended_addr)
-		return true;
-
-	if (ro->src_addr.mode == IEEE802154_ADDR_SHORT &&
-	    pan_id == ro->src_addr.pan_id &&
-	    short_addr == ro->src_addr.short_addr)
-		return true;
-
-	return false;
-}
-
-int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
-{
-	struct sock *sk, *prev = NULL;
-	int ret = NET_RX_SUCCESS;
-	__le16 pan_id, short_addr;
-	__le64 hw_addr;
-
-	/* Data frame processing */
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
-	short_addr = ieee802154_mlme_ops(dev)->get_short_addr(dev);
-	hw_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
-
-	read_lock(&dgram_lock);
-	sk_for_each(sk, &dgram_head) {
-		if (ieee802154_match_sock(hw_addr, pan_id, short_addr,
-					  dgram_sk(sk))) {
-			if (prev) {
-				struct sk_buff *clone;
-
-				clone = skb_clone(skb, GFP_ATOMIC);
-				if (clone)
-					dgram_rcv_skb(prev, clone);
-			}
-
-			prev = sk;
-		}
-	}
-
-	if (prev) {
-		dgram_rcv_skb(prev, skb);
-	} else {
-		kfree_skb(skb);
-		ret = NET_RX_DROP;
-	}
-	read_unlock(&dgram_lock);
-
-	return ret;
-}
-
-static int dgram_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
-{
-	struct dgram_sock *ro = dgram_sk(sk);
-
-	int val, len;
-
-	if (level != SOL_IEEE802154)
-		return -EOPNOTSUPP;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	len = min_t(unsigned int, len, sizeof(int));
-
-	switch (optname) {
-	case WPAN_WANTACK:
-		val = ro->want_ack;
-		break;
-	case WPAN_SECURITY:
-		if (!ro->secen_override)
-			val = WPAN_SECURITY_DEFAULT;
-		else if (ro->secen)
-			val = WPAN_SECURITY_ON;
-		else
-			val = WPAN_SECURITY_OFF;
-		break;
-	case WPAN_SECURITY_LEVEL:
-		if (!ro->seclevel_override)
-			val = WPAN_SECURITY_LEVEL_DEFAULT;
-		else
-			val = ro->seclevel;
-		break;
-	default:
-		return -ENOPROTOOPT;
-	}
-
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
-		return -EFAULT;
-	return 0;
-}
-
-static int dgram_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, unsigned int optlen)
-{
-	struct dgram_sock *ro = dgram_sk(sk);
-	struct net *net = sock_net(sk);
-	int val;
-	int err = 0;
-
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (get_user(val, (int __user *)optval))
-		return -EFAULT;
-
-	lock_sock(sk);
-
-	switch (optname) {
-	case WPAN_WANTACK:
-		ro->want_ack = !!val;
-		break;
-	case WPAN_SECURITY:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
-		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
-			err = -EPERM;
-			break;
-		}
-
-		switch (val) {
-		case WPAN_SECURITY_DEFAULT:
-			ro->secen_override = 0;
-			break;
-		case WPAN_SECURITY_ON:
-			ro->secen_override = 1;
-			ro->secen = 1;
-			break;
-		case WPAN_SECURITY_OFF:
-			ro->secen_override = 1;
-			ro->secen = 0;
-			break;
-		default:
-			err = -EINVAL;
-			break;
-		}
-		break;
-	case WPAN_SECURITY_LEVEL:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
-		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
-			err = -EPERM;
-			break;
-		}
-
-		if (val < WPAN_SECURITY_LEVEL_DEFAULT ||
-		    val > IEEE802154_SCF_SECLEVEL_ENC_MIC128) {
-			err = -EINVAL;
-		} else if (val == WPAN_SECURITY_LEVEL_DEFAULT) {
-			ro->seclevel_override = 0;
-		} else {
-			ro->seclevel_override = 1;
-			ro->seclevel = val;
-		}
-		break;
-	default:
-		err = -ENOPROTOOPT;
-		break;
-	}
-
-	release_sock(sk);
-	return err;
-}
-
-struct proto ieee802154_dgram_prot = {
-	.name		= "IEEE-802.15.4-MAC",
-	.owner		= THIS_MODULE,
-	.obj_size	= sizeof(struct dgram_sock),
-	.init		= dgram_init,
-	.close		= dgram_close,
-	.bind		= dgram_bind,
-	.sendmsg	= dgram_sendmsg,
-	.recvmsg	= dgram_recvmsg,
-	.hash		= dgram_hash,
-	.unhash		= dgram_unhash,
-	.connect	= dgram_connect,
-	.disconnect	= dgram_disconnect,
-	.ioctl		= dgram_ioctl,
-	.getsockopt	= dgram_getsockopt,
-	.setsockopt	= dgram_setsockopt,
-};
-
diff --git a/net/ieee802154/raw.c b/net/ieee802154/raw.c
deleted file mode 100644
index 1674b115..0000000
--- a/net/ieee802154/raw.c
+++ /dev/null
@@ -1,270 +0,0 @@
-/*
- * Raw IEEE 802.15.4 sockets
- *
- * Copyright 2007, 2008 Siemens AG
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Written by:
- * Sergey Lapin <slapin@ossfans.org>
- * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
- */
-
-#include <linux/net.h>
-#include <linux/module.h>
-#include <linux/if_arp.h>
-#include <linux/list.h>
-#include <linux/slab.h>
-#include <net/sock.h>
-#include <net/af_ieee802154.h>
-#include <net/ieee802154_netdev.h>
-
-#include "af802154.h"
-
-static HLIST_HEAD(raw_head);
-static DEFINE_RWLOCK(raw_lock);
-
-static void raw_hash(struct sock *sk)
-{
-	write_lock_bh(&raw_lock);
-	sk_add_node(sk, &raw_head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-	write_unlock_bh(&raw_lock);
-}
-
-static void raw_unhash(struct sock *sk)
-{
-	write_lock_bh(&raw_lock);
-	if (sk_del_node_init(sk))
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-	write_unlock_bh(&raw_lock);
-}
-
-static void raw_close(struct sock *sk, long timeout)
-{
-	sk_common_release(sk);
-}
-
-static int raw_bind(struct sock *sk, struct sockaddr *_uaddr, int len)
-{
-	struct ieee802154_addr addr;
-	struct sockaddr_ieee802154 *uaddr = (struct sockaddr_ieee802154 *)_uaddr;
-	int err = 0;
-	struct net_device *dev = NULL;
-
-	if (len < sizeof(*uaddr))
-		return -EINVAL;
-
-	uaddr = (struct sockaddr_ieee802154 *)_uaddr;
-	if (uaddr->family != AF_IEEE802154)
-		return -EINVAL;
-
-	lock_sock(sk);
-
-	ieee802154_addr_from_sa(&addr, &uaddr->addr);
-	dev = ieee802154_get_dev(sock_net(sk), &addr);
-	if (!dev) {
-		err = -ENODEV;
-		goto out;
-	}
-
-	if (dev->type != ARPHRD_IEEE802154) {
-		err = -ENODEV;
-		goto out_put;
-	}
-
-	sk->sk_bound_dev_if = dev->ifindex;
-	sk_dst_reset(sk);
-
-out_put:
-	dev_put(dev);
-out:
-	release_sock(sk);
-
-	return err;
-}
-
-static int raw_connect(struct sock *sk, struct sockaddr *uaddr,
-		       int addr_len)
-{
-	return -ENOTSUPP;
-}
-
-static int raw_disconnect(struct sock *sk, int flags)
-{
-	return 0;
-}
-
-static int raw_sendmsg(struct kiocb *iocb, struct sock *sk,
-		       struct msghdr *msg, size_t size)
-{
-	struct net_device *dev;
-	unsigned int mtu;
-	struct sk_buff *skb;
-	int hlen, tlen;
-	int err;
-
-	if (msg->msg_flags & MSG_OOB) {
-		pr_debug("msg->msg_flags = 0x%x\n", msg->msg_flags);
-		return -EOPNOTSUPP;
-	}
-
-	lock_sock(sk);
-	if (!sk->sk_bound_dev_if)
-		dev = dev_getfirstbyhwtype(sock_net(sk), ARPHRD_IEEE802154);
-	else
-		dev = dev_get_by_index(sock_net(sk), sk->sk_bound_dev_if);
-	release_sock(sk);
-
-	if (!dev) {
-		pr_debug("no dev\n");
-		err = -ENXIO;
-		goto out;
-	}
-
-	mtu = dev->mtu;
-	pr_debug("name = %s, mtu = %u\n", dev->name, mtu);
-
-	if (size > mtu) {
-		pr_debug("size = %Zu, mtu = %u\n", size, mtu);
-		err = -EINVAL;
-		goto out_dev;
-	}
-
-	hlen = LL_RESERVED_SPACE(dev);
-	tlen = dev->needed_tailroom;
-	skb = sock_alloc_send_skb(sk, hlen + tlen + size,
-				  msg->msg_flags & MSG_DONTWAIT, &err);
-	if (!skb)
-		goto out_dev;
-
-	skb_reserve(skb, hlen);
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-
-	err = memcpy_from_msg(skb_put(skb, size), msg, size);
-	if (err < 0)
-		goto out_skb;
-
-	skb->dev = dev;
-	skb->sk  = sk;
-	skb->protocol = htons(ETH_P_IEEE802154);
-
-	dev_put(dev);
-
-	err = dev_queue_xmit(skb);
-	if (err > 0)
-		err = net_xmit_errno(err);
-
-	return err ?: size;
-
-out_skb:
-	kfree_skb(skb);
-out_dev:
-	dev_put(dev);
-out:
-	return err;
-}
-
-static int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		       size_t len, int noblock, int flags, int *addr_len)
-{
-	size_t copied = 0;
-	int err = -EOPNOTSUPP;
-	struct sk_buff *skb;
-
-	skb = skb_recv_datagram(sk, flags, noblock, &err);
-	if (!skb)
-		goto out;
-
-	copied = skb->len;
-	if (len < copied) {
-		msg->msg_flags |= MSG_TRUNC;
-		copied = len;
-	}
-
-	err = skb_copy_datagram_msg(skb, 0, msg, copied);
-	if (err)
-		goto done;
-
-	sock_recv_ts_and_drops(msg, sk, skb);
-
-	if (flags & MSG_TRUNC)
-		copied = skb->len;
-done:
-	skb_free_datagram(sk, skb);
-out:
-	if (err)
-		return err;
-	return copied;
-}
-
-static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!skb)
-		return NET_RX_DROP;
-
-	if (sock_queue_rcv_skb(sk, skb) < 0) {
-		kfree_skb(skb);
-		return NET_RX_DROP;
-	}
-
-	return NET_RX_SUCCESS;
-}
-
-void ieee802154_raw_deliver(struct net_device *dev, struct sk_buff *skb)
-{
-	struct sock *sk;
-
-	read_lock(&raw_lock);
-	sk_for_each(sk, &raw_head) {
-		bh_lock_sock(sk);
-		if (!sk->sk_bound_dev_if ||
-		    sk->sk_bound_dev_if == dev->ifindex) {
-			struct sk_buff *clone;
-
-			clone = skb_clone(skb, GFP_ATOMIC);
-			if (clone)
-				raw_rcv_skb(sk, clone);
-		}
-		bh_unlock_sock(sk);
-	}
-	read_unlock(&raw_lock);
-}
-
-static int raw_getsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int __user *optlen)
-{
-	return -EOPNOTSUPP;
-}
-
-static int raw_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
-{
-	return -EOPNOTSUPP;
-}
-
-struct proto ieee802154_raw_prot = {
-	.name		= "IEEE-802.15.4-RAW",
-	.owner		= THIS_MODULE,
-	.obj_size	= sizeof(struct sock),
-	.close		= raw_close,
-	.bind		= raw_bind,
-	.sendmsg	= raw_sendmsg,
-	.recvmsg	= raw_recvmsg,
-	.hash		= raw_hash,
-	.unhash		= raw_unhash,
-	.connect	= raw_connect,
-	.disconnect	= raw_disconnect,
-	.getsockopt	= raw_getsockopt,
-	.setsockopt	= raw_setsockopt,
-};
-- 
2.2.0

