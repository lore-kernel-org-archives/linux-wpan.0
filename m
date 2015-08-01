Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:59963 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbbHAH3J (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Aug 2015 03:29:09 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: iphc, rfc6553/6554 and 6lo ESC discussion
In-Reply-To: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 31 Jul 2015 20:45:31 -0400
Message-ID: <6541.1438389931@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


{trimmed CC list}

Alexander Aring <alex.aring@gmail.com> wrote:
    > check the LL type which can be currently BTLE or IEEE802154. This could
    > be useful to make different handling in iphc compress/decompress and
    > evaluating LL private data of skb control block "skb->cb".

Speaking of iphc compression,  the IETF 6lo WG is currently looking at ways
to expand the available HC and NHC space.  This is mostly so that the ROLL WG
(which I co-chair) can then define a way to compress the RH3 and RPI headers
(and the IPIP header required to insert those).

It would be great to have more people writing code in this discussion.
If you need more pointers to the discussion, or even if you want to have a
G+/Jitsi/etc. meeting to understand the *why* of the discussion, let me know.

    >    The handling is currently for 802.15.4 is in generic 6lowpan code
    > currently not quite. This should be handled by private data. At the
    > moment btle use the same handling like for 802.15.4 extended
    > address. Nevertheless is we can cleanup some handling then in generic
    > iphc functionality.

Something to think about is there are networks which are not 15.4...
Including NFC, DECT/ULE, BACnet, and G.9959 (which uses 8-bit
short-addresses).

My gut is that DECT/ULE is going to take over :-)

    >  - In Lukasz Duda RFC for introducing stateful address compression, I
    > saw some behaviour which such functionality is also useful. Currently
    > we don't have a allocated space for a 6LoWPAN generic space which is
    > assigned to a lowpan interface. When LL layers (BTLE, IEEE802154) calls
    > iphc compress/decompress Lukasz had no change to access some room which
    > is needed for storing the context information into a table. The
    > workaround for this feature was to add allocate a static data room for
    > the table and doing a lookup/match of netdev name. Which a generic
    > 6lowpan private data room per each lowpan interface we can put this
    > table according to the netdev private room, which means in short: no
    > lookup is needed anymore, just dereferencing lowpan_priv.

yeah!


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEVAwUBVbwWqICLcPvd0N1lAQK3Ngf/dcR2oiOwbUCli1e6sn2XLWcWo0NNsTFe
yXCXi9R8MRxP1VFacJXfkLZSjbXCr6KvXV3b6FtAzpIaO99nccTLWyq072GAVHIQ
uSDlfsAGSq4DNlRwtrMo1lPuiFv2HZOdaXmSIUgzH8ejO+M1mU7cjshUIMaLkAgQ
RUlKvzhEMjBF2xG7+wuMPD52UsCCgMNxwUqbtch9LWLt/mBgQUoWnQ9hoSy9MJ20
pRjF8hnqlemKOid9ujsChEMrCkie3vo8Lreeh0p/lmy9IWJc6pGlyIo+JgmLJFaV
keIl96TVAx8oWfMKDRxNSsR6IWXscRApRMl7bm00AgTVdNSwBHwCBQ==
=6tX8
-----END PGP SIGNATURE-----
--=-=-=--
