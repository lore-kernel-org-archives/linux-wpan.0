Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49765 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbbCBOQ7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 09:16:59 -0500
Message-ID: <54F470D2.30703@pengutronix.de>
Date: Mon, 02 Mar 2015 15:16:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 1/3] ieee802154: 6lowpan: fix
 ARPHRD to ARPHRD_6LOWPAN
References: <1425305405-30706-1-git-send-email-alex.aring@gmail.com> <1425305405-30706-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425305405-30706-2-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7bti9PXidRk79lfAx9dfevt07caAdDIdH"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7bti9PXidRk79lfAx9dfevt07caAdDIdH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2015 03:10 PM, Alexander Aring wrote:
> Currently there exists two interface types with ARPHRD_IEEE802154. Thes=
e
> are the 802.15.4 interfaces and 802.15.4 6LoWPAN interfaces. This is
> more a bug because some userspace applications checks on this value lik=
e
> wireshark. This occurs that wireshark will always try to parse a lowpan=

> interface as 802.15.4 frames. With ARPHRD_6LOWPAN wireshark will parse
> it as IPv6 frames which is correct.
>=20
> Much applications checks on this value to readout the EUI64 mac address=

> which should be the same for ARPHRD_6LOWPAN. BTLE 6LoWPAN and ieee80215=
4
> 6LoWPAN will share now the same ARPHRD.

Does this have effects on libpcap/tcpdump and/or wireshark?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7bti9PXidRk79lfAx9dfevt07caAdDIdH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9HDYAAoJECte4hHFiupU2f4QAIPqcZvK5ZqQsfvCCO47i/Oh
qmGG1l13dtnhVFtX5UOAJ5vlhNU7+k9jU7yEN4++lDOpj1P1uLx1tTuT8HoKbQ1Y
h55IfxLKtIoZsqf9YnEQZInph3GpV8zYGyzJjkd0pHX/heXxQM1R6Ny6agZbmKoy
VYCDrYAPICzb+UXaxZC4eU5glv8Gd8UjvrOTyWc7UHO1ACoo3AEn1f1pbdY/FRw0
61c/kjVPlUq9vc6dO4/M4RAsU/cjxYMsp//rCu07puOPR4q+umdVAy1l1tWB/nmi
alZYr8MgzLrBaG71ZJQ/6kwaiyTmUbR6fR3x7Xl0cpBT6z4g6pzYLSYuNxDkKeUJ
Qld9zBuYz9LWAGCi4nzYDbh/swAs8tUOH8oR1F/5mV5sKmkquwbSt0Mqc17eeVsc
uVjCluTAFSU8VfRg5VjTtmC08TVh38jGqDgt9zZfNgTjHqfqFGYavCpputUFk1Te
Fn9/dXxmuBD9Jf2QNOdr83ocvGPEES5lIndduKfLkUD6MrnVEV7rfWg67UnftMpZ
Zph5ZF2QMSR4FtIkLDuLPAcAhy5LgJ4xKVxEvoBDYFI5NMp5rvCJE2T4BVLnwRM0
uK22XCs/Y/HP+QDLpau3pZVdjWGZirtrnHlM10ps74yvwowxMStTWELqjRuGR2nR
JHUKwQw2sCHpdvaQWVWG
=7aCD
-----END PGP SIGNATURE-----

--7bti9PXidRk79lfAx9dfevt07caAdDIdH--
