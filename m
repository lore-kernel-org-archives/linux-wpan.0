Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59966 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbbCEJai (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Mar 2015 04:30:38 -0500
Message-ID: <54F82234.7060704@pengutronix.de>
Date: Thu, 05 Mar 2015 10:30:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [Linux-zigbee-devel] Can I get the patches for 3.10 kernel
References: <CALw2d_OcB4XQhxC5KsQY_BsuE85jb_+VrkiRRciCz3hunyXs1Q@mail.gmail.com>	<54F718AB.9020701@pengutronix.de>	<CAAkeqgWqiDO_7_vULKugtm1h20BykOZvqiUcbMMhYg7rWzremQ@mail.gmail.com> <CALw2d_Mveq3nKV4eOpkN90HJ3K1hMid3yTq8c++sKW8szzA_EA@mail.gmail.com>
In-Reply-To: <CALw2d_Mveq3nKV4eOpkN90HJ3K1hMid3yTq8c++sKW8szzA_EA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WxlMO1Lwmu7nh7Ag6homwi5kH8UOdjIXn"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujith H <hari.sujith@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: linux-wpan@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WxlMO1Lwmu7nh7Ag6homwi5kH8UOdjIXn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2015 10:19 AM, Sujith H wrote:
> The problem we have is, imx6q we use is based on 3.10.61 kernel. I had
> tested 3.19 kernel and where I got it working. Hence I thought of
> dropping a mail
> to the mailing list, thinking if I can get some help here. Moving to
> latest version would be impossible for us at this moment. Hence I was
> thinking if any patchset available to get it working on 3.10.

I don't think there's a ready to go patchset available, that ports the
latest and greatest features to such an old kernel. I think you have to
do it yourself or get some commercial support.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WxlMO1Lwmu7nh7Ag6homwi5kH8UOdjIXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU+CI4AAoJECte4hHFiupUxVUQAIp1r0HzWt/Jo706iW6H+jkB
k+9egMf7z68UjiO/H078ypfSAOQISbD0unyQ3xGGyIT03fswkn9mhHGqzyt19BWq
/UiA3sDbJuhT/qmky42+FvMZNckj00GXHbnONDn2tB0X1DMIhqugmxDSfV6oxFPU
PQV3DYu/y6u0l7krqTde4Anqu3X2WfKo54KrSp0V5kFTNbTOJrVmDUVjg6TVs7lN
Fn1rmvYB8WKlGPKywKLUzx1PgvZF6POp60qGxaw6THxbL+tEl6mKDU7Ch6SJsJQ6
J9dUvU96Q54lcijhek4HI9d/HEYyfav3TCvnnB2qPWhId61dcNsqC49W6I8ujHOs
nJ1GY0h3Q5hCMyfwHQ0hD/HCkTJ6FrDj4Rkj15ROsswtR+a2yHbeY++tEC22HO7s
EdBH+8oAgSY7i6Xaos+g4rmpUSLPZ8wE8Lo411r+GHv6Mwwy7a8QP4yAqXUmGuRQ
s3GR1AydPm+snp1NfZg32mfvXHme3pFVzWZHggobjX21QLJhZWuQLSk2d6VnWNTQ
cLMkHWzIEF+Xs+QOWhAA7gSYX3meEZ8uMZUTizcrgA5XpWbUbxqM3FHVP284p6c7
XjNI3CHgq4j8RFlbxzeSMa11E2J0NEEeX2icLyUIZzL1fgyqAlDAOD5SIwTWVVpx
9+Dim6w8VkH/aKuo+VY4
=RsWi
-----END PGP SIGNATURE-----

--WxlMO1Lwmu7nh7Ag6homwi5kH8UOdjIXn--
