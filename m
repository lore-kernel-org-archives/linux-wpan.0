Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34087 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeGBNeg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jul 2018 09:34:36 -0400
MIME-Version: 1.0
References: <20180607140802.22666-1-peron.clem@gmail.com>
In-Reply-To: <20180607140802.22666-1-peron.clem@gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Mon, 2 Jul 2018 15:28:04 +0200
Message-ID: <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Romuald Cari <romuald.cari@devialet.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>

Could you review it please ?

Thanks,
Clement
On Thu, 7 Jun 2018 at 16:08, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> From: Romuald CARI <romuald.cari@devialet.com>
>
> The Link Quality Indication data exposed by drivers could not be accessed=
 from
> userspace. Since this data is per-datagram received, it makes sense to ma=
ke it
> available to userspace application through the ancillary data mechanism i=
n
> recvmsg rather than through ioctls. This can be activated using the socke=
t
> option WPAN_WANTLQI under SOL_IEEE802154 protocol.
>
> This LQI data is available in the ancillary data buffer under the SOL_IEE=
E802154
> level as the type WPAN_LQI. The value is an unsigned byte indicating the =
link
> quality with values ranging 0-255.
>
> Signed-off-by: Romuald Cari <romuald.cari@devialet.com>
> Signed-off-by: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> ---
>  include/net/af_ieee802154.h |  1 +
>  net/ieee802154/socket.c     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> index a5563d27a3eb..8003a9f6eb43 100644
> --- a/include/net/af_ieee802154.h
> +++ b/include/net/af_ieee802154.h
> @@ -56,6 +56,7 @@ struct sockaddr_ieee802154 {
>  #define WPAN_WANTACK           0
>  #define WPAN_SECURITY          1
>  #define WPAN_SECURITY_LEVEL    2
> +#define WPAN_WANTLQI           3
>
>  #define WPAN_SECURITY_DEFAULT  0
>  #define WPAN_SECURITY_OFF      1
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index a60658c85a9a..bc6b912603f1 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -25,6 +25,7 @@
>  #include <linux/termios.h>     /* For TIOCOUTQ/INQ */
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/socket.h>
>  #include <net/datalink.h>
>  #include <net/psnap.h>
>  #include <net/sock.h>
> @@ -452,6 +453,7 @@ struct dgram_sock {
>         unsigned int bound:1;
>         unsigned int connected:1;
>         unsigned int want_ack:1;
> +       unsigned int want_lqi:1;
>         unsigned int secen:1;
>         unsigned int secen_override:1;
>         unsigned int seclevel:3;
> @@ -486,6 +488,7 @@ static int dgram_init(struct sock *sk)
>         struct dgram_sock *ro =3D dgram_sk(sk);
>
>         ro->want_ack =3D 1;
> +       ro->want_lqi =3D 0;
>         return 0;
>  }
>
> @@ -713,6 +716,7 @@ static int dgram_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>         size_t copied =3D 0;
>         int err =3D -EOPNOTSUPP;
>         struct sk_buff *skb;
> +       struct dgram_sock *ro =3D dgram_sk(sk);
>         DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_na=
me);
>
>         skb =3D skb_recv_datagram(sk, flags, noblock, &err);
> @@ -744,6 +748,13 @@ static int dgram_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>                 *addr_len =3D sizeof(*saddr);
>         }
>
> +       if (ro->want_lqi) {
> +               err =3D put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> +                              sizeof(uint8_t), &(mac_cb(skb)->lqi));
> +               if (err)
> +                       goto done;
> +       }
> +
>         if (flags & MSG_TRUNC)
>                 copied =3D skb->len;
>  done:
> @@ -847,6 +858,9 @@ static int dgram_getsockopt(struct sock *sk, int leve=
l, int optname,
>         case WPAN_WANTACK:
>                 val =3D ro->want_ack;
>                 break;
> +       case WPAN_WANTLQI:
> +               val =3D ro->want_lqi;
> +               break;
>         case WPAN_SECURITY:
>                 if (!ro->secen_override)
>                         val =3D WPAN_SECURITY_DEFAULT;
> @@ -892,6 +906,9 @@ static int dgram_setsockopt(struct sock *sk, int leve=
l, int optname,
>         case WPAN_WANTACK:
>                 ro->want_ack =3D !!val;
>                 break;
> +       case WPAN_WANTLQI:
> +               ro->want_lqi =3D !!val;
> +               break;
>         case WPAN_SECURITY:
>                 if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
>                     !ns_capable(net->user_ns, CAP_NET_RAW)) {
> --
> 2.17.1
>
