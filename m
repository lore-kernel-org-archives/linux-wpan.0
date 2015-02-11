Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35857 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbBKMR6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 07:17:58 -0500
Message-ID: <54DB486E.4080905@pengutronix.de>
Date: Wed, 11 Feb 2015 13:17:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: cleanup ieee802154_be64_to_le64
References: <1423606461-16945-1-git-send-email-alex.aring@gmail.com> <1423606461-16945-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423606461-16945-3-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hne489WG9TPkKv19VxCe1qtULkbikp0uf"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hne489WG9TPkKv19VxCe1qtULkbikp0uf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2015 11:14 PM, Alexander Aring wrote:
> This patch cleanups the ieee802154_be64_to_le64 function. This patch
> removes an unnecessary temporary variable.
>=20
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/net/mac802154.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 8506478..a4dcefe 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -233,9 +233,7 @@ struct ieee802154_ops {
>   */
>  static inline void ieee802154_be64_to_le64(void *le64_dst, const void =
*be64_src)
>  {
> -	__le64 tmp =3D (__force __le64)swab64p(be64_src);
> -
> -	memcpy(le64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
> +	*((__le64 *)le64_dst) =3D (__force __le64)swab64p(be64_src);

I assume the compiler optimizes the memcpy, due to the constant length
argument. It the dst always 64 bit aligned?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hne489WG9TPkKv19VxCe1qtULkbikp0uf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU20huAAoJECte4hHFiupUZCIP/jV1Ct5TAQfblw6f1iaxJAyR
LKDswVcy7J7UHnJhhPVthItZooqsY36Yy5Iz+MN1mkUiy7G520mDej0fMDBfpuea
0Ij4dPJxoMhJUgCNxLaQ0L94pb5Cz5gl7osqBMR1vaYXU/OhDEbm7eFBlSYuPpgV
Uj8nxEUHo+5O8EZyvVWX5dVjUGsTJ1tHynM4Xo1ikCIQCuvjDDZ2QWJE9RiEeAO5
oPcxFGjF+C7hGe4fr6GpunsEFDF2aY2VJtU7R68xbyao8qwecTiE9VZ8ni/HrogC
Bqge6CNpRd7qRiO0TNDY488kMB3kF1LYkk/eBp+j5p2FB9Ao84PZN6M+eThWwF8R
cYzTZK1f++dW51NjsAjGyJKyM0psGgeGbpmDyF/DyQ7J5LPqoWXWtX/OYWVZbAwS
x0H5V4KVTMXMBTDWaj0Q28UVrIap9RiFiqZm0kde1m+TdaRVODSanwRAOxxYTQBM
Lc8soFKy4i1VViijwX0yCr6yrIROPt/Zy3gb9wjBbTNyVnn8ot6H2CI/LrM2Y7Bv
eDW4dg3JIJGNBLeGvazSLgQyb2QRdHHkUT30f+n5gzecbtoijpoGBmP0BffXxL12
fuj7EaktI8iE/tGnM8K2BL6GyLpqWNEK2wE6g7zOxzlAr5NW6z1SzM1EuCgcV99V
zBg7nk1ZI7Pia8GpDdGe
=WD1Z
-----END PGP SIGNATURE-----

--hne489WG9TPkKv19VxCe1qtULkbikp0uf--
