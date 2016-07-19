Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:53914 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbcGSNIL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Jul 2016 09:08:11 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan implementation
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 19 Jul 2016 08:58:40 -0400
Message-ID: <30038.1468933120@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com

--=-=-=
Content-Type: text/plain


Alexander Aring <aar@pengutronix.de> wrote:
    > The issue is "tx credits in L2CAP (bluetooth experts know what I mean
    > here) will be reach to zero at the same time on both nodes. This occurs
    > a deadlock
    > and nobody will transmit anything anymore".

What puts more credits in the bucket?
Wouldn't it be a successful TX event?


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBV44j/YCLcPvd0N1lAQLmcQf9EOHQe309I+CsDQtD/UtMUpSIuhNjhwhc
uUTsJozfQUzHErLw7lJnvyCimVhkK78krqfFkDkU76euPIcVRvAI2aWU9MEuqA39
91F6yUp3e1+tBaPB98trwTLCnUIvSftFEQXQr3wvrIW3130QZBk6PEWZ6lWCdGNv
hNNYO+fP0yZmepzlTVHe+MQYnyFOZDyfmanU4bD5tcw77onswITvJMh7kd62dCsQ
9V1cGCYEvGUbPUgHD5ffyEvsxNigaxlZET+4I/qFJpFn6c+TZTVYr5gu1qpadCsE
jwDT8eKDhhdR/KDGgiQHu3prV5/dGFDJSdOEOMxM3Vuf/4hgZmhTyw==
=Kwmx
-----END PGP SIGNATURE-----
--=-=-=--
