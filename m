Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:43025 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796AbcCDUaC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 15:30:02 -0500
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: big frame support in 802.15.4G
In-Reply-To: <20160304163749.GA21798@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 04 Mar 2016 15:30:00 -0500
Message-ID: <18168.1457123400@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 6lo@ietf.org
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Can 802.15.4g with 2048 byte frames exist in an LLN along with nodes using
802.15.4-2012 classic 127 byte frames?

There are three questions embedded here:
1) are there radios issues that would prevent this from ever being an issue?

2) assuming that 15.4g radios can communicate with 15.4 radios, is there
   something that would permit one 15.4g radio to realize it was talking
   to another 15.4g radio at the L2 (frame) level?

3) if the answer to #2 is no, then is this akin to ethernet with jumbo
   frames, where the MTU (and fraglettation method) to each destination needs
   to go into the neighbour cache?

RFC4681 section 4.6.4 specifies an MTU value for the network as a whole
        in the RA.  https://tools.ietf.org/html/rfc4861#section-4.6.4

I thought that I'd see an option to put the MTU into the NA as well, but
I don't see that specified, so how can jumbo ethernet work today?
(maybe that's why it isn't on by default more often...)

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVtnwRoCLcPvd0N1lAQJ5VQf8C0ptAfSZ0e2lCJRDkh11GZwTZaUS2ncr
TW5UFB8NoX2VCQUUbHVWMrzFsIFO+lBIQZ+PjyYRBPqZQp9O4cBVVa2VYxNNQbOV
ThVFdly3StfUpJgDv/0oXkhxnWehgpkWaIXGaElZbkvGp8efUkHmVSt5HrfThfrC
HcK04QoLKZortI5VHwvwzXhiJHuFWXFj2gBmSCrqCqZChbptMrdUc6GnxB5jY4Au
XtA9uxp+OLEV3aLgZJSEwOVHlK6hzPenYN8BHUCHdZd41JZcTJ98wAxaYDzlmjSH
TMh8tCtRcuBg+BJFyim/5Z1y8ICaEFVVyopuWoyiT1ZqDC/pr4t4Jw==
=JvYD
-----END PGP SIGNATURE-----
--=-=-=--
