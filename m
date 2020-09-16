Return-Path: <SRS0=EzT3=CZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA3C43461
	for <linux-wpan@archiver.kernel.org>; Wed, 16 Sep 2020 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50342087D
	for <linux-wpan@archiver.kernel.org>; Wed, 16 Sep 2020 20:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIPUaS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:30:18 -0400
Received: from tuna.sandelman.ca ([209.87.249.19]:57001 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgIPRM6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 16 Sep 2020 13:12:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by tuna.sandelman.ca (Postfix) with ESMTP id A8A17389A3;
        Wed, 16 Sep 2020 12:40:26 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GH2bhUiVa1Ro; Wed, 16 Sep 2020 12:40:25 -0400 (EDT)
Received: from sandelman.ca (unknown [IPv6:2607:f0b0:f:2:103c:9eff:fecb:2eac])
        by tuna.sandelman.ca (Postfix) with ESMTP id 762F238997;
        Wed, 16 Sep 2020 12:40:25 -0400 (EDT)
Received: from localhost (localhost [IPv6:::1])
        by sandelman.ca (Postfix) with ESMTP id 097EF670;
        Wed, 16 Sep 2020 13:01:42 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
To:     Alexander Aring <alex.aring@gmail.com>
cc:     Achim Kraus <achimkraus@gmx.net>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
In-Reply-To: <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com>
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net> <21010.1600201310@localhost> <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Wed, 16 Sep 2020 13:01:42 -0400
Message-ID: <9724.1600275702@localhost>
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <alex.aring@gmail.com> wrote:
    > I tried to use BT 6LoWPAN and experienced a lot of races there, sadly
    > nobody is fixing it. I sent a RFC some years ago to tackle these
    > issues, also that the link-layer address is reconstructed by L3
    > address and not by a ndisc lookup is very weird. I don't know if this
    > is fixed or not.  However it was nothing related to the new BT mesh
    > stuff.

    >> for any BT device.  I would love to be wrong!!
    >>
    >> Running BTLE mesh is something I'd really like to do.
    >> My guess is that one could probably prototype this in userspace on top of
    >> bluez, and then use Alex' 6lowpan tap interface.

    > I did not do the "6lowpan tap" interface, the bluetooth people did
    > that and I complained about it and I never would accept this upstream.

okay, what did you use to connect the OpenThread native-build processes together?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        |    IoT architect   [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAl9iRPUACgkQgItw+93Q
3WV5Bgf6A0d6LhwVeADlgVu1LS16pf6ihNPC0o9yzA4wCV4tobp0eWfHMjYaINJC
P8iNTy6YFFKz6Wp4CHoyxMIyxUmzkQ39sbtJyBOKR4U0NQHpWeEsTW4BY/x6e5/z
h6TVMG670slb5az1FtQLz7R2ZIK4KEHGu5BmAZYcWvCZFFLTABt0hnM5wdbrDfEb
1iIOloiKVKHD2bWw8fHbuh/LsYLWeYVaobhqLo3L1dp52cgdmBvJvJO3OCJ0Dl6K
cGEajdORR1VTkm8LnTO5LqEmXcvLlR63gzXuUjnHrigdejcByUyzWkfYjTGx4dxj
LOhN25llKILRuzi/cZv+JNKcHkZ7SA==
=xgyR
-----END PGP SIGNATURE-----
--=-=-=--
