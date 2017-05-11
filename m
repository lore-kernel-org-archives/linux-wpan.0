Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:37117 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbdEKM3g (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 11 May 2017 08:29:36 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: monitor interfaces and fcs
In-Reply-To: <20170505201000.hprmmtwsfi6jy7uf@omega>
References: <20170505201000.hprmmtwsfi6jy7uf@omega>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 11 May 2017 08:29:34 -0400
Message-ID: <20887.1494505774@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <alex.aring@gmail.com> wrote:
    > New behaviour?:

    > The new behaviour should also deal with hardware where we don't get FCS
    > information from hardware (cc2520 in non promicuousmode is such
    > hardware).

Nice.

    > Important node - you can change this behaviour for monitors:

    > Rx: while monitor interface generation you can decide if you want FCS

    > Tx: while monitor interface generation you can decide if you want to
    > send FCS

Do you return FCS as auxdata if asked for?

    > If the hardware doesn't support that - it will not allow you to generate
    > such interface.

Do you mean, if the hardware can't return FCS? Or insists on generating FCS
itself?

    > IMPORTANT NOTE:
    > This will of course break userspace software - fix should be simple, but
    > it's already broken somehow. E.g. tx with wireshark, it thinks there is
    > a FCS there, but there is no FCS...

    > We should fix all userspace software afterwards...

    > What we need is just some behaviour which everybody acks now and we
    > don't touch it again! Please comment this mail with your opinions about
    > default behaviours of FCS and different interface types (node vs
    > monitor) in combination with AF_PACKET RAW.

It is unfortunate, but I think that the number of people doing monitoring
on 15.4 is relatively small, and it's mostly with wireshark.
Is there a way to determine old behaviour vs new behaviour?


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAlkUWS4ACgkQgItw+93Q
3WW2Ewf+MiVnB0KB/iaVBce5LM59Qxozvuj2jqRc0GZ13VboTxfuBVj4aZfBWuM/
YYrVaS9iK/S+w1V0qm5NxlCz0RMp6Gq34UBpznemvhm5dGp09BuYYTIy/nYRYKog
/uS01VWqUDXycUNjIJF3pPcUW/mWgJn2DELThi/TyxScdqnSXotMCQn/OwzSP63d
jXO0ozIIIdr/0camIGK0JmFl/SUrmeXq3iLVp41HRxrYIvBtPNX7vIH2GTjfvnFb
ohoRHOf0f3PXG378/Zdc08fJYVAVSV2q7mzrpCCQFnDnXDTf56lwcDg87Ffo782Z
3LLF2LLDVA363r9Rv78WO09ukwQBgQ==
=3384
-----END PGP SIGNATURE-----
--=-=-=--
