Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48577 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384AbbCDOhm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 09:37:42 -0500
Message-ID: <54F718AB.9020701@pengutronix.de>
Date: Wed, 04 Mar 2015 15:37:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [Linux-zigbee-devel] Can I get the patches for 3.10 kernel
References: <CALw2d_OcB4XQhxC5KsQY_BsuE85jb_+VrkiRRciCz3hunyXs1Q@mail.gmail.com>
In-Reply-To: <CALw2d_OcB4XQhxC5KsQY_BsuE85jb_+VrkiRRciCz3hunyXs1Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rlrJff69W2E0CKpu9hhilFl1L9LFDQlMn"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujith H <hari.sujith@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rlrJff69W2E0CKpu9hhilFl1L9LFDQlMn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2015 02:56 PM, Sujith H wrote:
> While reading through mailing list I found this link:
> http://sourceforge.net/p/linux-zigbee/mailman/message/31782189/

This mail is from 2013 :D and the mailing list ist deprecated, please
use linux-wpan@vger.kernel.org (Cc'ed).

> And there is a reference to
> https://github.com/linux-wpan/linux-wpan-next/commits/6lowpan_pending_p=
atches
> , which is missing when I searched.
>=20
> I am trying to get 6lowpan working for freescale's i.MX6 board. i.MX6
> sabre lite board I have uses 3.10.61 kernel. Is there any way to get
> those patches or is there any alternative which anyone can suggest, it
> would be a great help/relief for me.

Why are you using such an old kernel? v3.10 is almost two years old. And
imx6 is quite well supported on mainline nowadays.

802154 is a heavy moving target, and Alex is doing a great job of
bringing the subsysten into usable shape. I suggest to use the latest
and greatest kernel, even consider backports from the bluetooth next
repository.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rlrJff69W2E0CKpu9hhilFl1L9LFDQlMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9xiyAAoJECte4hHFiupUnTsQAKXInkMEw4MCBPMUGmCEMCk/
mBF1fLL5tmwEUB3WVmflTXtwTp45+uZHB7Ai+CzHDwKACu0N/n5sRAaP8b4Pujvy
56kGaia2gjOjnaOiTuIWYXhs+ILPlq9/JR5ouRWNE/2C2jw5tnW+5h9aNrp4Lr3Z
4lBCd7F6oayguvAcEPEQLonZScgrO5I4lIzhfZy6R8e5Vqa5hdKWmAed9Spmwrbh
SG+Yy7K1v0WIXUbu3gzf8AxwxreIr7OPahZ5EL1H5++jG2yn5eq9TOxPS8o0foVi
N/NiSJNn9AEJPt/nM2bVfSjR4CHbbc1juSv/7wM07q0msN8gMcV5u6tgtWAQCIT+
HfwNpcgriXYTyMnqZn2WB6VsBQRydZZigIIqDqbuN0Tn2EaNDd2WzgK9riVQK0tj
T/pwnMuwT0eqBgJKzkeCFv/yem1xhsOA8reQFxFdlEeDpQ61B4sKNY7n6sxM2eGr
r/TnEcjaTs3WRq6XAZBuIHEK/VCp5xdUW1CXBnxLOpZTEgxl4qC/XlcyubUzfM5w
i5P+Ob5cy/3t2H9vmaV7aRFyAQGdnzDOzyHSILvD48j25gMG81KzBL0sGYixw1Pf
F0sf3TLUnDeniZ4yXjtaqNkyo2IgPZrE/+sgj/ywGv3sskqAkhyNYeQ3i9npikZt
0X3XfI+aJK5VAAyHUDUG
=G3fu
-----END PGP SIGNATURE-----

--rlrJff69W2E0CKpu9hhilFl1L9LFDQlMn--
