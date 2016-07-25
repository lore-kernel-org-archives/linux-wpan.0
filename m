Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43952 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292AbcGYMPD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 08:15:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 1/4] ieee802154: socket: remove af802154 raw socket
Date: Mon, 25 Jul 2016 14:14:47 +0200
Message-Id: <20160725121450.4093-2-aar@pengutronix.de>
In-Reply-To: <20160725121450.4093-1-aar@pengutronix.de>
References: <20160725121450.4093-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch removes the af802154 raw socket handling which is a long time
broken. The current socket implementation sends out frames with mac header
included from userspace, which is the correct handling on raw sockets.
But on recevie handling the mac header isn't included because it will
cut off from packet layer handling.

The correct and new replacement is AF_PACKET RAW sockets which also
don't run "dev_queue_xmit" for sending out raw frames. So no qdisc will
be involved.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ieee802154/socket.c | 277 +-----------------------------------------------
 1 file changed, 1 insertion(+), 276 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index e0bd013..8679111 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -178,268 +178,6 @@ static int ieee802154_sock_ioctl(struct socket *sock, unsigned int cmd,
 	}
 }
 
-/* RAW Sockets (802.15.4 created in userspace) */
-static HLIST_HEAD(raw_head);
-static DEFINE_RWLOCK(raw_lock);
-
-static int raw_hash(struct sock *sk)
-{
-	write_lock_bh(&raw_lock);
-	sk_add_node(sk, &raw_head);
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-	write_unlock_bh(&raw_lock);
-
-	return 0;
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
-	sk->sk_bound_dev_if = dev->ifindex;
-	sk_dst_reset(sk);
-
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
-static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
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
-	mtu = IEEE802154_MTU;
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
-static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-		       int noblock, int flags, int *addr_len)
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
-static void ieee802154_raw_deliver(struct net_device *dev, struct sk_buff *skb)
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
-static struct proto ieee802154_raw_prot = {
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
-
-static const struct proto_ops ieee802154_raw_ops = {
-	.family		   = PF_IEEE802154,
-	.owner		   = THIS_MODULE,
-	.release	   = ieee802154_sock_release,
-	.bind		   = ieee802154_sock_bind,
-	.connect	   = ieee802154_sock_connect,
-	.socketpair	   = sock_no_socketpair,
-	.accept		   = sock_no_accept,
-	.getname	   = sock_no_getname,
-	.poll		   = datagram_poll,
-	.ioctl		   = ieee802154_sock_ioctl,
-	.listen		   = sock_no_listen,
-	.shutdown	   = sock_no_shutdown,
-	.setsockopt	   = sock_common_setsockopt,
-	.getsockopt	   = sock_common_getsockopt,
-	.sendmsg	   = ieee802154_sock_sendmsg,
-	.recvmsg	   = sock_common_recvmsg,
-	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
-#ifdef CONFIG_COMPAT
-	.compat_setsockopt = compat_sock_common_setsockopt,
-	.compat_getsockopt = compat_sock_common_getsockopt,
-#endif
-};
-
 /* DGRAM Sockets (802.15.4 dataframes) */
 static HLIST_HEAD(dgram_head);
 static DEFINE_RWLOCK(dgram_lock);
@@ -1002,10 +740,6 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 		return -EAFNOSUPPORT;
 
 	switch (sock->type) {
-	case SOCK_RAW:
-		proto = &ieee802154_raw_prot;
-		ops = &ieee802154_raw_ops;
-		break;
 	case SOCK_DGRAM:
 		proto = &ieee802154_dgram_prot;
 		ops = &ieee802154_dgram_ops;
@@ -1067,8 +801,6 @@ static int ieee802154_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!net_eq(dev_net(dev), &init_net))
 		goto drop;
 
-	ieee802154_raw_deliver(dev, skb);
-
 	if (dev->type != ARPHRD_IEEE802154)
 		goto drop;
 
@@ -1089,13 +821,9 @@ static int __init af_ieee802154_init(void)
 {
 	int rc = -EINVAL;
 
-	rc = proto_register(&ieee802154_raw_prot, 1);
-	if (rc)
-		goto out;
-
 	rc = proto_register(&ieee802154_dgram_prot, 1);
 	if (rc)
-		goto err_dgram;
+		goto out;
 
 	/* Tell SOCKET that we are alive */
 	rc = sock_register(&ieee802154_family_ops);
@@ -1108,8 +836,6 @@ static int __init af_ieee802154_init(void)
 
 err_sock:
 	proto_unregister(&ieee802154_dgram_prot);
-err_dgram:
-	proto_unregister(&ieee802154_raw_prot);
 out:
 	return rc;
 }
@@ -1119,7 +845,6 @@ static void __exit af_ieee802154_remove(void)
 	dev_remove_pack(&ieee802154_packet_type);
 	sock_unregister(PF_IEEE802154);
 	proto_unregister(&ieee802154_dgram_prot);
-	proto_unregister(&ieee802154_raw_prot);
 }
 
 module_init(af_ieee802154_init);
-- 
2.9.0

