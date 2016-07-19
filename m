Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:35336 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbcGSNTt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Jul 2016 09:19:49 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [RFC bluetooth-next 01/20] 6lowpan: ndisc: don't remove short address
In-Reply-To: <20160711195044.25343-2-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-2-aar@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 19 Jul 2016 09:19:47 -0400
Message-ID: <1996.1468934387@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


{cutting many from the CC}
I realized while reading your patches that I don't think we have a way for an
application to tell if a packet (such as an ICMPv6 packet received on a raw
IP socket) arrives with a 2-byte or 8-byte address, or for an application to
ask for 8-byte address, despite there being a 2-byte address available.

Do you think we could do this via neighbour caches for directly connected
nodes?  For not directly connected nodes part of an RPL mesh, the RPL daemon
would install routes using the router's 2-byte address if it can anyway.

This will matter for handling of ND, in particular the DAR/DAC processing.

I also wonder: if we configure an IPv6 address via SLAAC with our 8-byte
EUI64, and we configure another v6 address via SLAAC with our 2-byte address,
if we should:
   a) always use the 2-byte layer-2 when there is a matching 2-byte v6
      address in the source.  and vv for 8-byte EUI64s
   b) preference the 2-byte layer-3 address so that it is chosen by
      source address selection.

I think that the above probably gets us all the mechanisms we need for
transmit.   For receive, I think that we have no APIs that will give you the
layer-2 address for an incoming packet the way that IPV6_RECVPKTINFO will
do for layer-3 addresses and extensions.   It would be nice to have such
an API.

What do others think?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBV44o8ICLcPvd0N1lAQLrUQf+KVaEf2Ml7FR3bcrrEbprcms3S573U/4q
BOc6njg9n6Qu9fno8X9LDfi5iljK8JBVz9vsPDdopWOIo11Fb7N+/vkSlGaZK6jb
QCJ/7Y/o40PbC2Rg4FQJLx/75zo2oJgUjjd57OAm7AM3f9mhd1HhHS4dc88Qhm2j
ESPFZiuZko1Bd/4lUImjx+zYCWof2be8Fzm6/Fw0ybbofTHXiRrabR/dRVCewF2D
DMbPv6oJzwUFQ0RMbl4b0wKKbWup8gYcQsmT7YOdC9wsn5Q4/qkcYFStOcg9IcWI
khXIMj1hBSCTwMIm5CswOpDgKCrWg/BEATXm/scAktOZMQx6IYjuRw==
=vyBq
-----END PGP SIGNATURE-----
--=-=-=--
