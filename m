Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:52000 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdCEXUL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Mar 2017 18:20:11 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: RPL integration needs in the Linux Kernel
In-Reply-To: <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com> <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sun, 05 Mar 2017 18:12:43 -0500
Message-ID: <6934.1488755563@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: =?us-ascii?Q?=3D=3Futf-8=3FQ=3FJo=3DC3=3DA3o=5FPedro=5FTaveira=3F=3D?= <joao.p.taveira@gmail.com>

--=-=-=
Content-Type: text/plain


{please forgive how long it's taken me to respond. I've been meaning to reply
at length for some time.  And my thanks for reading to the end.
I know it's long.}

In advance of the netdev2.1 IoT panel discussion,
   http://netdevconf.org/2.1/session.html?schmidt
I thought it useful to put some thoughts on the things that userspace
routing protocols need from the kernel and 6lowPAN layer.
Some of these needs apply to BABEL and OLSR as well as RPL, btw.

Most of these things are probably in common with Joao's needs for his
in-kernel RPL implementation.  I think that other mesh protocols, perhaps
including ISA100-type mesh-under might be able to use some of these things
too, but generally, I dislike layer-2 mesh.  Enough with the layer-2 tricks,
I say.

Oh, and this is more than just 802.15.4, check out:
    https://datatracker.ietf.org/wg/6lo/documents/
to see it's also about BTLE, "lobac" aka MS/TP, DECT, NFC, G9959,
MS/TP is multi-drop 9600 baud RS422 over twisted pair, and is probably in
      every commercial building that has elevators or air-conditioning.

====

About me: I was the IETF ROLL WG co-chair from 2012 to 2016, and I edited the
      security threats analysis and then wrote a lot of the "useofrplinfo"
      document.  (I stepped down as co-chair to enable others, to return to
      being at cat, rather than a cat-herder)

      While RFC6550 tells you a lot about the RPL routing protocol
      itself, it leaves 6553 and 6554 to tell one about how to construct the
      forwarding level.  And those documents have failed to produce
      interoperable implementations.

https://datatracker.ietf.org/doc/draft-ietf-roll-useofrplinfo/ is in WG Last
Call. I'm a co-author. There are some RFC2460 rules (and 2460bis) which we
have to follow.   This clarification of the rules for when you need RFC6553
(RPI) and RFC6554 (RH3) headers (and related IPIP header) was driven by the
desire to further compress these artifacts by the 6LoWPAN Routing Header.
https://datatracker.ietf.org/doc/draft-ietf-roll-routing-dispatch/
{we couldn't know what mattered most to compress until we sure when each
header occured and in what order}

====

Most, like Joao test against Contiki, and Contiki
      a) only implemented storing mode until very recently.
      b) did not actually support multiple instanceIDs.

If one does only storing mode with a single instanceID, and ignores all the
other stuff, then the stock Linux IPv6 kernel router processes can be made to
work.  As soon as one wants more... then we get into trouble.

Alexander Aring has done a bunch of work, or at least, planning for work on
how to implement the new compression code in the kernel.  The code patches
are still in his head at this point, I think :-)

In general many of us see Linux based devices being the RPL root nodes,
having power, lots (compared to class 2 devices) of ram, and a multitude of
interfaces.   Joao's work shows that in a number of situations the sensors
and motes could well be big enough to run Linux, and increasingly, the cost
of Linux based SoC is often lower than some ATmel based ones.  $9 CHIPs
and $10 VoCore's and PINE64s and the like.  Even RPIs and things like the
Orange PI 0... many are power-hungry, but sometimes that's okay.

802.15.4 PHYs are growing from the 128-byte packet limit, and 250kbps
peaks, to having 2K packet sizes and 2Mb/s data rates, meanwhile the
power-cost of some 802.11 chips has plumetted.

We run into problems once we start to think about being gateway routers,
running non-storing mode, or supporting multiple instanceIDs.

What we need in the kernel for the forwarding plane:
   1) processing of the RPI header in uncompressed form.
      This means to be able to increment/decrement the rank depending
      upon what direction the packet is going.  As it may well enter and
      exit upon the same (radio) interface, this directionality (up/down)
      needs to be encoded into the route and/or "Grand Unified Flow Cache".

   2) when processing the RPI header, the instanceID needs to be mapped to
      a routing table number.  We have to think about attacks involving
      this kind of header, and so we have to have some ways to either contain
      or ignore this header.  The system in question may well have a
      multitude of other functions in addition to being a RPL root.

   3) we need processing of the (source) RH3 header, which is rather simple, but a
      key point is that it asks for ignoring the routing table. Again, even
      more concerns about RH3 headers showing up in surprising places.
      The RH3 header may well evolve to become more of a Loose source route,
      and so it would be good to support some routing lookup at times.

   4) we need to be able to specify inserting of a RH3 (and IPIP) header
      within a route entry.  This is how non-storing mode works, and also
      how the P2P mode of RPL works.  Also inserting of an RPI header.

Then, we need to do all of the above for 6lowRH compressed form of headers.
Such a form is, btw, defined for 6lowpan links only, and yet RPL is layer 3,
and happily forwards over 802.11 or ethernet or PPP...

The compression is designed so that one does not need to take it all apart to
process things, but rather one manipulates the compressed form directly when
an intermediate node.  At any point, though, an error (such as
no-route-to-host), might cause the packet to be uncompressed, and then an
ICMPv6 created... and then some of that would get compressed again.

Some of the compression can be handled as if it were hardware offload or
layer-2 drivers.  For instance if one wants to perform RFC7400 (GHC)
compression on the whole packet, that can be done "below" IP.

