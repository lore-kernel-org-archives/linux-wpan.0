Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:33669 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbeFITEM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Jun 2018 15:04:12 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: netdevice notifier and device private data
In-Reply-To: <20180609152921.hqfmprmd4ryttaie@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t> <32763.1528486664@localhost> <20180609152921.hqfmprmd4ryttaie@x220t>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 09 Jun 2018 15:01:18 -0400
Message-ID: <29706.1528570878@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Alexander Aring <aring@mojatatu.com> wrote:
    > Futhermore user space programs e.g. radvd will do 6lowpan specific
    > handling on 6lowpan dev->type, it will not work either on tun
    > devices.

    > I know that wpantund from NestLabs do this switch, I am very
    > curious about the reason but I think they do it because the name
    > is 6LoWPAN. But wpantund is just a SLIP like protocol with
    > additional radio/foo commands.

How do they change it then, and what does it do?
It totally seems like broken behaviour.  Maybe it's not even intentional.
Maybe they are just foobar.

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

iQEVAwUBWxwj+4CLcPvd0N1lAQJmQgf+LLihApEWgVDEgGxycK4JTZbmURwi5Mpd
jo5mL5PozkXqY60jF3hGhHuMfygfqowNi7h1sqcXObtP4wFpzavdUW/VOImk2h7N
OWpptj3w8JoKqSaiEBcXbbfQPBzWQEpooKy2SmAqL+8H2NM6ZVtkWU7H/UpPUflZ
M6137b6agY9dpA3GN4BqgKtAZGsV3jSo+Jwv402tEB+zt5cEor3E08nv+GHomueW
6SoaH/BmaKx7EOnRaQQb53oYN0ZAOS9WGt66qiXmxzC/LEZvAFyCMDYRFdUt1ezB
XFPZoKSUks1nNlLvwyPdq70sM5bf3z+aPm+M68hc2hMu9v9j+VQCXw==
=JJPa
-----END PGP SIGNATURE-----
--=-=-=--
