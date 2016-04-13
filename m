Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:40324 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760449AbcDMMu0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Apr 2016 08:50:26 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: UDP stress-testing
In-Reply-To: <20160413082852.GA2428@omega>
References: <5706C0D7.1040000@haw-hamburg.de> <20160407204125.GA4736@omega> <57075C35.5070206@haw-hamburg.de> <11304.1460505658@obiwan.sandelman.ca> <20160413082852.GA2428@omega>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 13 Apr 2016 08:50:22 -0400
Message-ID: <16058.1460551822@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Peter Kietzmann <peter.kietzmann@haw-hamburg.de>

--=-=-=
Content-Type: text/plain


Alexander Aring <alex.aring@gmail.com> wrote:
    > _All_ current supported transceivers have on hardware side _one_
    > framebuffer only.

    > I would agree 3-4 frames should keep the transmitter buffer, because
    > only one framebuffer, 250kBit (even slower on sub 1-GHz) and holding
    > 3-4 skb's in background.

If we are counting frames rather than packets, then I agree that 3-4 is too
low; we should accomodate 2-3 full-sized IPv6 packets worth of fragments.
1280 / 88 = 14 * 3 = 42.
So I suggest somewhere between 32 and 48 as a good default.

Well, we really ought to use the BQL to get the right number!
        https://lwn.net/Articles/469652/

    > On most systems the qdisc default is pfifo (but I remember something
    > that systemd changed to fq_codel as default).

yes, fq_codel is often the default now.

    > This will getting the queue full and with payload of 352 bytes it makes
    > fragments invalid because pfifo will drop some which is part of the
    > whole fragment.

I had assumed that the fragmentation happened after the qdisc.

    > What I know is, when we drop one fragment, then we could drop every
    > fragment inside the queue which comes from the whole fragmented 6lowpan
    > packet. it seems this will not be handled currently.

This is very important, and why I had assumed that fragmentation was
afterwards.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVw5Ai4CLcPvd0N1lAQI8zwf+Pvn60HMF2mMHEuEcFZ3MQlUlbb9dAey3
rFz46H7Ku3LpFvKPeIzRz/vOBRN7R8Lb5kSHeDDXWtBGd+iCl341aWaKW5HbXElt
MO3LdQMZhbBQZMg+/GgNhFRIH69p2JqmnuJXjdIh91a0Hoi2JnnpbgTKSAo6PJLB
XMbbEP/vf+qwYCpcwSryZr4gd60ZRvBfGSYejbR/BK8ZsITKsOmsOnstlipbP/FR
XX6Kg/IhpK21Mirtu5HRUzDZIGG8vUMVuYtN8ccjecMyAsv9SYixBqTmCI8+DHzk
uuDo6mwEsE5P3E+9qZpWZIlgX1ATItYSHhOV9RBPYg2hjQoXTYEg4A==
=Kbn5
-----END PGP SIGNATURE-----
--=-=-=--
