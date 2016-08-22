Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:34434 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbcHVPlQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Aug 2016 11:41:16 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: at86rf233 in Raspberry Pi 3
In-Reply-To: <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net>
References: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com> <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 22 Aug 2016 11:30:34 -0400
Message-ID: <2270.1471879834@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: smlng <s@mlng.net>
Cc: Tao Liu <liu3tao@gmail.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


smlng <s@mlng.net> wrote:
    > the RIOT-OS Wiki-Guide is rather outdated on this, please have look at
    > [1] - this approach works for me and I heard from other, successfully
    > using that one too.

In my experience the most challenging part of this is getting the right
upstream RPI3 kernel things with and the right linux-bluetooth-next stuff.

On RPI2, everything is upstream, so the bt-next tree just works. That might
not be the case for RPI3... and I'd probably stick to 32-bit kernels/systems
for now, since I still see lots of 64-bit fixes going upstream.

I have two RPI2 unit working fine, but I traded my RPI3 for an RPI2, because
the serial console UART on the RPI3 is wonky. I believe that this is now fixed.


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBV7saloCLcPvd0N1lAQICBwf/WL3l7COwIbVl5D4fu5rVaJts5r8ajtvF
S2GnBIlngTgEA/SXrdV0u9/k/3XuWWHgfimQ5D0FLRc9noR4gmw5/r4wbNMuvoXu
ybnKWHPG8Lpfso8kfjRzUH/qu9uFZO/Pj8BMA020uW1q7QP+AiprTVfsVC8ZW7Zk
QkqHaBeYZqQVvMgprqVlzFO73iALKErm9H//hY47Hlrsxb8DkFjiuevSo570nqM6
QmvEiqdSz5U/fePwknPEKdnEVS4jtaY6wbOae+hI3Ju2yKXS4IElF97bJWK//gFK
WPnllIa8UDWWhZjCtCWFBwXXPy54Zba8EQSOpspdznxU9LE+RSvbRQ==
=HGlE
-----END PGP SIGNATURE-----
--=-=-=--
