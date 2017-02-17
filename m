Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:47718 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934283AbdBQQNH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Feb 2017 11:13:07 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
In-Reply-To: <7eae598a-c56e-2aac-c0f4-cef9b92dc23b@pengutronix.de>
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com> <28517.1487255767@obiwan.sandelman.ca> <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de> <32430.1487274266@obiwan.sandelman.ca> <7eae598a-c56e-2aac-c0f4-cef9b92dc23b@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 17 Feb 2017 11:12:53 -0500
Message-ID: <10193.1487347973@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <aar@pengutronix.de> wrote:
    > Yes, turn transceiver "quietly" (maybe some pr_info notice) into
    > promiscuous mode or (if supported) turn off address filtering only.
    > Needs some driver layer changed and subsystem changes to allow it.

    > And this all quietly, just make a pr_info notice for networking experts
    > why your interrupt load for the transceiver will be increased.

Yup. Clearly if you try to do things in software to compensate for lacks in
hardware, there is a cost.  That's fine as long as nobody is surprised.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAlinIQQACgkQgItw+93Q
3WVyVgf+I7S6HF5D4UrVahzEBxFk1E2NaRJJXLDXmFATzJ246mSyJURr6JwKZNN/
pSS+mjhWl0IUA9maO2Q2yxftAebGKatBWoPCrWJymnRMgb8j75wb2Z5qwQuXp4md
cgHmD346sYEguq3+WxDMEAwl/xOnCc6zjJiYInYftUWFaKpFcSfz5CnqK1pzzmRj
muYGbu3+Ip1RdMLpqjFNlTkMSe0757DBPL8HqY5ipux60k5hSF/KIFnYosKwOZmh
FiWvB2WVGLLMK9bNq+rylfh/VodRqbXsQgcNsnX4GVzXe4kaOzc+5sdXVKdp1iTw
AqTiNuiIi+WTCb9wBqa4x/57dUr1QQ==
=q94X
-----END PGP SIGNATURE-----
--=-=-=--
