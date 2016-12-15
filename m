Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52649 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757534AbcLOH7F (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 15 Dec 2016 02:59:05 -0500
Subject: Re: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <4b0172bd-2779-35b2-96af-407087db844e@pengutronix.de>
Date: Thu, 15 Dec 2016 08:57:57 +0100
MIME-Version: 1.0
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="20OdsOHopTjIkLdocWTx6rgi2767kTTSI"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-wireless@vger.kernel.org, wil6210@qca.qualcomm.com, brcm80211-dev-list.pdl@broadcom.com, devel@driverdev.osuosl.org, linux-wpan@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--20OdsOHopTjIkLdocWTx6rgi2767kTTSI
Content-Type: multipart/mixed; boundary="sdkl0Xxt0KtFM41xEtdan2EW1NXVMs5c1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Alexander Aring <aar@pengutronix.de>, Stefan Schmidt
 <stefan@osg.samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 linux-wireless@vger.kernel.org, wil6210@qca.qualcomm.com,
 brcm80211-dev-list.pdl@broadcom.com, devel@driverdev.osuosl.org,
 linux-wpan@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Message-ID: <4b0172bd-2779-35b2-96af-407087db844e@pengutronix.de>
Subject: Re: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>

--sdkl0Xxt0KtFM41xEtdan2EW1NXVMs5c1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2016 06:15 AM, Michael S. Tsirkin wrote:
> That's the default now, no need for makefiles to set it.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
[...]
>  drivers/net/can/Makefile                                  | 1 -

For drivers/net/can/Makefile:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sdkl0Xxt0KtFM41xEtdan2EW1NXVMs5c1--

--20OdsOHopTjIkLdocWTx6rgi2767kTTSI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhSTQUACgkQPTuqJayp
JWrYQwgAgF2pgtnOHFbQf8oOT0jYDqhXKpceBGDqy6nW6Dfs66GUNSM4nq3EHz99
s4Slq4IQjzACZjHbO0s/lALFRfK/BKYCmuRhBQ/iE2wjBTBw3Ej4keoXl9OiKvN+
VteIS+Y5REHxYDLfNRl15oCrn5s8oiImp93dl3rVHjIbMYq4mnWqapXK3Utj6GZf
l6FOT/t1I1i62GTeCwjwlTUC0MId3PYCQRax1JnjZsEWx/hHbaJUN26JGISns2uL
r1as5wh3Y1ey0l0+NdVpkAX1v9/BlqS56H1CdgCw2ucNo0GA3F5/Y9CGHjUcT47X
2l3UqTcMhQdEoPBTKauMUmq7YcACQw==
=NRSu
-----END PGP SIGNATURE-----

--20OdsOHopTjIkLdocWTx6rgi2767kTTSI--
