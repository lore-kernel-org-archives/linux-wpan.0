Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34734 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbfAGOr3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Jan 2019 09:47:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id r62so507141oie.1
        for <linux-wpan@vger.kernel.org>; Mon, 07 Jan 2019 06:47:27 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-2-starnight@g.ncu.edu.tw> <b1eb9451-cb15-3fc7-f95e-3100cf715ef6@suse.de>
In-Reply-To: <b1eb9451-cb15-3fc7-f95e-3100cf715ef6@suse.de>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Mon, 7 Jan 2019 22:47:34 +0800
Message-ID: <CAC=mGzgbVUFJuGaKByK0MQgArtDaYN+d1T3FaDiRJDJaG7hkwA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] net: lorawan: Add LoRaWAN socket module
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Ben Whitten <ben.whitten@lairdtech.com>

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2018=E5=B9=B412=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:27=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi Jian-Hong,
>
> Am 16.12.18 um 11:18 schrieb Jian-Hong Pan:
> > This patch adds a new address/protocol family for LoRaWAN network.
> > It also implements the the functions and maps to Datagram socket for
> > LoRaWAN unconfirmed data messages.
> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> [...]
> >  include/linux/lora/lorawan_netdev.h |  52 +++
> >  net/lorawan/Kconfig                 |  10 +
> >  net/lorawan/Makefile                |   2 +
> >  net/lorawan/socket.c                | 686 ++++++++++++++++++++++++++++
> >  4 files changed, 750 insertions(+)
> >  create mode 100644 include/linux/lora/lorawan_netdev.h
> >  create mode 100644 net/lorawan/Kconfig
> >  create mode 100644 net/lorawan/Makefile
> >  create mode 100644 net/lorawan/socket.c
>
> I'm not 100% happy with this yet, but to decouple it from the soft-MAC
> discussion (patches 2-6/6) and to allow reuse by Ben, I've staged it in
> linux-lora.git.
>
> We can clean it up with incremental patches there (and squash later).
>
> >
> > diff --git a/include/linux/lora/lorawan_netdev.h b/include/linux/lora/l=
orawan_netdev.h
> > new file mode 100644
> > index 000000000000..5bffb5164f95
> > --- /dev/null
> > +++ b/include/linux/lora/lorawan_netdev.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
>
> Is there any practical reason you dual-license your code? My LoRa code
> is only GPL - should I reconsider that?

I use dual-license due to the event "[Ksummit-discuss] [CORE TOPIC]
GPL defense issues"
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003=
580.html

> > +/*-
>
> I assume the dash is a typo?
>
> > + * LoRaWAN stack related definitions
> > + *
> > + * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
> > + *
>
> Leftover white line from old license header?
>
> > + */
> > +
> > +#ifndef __LORAWAN_NET_DEVICE_H__
> > +#define __LORAWAN_NET_DEVICE_H__
> > +
> > +enum {
> > +     LRW_ADDR_APPEUI,
> > +     LRW_ADDR_DEVEUI,
> > +     LRW_ADDR_DEVADDR,
> > +};
> > +
> > +struct lrw_addr_in {
> > +     int addr_type;
> > +     union {
> > +             u64 app_eui;
> > +             u64 dev_eui;
>
> In my RFC and in linux-lora.git I have a lora_eui typedef - any reason
> you're not using it here?

lora_eui is defined as a type of u8 array with 8 bytes in
include/linux/lora/dev.h
typedef u8 lora_eui[8];
It is not a basic nor simple data type.

1. There is the endian issue.  LoRaWAN uses little endian for
transmission.  If u64 data type is used, we can call functions like
cpu_to_le64 and le64_to_cpu to deal the endian jobs directly.
2. We can compare the EUIs with relational operators directly if the
EUI is not a type of array.

> > +             u32 devaddr;
> > +     };
> > +};
> > +
> > +struct sockaddr_lorawan {
> > +     sa_family_t family; /* AF_LORAWAN */
> > +     struct lrw_addr_in addr_in;
> > +};
> > +
> > +/**
> > + * lrw_mac_cb - This structure holds the control buffer (cb) of sk_buf=
f
> > + *
> > + * @devaddr: the LoRaWAN device address of this LoRaWAN hardware
> > + */
> > +struct lrw_mac_cb {
> > +     u32 devaddr;
> > +};
> > +
> > +/**
> > + * lrw_get_mac_cb - Get the LoRaWAN MAC control buffer of the sk_buff
> > + * @skb:     the exchanging sk_buff
> > + *
> > + * Return:   the pointer of LoRaWAN MAC control buffer
> > + */
> > +static inline struct lrw_mac_cb *lrw_get_mac_cb(struct sk_buff *skb)
> > +{
> > +     return (struct lrw_mac_cb *)skb->cb;
> > +}
>
> For LoRa I have a separate lora/skb.h - suggest to split this off into
> its own header consistently.

