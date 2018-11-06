Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38475 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbeKFXxv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Nov 2018 18:53:51 -0500
Received: by mail-oi1-f180.google.com with SMTP id v83-v6so10836570oia.5
        for <linux-wpan@vger.kernel.org>; Tue, 06 Nov 2018 06:28:22 -0800 (PST)
MIME-Version: 1.0
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <20181105165544.5215-3-starnight@g.ncu.edu.tw> <20181105.101610.1437737564548154497.davem@davemloft.net>
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue, 6 Nov 2018 22:28:18 +0800
Message-ID: <CAC=mGzh3KH5H6zAOb_rZvjkYycGcJ=99bJreRzKtgVGS==K8qA@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] net: lorawan: Add LoRaWAN socket module
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B411=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Tue,  6 Nov 2018 00:55:40 +0800
>
> > +static inline struct lrw_mac_cb * mac_cb(struct sk_buff *skb)
>
> "mac_cb()" is pretty generic for a name, and leads to namespace pollution=
,
> please use lrw_mac_cb() or similar.
>
> > +static inline struct dgram_sock *
> > +dgram_sk(const struct sock *sk)
> > +{
> > +     return container_of(sk, struct dgram_sock, sk);
> > +}
> > +
> > +static inline struct net_device *
> > +lrw_get_dev_by_addr(struct net *net, u32 devaddr)
>
> Never use inline for functions in a foo.c file, let the compiler decide.
>
> > +{
> > +     struct net_device *ndev =3D NULL;
> > +     __be32 be_addr =3D cpu_to_be32(devaddr);
>
> Always order local variables from longest to shortest line.
>
> > +static int
> > +dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > +           int noblock, int flags, int *addr_len)
> > +{
> > +     struct sk_buff *skb;
> > +     size_t copied =3D 0;
> > +     DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name)=
;
> > +     int err;
>
> Likewise.
>
> I'm not going to point out every single place where you have made these
> two errors.
>
> Please audit your entire submission and fix the problems wherever they
> occur.

Thanks for the reviewing.  I will check the submission again.

Jian-Hong Pan
