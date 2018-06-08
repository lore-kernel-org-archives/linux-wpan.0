Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:56273 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFHTt3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Jun 2018 15:49:29 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: netdevice notifier and device private data
In-Reply-To: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
References: <20180608173455.vrnfvv7dlu4oxwqf@x220t>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 08 Jun 2018 15:37:44 -0400
Message-ID: <32763.1528486664@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Alexander Aring <aring@mojatatu.com> wrote:
    Alex> I already see code outside who changed tun netdevice to the
    Alex> ARPHRD_6LOWPAN type and I suppose they running into this
    Alex> issue.  (Btw: I don't know why somebody wants to changed that
    Alex> type to ARPHRD_6LOWPAN on tun).

so that they can have the kernel do 6lowpan processing, emitting 6lowPAN
packets into userspace to be transfered into a radio via some proprietary
interface (including, for instance SLIP over USB cable to Contiki or OpenWS=
N stack,=20
set up to act as radio only)

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

iQEVAwUBWxrbCICLcPvd0N1lAQKJJwf/Wk66HYbOQi3dDrwU/x2nDr9CA0lSyLRL
FLLulloFQ8kFHuT266D5HwktOCy2j8CdCspYH9k+KoRn5BnM+RoLHDQDDY+wwiZ4
vzOY+z1JAzPJVqBtsfAjtl8jFM9QlkpbxqQVRDw2r5hR0thV3RI4GGZ0zIvGWSIK
Oo1OOQmTcQLtH2UA1fQqTs/1g9ZNhBPCqmmVbPhUQSPwq9AtJSCuqJV8dw0oZpdq
Af9PSwj+fqHtLosajyhnfZxow8ZDCTdcAypsRvtl8jEcTMohYelpbaGb+Ezklwm1
5M3IVyJlki8g4WH0bLFGBzsreNLFVBLlr7iylhuqGcd4XuydP3zlBA==
=Xnnk
-----END PGP SIGNATURE-----
--=-=-=--
