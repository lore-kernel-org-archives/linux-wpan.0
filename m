Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52038 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFULCh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Jun 2019 07:02:37 -0400
Date: Fri, 21 Jun 2019 13:02:12 +0200
From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v2 12/28] drivers: Introduce class_find_device_by_name()
 helper
Message-ID: <20190621110212.GE24145@amd>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-13-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <1560534863-15115-13-git-send-email-suzuki.poulose@arm.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dan Murphy <dmurphy@ti.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-06-14 18:54:07, Suzuki K Poulose wrote:
> Add a new wrapper for class_find_device() to search for devices
> by name and convert the existing users to use the new helper.
>=20
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0MuTQACgkQMOfwapXb+vJ8WgCgnOZkd5moXKRPvuQkd1eU8H06
grYAn0ag+mNIvHHKvgTnU0Y6VSeNUVZt
=oxwG
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
