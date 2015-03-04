Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52587 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437AbbCDLbt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 06:31:49 -0500
Message-ID: <54F6ED17.8090805@pengutronix.de>
Date: Wed, 04 Mar 2015 12:31:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bluetooth-next 2/2] ieee802154: replace magic
 numbers by standard defines
References: <1425468290-24525-1-git-send-email-alex.aring@gmail.com> <1425468290-24525-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425468290-24525-3-git-send-email-alex.aring@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="k7Qbhc7VbShdL5RLNrtujcNbdOm87pTu6"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k7Qbhc7VbShdL5RLNrtujcNbdOm87pTu6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2015 12:24 PM, Alexander Aring wrote:
> This patch adds a define for the max sifs frame size value and frame ch=
eck
> sequence according to 802.15.4 standard.

and now squash 2 into 1 :) It make no sense to first add magic numbers
and then replace them.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--k7Qbhc7VbShdL5RLNrtujcNbdOm87pTu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9u0iAAoJECte4hHFiupUdNEP/0FayyvdEfXWkA29v4Y/tjcw
c6s5b3eyrK/hffvUdXX6UlvETWOpb9QZ66QUpUmtr3vO98YV8i4q5zIaYjXqTqxD
VIUYAVxanwqQGeas8zjPiQ6YfER2vBbW73IT4oSXCLvhs7S+gjQInrsIxUetn1EF
m1YbA7lIjboYpITIudqVJ0+yv8ZRvdezjbps7IJauGdzix95B/bp1A5sInzYIANp
ms9cXvySUjLKRlE9IX097rcNyutYKswhGkOoY80JBcto2kJxvmoj0CV/p8vcB8sd
enYRASCUL/S3cvbVqjqqlflY0mK6qnFE3+I5GX3a6jk9365DEnKluHPYaGcb/7Cf
pQyCIgjf0OTVcfKzxj0LHmAsvbYI/z8Azt2DFS40JCwS97Y1yVjCnVHMCQCncRWq
mzNaOWAG5Yuys6f+4sBcsSTCjkd8pb5a+Oj/WW+uIoCgK/tqydSzx+FlsJdob/8+
eAFv74aYcRg62YP+AmNu66i60d8MrkWtc4ajMkC9B6hAWXOy6ZNEglrYL9YkX+Hs
bQrPM8pfFdGiofZoxHIPs3/TBurXWbrevfHjRWVMd8YFCEYc2vkt+4BM83TW/dOj
e5T1GA2JM+5gXb2yrewsERk+9rxejyx2h8/XK0OlB9HMJg8qlYJjrH+DSMQqwwOH
hKRjswyZutSWCzJRsSUq
=KiJK
-----END PGP SIGNATURE-----

--k7Qbhc7VbShdL5RLNrtujcNbdOm87pTu6--
