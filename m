Return-Path: <SRS0=wjm+=CY=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88AC43461
	for <linux-wpan@archiver.kernel.org>; Tue, 15 Sep 2020 20:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA65207DE
	for <linux-wpan@archiver.kernel.org>; Tue, 15 Sep 2020 20:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIOUeu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:34:50 -0400
Received: from tuna.sandelman.ca ([209.87.249.19]:50184 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgIOUco (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 15 Sep 2020 16:32:44 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2020 16:32:44 EDT
Received: from localhost (localhost [127.0.0.1])
        by tuna.sandelman.ca (Postfix) with ESMTP id A601B389A1;
        Tue, 15 Sep 2020 16:00:44 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id S-1B1MatKcJ7; Tue, 15 Sep 2020 16:00:34 -0400 (EDT)
Received: from sandelman.ca (unknown [IPv6:2607:f0b0:f:2:103c:9eff:fecb:2eac])
        by tuna.sandelman.ca (Postfix) with ESMTP id 1E1703899E;
        Tue, 15 Sep 2020 16:00:34 -0400 (EDT)
Received: from localhost (localhost [IPv6:::1])
        by sandelman.ca (Postfix) with ESMTP id 3094150C;
        Tue, 15 Sep 2020 16:21:50 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
To:     Achim Kraus <achimkraus@gmx.net>, linux-wpan@vger.kernel.org
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
In-Reply-To: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net>
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Tue, 15 Sep 2020 16:21:50 -0400
Message-ID: <21010.1600201310@localhost>
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Achim Kraus <achimkraus@gmx.net> wrote:
    > it seems to be possible for the hardware, but I could not find hints,
    > that it is working with the software. According

    > https://linux-wpan.org/hardware

    > it's not listed, but the nrf52840 is also not listed (but working with
    > the openthread setup from nordic).

    > So:
    > Does someone have tried to use a Raspberry PI 3B+ native CYW43455 for
    > 6lowpan?

I don't think anyone has done RFC7668
  _IPv6 over BLUETOOTH(R) Low Energy_

for any BT device.  I would love to be wrong!!

Running BTLE mesh is something I'd really like to do.
My guess is that one could probably prototype this in userspace on top of
bluez, and then use Alex' 6lowpan tap interface.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        |    IoT architect   [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAl9hIl0ACgkQgItw+93Q
3WUrRgf/dJyF4RuEHQahJ2bPVY1D0zwY2X0V96sNu4K5WtPxvkY/SDq32RPNdoAs
XKDZcr/NQf5RoYg/sHHhe87z0Ib8rXxDGUn6GZqEmSa3crgIKkvcyTMoMEYelwcs
HfbsZaAUMVtyh+ao2ODMg8NjMucTyTXrILBXSMCtpYkfH4v+Grs6VlvoeI2tEF5W
nYbbmh1vDURUfOuszezmwXnnU4rxG7RMFS2697kyGAwFgoL+pTSy8HYiItFeC+/6
581muIvcrJqi+MR4mEmwNLHeTTo0He4j2l3HZf6qbI6PGvGvHGH9ebOk/8s35off
MSUKeNLu7JrBKuF/YF0b6g6NF1aZiA==
=1Dv3
-----END PGP SIGNATURE-----
--=-=-=--
