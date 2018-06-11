Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:41178 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753886AbeFKCMe (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 10 Jun 2018 22:12:34 -0400
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: Re: netdevice notifier and device private data
In-Reply-To: <20180610153956.mgzigzfne6shjb4s@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t> <32763.1528486664@localhost> <20180609152921.hqfmprmd4ryttaie@x220t> <29706.1528570878@localhost> <20180610153956.mgzigzfne6shjb4s@x220t>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 10 Jun 2018 22:09:39 -0400
Message-ID: <1326.1528682979@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Alexander Aring <aring@mojatatu.com> wrote:
    >> It totally seems like broken behaviour.  Maybe it's not even
    >> intentional.  Maybe they are just foobar.

    > They simple don't know what they doing... somebody thought 6LoWPAN ne=
ed
    > to be 6LoWPAN, but they actually don't use the 6LoWPAN handling inside
    > the kernel. _Except_ they doing out of tree stuff which I don't
    > believe.

So, it seems like this ioctl() should be disabled, or restricted to cases
that actually work.  hate to break their code, but if it's broken anyway, at
least the kernel won't crash under them.

    > According to [0] it also works with tun default (I suppsoe raw IPv6),
    > because ifdef. And they should not change it because they don't use
    > in-kernel 6LoWPAN functionality.

    > I really think that this tun/tap feature makes a lot of trouble for
    > some type changes. I probably introduce lowpan_dev pointer to netdevi=
ce
    > and then check if it's really a 6LoPWAN interface, a dev->type will n=
ot
    > garantuee anymore you have a 6LoWPAN interface. At least in user space
    > it's not possible to have a check if you really have a 6LoWPAN
    > interface.

    > - Alex

    > [0]
    > https://github.com/openthread/wpantund/blob/master/src/util/tunnel.c#=
L180
    > [1] https://github.com/reubenhwk/radvd/blob/master/device-linux.c#L75

=2D-=20
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -=3D IPv6 IoT consulting =3D-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBWx3Z4ICLcPvd0N1lAQIB3AgAj9QBPjOOiA5n84vdP47/8lxTsBkLTF8b
/bEdL5tJkeFDJqvc1OkK8ldt99LLFOMrITIrnOClmrKBtczN00WLVCrtX/v7juX6
dM1DT1G65eP/ecbJrBd2AY6CBc9RPqESz4xatOiSAZc2ez0wRuyTbcPQqkpoCBXo
cXl5PstkeX4W+VVIqCQuyj6derJx44iKckPMCvq2TytMywG9TT0dX5RLFci1jLvW
L0cN0lVu2XPcDAU4xsrLV9PdjsXd854sI3yZyV1JxPZzX+SjKy9wVeoGI22cFzzp
J45J/uwP+lixmSQojEiKFBKTJ+rSeKq2/ToG/qSaZ8VX/a+HqbpwEw==
=KeRd
-----END PGP SIGNATURE-----
--=-=-=--
