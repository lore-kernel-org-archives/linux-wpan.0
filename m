Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:54034 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcGYN2P (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Jul 2016 09:28:15 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Packets not reaching lowpan interface
In-Reply-To: <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com> <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 25 Jul 2016 09:28:12 -0400
Message-ID: <25673.1469453292@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aaron Sowry <aeneby@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Aaron Sowry <aeneby@gmail.com> wrote:
    > 2) Created a lowpan interface:

    > # ip link set wpan0 down
    > # iwpan phy phy0 set channel 0 26
    > # iwpan dev wpan0 set pan_id 0x0023
    > # ip link set wpan0 up
    > # ip link set lowpan0 up

I think you got everything plumbed up correctly, but I wanted to post for
google benefit that by default the wpan0 and wpan1 that come up are virtual
interfaces, and wpan2 is the first real radio.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBV5YT6oCLcPvd0N1lAQIF4wf/WVDkLPXjvJ/HGpXWfk+Iqor8Q0QQLPhS
sVTSyjBhTA1JHmwLW3zt6Ks3z3v9sekbgsx4n5FDFpVexJCMdsvFgl2Yml7gEwGo
ifSk7C63xGLnWNQNH63htEBc70hbX2CeDxz32ac7AzVJxbcS5cQ8fREapHEcKH2O
g76ukh08ifuJfsgi4/uWXXD6EgEW6V6W/jfXXxRcLQdHIrJSNyfAbrZzGKQRuHux
4puf/Aeld0MVgVAWNqw5VxmwBfZkvMCkzFp1d/AAXZLTmbY0FazhqFnPyOdTPTdA
bfR+qj8+sM5tPW1QFSUYa6IqyJjYqBaJ+R4arcTDcWIJhX+CeiHY4g==
=Jgec
-----END PGP SIGNATURE-----
--=-=-=--
