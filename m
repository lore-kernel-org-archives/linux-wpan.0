Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:41657 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752601AbdAZOcS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Jan 2017 09:32:18 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: how to communicate with contiki node, from raspberry pi with at86rf233 module
In-Reply-To: <CAAK7Ti8d-1xHNg8T4P_AYCnUxp_akk4ge24tdqJoLMx-GxWrvw@mail.gmail.com>
References: <CAAK7Ti8d-1xHNg8T4P_AYCnUxp_akk4ge24tdqJoLMx-GxWrvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 26 Jan 2017 09:26:30 -0500
Message-ID: <23132.1485440790@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


JANARDHANACHARI KELLA <eni.chari@gmail.com> wrote:
    > i have attached at86rf233 module to Raspberry pi. device is able to
    > send radio packet data out. i am able to sniff from outside. any one
    > please guide me, to initiate communication between contiki node and
    > raspberry pi.

Assuming that you have two contiki devices that can talk to each other so
that we aren't debugging the contiki side of things:
  Have you checked that you have the right PANIDs, and frequency choices?

You also need to tell us something about the kernels involved, the version
of wpan-tools you are using, how you are sniffing, and how you are generating
traffic.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAliKBxYACgkQgItw+93Q
3WWTaAf9EFm1QDJhWKe/qcJnaAmLcbq/CiKoohLpGNevfx1vYfnNfuIvOK5tDfd8
PDShuosYNbpzemnU1UoAyotH0Krxg9szIFQm3W67lzpad8xF1lduo7qzzpCl2XgX
y5oK8020eTPBJ3OUp/Btoi8uElDmdVlRysyEtXTI6nxE5hZfy538KAzng3kkXbdH
NeqaKiw8YazjDZ0N/WOrPX4wxF7uA81OfWrGedyRixfwCc5r+ycsxnnHm5BYSuqD
an+1ZT6EgPoNipTyCkNklP0Bgk29LpD7e7m6xWwWJAashZzAbTMY4/iKBe+HYSlX
LhXC2jeHhiXCoLrN1bgwAuJ34iFXOg==
=lXE0
-----END PGP SIGNATURE-----
--=-=-=--
