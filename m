Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:40023 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbcDTUPh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Apr 2016 16:15:37 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: drop all fragments inside tx queue if one gets dropped
In-Reply-To: <57175156.3050501@pengutronix.de>
References: <57175156.3050501@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 20 Apr 2016 16:15:34 -0400
Message-ID: <11312.1461183334@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

--=-=-=
Content-Type: text/plain


{adding some more comments from the -wpan side of things}

Alexander Aring <aar@pengutronix.de> wrote:
    > On linux-wpan we had a discussion about setting the right tx_queue_len
    > and came to some issues in 802.15.4 6LoWPAN networks.

...

    > And then a lot of fragments laying inside the tx_queue and waits to
    > transfer to the transceiver which has only one framebuffer to transmit
    > one frame and waits for tx completion to transfer the next one.

    > My question is, if qdisc drops some fragment because the queue is full
    > or something else. Exists there some way to remove all fragments inside
    > the queue? If one fragment will be dropped and all related are still
    > inside the queue then we send mostly garbage.

The big concern is that if we make tx_queue_len too big, we are effectively
introducing bloat.
If we make it too small, then we might drop one fragment, when we would
prefer to drop the entire packet.

It seems that maybe we ought to have a queue in the upper interface and fill
the lower interface with at most two packets' worth of fragments.

    > I want to add a behaviour which drops all related fragments for 6LoWPAN
    > fragmentation at first, if the payload is above 1280 bytes, then we
    > have also IPv6 fragmentation on it. In future I also like to remove all
    > related 6LoWPAN fragments which are related according to the IPv6
    > fragment.

It would still be useful to be able to do this in general: this kind of
operation would also benefit sending large UDP packets over ethernet when we
have to do IP-layer fragmentation.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVxfjY4CLcPvd0N1lAQI4ewf8Cf5n7qO92Ekov86G1b+Jb+GbnhJ20wC+
ZKwWcYQr7UlEKZ7JP8tL0cf5GTDHnyjD5yBk1xcLOCTo9Zd9/G7dWZfJwFopOhQj
jsWXhZ4E/vEH/b5uohQeBu3mrM/FIpi+J/mAnmNryEaL97ezfrJHAp2jx1pP9kHj
fBFwp7Q/1WUoV3vQcZvQPaoUK5CSEclI78FENN3w4VYJIcwmOkhmHz0yc164VK3F
1oOhYfNF0EQGL+ld06dRmcaiM4pikn/Jb8sOvBMz1Dt+e/71Lfz7eWgoq6GllrC5
rEYiMojTWIAdG1mIsEro6AW1dwqudeC+cpU+G6JWkOfClPSOq7Nn/g==
=vcF/
-----END PGP SIGNATURE-----
--=-=-=--
