Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from relay.cooperix.net ([176.58.120.209]:39592 "EHLO
        relay.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdGMIum (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Jul 2017 04:50:42 -0400
Received: from dooku.sandelman.ca (unknown [IPv6:2001:0:53aa:64c:cbb:57af:a607:73ec])
        by relay.sandelman.ca (Postfix) with ESMTPS id D579E1F906
        for <linux-wpan@vger.kernel.org>; Thu, 13 Jul 2017 08:50:35 +0000 (UTC)
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Applications on wpan-linux
In-reply-to: <20170712155110.itv5gqc4ohnh5lrz@omega>
References: <CAJuUDws4t0mSS4mONnXs=b9QLF28w9CTfQE-+2QKMnHg8_5HmA@mail.gmail.com> <b3e88cdb-59f7-5915-6abe-36c5b6cfc8ef@osg.samsung.com> <28959.1499804094@dooku.sandelman.ca> <20170712155110.itv5gqc4ohnh5lrz@omega>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 13 Jul 2017 10:50:23 +0200
Message-ID: <13647.1499935823@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Alexander Aring <alex.aring@gmail.com> wrote:
    > About marketing: I think we need to make some tutorial for RIOT/Conti=
ki
    > to build e.g. a broder router. All others IoT MCU OS's make their own
    > Border Router solution and feed their IPv6 Stack on $MCU_IOT_OS over
    > SLIP and they do marketing with that.

That's not what I mean by marketing.
Assume that we had some tutorial, where would people look for it?
How would it get updated?

Documentation/networking/6lowpan.txt points at no web site.
Documentation/networking//ieee802154.txt points at http://wpan.cakelab.org/
and https://github.com/linux-wpan/wpan-tools

I don't know Christian Fromme, is he still around? He seems to own cakelab.=
org.
I'm happy with github wiki documentation.

=2D-=20
]               Never tell me the odds!                 | ipv6 mesh network=
s [=20
]   Michael Richardson, Sandelman Software Works        | network architect=
  [=20
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails  =
  [=20
=09


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZZzRPAAoJEJVM4Vb9/EKQ0roIAKgJO2j9MnQHIEbh8SNY5ftg
v6xEROM5xX+P/lWh8mv6q3r/cZcVwlk0YBNnj3gt3ikG5QbxbYkJ3uOH2T6XB/yh
lmAnfIMvo9nKuYTzQ9OszhFaAKq/Zfo9AKNOpkcICvfco/tm9x7CwF4PyZmNZtl3
smVxswak1DqUJLY/iycO2Oa/PyLjAMLM95lQnHwvnAGLs4bheSZ2wO94/tevRwey
nREWoSx/9Oin+g11kBKpmwRTbhp8q6Nmika4HURC3n21w8vBiqszUTYJdtozxndz
VwaxoEBaEnyBWMHxx+J0d7nsI33vRMY6OntV1U3GRo+F3w0+iaEwroYdcontuFc=
=Zm7y
-----END PGP SIGNATURE-----
--=-=-=--
