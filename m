Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35407 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753168AbcGSSDU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Jul 2016 14:03:20 -0400
Subject: Re: [RFC bluetooth-next 01/20] 6lowpan: ndisc: don't remove short
 address
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-2-aar@pengutronix.de>
 <1996.1468934387@obiwan.sandelman.ca>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <fef88ca3-84dc-822a-2ba1-0e593885bd8a@pengutronix.de>
Date: Tue, 19 Jul 2016 20:03:08 +0200
MIME-Version: 1.0
In-Reply-To: <1996.1468934387@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org


Hi,

On 07/19/2016 03:19 PM, Michael Richardson wrote:
> 
> {cutting many from the CC}

ok.

> I realized while reading your patches that I don't think we have a way for an
> application to tell if a packet (such as an ICMPv6 packet received on a raw
> IP socket) arrives with a 2-byte or 8-byte address, or for an application to
> ask for 8-byte address, despite there being a 2-byte address available.
> 

Yes this isn't possible. The 6lowpan interface has raw IPv6 view, no L2
part isn't involved.

Currently what we do is to have some "best-fit" strategy according to
using the best compression method which depends on L3 address.

I can understand that you want to decide from userspace which L2 address
you want to use. We should have some way to overwrite the best fit
strategy and you can control it somehow from userspace.

The "best-fit" strategy will be used then if a "overwrite strategy"
isn't given, so we have no dependency on that we MUST need to set short
or extended from socket side. Otherwise we put 802.15.4 dependencies
into IPv6 userspace applications.

> Do you think we could do this via neighbour caches for directly connected
> nodes?  For not directly connected nodes part of an RPL mesh, the RPL daemon
> would install routes using the router's 2-byte address if it can anyway.
> 

I can imagine that if a neighbour has both address types "short and extended"
then we run into the possibility that you can decide "if using short xor
extended address" while generating 6LoWPAN+L2 headers.

So you want to have such "flag":

"please force use short address always if short available" and
"please force use extended address always (if short address is available)"

_per_ neighbour? If this fits to your use-case then I think it could work.

At last you need to have some "neighbour add" netlink event listener
which reacts on if neighbours will be added and then set such flag for
the neighbour (which is indicated by L3 address).

---

Maybe another idea to avoid a event handling mechanism is to keep some
hash table in table with the L3 address as key and then sets such flag,
do not depend on neighbour exists or not.

But the neighbour cache is already a hash with L3 address as key. I
think the neighbour cache should be used for such use-case. What do you
think.

> This will matter for handling of ND, in particular the DAR/DAC processing.
> 

ah, ok. So for sending out DAR/DAC we need to control somehow to use
short or extended address?

You want to send these messages via userspace? In kernelspace we could
handle it (I think), lowpan interface knows the wpan interface and we
could decide somehow to force using short xor extended when generating
mac header for DAR/DAC.

> I also wonder: if we configure an IPv6 address via SLAAC with our 8-byte
> EUI64, and we configure another v6 address via SLAAC with our 2-byte address,
> if we should:
>    a) always use the 2-byte layer-2 when there is a matching 2-byte v6
>       address in the source.  and vv for 8-byte EUI64s
>    b) preference the 2-byte layer-3 address so that it is chosen by
>       source address selection.
> 

If I understand correctly, we do at the moment a) case.
By "Looking at L3 address and choose the L2 address according to which
best address do more compression", isn't it?

I already implemented this stuff, the only one think is... it's more
than looking into L3 address only. It depends also on fragmentation. We
can compress maybe lot of bytes in FRAG1 which contains 6LoWPAN header
with the right L3 address by doing extended address. But if we have ~3
fragments (didn't calculate the number of necessary fragments now) then
it's better to use short address, because you can compress more bytes by
using short addresses in the fragments.

---

The method b) would be something that you can set some attribute
_per_ interface to force use short address xor extended as _source_.

RIOT-OS has something like that which is the "src_len" attribute of the
netdev2 interface.

---

What I would like the see is maybe a similar handling like the "estimate
the daddr L2 address". Doing a) by default, because it will choose the
best option to compress data, but you can do b) (by some netlink command)
to overwrite the handling of a).

The b) stuff will work then _per_ interface. Would be maybe nice to
have this per socket. I would say per socket would be nicer, because you
can overwrite the setting for exactly your use-case and all other
applications still do a). Currently I have no idea how to getting such
information from IPv6 socket to the 6LoWPAN layer but this should be
possible. This will also no add any 802.15.4 dependency for IPv6
applications, default handling should be still a).

> I think that the above probably gets us all the mechanisms we need for
> transmit.   For receive, I think that we have no APIs that will give you the
> layer-2 address for an incoming packet the way that IPV6_RECVPKTINFO will
> do for layer-3 addresses and extensions.   It would be nice to have such
> an API.

I also have no idea to get L2 receive information to the userspace at
the IPv6 socket yet. Need to take a look into ipv6 sockets,
IPV6_RECVPKTINFO is a nice hint, if we can easly extend this information.

> 
> What do others think?

In short what I described above:

Make a reasonable default handling which looks for "what we need to do
to doing the best 6LoWPAN compression", but there exists the possibility
to overwrite this handling and force a different handling.


I hope it's clear what I mean, otherwise we can chat.

- Alex