However, in order to efficiently forward, it would be nice to if the
forwarding decompression routines could populate parts of the SKB in much the
way that the VLAN processing doesn't care if it was the NIC that did the
work, or the VLAN layer.

The number of fields and new structures required in the kernel could be many,
and stuffing them into skbuff, etc. might be unpopular.  My (recent) review
of Joao's code points to this being perhaps one reason it was perhaps not well
received. (Also not being linux-next git-pullable probably mattered).

I regard this as the challenge: not, "how to write this", but rather,
  - how can we write this in a way that is minimally disruptive to other users?

  - while we can have an option to compile things in/out, if a gateway device
    is doing both FTTH Gb/E forwarding, and also 802.15.4, can we have add
    the new things we need without killing Gb/E forwarding?

One thought that Alex and I discussed in chat over many days was how much
could we move to userspace?  802.15.4 networks are SLOW.  Aside from the
power cost of being awake longer,  the speed won't be adversely affected by a
few data copies in and out of the kernel.

One approach which has been repeated in software and hardware is not to even
try to do this in the kernel!  The Redwire gateway for instance, is a
Linux-based home router with a Redwire Econotag running Contiki attached to
it.  The radio is on the econotag, and they speak via SLIP over USB-serial.
One can repeat today with an RPI and an OpenMote with OpenWSN, and in fact
this is part of the preferered 6tisch development platform.
One version of this runs RPL and 6lowpan written in Python on the host.
The result is an academic solution: the python is too big and new to run
with uPython on platforms that would actually work.

6tisch is TIme Slot Channel Hoping, and permits devices to sleep 99% of the
time by coordinating when they actually need to be awake to Tx/Rx
packets. Getting the precise timing is actually a bit of a challenge with
Linux, and so far the solution is an OpenMote on USB, or on RPI shield.

I'm trying to switch it from a bastardized SLIP interface, to PPP, such that
we can do the 6lowpan on the Linux side, but leave the precise timing to the
OpenMote processor fow now.  PPP because I think it will be easiest to extend
to include time-slot, channel, Rx and Tx powers.

This brings up two requirements that we have in common with the mac80211
work.

a) We need to be expose Rx and Tx parameters to userspace applications.

b) We need to feed/store ETX ("link quality") values calculated by userspace
   applications back into the kernel's neighbour table.

To explain, RPL needs to know how far away each peer is so that it can best
determine what parents it should pick.  An important part of this can be
knowing how much power it took to send to that peer, and how strong the
signal was when traffic was received from that peer.

This would be best stored in the neighbour cache table in the kernel, to
expire and be recreated.  (And along with this, Alex has been working on
storing both the EUI-64 extended address and the 16-bit short address into
that table)

One can't know what the link quality is with a peer unless one actually tries
transmitting to that peer.  Zigbee defined a protocol called MLE.  It's
*still* a draft:
        https://datatracker.ietf.org/doc/draft-ietf-6lo-mesh-link-establishment/
(sigh, expired again....)

the essence is to send traffic to peers, and record how well one does.
This lives in UDP. (I claim it should have been ICMPv6).  It certainly
would be easier to do inside the kernel with better access to Tx/Rx power
information in the skbuff.  Do the mac80211 folks have a userspace API yet to
Tx/Rx info?   I know that they wanted to have one at some point.

So, if we can get/set Rx/Tx info via recvmsg(2), then a free-running daemon
can detect how strong signals are, and based upon that, we can then populate
the neighbour cache entries.  This has two purposes.  a) so that a routing
daemon (whether userspace or kernel) could see the strengths.
more importantly: b) so that the kernel will only transmit with as much power
                  is it needs to. using only as much battery as needed, and
                  also disrupting as few distant nodes as possible.

Wow, this is a lot of lines.

Let me respond to some of Joao's comments:

    > After Linux RPL Implementation in kernel space being tested, on several
    > SoCs, with transceivers 802.15.4 on 2.4GHz and/or 868, I tried to get
    > in touch with kernel wpan group, but no one seamed to be interested in
    > my contributions. ROLL ietf group was very receptive to know that a
    > kernel land implementation was in development, but wpan-linux had other
    > ideas for the wpan stack, some kind of scorn about RPL, they simply
    > ignored my issues and questions.

    > After this "kindly" and "warm" acceptance from wpan-group and the lack
    > of interest in merge efforts, I was forced to give up on get RPL
    > implementation in kernel.

I rather think you got silence because nobody knew what you were doing, nor
why.   I don't know why you think the userland code bases were so "huge":
lines of source code with debugging enabled is not the same as executable
size with things stripped out.  But in any case, you never contacted me.

    > When there will be interest, will and gumption to resume linux-rpl
    > project, simply let me know.







--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAli8m2sACgkQgItw+93Q
3WWRzwf/SrfxSg7RSIG51u/5dB4fnbGicaN6ZEy02CgQkBCMo0QTTze8d+S2W3+P
b/WrwxDC/XZeRA55UsXayImzVGRBRTLBmPmszJLoSlAYPPUOh5/iYjosv30TMP5a
wi4df1JJkr4YK9ibFZbrf4vguqp5BbSPCQYHP63Q3jJ+sFQRwfrqdG9M1gH2NNWc
yk86aEIji5VVOe0tB8Xsml80c+QgX+dwAfB+mMwGlbFIEXHkvL9Z8pyFqlHiXLrD
PsLEa0PBWdsRt3t/aT0m5Z4fiBks8E8o7rY3lPP/yFD4BwyAoPTGMk5o77F6vjnt
EB03LF9+UPomKa0hjOOil5bc420tSw==
=M3GQ
-----END PGP SIGNATURE-----
--=-=-=--
