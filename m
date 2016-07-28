Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:37649 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742AbcG1VT5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 Jul 2016 17:19:57 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Looking for boards with an 802.15.4 chip
In-Reply-To: <20160728174051.GB75405@redhat.com>
References: <20160728174051.GB75405@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 28 Jul 2016 17:19:54 -0400
Message-ID: <10331.1469740794@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: aar@pengutronix.de, linux-wpan@vger.kernel.org, linville@redhat.com

--=-=-=
Content-Type: text/plain


Don Zickus <dzickus@redhat.com> wrote:
    > I was wondering what boards/chips folks like yourself use to develop/test
    > the 802.15.4 work?  I noticed the website  http://wpan.cakelab.org/
    > mentions

It depends a lot on what you want to do, what pieces you want to hack on,
and what devices you want to interoperate with.

The at86rf233 is popular and easily obtainable and Alex is doing lots of work
to support it.  Get the openlabs device.  It seems that we might be able
to support 6tisch on this device if we try hard enough, but for the moment
you are restricted to 1 channel and aloha-only time slots.

Many people are using openmote's connected via USB or via daughter card
to an RPI.   The openmote does the 6tisch stuff, but "bridges" (but/wrong
term, but have yet to find a better one) the raw 6lowpan packets over USB
using a custom encapsulation.  (I'd like to change it to ppp actually)

    > I assume the SPI bus is easily found on a rPI-like board.  Is it
    > difficult to hook one of them up to an x86 desktop?

Yes, it's a bit painful since few desktops have easily accessible GPIO
pins that you can turn into a SPI bus.  You can add one with a FTDI USB
interface easily, but given the cost of an RPI... hard to argue.


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBV5p2+ICLcPvd0N1lAQLOcgf7BDKcwz2B1lkEgfbAmOLnIVrat28pSozW
xZGDN6KQj9K4axHfogsSXa3B8U/OM4v3zYCOuCGJsrZoCrUbM6gbkW1ekYoZZLlF
ZFAOPW76Vef1LWTmX6BG4b/d0HZtFDlNWJduspYK57Xcm96CmQmYj8dWZESjgTdO
fhEqw1Gsowtv7tCQhLQa8xNFDkKVdVBvFpFqshekyltiOK+n8kQF71P6s8PiPwAk
ho3BpCS6z0ygah/ynEKnqg6nvCm+xRKMsx4S7RwPWa11lQSlykj0GvP3i6l8DAQK
T63ebZYZKsZO3Rd69zTYyC+SUi5xT3hgmcAw+QxNw/LmMrCQUDXI5w==
=l33R
-----END PGP SIGNATURE-----
--=-=-=--
