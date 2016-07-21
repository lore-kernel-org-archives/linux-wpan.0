Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:51704 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbcGUIoN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 Jul 2016 04:44:13 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [RFC bluetooth-next 01/20] 6lowpan: ndisc: don't remove short address
In-Reply-To: <fef88ca3-84dc-822a-2ba1-0e593885bd8a@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-2-aar@pengutronix.de> <1996.1468934387@obiwan.sandelman.ca> <fef88ca3-84dc-822a-2ba1-0e593885bd8a@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 21 Jul 2016 04:44:10 -0400
Message-ID: <19276.1469090650@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <aar@pengutronix.de> wrote:
    > So you want to have such "flag":

    > "please force use short address always if short available" and
    > "please force use extended address always (if short address is
    > available)"

    > _per_ neighbour? If this fits to your use-case then I think it could
    > work.

yes, I think this is what I want.

    > At last you need to have some "neighbour add" netlink event listener
    > which reacts on if neighbours will be added and then set such flag for
    > the neighbour (which is indicated by L3 address).

Yes.

    > But the neighbour cache is already a hash with L3 address as key. I
    > think the neighbour cache should be used for such use-case. What do you
    > think.

I think it's an appropriate use.

    >> This will matter for handling of ND, in particular the DAR/DAC
    >> processing.

    > ah, ok. So for sending out DAR/DAC we need to control somehow to use
    > short or extended address?

Here, I think it's that we need the layer-2 address in the NA to validate the
ARO option in the NA, so that we can send the DAR with confidence.
I have to re-read https://tools.ietf.org/html/rfc6775#section-8.2.3 carefully
to see if I really need this or not.

    > You want to send these messages via userspace? In kernelspace we could
    > handle it (I think), lowpan interface knows the wpan interface and we
    > could decide somehow to force using short xor extended when generating
    > mac header for DAR/DAC.

I think that there is too much long-term state and policy to do this in the
kernel.

    > If I understand correctly, we do at the moment a) case.
    > By "Looking at L3 address and choose the L2 address according to which
    > best address do more compression", isn't it?

yeah...

    > I already implemented this stuff, the only one think is... it's more
    > than looking into L3 address only. It depends also on fragmentation. We
    > can compress maybe lot of bytes in FRAG1 which contains 6LoWPAN header
    > with the right L3 address by doing extended address. But if we have ~3
    > fragments (didn't calculate the number of necessary fragments now) then
    > it's better to use short address, because you can compress more bytes by
    > using short addresses in the fragments.

Yes, i recall discussing this with you.

    > The b) stuff will work then _per_ interface. Would be maybe nice to
    > have this per socket. I would say per socket would be nicer, because you
    > can overwrite the setting for exactly your use-case and all other
    > applications still do a). Currently I have no idea how to getting such
    > information from IPv6 socket to the 6LoWPAN layer but this should be
    > possible. This will also no add any 802.15.4 dependency for IPv6
    > applications, default handling should be still a).

setsockopt() is the normal way to indicate this down.  It gets into the
skbuff in a way that I don't recall.  Probably skbuff->sock or some such.

    > I also have no idea to get L2 receive information to the userspace at
    > the IPv6 socket yet. Need to take a look into ipv6 sockets,
    > IPV6_RECVPKTINFO is a nice hint, if we can easly extend this information.

that's the right mechanism, you send it up as aux data.


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBV5CLV4CLcPvd0N1lAQKsegf+M9nuoK6A5C4KqXYfUTOZhOfAyysIcQni
X262IgycjSwFjTkKGlhlfDRLIienjrJ+ZCChOF3JbkPPE3Tk2C6KSPN+8v9nsVPE
QunglkIhLoALhbCdOmSqmhQERmTMJCLQxe0mJjIu812p0WqL5hpmk0XzkfKGpo6j
QQqICulFk8rIm+L+Nztj8K68LpbVAAZp2unHMXbhhyvbsn6PEkK2gax1S0aeS4/O
nNr5gYMkYqBbzYqHzOU5D8Qo2i+qEaFxnJP91yTALDAYpXu3M+H6R2XmSKhvfLVe
64GqgHOgFsrPoWQuPAuafAMpATdIxtoZcHkEm5GT6SIRraw/QOqSqQ==
=Rsf+
-----END PGP SIGNATURE-----
--=-=-=--
