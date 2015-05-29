Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53952 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbbE2DUA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 23:20:00 -0400
Date: Fri, 29 May 2015 06:19:58 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150529031958.GL11340@wantstofly.org>
References: <20150528123832.GD11340@wantstofly.org>
 <20150528131714.GD716@omega>
 <20150528133948.GF11340@wantstofly.org>
 <20150528144249.GF716@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150528144249.GF716@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, May 28, 2015 at 04:42:53PM +0200, Alexander Aring wrote:

> > Also compare your [0] with this document:
> > 
> > 	http://standards.ieee.org/develop/regauth/tut/eui48.pdf
> > 
> > And note how neither the EUI-48 nor the EUI-64 PDFs talk about group
> > addresses -- this is because an EUI-{48,64} contains an OUI, and the
> > OUI contains the scope/group bits, and so the documents explaining
> > the EUI-{48,64} format are not the right place to discuss those bits,
> > although they exist both in EUI-48 and in EUI-64 addresses.
> > 
> > Just the fact that 802.15.4 spec doesn't talk about multicast doesn't
> > suddenly redefine the EUI-64 group bit as just another unicast address
> > bit, in my humble opinion, but this is what Linux is currently doing.
> 
> The 802.15.4 spec doesn't also say any words about that the "extended
> address" is an EUI-64 address.  6LoWPAN RFC says it should handled like a
> EUI-64 [1]. General question is "Is the extended-address in 802.15.4
> really meaning an EUI-64 address?". Sorry for this newbie question, but
> this is what I am asking myself now.
> 
> What I see is that the extended-addr is described as "The 64-bit (IEEE)
> address assigned to the device." Which says to me it's an EUI-64, or?

You are right that there are no occurences of the "OUI" or "EUI"
strings in the 802.15.4 spec (good observation -- I hadn't noticed
this before!).  I'm basing my assumption that 802.15.4 64 bit
addresses are EUI-64s on this remark in 802.15.4-2011 section 5.2:

	A device’s extended address shall be a 64-bit universal
	address, as defined by the IEEE Registration Authority. [5]

Where footnote 5 is:

	[5] Interested applicants should contact the IEEE Registration
	Authority, http://standards.ieee.org/develop/regauth/.

On this web page, the only listed IEEE registries that seem relevant
ot me are the OUI registries (MA-L, MA-M, MA-S) -- none of the other
registries look like they could be the ones referenced by this remark
in the 802.15.4 spec.  This to me suggests that the 64 bit address
is an EUI-64, even if the literal term "EUI-64" isn't used anywhere.

And, as you remarked as well, there are several other references
online that suggest that 802.15.4 addresses are EUI-64s, for example
this TI FAQ page:

	https://e2e.ti.com/support/wireless_connectivity/w/design_notes/acquiring-ieee-address-range-802-15-4-mac-z-stack-zigbee-cc2420-cc2430-cc2431-cc2530-cc2531

Which has:

	Q: FAQ: Acquiring IEEE address range (802.15.4 MAC, Z-stack,
	ZigBee, CC2420, CC2430, CC2431, CC2530, CC2531)

	The IEEE 64 bit address is known at IEEE as the EUI-64(tm)
	which is a concatenation of the 24-bit OUI (Company ID) value
	assigned by the IEEE Registration Authority and a 40-bit
	extension identifier assigned by the organization with that
	OUI assignment.

	A one time fee of $1,650.00(US) is required. The addresses
	used for 802.15.4 has the same format and ranges as Ethernet
	MAC addresses.


> But then this means 0x00..00 and 0xff..ff are also valid, but IPv6
> can't deal with the 0x00..00.

0xff..ff wouldn't be valid as a station address as it is a group
address, and https://standards.ieee.org/develop/regauth/tut/eui64.pdf
also contains this remark:

	The all-zeros and all-ones EUI-64 values,
	00-00-00-00-00-00-00-00_hex and FF-FF-FF-FF-FF-FF-FF-FF_hex,
	are owned by the IEEE Registration Authority and will never
	be assigned, and are invalid for use as identifiers.


> > From a hardware point of view, multicast packets should never be
> > ACKed, so there is no need for the hardware to be aware of the active
> > multicast addresses on this interface per se.  (We could theoretically
> > pass the multicast address list for the interface to the hardware to
> > allow doing frame filtering in hardware, but this does not affect
> > operational correctness.)
> 
> So then we should also add a check of this bit at [0]? Then set the
> ackreq bit to 0 if the bit is set?

I would think so, but also, all v6 multicast addresses should be
mapped to the broadcast short address (when not using mesh mode),
according to RFC4944:

	This document assumes that a PAN maps to a specific IPv6 link.  This
	complies with the recommendation that shared networks support link-
	layer subnet [RFC3819] broadcast.  Strictly speaking, it is multicast
	not broadcast that exists in IPv6.  However, multicast is not
	supported natively in IEEE 802.15.4.  Hence, IPv6 level multicast
	packets MUST be carried as link-layer broadcast frames in IEEE
	802.15.4 networks.  This MUST be done such that the broadcast frames
	are only heeded by devices within the specific PAN of the link in
	question.  As per Section 7.5.6.2 in [ieee802.15.4], this is
	accomplished as follows:

	1.  A destination PAN identifier is included in the frame, and it
	    MUST match the PAN ID of the link in question.

	2.  A short destination address is included in the frame, and it MUST
	    match the broadcast address (0xffff).

So I thiiiink (but I haven't had my morning caffeine yet) that the
lowpan_is_addr_broadcast() check in lowpan_header() should be matching
on all multicast destination addresses instead.


> > Whether we should be using EUI-64 group addresses on the "wire" for
> > 802.15.4 for multicast (IPv6) traffic is another question, but using
> > EUI-64 group addresses as station addresses just because the link
> > layer doesn't define multicast functionality is wrong from my point
> > of view.
> 
> When this address is invalid and the MAC layer doesn't use this bit.
> Then we need to care that we drop all frames with the source address
> with this bit. I also don't see that any transceiver with address
> filtering enabled will drop this frame (okay they also don't filter
> 0x00..00 and 0xff...ff) frames.

For 802.3 ("plain" ethernet), we drop frames that have the group
address bit set in the frame source address, and in theory we should
probably be doing the same for 802.15.4, but in practise, I don't
think we can justify making this change now, as we already have an
installed base that happily uses group addresses as station addresses,
and making this change would break compatibility with those devices,
with no obvious advantage other than spec compliance.

If some future 802.15.4 stack change makes it necessary to start
dropping received frames with the group address bit set in the
source address, then I guess we can consider it, but at this point
I just don't see enough justification to intentionally break
communication with older Linux boxes with 50% probability (which
is the probability of them generating a group address as station
address).


> I am currently really unsure and looking in well-known IoT OS, if they
> look on this bit. But I didn't saw anything. Only that the most using
> the same like eth_random_addr address and fill with ff fe bit pattern.
> Maybe to operate with some virtual linux networking ethernet interfaces
> which are connected over slip and tun/tap and such things...

ff fe bit pattern?
