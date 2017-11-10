Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:45572 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbdKJRwC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Nov 2017 12:52:02 -0500
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: Re: Bridging a lowpan interface
In-Reply-To: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no>
References: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 10 Nov 2017 12:46:12 -0500
Message-ID: <730.1510335972@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Palma <david.palma@ntnu.no>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

--=-=-=
Content-Type: text/plain


David Palma <david.palma@ntnu.no> wrote:
    > After shamefully trying it, I suppose it's not possible to add a lowpan
    > interface to a bridge because it's not an ethernet segment.

    > However, I was wondering if this could/will be a possibility in the
    > future?

No, because 802.15.4 uses 8-byte EUI64 addresses, or 2-byte short addresses.

    > If I understood correctly there was a discussion about the tun/tap
    > driver that touched upon similar aspects, but I didn't get the
    > conclusion.

    > The motivation for this question is to enable offloading/traffic
    > redirection between 15.4 and .11 depending on certain conditions
    > (e.g. energy and distance). I have accomplished this with changing
    > routes and iptables but I was looking for an "SDN/OpenFlow-like"
    > approach.

Stupid Layer-2 tricks are a bad idea here.
Use smart layer-3 techniques instead: routing.

Assuming that both of your devices have 15.4 and .11 interfaces, then put
them into seperate subnets, and then distribute /128 addresses to your end
systems, and use a dynamic routing protocol to announce things.

Choices would include: RPL (see my unstrung.sandelman.ca, and others),
BABEL, OSPFv3.

Before you complain about overhead of that, you need to go read the source
code for the bridging code that includes {R,M,}STP.

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAloF5eQACgkQgItw+93Q
3WXevAf/XIqc1lCuV0K5coRv2R6+/3c2J56uThtBiEpsjUTY9JGfQIOYrY2mxZPL
bvzKJcoc0CmHfJ4INeYyN9RTzZty4heAuPo+XaP8nF64b/kQrV1JJJ5MZvYA3Khc
vP1QARyc5pDyOfVlNEFzjAhI7pCdWhX6iu5QAeZgP/u7Yw6Tz1uPK/LoHAjKBDwN
U3WFDSvxrFNctfV27X+dvGDA5x4g2iSyrH1rfUt3jMdb0baDXduoOiALqgcgPbCE
xitC48+0GoLul/HnzlLOhI5Q81NEvKIDt0ToFFOp9poNymXg2/FU05zf3Ve6jU3M
6iAni1kIfHrHX57rUqgk1iVr1IGHuA==
=rs4C
-----END PGP SIGNATURE-----
--=-=-=--