Sounds good.
Do you prefer separate them into lora/skb.h or lora/lorawan_skb.h?

> > +
> > +#endif
> > diff --git a/net/lorawan/Kconfig b/net/lorawan/Kconfig
> > new file mode 100644
> > index 000000000000..bf6c9b77573b
> > --- /dev/null
> > +++ b/net/lorawan/Kconfig
> > @@ -0,0 +1,10 @@
> > +config LORAWAN
> > +     tristate "LoRaWAN Network support"
>
> The N in LoRaWAN is already for Network. :)
>
> > +     help
> > +       LoRaWAN defines low data rate, low power and long range wireles=
s
> > +       wide area networks. It was designed to organize networks of aut=
omation
> > +       devices, such as sensors, switches and actuators. It can operat=
e
> > +       multiple kilometers wide.
>
> The missing information here to distinguish it from LoRa would be that
> it's a client/server technology centered around gateways. In particular
> gateways that anyone can run, distinguishing it from (Sigfox or) NB-IoT.
>
> > +
> > +       Say Y here to compile LoRaWAN support into the kernel or say M =
to
> > +       compile it as a module.
> > diff --git a/net/lorawan/Makefile b/net/lorawan/Makefile
> > new file mode 100644
> > index 000000000000..8c923ca6541a
> > --- /dev/null
> > +++ b/net/lorawan/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_LORAWAN)        +=3D lorawan.o
> > +lorawan-objs         :=3D socket.o
>
> Both Kconfig and Makefile are not integrated into net/ here. That
> happens only in 6/6.
>
> > diff --git a/net/lorawan/socket.c b/net/lorawan/socket.c
> > new file mode 100644
> > index 000000000000..7ef106b877ca
> > --- /dev/null
> > +++ b/net/lorawan/socket.c
> > @@ -0,0 +1,686 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> > +/*-
>
> ?
>
> > + * LoRaWAN stack related definitions
> > + *
> > + * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
> > + *
>
> ?
>
> > + */
> > +
> > +#define      LORAWAN_MODULE_NAME     "lorawan"
> > +
> > +#define      pr_fmt(fmt)             LORAWAN_MODULE_NAME ": " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/list.h>
> > +#include <linux/net.h>
> > +#include <linux/if_arp.h>
> > +#include <linux/termios.h>           /* For TIOCOUTQ/INQ */
> > +#include <net/sock.h>
> > +#include <linux/lora/lorawan_netdev.h>
>
> Please sort headers alphabetically.
>
> > +
> > +/**
> > + * dgram_sock - This structure holds the states of Datagram socket
> > + *
> > + * @sk:                      network layer representation of the socke=
t
> > + *                   sk must be the first member of dgram_sock
>
> Might that sentence be more useful as inline comment below?
>
> > + * @src_devaddr:     the LoRaWAN device address for this connection
> > + * @bound:           this socket is bound or not
> > + * @connected:               this socket is connected to the destinati=
on or not
> > + * @want_ack:                this socket needs to ack for the connecti=
on or not
>
> Doesn't exist below?
>
> > + */
> > +struct dgram_sock {
> > +     struct sock sk;
> > +     u32 src_devaddr;
> > +
> > +     u8 bound:1;
> > +     u8 connected:1;
> > +};
> > +
> > +static HLIST_HEAD(dgram_head);
> > +static DEFINE_RWLOCK(dgram_lock);
> > +
> > +static struct dgram_sock *
> > +dgram_sk(const struct sock *sk)
> > +{
> > +     return container_of(sk, struct dgram_sock, sk);
> > +}
> > +
> > +static struct net_device *
> > +lrw_get_dev_by_addr(struct net *net, u32 devaddr)
> > +{
> > +     __be32 be_addr =3D cpu_to_be32(devaddr);
> > +     struct net_device *ndev =3D NULL;
> > +
> > +     rcu_read_lock();
> > +     ndev =3D dev_getbyhwaddr_rcu(net, ARPHRD_LORAWAN, (char *)&be_add=
r);
> > +     if (ndev)
> > +             dev_hold(ndev);
> > +     rcu_read_unlock();
> > +
> > +     return ndev;
> > +}
> > +
> > +static int
> > +dgram_init(struct sock *sk)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void
> > +dgram_close(struct sock *sk, long timeout)
> > +{
> > +     sk_common_release(sk);
> > +}
> > +
> > +static int
> > +dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
> > +{
> > +     struct sockaddr_lorawan *addr =3D (struct sockaddr_lorawan *)uadd=
r;
> > +     struct dgram_sock *ro =3D dgram_sk(sk);
> > +     struct net_device *ndev;
> > +     int ret;
> > +
> > +     lock_sock(sk);
> > +     ro->bound =3D 0;
> > +
> > +     ret =3D -EINVAL;
> > +     if (len < sizeof(*addr))
> > +             goto dgram_bind_end;
> > +
> > +     if (addr->family !=3D AF_LORAWAN)
> > +             goto dgram_bind_end;
> > +
> > +     if (addr->addr_in.addr_type !=3D LRW_ADDR_DEVADDR)
> > +             goto dgram_bind_end;
> > +
> > +     pr_debug("%s: bind address %X\n", __func__, addr->addr_in.devaddr=
);
> > +     ndev =3D lrw_get_dev_by_addr(sock_net(sk), addr->addr_in.devaddr)=
;
> > +     if (!ndev) {
> > +             ret =3D -ENODEV;
> > +             goto dgram_bind_end;
> > +     }
> > +     netdev_dbg(ndev, "%s: get ndev\n", __func__);
> > +
> > +     if (ndev->type !=3D ARPHRD_LORAWAN) {
> > +             ret =3D -ENODEV;
> > +             goto dgram_bind_end;
>
> This is leaking ndev.
>
> > +     }
> > +
> > +     ro->src_devaddr =3D addr->addr_in.devaddr;
> > +     ro->bound =3D 1;
> > +     ret =3D 0;
> > +     dev_put(ndev);
> > +     pr_debug("%s: bound address %X\n", __func__, ro->src_devaddr);
> > +
> > +dgram_bind_end:
> > +     release_sock(sk);
> > +     return ret;
> > +}
> > +
> > +static int
> > +lrw_dev_hard_header(struct sk_buff *skb, struct net_device *ndev,
> > +                 const u32 src_devaddr, size_t len)
> > +{
> > +     /* TODO: Prepare the LoRaWAN sending header here */
>
> I wonder, is your idea that you would always write headers here but have
> me ignore them in hard-MAC drivers by accessing data and not head?
>
> I.e., does this dgram (and a later seqpacket) implementation give us not
> just the buffer to pass to hard-MAC or soft-MAC but actually LoRa, too,
> so that maclorawan needs to further post-processing of header/checksum?

I put lrw_dev_hard_header function here for the header processing nnd
thought it might be called in the future originally.  However, as you
mentioned, we already have soft and hard-MAC and this abstraction
layer only pass the buffer.  So, it can be removed now.

> > +     return 0;
> > +}
> > +
> > +static int
> > +dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> > +{
> > +     struct dgram_sock *ro =3D dgram_sk(sk);
> > +     struct net_device *ndev;
> > +     struct sk_buff *skb;
> > +     size_t hlen;
> > +     size_t tlen;
> > +     int ret;
> > +
> > +     pr_debug("%s: going to send %zu bytes", __func__, size);
>
> \n
>
> > +     if (msg->msg_flags & MSG_OOB) {
> > +             pr_debug("msg->msg_flags =3D 0x%x\n", msg->msg_flags);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     pr_debug("%s: check msg_name\n", __func__);
> > +     if (!ro->connected && !msg->msg_name)
> > +             return -EDESTADDRREQ;
> > +     else if (ro->connected && msg->msg_name)
> > +             return -EISCONN;
> > +
> > +     pr_debug("%s: check bound\n", __func__);
> > +     if (!ro->bound)
> > +             ndev =3D dev_getfirstbyhwtype(sock_net(sk), ARPHRD_LORAWA=
N);
> > +     else
> > +             ndev =3D lrw_get_dev_by_addr(sock_net(sk), ro->src_devadd=
r);
> > +
> > +     if (!ndev) {
> > +             pr_debug("no dev\n");
> > +             ret =3D -ENXIO;
> > +             goto dgram_sendmsg_end;
> > +     }
> > +
> > +     if (size > ndev->mtu) {
> > +             netdev_dbg(ndev, "size =3D %zu, mtu =3D %u\n", size, ndev=
->mtu);
> > +             ret =3D -EMSGSIZE;
> > +             goto dgram_sendmsg_end;
>
> Leaks at least ndev from lrw_get_dev_by_addr.
>
> > +     }
> > +
> > +     netdev_dbg(ndev, "%s: create skb\n", __func__);
> > +     hlen =3D LL_RESERVED_SPACE(ndev);
> > +     tlen =3D ndev->needed_tailroom;
> > +     skb =3D sock_alloc_send_skb(sk, hlen + tlen + size,
> > +                               msg->msg_flags & MSG_DONTWAIT,
> > +                               &ret);
> > +
> > +     if (!skb)
> > +             goto dgram_sendmsg_no_skb;
> > +
> > +     skb_reserve(skb, hlen);
> > +     skb_reset_network_header(skb);
> > +
> > +     ret =3D lrw_dev_hard_header(skb, ndev, 0, size);
> > +     if (ret < 0)
> > +             goto dgram_sendmsg_no_skb;
> > +
> > +     ret =3D memcpy_from_msg(skb_put(skb, size), msg, size);
> > +     if (ret > 0)
> > +             goto dgram_sendmsg_err_skb;
> > +
> > +     skb->dev =3D ndev;
> > +     skb->protocol =3D htons(ETH_P_LORAWAN);
> > +
> > +     netdev_dbg(ndev, "%s: push skb to xmit queue\n", __func__);
> > +     ret =3D dev_queue_xmit(skb);
> > +     if (ret > 0)
> > +             ret =3D net_xmit_errno(ret);
> > +     netdev_dbg(ndev, "%s: pushed skb to xmit queue with ret=3D%d\n",
> > +                __func__, ret);
> > +     dev_put(ndev);
> > +
> > +     return ret ?: size;
> > +
> > +dgram_sendmsg_err_skb:
> > +     kfree_skb(skb);
> > +dgram_sendmsg_no_skb:
> > +     dev_put(ndev);
> > +
> > +dgram_sendmsg_end:
> > +     return ret;
> > +}
> > +
> > +static int
> > +dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > +           int noblock, int flags, int *addr_len)
> > +{
> > +     DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name)=
;
> > +     struct sk_buff *skb;
> > +     size_t copied =3D 0;
> > +     int err;
> > +
> > +     skb =3D skb_recv_datagram(sk, flags, noblock, &err);
> > +     if (!skb)
> > +             goto dgram_recvmsg_end;
> > +
> > +     copied =3D skb->len;
> > +     if (len < copied) {
> > +             msg->msg_flags |=3D MSG_TRUNC;
> > +             copied =3D len;
> > +     }
> > +
> > +     err =3D skb_copy_datagram_msg(skb, 0, msg, copied);
> > +     if (err)
> > +             goto dgram_recvmsg_done;
> > +
> > +     sock_recv_ts_and_drops(msg, sk, skb);
> > +     if (saddr) {
> > +             memset(saddr, 0, sizeof(*saddr));
> > +             saddr->family =3D AF_LORAWAN;
> > +             saddr->addr_in.devaddr =3D lrw_get_mac_cb(skb)->devaddr;
> > +             *addr_len =3D sizeof(*saddr);
> > +     }
> > +
> > +     if (flags & MSG_TRUNC)
> > +             copied =3D skb->len;
> > +
> > +dgram_recvmsg_done:
> > +     skb_free_datagram(sk, skb);
> > +
> > +dgram_recvmsg_end:
> > +     if (err)
> > +             return err;
> > +     return copied;
> > +}
> > +
> > +static int
> > +dgram_hash(struct sock *sk)
> > +{
> > +     pr_debug("%s\n", __func__);
> > +     write_lock_bh(&dgram_lock);
> > +     sk_add_node(sk, &dgram_head);
> > +     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> > +     write_unlock_bh(&dgram_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static void
> > +dgram_unhash(struct sock *sk)
> > +{
> > +     pr_debug("%s\n", __func__);
> > +     write_lock_bh(&dgram_lock);
> > +     if (sk_del_node_init(sk))
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > +     write_unlock_bh(&dgram_lock);
> > +}
> > +
> > +static int
> > +dgram_connect(struct sock *sk, struct sockaddr *uaddr, int len)
> > +{
> > +     struct dgram_sock *ro =3D dgram_sk(sk);
> > +
> > +     /* Nodes of LoRaWAN send data to a gateway only, then data is rec=
eived
> > +      * and transferred to servers with the gateway's policy.
> > +      * So, the destination address is not used by nodes.
> > +      */
> > +     lock_sock(sk);
> > +     ro->connected =3D 1;
> > +     release_sock(sk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +dgram_disconnect(struct sock *sk, int flags)
> > +{
> > +     struct dgram_sock *ro =3D dgram_sk(sk);
> > +
> > +     lock_sock(sk);
> > +     ro->connected =3D 0;
> > +     release_sock(sk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +dgram_ioctl(struct sock *sk, int cmd, unsigned long arg)
> > +{
> > +     struct net_device *ndev =3D sk->sk_dst_cache->dev;
> > +     struct sk_buff *skb;
> > +     int amount;
> > +     int err;
> > +
> > +     netdev_dbg(ndev, "%s: ioctl file (cmd=3D0x%X)\n", __func__, cmd);
> > +     switch (cmd) {
> > +     case SIOCOUTQ:
> > +             amount =3D sk_wmem_alloc_get(sk);
> > +             err =3D put_user(amount, (int __user *)arg);
> > +             break;
> > +     case SIOCINQ:
> > +             amount =3D 0;
> > +             spin_lock_bh(&sk->sk_receive_queue.lock);
> > +             skb =3D skb_peek(&sk->sk_receive_queue);
> > +             if (skb) {
> > +                     /* We will only return the amount of this packet
> > +                      * since that is all that will be read.
> > +                      */
> > +                     amount =3D skb->len;
> > +             }
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +             err =3D put_user(amount, (int __user *)arg);
> > +             break;
> > +     default:
> > +             err =3D -ENOIOCTLCMD;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static int
> > +dgram_getsockopt(struct sock *sk, int level, int optname,
> > +              char __user *optval, int __user *optlen)
> > +{
> > +     int val, len;
> > +
> > +     if (level !=3D SOL_LORAWAN)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (get_user(len, optlen))
> > +             return -EFAULT;
> > +
> > +     len =3D min_t(unsigned int, len, sizeof(int));
> > +
> > +     switch (optname) {
> > +     default:
> > +             return -ENOPROTOOPT;
> > +     }
> > +
> > +     if (put_user(len, optlen))
> > +             return -EFAULT;
> > +
> > +     if (copy_to_user(optval, &val, len))
> > +             return -EFAULT;
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +dgram_setsockopt(struct sock *sk, int level, int optname,
> > +              char __user *optval, unsigned int optlen)
> > +{
> > +     int val;
> > +     int err;
> > +
> > +     err =3D 0;
> > +
> > +     if (optlen < sizeof(int))
> > +             return -EINVAL;
> > +
> > +     if (get_user(val, (int __user *)optval))
> > +             return -EFAULT;
> > +
> > +     lock_sock(sk);
> > +
> > +     switch (optname) {
> > +     default:
> > +             err =3D -ENOPROTOOPT;
> > +             break;
> > +     }
> > +
> > +     release_sock(sk);
> > +
> > +     return err;
> > +}
> > +
> > +static struct proto lrw_dgram_prot =3D {
> > +     .name           =3D "LoRaWAN",
> > +     .owner          =3D THIS_MODULE,
> > +     .obj_size       =3D sizeof(struct dgram_sock),
> > +     .init           =3D dgram_init,
> > +     .close          =3D dgram_close,
> > +     .bind           =3D dgram_bind,
> > +     .sendmsg        =3D dgram_sendmsg,
> > +     .recvmsg        =3D dgram_recvmsg,
> > +     .hash           =3D dgram_hash,
> > +     .unhash         =3D dgram_unhash,
> > +     .connect        =3D dgram_connect,
> > +     .disconnect     =3D dgram_disconnect,
> > +     .ioctl          =3D dgram_ioctl,
> > +     .getsockopt     =3D dgram_getsockopt,
> > +     .setsockopt     =3D dgram_setsockopt,
> > +};
> > +
> > +static int
> > +lrw_sock_release(struct socket *sock)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     if (sk) {
> > +             sock->sk =3D NULL;
> > +             sk->sk_prot->close(sk, 0);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +lrw_sock_bind(struct socket *sock, struct sockaddr *uaddr, int addr_le=
n)
> > +{
> > +     struct sockaddr_lorawan *addr =3D (struct sockaddr_lorawan *)uadd=
r;
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     pr_debug("%s: bind address %X\n", __func__, addr->addr_in.devaddr=
);
> > +     if (sk->sk_prot->bind)
> > +             return sk->sk_prot->bind(sk, uaddr, addr_len);
> > +
> > +     return sock_no_bind(sock, uaddr, addr_len);
> > +}
> > +
> > +static int
> > +lrw_sock_connect(struct socket *sock, struct sockaddr *uaddr,
> > +              int addr_len, int flags)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     if (addr_len < sizeof(uaddr->sa_family))
> > +             return -EINVAL;
> > +
> > +     return sk->sk_prot->connect(sk, uaddr, addr_len);
> > +}
> > +
> > +static int
> > +lrw_ndev_ioctl(struct sock *sk, struct ifreq __user *arg, unsigned int=
 cmd)
> > +{
> > +     struct net_device *ndev;
> > +     struct ifreq ifr;
> > +     int ret;
> > +
> > +     pr_debug("%s: cmd %ud\n", __func__, cmd);
> > +     ret =3D -ENOIOCTLCMD;
> > +
> > +     if (copy_from_user(&ifr, arg, sizeof(struct ifreq)))
> > +             return -EFAULT;
> > +
> > +     ifr.ifr_name[IFNAMSIZ - 1] =3D 0;
> > +
> > +     dev_load(sock_net(sk), ifr.ifr_name);
> > +     ndev =3D dev_get_by_name(sock_net(sk), ifr.ifr_name);
> > +
> > +     netdev_dbg(ndev, "%s: cmd %ud\n", __func__, cmd);
> > +     if (!ndev)
> > +             return -ENODEV;
> > +
> > +     if (ndev->type =3D=3D ARPHRD_LORAWAN && ndev->netdev_ops->ndo_do_=
ioctl)
> > +             ret =3D ndev->netdev_ops->ndo_do_ioctl(ndev, &ifr, cmd);
> > +
> > +     if (!ret && copy_to_user(arg, &ifr, sizeof(struct ifreq)))
> > +             ret =3D -EFAULT;
> > +     dev_put(ndev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int
> > +lrw_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long ar=
g)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     pr_debug("%s: cmd %ud\n", __func__, cmd);
> > +     switch (cmd) {
> > +     case SIOCGSTAMP:
> > +             return sock_get_timestamp(sk, (struct timeval __user *)ar=
g);
> > +     case SIOCGSTAMPNS:
> > +             return sock_get_timestampns(sk, (struct timespec __user *=
)arg);
> > +     case SIOCOUTQ:
> > +     case SIOCINQ:
> > +             if (!sk->sk_prot->ioctl)
> > +                     return -ENOIOCTLCMD;
> > +             return sk->sk_prot->ioctl(sk, cmd, arg);
> > +     default:
> > +             return lrw_ndev_ioctl(sk, (struct ifreq __user *)arg, cmd=
);
> > +     }
> > +}
> > +
> > +static int
> > +lrw_sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     pr_debug("%s: going to send %zu bytes\n", __func__, len);
> > +     return sk->sk_prot->sendmsg(sk, msg, len);
> > +}
> > +
> > +static const struct proto_ops lrw_dgram_ops =3D {
> > +     .family         =3D PF_LORAWAN,
> > +     .owner          =3D THIS_MODULE,
> > +     .release        =3D lrw_sock_release,
> > +     .bind           =3D lrw_sock_bind,
> > +     .connect        =3D lrw_sock_connect,
> > +     .socketpair     =3D sock_no_socketpair,
> > +     .accept         =3D sock_no_accept,
> > +     .getname        =3D sock_no_getname,
> > +     .poll           =3D datagram_poll,
> > +     .ioctl          =3D lrw_sock_ioctl,
> > +     .listen         =3D sock_no_listen,
> > +     .shutdown       =3D sock_no_shutdown,
> > +     .setsockopt     =3D sock_common_setsockopt,
> > +     .getsockopt     =3D sock_common_getsockopt,
> > +     .sendmsg        =3D lrw_sock_sendmsg,
> > +     .recvmsg        =3D sock_common_recvmsg,
> > +     .mmap           =3D sock_no_mmap,
> > +     .sendpage       =3D sock_no_sendpage,
> > +};
> > +
> > +static int
> > +lorawan_creat(struct net *net, struct socket *sock, int protocol, int =
kern)
>
> create
> Also, why lorawan_ here and lrw_ elsewhere?
>
> > +{
> > +     struct sock *sk;
> > +     int ret;
> > +
> > +     if (!net_eq(net, &init_net))
> > +             return -EAFNOSUPPORT;
> > +
> > +     if (sock->type !=3D SOCK_DGRAM)
> > +             return -EAFNOSUPPORT;
> > +
> > +     /* Allocates enough memory for dgram_sock whose first member is s=
k */
> > +     sk =3D sk_alloc(net, PF_LORAWAN, GFP_KERNEL, &lrw_dgram_prot, ker=
n);
> > +     if (!sk)
> > +             return -ENOMEM;
> > +
> > +     sock->ops =3D &lrw_dgram_ops;
> > +     sock_init_data(sock, sk);
> > +     sk->sk_family =3D PF_LORAWAN;
> > +     sock_set_flag(sk, SOCK_ZAPPED);
> > +
> > +     if (sk->sk_prot->hash) {
> > +             ret =3D sk->sk_prot->hash(sk);
> > +             if (ret) {
> > +                     sk_common_release(sk);
> > +                     goto lorawan_creat_end;
> > +             }
> > +     }
> > +
> > +     if (sk->sk_prot->init) {
> > +             ret =3D sk->sk_prot->init(sk);
> > +             if (ret)
> > +                     sk_common_release(sk);
> > +     }
> > +
> > +lorawan_creat_end:
>
> create
>
> > +     return ret;
> > +}
> > +
> > +static const struct net_proto_family lorawan_family_ops =3D {
> > +     .owner          =3D THIS_MODULE,
> > +     .family         =3D PF_LORAWAN,
> > +     .create         =3D lorawan_creat,
> > +};
> > +
> > +static int
> > +lrw_dgram_deliver(struct net_device *ndev, struct sk_buff *skb)
> > +{
> > +     struct dgram_sock *ro;
> > +     struct sock *sk;
> > +     bool found;
> > +     int ret;
> > +
> > +     ret =3D NET_RX_SUCCESS;
> > +     found =3D false;
>
> In times of C99 you could probably fold that into the declarations.
>
> > +
> > +     read_lock(&dgram_lock);
> > +     sk_for_each(sk, &dgram_head) {
> > +             ro =3D dgram_sk(sk);
> > +             if (cpu_to_be32(ro->src_devaddr) =3D=3D *(__be32 *)ndev->=
dev_addr) {
> > +                     found =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     read_unlock(&dgram_lock);
> > +
> > +     if (!found)
> > +             goto lrw_dgram_deliver_err;
> > +
> > +     skb =3D skb_share_check(skb, GFP_ATOMIC);
> > +     if (!skb)
> > +             return NET_RX_DROP;
> > +
> > +     if (sock_queue_rcv_skb(sk, skb) < 0)
> > +             goto lrw_dgram_deliver_err;
> > +
> > +     return ret;
> > +
> > +lrw_dgram_deliver_err:
> > +     kfree_skb(skb);
> > +     ret =3D NET_RX_DROP;
> > +     return ret;
> > +}
> > +
> > +static int
> > +lorawan_rcv(struct sk_buff *skb, struct net_device *ndev,
> > +         struct packet_type *pt, struct net_device *orig_ndev)
> > +{
> > +     if (!netif_running(ndev))
> > +             goto lorawan_rcv_drop;
> > +
> > +     if (!net_eq(dev_net(ndev), &init_net))
> > +             goto lorawan_rcv_drop;
> > +
> > +     if (ndev->type !=3D ARPHRD_LORAWAN)
> > +             goto lorawan_rcv_drop;
> > +
> > +     if (skb->pkt_type !=3D PACKET_OTHERHOST)
> > +             return lrw_dgram_deliver(ndev, skb);
> > +
> > +lorawan_rcv_drop:
> > +     kfree_skb(skb);
> > +     return NET_RX_DROP;
> > +}
> > +
> > +static struct packet_type lorawan_packet_type =3D {
> > +     .type           =3D htons(ETH_P_LORAWAN),
> > +     .func           =3D lorawan_rcv,
> > +};
> > +
> > +static int __init
> > +lrw_sock_init(void)
> > +{
> > +     int ret;
> > +
> > +     pr_info("module inserted\n");
> > +     ret =3D proto_register(&lrw_dgram_prot, 1);
> > +     if (ret)
> > +             goto lrw_sock_init_end;
> > +
> > +     /* Tell SOCKET that we are alive */
>
> Drop?
>
> > +     ret =3D sock_register(&lorawan_family_ops);
> > +     if (ret)
> > +             goto lrw_sock_init_err;
> > +
> > +     dev_add_pack(&lorawan_packet_type);
> > +     ret =3D 0;
> > +     goto lrw_sock_init_end;
> > +
> > +lrw_sock_init_err:
> > +     proto_unregister(&lrw_dgram_prot);
> > +
> > +lrw_sock_init_end:
> > +     return 0;
>
> return ret;?
>
> > +}
> > +
> > +static void __exit
> > +lrw_sock_exit(void)
> > +{
> > +     dev_remove_pack(&lorawan_packet_type);
> > +     sock_unregister(PF_LORAWAN);
> > +     proto_unregister(&lrw_dgram_prot);
> > +     pr_info("module removed\n");
> > +}
> > +
> > +module_init(lrw_sock_init);
> > +module_exit(lrw_sock_exit);
> > +
> > +MODULE_AUTHOR("Jian-Hong Pan, <starnight@g.ncu.edu.tw>");
>
> Drop the comma?
>
> > +MODULE_DESCRIPTION("LoRaWAN socket kernel module");
>
> Aren't they all kernel modules? :)
>
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_ALIAS_NETPROTO(PF_LORAWAN);

Thanks for the reviewing.  Preparing the fixing patches now. :)

Jain-Hong Pan
