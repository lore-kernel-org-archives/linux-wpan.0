Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:55049 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbcCGQZR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Mar 2016 11:25:17 -0500
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: Re: [6lo] big frame support in 802.15.4G
In-Reply-To: <56DC2A0A.6070906@htt-consult.com>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega> <18168.1457123400@obiwan.sandelman.ca> <56DC2A0A.6070906@htt-consult.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 07 Mar 2016 11:25:13 -0500
Message-ID: <4538.1457367913@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Robert Moskowitz <rgm-ietf@htt-consult.com>
Cc: 6lo@ietf.org, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Robert Moskowitz <rgm-ietf@htt-consult.com> wrote:
    > The difference is in the header bits. A 802.15.4-2011 device would see
    > the bits set in the header that 4g uses and drop the packet
    > immediately. Pat would have to pipe in here, and there may be some
    > issues around super frames and intergap timings that result in
    > interesting behaviour, better to be avoided.

Right, but the question is:

1) is it physically possible for a 15.4g device to send both 15.4g
   frames and 15.4-2011 frames?
   Another email suggests that this can never happen because frequencies
   are never the same.  If so, end of problem.

2) if the answer to question 1 is yes, then 15.4g devices need to know
   if they are speaking to 15.4-2011 devices, and
      a) adjust their frame header bits appropriately.
      b) to 6lowpan fraglettation.


--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVt2rZoCLcPvd0N1lAQJ9ygf/Z8BkiLXyMoqNIrW43YiNjjAjaVA94ZnE
+jdgJz1FhoWaWjyLXw64u7dAzjJ4nwaVQit/gJASTHrhcHQKsVQxmsZXyyVM1BzV
S1KY9nzQsNCjaWRX1OsYhTzOb+VykhcPobLLnzDKNnSEFnIiBTV2bsVCABTq0Pgi
E9qAOSTjdZiY6NbO3CAd/mFPkkTuiFa87M9KxKBNjh9p0beRx+ZIosGZ8u1XQvXP
XkhF97btVRQGHWGkFbsY3sRr0uI1ygsOswokJPWdXq7vTAy4jN4EFBtAC5QaRrXp
Ei6RjT2MNeJDDKUrEWSewkCSCKVg97rNj+peJK0M/uo8yxV8Kt+2Bg==
=8/La
-----END PGP SIGNATURE-----
--=-=-=--
