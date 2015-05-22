Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38444 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbbEVKe2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 06:34:28 -0400
Subject: Re: [PATCH bluetooth-next 4/4] mac802154: use atomic ops for sequence
 incrementation
references: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
 <1432285031-3360-5-git-send-email-alex.aring@gmail.com>
 <555EEFF1.90603@pengutronix.de> <555F0560.8060805@osg.samsung.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
message-id: <555F062B.3010107@pengutronix.de>
Date: Fri, 22 May 2015 12:34:19 +0200
mime-version: 1.0
in-reply-to: <555F0560.8060805@osg.samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3AJWCmwbtuSsxxdcLPkacIl6wNFAsPOmg"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3AJWCmwbtuSsxxdcLPkacIl6wNFAsPOmg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2015 12:30 PM, Stefan Schmidt wrote:
> Hello.
>=20
> On 22/05/15 10:59, Marc Kleine-Budde wrote:
>> On 05/22/2015 10:57 AM, Alexander Aring wrote:
>>> This patch will use atomic operations for sequence number incrementat=
ion
>>> while MAC header generation. Upper layers like af_802154 or 6LoWPAN
>>> could call this function in a parallel context while generating 802.1=
5.4
>>> MAC header before queuing into wpan interfaces transmit queue.
>> what about swapping patch 3 and 4?
>=20
> To avoid having problems during a git bisect later one? E.g. having the=
=20
> lock removed but no atomic in place?

Yes, that's what I was thinking about. I don't know the code to tell if
this is an issue here.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3AJWCmwbtuSsxxdcLPkacIl6wNFAsPOmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVXwYrAAoJEP5prqPJtc/HK6AH/i0Py0/3lCJpYwQ6k5b7wLTn
TgFZOH1klC7iFXFYKm6ugMbl73KDcyR0aHkdvnT6htvNhyJolVJvmM6zTu1IGss2
4LJcAxRtZ3Q2UAdHamsrjgDGNF4CESWJgpI8tfPVnBhnHu9MLWGeun2Utok21J15
IdGnxRdK8+anHFh0hKYvGYS81tf49M1iF6aaMKwMo2hyTp6nNnqiEG0nPLEwgJfK
uuhY8VdmK3L8KrqROAzrSL03pNMFOYchvN4AuRNvKYTmCOaHNqQ5bblnLUhpRtWX
ptxS/a5jbxDI0Ki+Lz8PJ/VnnwBAgPXR0ZT76fduUrt5wk7RmW4p4VLmB8crWD8=
=lRr3
-----END PGP SIGNATURE-----

--3AJWCmwbtuSsxxdcLPkacIl6wNFAsPOmg--
