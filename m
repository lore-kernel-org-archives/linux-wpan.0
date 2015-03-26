Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51140 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbbCZLzZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 07:55:25 -0400
Message-ID: <5513F38B.30007@pengutronix.de>
Date: Thu, 26 Mar 2015 12:54:51 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 3/3] at86rf230: fix is_tx while
 error handling
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com> <1427370390-31302-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1427370390-31302-3-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1RI1bJrcmXNfAbuMxcOCdpCURukpIT9TC"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1RI1bJrcmXNfAbuMxcOCdpCURukpIT9TC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/26/2015 12:46 PM, Alexander Aring wrote:
> This patch fix the error handling when is_tx is true. The error handlin=
g
> tries to get the transceiver into RX_AACK_ON mode then we need to be
> sure that is_tx is false.

Generally speaking, first fix errors, then clean up and improve code.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1RI1bJrcmXNfAbuMxcOCdpCURukpIT9TC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVE/OPAAoJECte4hHFiupUhPsP+wZ7IWg4eiVVP9+ATfiyLxIK
0imMf7etueuv+OTEMb2wEgSqUqrMtmJ7g9euzOWl4AzmIhzs4b5giL8nj/QJJlhu
TSI70mtnnRF6bObpNNYNN1PW7dkNGJmsJpkDzmuiklHnxsp6rY3otanX+oofKVO2
Iq0yBgxxosPUAYRaxWYdk9j8VqJ3t55ORzMPibvYzWWiFC9NvZbgm8i7Pa4lm5S4
MWjbUaIvuFreRF/WrfEBWhUf4uh5f15WPKhLQnbFYd8zDSiaifsYH+A0O08E6T6a
0kmvIZZ9BTSm2Lo0XJlKR8PDB/aNXry03cLOmlhmWmtXL7DfyGjlvGrZg8yJSKWx
4BgWWMmfkq2CRKgNdtKEU+LW7C9r0Q4lcGuICtVwLmo9mEyA6PEr5CSqM8yNhlA5
4M1QdvLsxiOFkVs46X2BRhCeyojxI37b78YZs5/cYcFZEI5AYf6YL9iDqtCWC0ha
vmMO60CHcKjmbPqfvdaLwQ6Nud+FeFVMW2ECEurJGmGkmXJReaKTAqe3y3/SZpf7
UjVs5+8pbputfr6SJ3aW341mbR3lPw5E8YyGRSo74zGQotZuqRJhMPaNcGwzjA9+
pX7AE1Yxp9dSEhUWS1jsAd8XJ5JPOvti1IH9nTF3LKNC3hbY3JXAq0tHMEEWcHVJ
ZHg+AYh21pHMNZ1+1aFB
=jj0N
-----END PGP SIGNATURE-----

--1RI1bJrcmXNfAbuMxcOCdpCURukpIT9TC--
