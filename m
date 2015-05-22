Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36901 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124AbbEVI7h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 04:59:37 -0400
Subject: Re: [PATCH bluetooth-next 4/4] mac802154: use atomic ops for sequence
 incrementation
references: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
 <1432285031-3360-5-git-send-email-alex.aring@gmail.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
message-id: <555EEFF1.90603@pengutronix.de>
Date: Fri, 22 May 2015 10:59:29 +0200
mime-version: 1.0
in-reply-to: <1432285031-3360-5-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Rc7wvkXxasK3JbHXt3gcCeD2qwmOIOdmE"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rc7wvkXxasK3JbHXt3gcCeD2qwmOIOdmE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2015 10:57 AM, Alexander Aring wrote:
> This patch will use atomic operations for sequence number incrementatio=
n
> while MAC header generation. Upper layers like af_802154 or 6LoWPAN
> could call this function in a parallel context while generating 802.15.=
4
> MAC header before queuing into wpan interfaces transmit queue.

what about swapping patch 3 and 4?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Rc7wvkXxasK3JbHXt3gcCeD2qwmOIOdmE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVXu/xAAoJEP5prqPJtc/HB9IIAKx24NoQYyF/ddCYEvbO1Yr9
J+f4z++CY3ReCwyG/hJ1Ku2u04FHZ+vlwZl3LJe1yoYxho1PTTxeFJ08/5aMiuSw
wG8pRQoHFEKaj283MeekI3Ma+SyZSOGlxZo8U2Rh0tHJGCsczqvD2HXILl6lJknq
2LJEdWm7yzOuYAlF+mWttQk1xtNBJ/qtzQRrbNPfk3BfnQAgS9mtQ6GT1n0tgB15
TE5sRr0gV5cLfYP0nKzjsyugtiQ8secLFCZ5Z/oxB4/77emKKfDnBKEA7/zGoGLb
JBQuxaeBLNcTSA0ZotWvz6J+/mP8vAMIntZ+a8QtIla0xh2gq5D0ZQYrvjcfprc=
=I9QT
-----END PGP SIGNATURE-----

--Rc7wvkXxasK3JbHXt3gcCeD2qwmOIOdmE--
