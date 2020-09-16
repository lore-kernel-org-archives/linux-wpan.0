Return-Path: <SRS0=EzT3=CZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB9C43461
	for <linux-wpan@archiver.kernel.org>; Wed, 16 Sep 2020 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB91421941
	for <linux-wpan@archiver.kernel.org>; Wed, 16 Sep 2020 20:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgIPUjZ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:39:25 -0400
Received: from tuna.sandelman.ca ([209.87.249.19]:56968 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgIPRGs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 16 Sep 2020 13:06:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by tuna.sandelman.ca (Postfix) with ESMTP id 07E00389AD;
        Wed, 16 Sep 2020 12:45:17 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id iCG5Bn-goTgu; Wed, 16 Sep 2020 12:45:16 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
        by tuna.sandelman.ca (Postfix) with ESMTP id 2DE82389A9;
        Wed, 16 Sep 2020 12:45:16 -0400 (EDT)
Received: from localhost (localhost [IPv6:::1])
        by sandelman.ca (Postfix) with ESMTP id 07F2C670;
        Wed, 16 Sep 2020 13:06:33 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
To:     Achim Kraus <achimkraus@gmx.net>
cc:     Alexander Aring <alex.aring@gmail.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
In-Reply-To: <a9280f74-54f0-917f-22a7-8907afd33c95@gmx.net>
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net> <21010.1600201310@localhost> <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com> <a9280f74-54f0-917f-22a7-8907afd33c95@gmx.net>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Wed, 16 Sep 2020 13:06:33 -0400
Message-ID: <10921.1600275993@localhost>
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Achim Kraus <achimkraus@gmx.net> wrote:
    >>> for any BT device.  I would love to be wrong!!

    > Hi Michael,

    > The current Raspi OS (based on Debian, kernel 5.4) contains a
    > bluetooth_6lowpan module. With that it's possible to connect the
    > nrf52840 using a "plain raspi 3b+" (without extra rf module).

So, USB connection to this multi-radio device?

    > Unfortunately, nordic decided to provide precompile examples with the
    > old, deprecated address mapping and so I need to spend some time in
    > compile these examples before I can report, if it works at all, and the
    > experienced stability.

I am unclear what the split of effort between this mcu the kernel is.
I get the impression that we need to load firmware, and that it can in fact
run RIOTOS, etc. directly.

    > P.S.: though linux-wpan is not bluetooth, I hope the misuse of this list
    > is still OK ;-). But I guess, moving it to the right list will alos have
    > advantages. Does anyone know, which would be the proper list for that?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        |    IoT architect   [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAl9iRhgACgkQgItw+93Q
3WXG/gf/ZJVAQOESeT4SDzMxA9VULf6wsShDDDCVx9PIMfQMZ/t8ZzPv+P8MK+Ko
8cayRE1JscRy2qXYhub3fRasT0Y3O0NpyqdJvPSGBD9JG4o5CBmLHDwDYusATgkH
9d6Bm/Mcikv95HjzAt4vKakm2eFmxmLJTsLR3V4ltf6i9r4oIYNnXqz8+eUUG2Me
78NY6UHUqUq9L9yk8USf0botqpeLo7e5i99Z4v0+eeCAAj38OhBiiEA0cCWwOCwv
21cYrCbnUhz5RyRqUv1MT56gbUQEfGw34eyE9JGwyl+lJAPyHWOcZbeU+Zajn/Vj
AYPm01CvPqECowIfSEcTf1+e/QgDqA==
=Rf1f
-----END PGP SIGNATURE-----
--=-=-=--
