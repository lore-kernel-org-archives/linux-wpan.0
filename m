Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:59964 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbbHAH3N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Aug 2015 03:29:13 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [PATCHv2 bluetooth-next 1/2] ieee802154: 6lowpan: remove multiple lowpan support
In-Reply-To: <1438341102-15878-2-git-send-email-alex.aring@gmail.com>
References: <1438341102-15878-1-git-send-email-alex.aring@gmail.com> <1438341102-15878-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 31 Jul 2015 20:34:57 -0400
Message-ID: <4122.1438389297@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

--=-=-=
Content-Type: text/plain


Alexander Aring <alex.aring@gmail.com> wrote:
    > We currently supports multiple lowpan interfaces per wpan interface. I
    > never saw any use case into such functionality. We drop this feature

I was confused at first, because I was sure that you didn't mean that we
would not have support for multiple radios.

What you are saying is that we won't have multiple lowpan adaption layers per
wpan interface?  That does not, I think mean that we can't respond to multiple
EUI-64 layer-2 addresses, but does it have any affect on ability to respond
to multiple 16-bit (short) addresses?




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEVAwUBVbwULYCLcPvd0N1lAQJKlQgAkqa9nB805xlZ65yKX4yXA8qn9bsdQttq
GIQ05yWG1rUHbFO46BNL14RF6KAdyyrkjKIHRx5CDLUUjYDvvZevnBxgU5cU5vm2
CWHzn4luOJnoTdVUMi7pNxDVDRtDOpEc/cQiWG2Efymp1yjG+KL4OMM3Ddp7Do1M
2aCRD+jDYcQwMjz5rdO5vlpAAJG+/c1wHUoIh7v0tEQrLwhNwo1SbfVrQCy9ImuM
PGDMkZIA+XHijtiMYtfrB3myWtTfl8kBXtvUxOhQaGzdvJU1myaT2wEetQKuy9ie
wtas87pq4GOa8idHGEhPk9dn1XX96Qt3Q7MKDKSKExul4u2pO9/MgQ==
=z+Sy
-----END PGP SIGNATURE-----
--=-=-=--
