Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:39906
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbfCKHae (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 11 Mar 2019 03:30:34 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
Date: Mon, 11 Mar 2019 07:30:31 +0000
Message-ID: <BN3PR0301MB0897817BBE72CE6A33A1DE728E480@BN3PR0301MB0897.namprd03.prod.outlook.com>
References: <20190311072517.29740-1-kjlu@umn.edu>
In-Reply-To: <20190311072517.29740-1-kjlu@umn.edu>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Kangjie Lu <kjlu@umn.edu>
Cc: "pakki001@umn.edu" <pakki001@umn.edu>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Kangjie Lu [mailto:kjlu@umn.edu]
> Sent: Montag, 11. M=E4rz 2019 08:25
> To: kjlu@umn.edu
> Cc: pakki001@umn.edu; Hennerich, Michael <Michael.Hennerich@analog.com>; =
Alexander Aring <alex.aring@gmail.com>; Stefan
> Schmidt <stefan@datenfreihafen.org>; David S. Miller <davem@davemloft.net=
>; linux-wpan@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] net: ieee802154: fix a potential NULL pointer dereferenc=
e
>=20
> In case alloc_ordered_workqueue fails, the fix releases
> sources and returns -ENOMEM to avoid NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/net/ieee802154/adf7242.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/ad=
f7242.c
> index cd1d8faccca5..cd6b95e673a5 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
>         INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
>         lp->wqueue =3D alloc_ordered_workqueue(dev_name(&spi->dev),
>                                              WQ_MEM_RECLAIM);
> +       if (unlikely(!lp->wqueue)) {
> +               ret =3D -ENOMEM;
> +               goto err_hw_init;
> +       }
>=20
>         ret =3D adf7242_hw_init(lp);
>         if (ret)
> --
> 2.17.1
