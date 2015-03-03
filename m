Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43895 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbbCCWb4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Mar 2015 17:31:56 -0500
Message-ID: <54F63654.2020701@pengutronix.de>
Date: Tue, 03 Mar 2015 23:31:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: add IEEE802154_FCS_LEN
References: <1425421655-21420-1-git-send-email-alex.aring@gmail.com> <1425421655-21420-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425421655-21420-4-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EmkQmBVPEob9KpGqsP1GnriJ06qPUjFFL"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EmkQmBVPEob9KpGqsP1GnriJ06qPUjFFL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2015 11:27 PM, Alexander Aring wrote:
> This patch adds a IEEE802154_FCS_LEN for the frame check sequence also
> called CRC which is inside the MFR (MAC Footer).

I think you can sqaush patch 3 into 2.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EmkQmBVPEob9KpGqsP1GnriJ06qPUjFFL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9jZXAAoJECte4hHFiupUrNsQAKIsSWgcZg6FB10QdoXchoy/
bOPXFkSF/dahbuNyz58htugu81z1QbBhxB0V1F8qDlkL8QBFBx4g8PFAyyaf7JL2
K4mxBlpZ+4+B2Gl66FtrmZuESXW2hSZpQov8RREV9kyBNpEGPvdbdh9/l6+LZIz3
jdeemAKfkIsGU2SwLO0DzsNe8NqoogeBeCPBTsYZqvIGtaHWnknmFr39KqPVBbYQ
H0uWu/mj9bctO0Sah5lDs8BQ8o5I8xa8E4WD7v4DIEuvwhVm9HEHkY12puZNJxJq
3VLIGwbrbBUADuOasrJ8MK4yIS3hx1JXV9jO3FYuIcE8nDpZAJ8fjNffydYOx7nD
9FR2CFCe1v5Ws5PV/N1XJFdvfkdIABT/BnmAGHfMTC49QRbMZcLZdI/EheKSmgUQ
v81wnBNCmMPEZhkryjuhfrVTslrHwIMXlTRGRpxIaMUI4OzWJ1/rQHLgZ/KtKhK1
CiN/VAXneUCEZkcqP7PViPH8VUngn+HbEcSTe/qR22ysQrZggb4rj1VX8/XYcB8Q
VllZSlT4ActUsoK9m/HwCywEpwvrJG3CiNGdTCEuwhCsZjo2jrB8GYuxLhVQTd+c
bIo/XpJLVMOzZN0RA4fSvwxspSC5F07gIfMAwarmsxLjjXLd7B5jnFYXmLKx0KNy
QO6QKZWmFcg5cGxWypBu
=qn46
-----END PGP SIGNATURE-----

--EmkQmBVPEob9KpGqsP1GnriJ06qPUjFFL--
