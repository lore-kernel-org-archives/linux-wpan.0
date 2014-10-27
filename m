Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50515 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaJ0MPN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 08:15:13 -0400
Message-ID: <544E364E.5090702@pengutronix.de>
Date: Mon, 27 Oct 2014 13:10:54 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 04/16] mac802154: rx: warn if ieee80211_rx
 call from irq
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com> <1414410189-20092-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414410189-20092-5-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xIiJoUdCJt2BFtVp7jPaeSc7msNOHx3TJ"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xIiJoUdCJt2BFtVp7jPaeSc7msNOHx3TJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2014 12:42 PM, Alexander Aring wrote:
> This patch adds a warning if the ieee80211_rx function is called from a=
n
> irq context which should never happen.

do you mean hard and/or softirq here?

>=20
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/mac802154/rx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 2851a3f..c4df321 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -61,6 +61,8 @@ fail:
> =20
>  void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
>  {
> +	WARN_ON_ONCE(softirq_count() =3D=3D 0);
> +

better use in_irq() or in_softirq(), see:

http://lxr.free-electrons.com/source/include/linux/preempt_mask.h#L64

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xIiJoUdCJt2BFtVp7jPaeSc7msNOHx3TJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTjZOAAoJECte4hHFiupUrZEP+wSVb9ewtj0TLq9KrC2+3i76
AzDes1Y258gtFeipvW3RAR/t9MoayuxELJ/Cb9v4IvCmEUnfzbM6z5nyv28hSXhH
z2ZSwW8lf9AZZGFwkJHXM2BMmfQlr9MeFgcVL/JOOOK+dOVSp0sTY/rT+56XRe6/
Sn7aBgMlmOaJ2WTSF6RRqHvylXHd2bnyebuqGhhCWGja24k2p3QAS2+bsq6Q6XQo
erAPg8FH8x37FBctZZ6s+2y1wBhYHnHQ5Afq3Q0/KAWkwk12bS7XMCqFvwQsaP5s
HUUOYXg6hFdg6+D56DJKWE34Sdtbsyb6wUS5MK7HMkzuC+ea5s5pfoViStuQwjvZ
Yu4Z9DF3919JFsZkYk9Rk+CYt2Zax66pE60qZL1dElpWyI7p92/EXltBuUE9eY5k
+dPBSQDcywwD90aiZFKRR5SJQIquTpulpDar76cc1Dcf+aRDvc6B83BsKk0cfqKB
OvrSA3OLIeZFEQFsNjjeVjEhn9yCvIbacR4dxvkJKORdzMJU08B1yYLEYyDw+B4G
+ghQeMvz1TFTKm2JUAI0Ijw/N74xsHvzWGNTNIlmykyRxWp4sYq1ZnsihIhS1Faw
pTbN65bTcbANynQbV2WKG3Ndq2WlX1UWVXtkLdf1yRy63Nu3WaT5yrv6TS5xCssh
u8GXzyN/tov1b/BQl8Jv
=rL8O
-----END PGP SIGNATURE-----

--xIiJoUdCJt2BFtVp7jPaeSc7msNOHx3TJ--
