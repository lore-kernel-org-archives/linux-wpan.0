Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53798 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbE1Nju (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 09:39:50 -0400
Date: Thu, 28 May 2015 16:39:48 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150528133948.GF11340@wantstofly.org>
References: <20150528123832.GD11340@wantstofly.org>
 <20150528131714.GD716@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150528131714.GD716@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, May 28, 2015 at 03:17:15PM +0200, Alexander Aring wrote:

> > Currently, ieee802154_random_extended_addr() has a 50% chance of
> > generating a group (multicast) address, while this function is used
> > for generating station addresses (which can't be group addresses)
> > for interfaces that don't have a hardware-provided address.
> > 
> > Also, in case get_random_bytes() generates the EUI-64 address
> > 00:00:00:00:00:00:00:00 (extremely unlikely), which is an invalid
> > address, ieee802154_random_extended_addr() reacts by changing it
> > to 01:00:00:00:00:00:00:00, which is an invalid station address as
> > well, as it is a group address.
> > 
> > This patch changes the address generation procedure to grab eight
> > random bytes, treat that as an EUI-64, and then clear the Group
> > address bit and set the Locally Administered bit, which is in
> > line with how eth_random_addr() generates random EUI-48s.
> 
> This is one thing which I asked myself already. If the group address
> comming from EUI-64 standard or not. What I can say is that the 802.15.4
> MAC layer doesn't care about this bit and we don't have _any_ multicast
> functionality.
> 
> What you try to do is to map ethernet MAC functionality to 802.15.4 MAC. The
> 802.15.4 have no special bits inside the EUI64 which indicates
> something. Our multicast functionality is done by a broadcast (done by
> short address, which is currently indicate by a 0xff..ff extended addr,
> because IPv6 can't deal at the moment deal with two types of mac address
> types.)
> 
> What I always find is this document [0]. Which describes that the
> 0x00..00 and 0xff...ff are invalid. (And a node should really not use
> 0xff..ff since we have the workaround with IPv6 for broadcast).
> 
> 
> If we would have such bit, then we also need to implement [1], which
> generates the multicast address according the IPv6 address. At the
> moment we get the dev->broadcast address which is correct, because we
> don't have multicast functionality.
> 
> 
> I don't ack this patch, because I don't see at the moment that this is
> wrong. Maybe I don't get it. If IPv6 checks on this bit and indicates a
> multicast on L2 _then_ we should change it, but I don't think that IPv6
> do that.
> 
> - Alex
> 
> [0] http://standards.ieee.org/develop/regauth/tut/eui64.pdf
> [1] http://lxr.free-electrons.com/source/net/ipv6/ndisc.c#L264

Your [0] document states that EUI-64 addresses start with an OUI,
and the structure of the OUI is documented in this document:

	https://standards.ieee.org/develop/regauth/tut/eui.pdf

Page 4 of this document shows that every OUI(/CID) contains the
Universal/Local and Individual/Group address bits, and this is
true no matter whether this OUI is part of an EUI-48 or an EUI-64.

Also compare your [0] with this document:

	http://standards.ieee.org/develop/regauth/tut/eui48.pdf

And note how neither the EUI-48 nor the EUI-64 PDFs talk about group
addresses -- this is because an EUI-{48,64} contains an OUI, and the
OUI contains the scope/group bits, and so the documents explaining
the EUI-{48,64} format are not the right place to discuss those bits,
although they exist both in EUI-48 and in EUI-64 addresses.

Just the fact that 802.15.4 spec doesn't talk about multicast doesn't
suddenly redefine the EUI-64 group bit as just another unicast address
bit, in my humble opinion, but this is what Linux is currently doing.

 From a hardware point of view, multicast packets should never be
ACKed, so there is no need for the hardware to be aware of the active
multicast addresses on this interface per se.  (We could theoretically
pass the multicast address list for the interface to the hardware to
allow doing frame filtering in hardware, but this does not affect
operational correctness.)

Whether we should be using EUI-64 group addresses on the "wire" for
802.15.4 for multicast (IPv6) traffic is another question, but using
EUI-64 group addresses as station addresses just because the link
layer doesn't define multicast functionality is wrong from my point
of view.
