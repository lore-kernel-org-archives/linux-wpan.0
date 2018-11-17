Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45990 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRBLE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 17 Nov 2018 20:11:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id b141so12972174oii.12
        for <linux-wpan@vger.kernel.org>; Sat, 17 Nov 2018 06:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-3-starnight@g.ncu.edu.tw> <20181116.203200.1638720313402188457.davem@davemloft.net>
In-Reply-To: <20181116.203200.1638720313402188457.davem@davemloft.net>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sat, 17 Nov 2018 22:54:08 +0800
Message-ID: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/7] net: lorawan: Add LoRaWAN socket module
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B411=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Thu, 15 Nov 2018 00:01:23 +0800
>
> > +#define      lrw_get_mac_cb(skb)     ((struct lrw_mac_cb *)skb->cb)
>
> Please make this a static inline function.  If the identifier is all lowe=
rcase
> programmers expect it to be real code not a CPP macro.

Okay!  Sure

> > +#define      LORAWAN_MODULE_NAME     "lorawan"
> > +
> > +#define      LRW_DBG_STR(fmt)        LORAWAN_MODULE_NAME": "fmt
> > +#define      lrw_info(fmt, ...)      (pr_info(LRW_DBG_STR(fmt), ##__VA=
_ARGS__))
> > +#define      lrw_dbg(fmt, ...)       (pr_debug(LRW_DBG_STR(fmt), ##__V=
A_ARGS__))
>
> Just define "pr_fmt()" appropriately and you don't need to play these kin=
ds
> of games.
>
> Set pr_fmt() and call pr_info() and pr_debug() directly.

After checking printk.h again, I get the idea of the comment.
"pr_fmt()" is more convenient!

Thanks for the reviewing.  I will make new patches.

Jian-Hong Pan
