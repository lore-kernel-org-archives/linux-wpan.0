Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from relay.cooperix.net ([176.58.120.209]:46122 "EHLO
        relay.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbdGNKV6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 14 Jul 2017 06:21:58 -0400
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: Re: handling multiple MAC instances (multiple address filters)
In-reply-to: <20170713144157.uz6euwxbkkn3zqf4@omega>
References: <20170712171051.z35bk6piiqtqypwm@omega> <8887.1499889601@dooku.sandelman.ca> <20170713144157.uz6euwxbkkn3zqf4@omega>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 14 Jul 2017 12:21:52 +0200
Message-ID: <28086.1500027712@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <alex.aring@gmail.com> wrote:
    > So this is for me "we can only have a non-changing _source_ PAN". But
    > you could run more than one 802.15.4 MAC instances on one 802.15.4 PHY.
    > Which allows to run multiple wpan interfaces with different source PANs.

I'm not parsing the difference.

    > In short: You cannot handle multiple pan support on the same interface,
    > you need create other interfaces to run on other pans then. Is that what
    > you are looking for? I know unstrung need to have support to deal with
    > multiple interfaces then...

What does "same interface" mean here?
Differrent hardware is needed, or just different lowpanX interfaces?

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZaJtAAAoJEJVM4Vb9/EKQFV8IAJpMAdkM/+gZAQ6G9nFD3wUJ
/r8mlMCYZ4dHnDtI7msYBymospqSYVVIB3cdaX4sPW765PSCzpa59LZE0KIZr//D
DJ/NMR5g0fJaRxqcMWFLjAraZAN/FrtdVcPeZCjwTcKwOeS2bmCcmFToo7s4GLc0
GNz5zSRU0SjpOi9os3Kcl5Sa03sYRlpMS6MGCc092m25LrJM64v7UHt7kmQu87nm
ubE0RKh+8SBdqZzwn7YqUzoScG/FYoIOHwKcHOkqMOs0JQiyMUwAM33WsnTi4xrx
R8pj/uEV5Nkf9l6ZFqzgsGlnq7TRVBKq1JKsFRap4gFjFbKSo6q/07zzvUjaP8w=
=0mi6
-----END PGP SIGNATURE-----
--=-=-=--
