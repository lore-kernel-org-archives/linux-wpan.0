Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from relay.cooperix.net ([176.58.120.209]:48536 "EHLO
        relay.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbdGKU3o (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Jul 2017 16:29:44 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Applications on wpan-linux
In-reply-to: <b3e88cdb-59f7-5915-6abe-36c5b6cfc8ef@osg.samsung.com>
References: <CAJuUDws4t0mSS4mONnXs=b9QLF28w9CTfQE-+2QKMnHg8_5HmA@mail.gmail.com> <b3e88cdb-59f7-5915-6abe-36c5b6cfc8ef@osg.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 11 Jul 2017 16:14:54 -0400
Message-ID: <28959.1499804094@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


{cleaning my inbox}

Stefan Schmidt <stefan@osg.samsung.com> wrote:
    > If I understand this correctly you want to send out beacons to announce
    > a 15.4 network and do basic PAN coordinator tasks like handing out
    > short addresses and keeping track of devices within the PAN. Is that
    > correct?

    > We do not have this functionality right now. All communication is
    > ad-hoc and based knowing network parameters like channel, etc.

I feel that perhaps linux-wpan@ is not a focused enough group to actually get
this work done.  Perhaps we simply lack a bit of common marketing?
Maybe a silly single page web site with the ubiquitous "fork me on github"
banner.  Maybe that already exists and is poorly marketed such that I don't
even know about it.

    > Various steps are needed to get to the functionality you are looking
    > for. 1) Add support for MAC command frames for network management, 2)
    > add support for beacon frames 3) expose a netlink UAPI to act as a PAN
    > coordinator and 4) a coordinator daemon in userspace.

At this point, I don't quite recall the summary of solutions that we came
home from NetDev with.  I meant to watch the video to learn what we said :-)

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZZTG+AAoJEJVM4Vb9/EKQkMoIAIXIVfUhod8NWe1x28XOvfNG
rm3YDuvFAIr72nmojorEZQ8Cl0tHb4KH7LqB/lvGR5YQrZfoBq2He2Lth46mwAdI
GhrxygSTG60bs9iIsDPot2lXHbObsgQItOE19fwnZrKqPzj7mkFg9JzlcQyVZ86Y
+sMDg04ANsQZfxaPfJWiNMvrSlrq73Ap+3CBcfxPTws16oi7dofWmssAxdHhg96q
qsFaXVqYaqdIIygPip578EdFTSfr7BBI+uFsUMVtjDQskWhlHrv53mZ4gxNUAory
ox5J88THy6hToOTpCkKEKuRL7fEX0P42n/iUHIlTKtUEV76t5Wi+VVTuOHt3L40=
=sZFP
-----END PGP SIGNATURE-----
--=-=-=--
