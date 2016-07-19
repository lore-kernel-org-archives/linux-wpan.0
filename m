Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59426 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753898AbcGSSUS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Jul 2016 14:20:18 -0400
Subject: Re: [RFC bluetooth-next 18/20] 6lowpan: move multicast flags to
 generic
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-19-aar@pengutronix.de>
 <1295fe6f-280f-90c1-bb06-a507ecd6dc2b@pengutronix.de>
 <1468408545.3075.21.camel@linux.intel.com>
 <21544.1468939881@obiwan.sandelman.ca>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <0757adb3-7d86-1c09-48b1-d5df8b2e9c08@pengutronix.de>
Date: Tue, 19 Jul 2016 20:20:11 +0200
MIME-Version: 1.0
In-Reply-To: <21544.1468939881@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>, Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com


Hi,

On 07/19/2016 04:51 PM, Michael Richardson wrote:
> Jukka Rissanen <jukka.rissanen@linux.intel.com> wrote:
>     > According to packet(7), the "Packet sockets are used to receive or send
>     > raw packets at the device driver (OSI Layer 2) level."
>     > But lowpan0 interface is meant to compress IPv6 header so it is working
>     > on L3 data (or more precisely between L2 and L3).
>     > So I am wondering how this is suppose to work and what kind of use case
>     > you have for this?
> 
> First, one might want to send 802.15.4 packets with custom Information
> Elements. So you ask why we would want to do this through the lowpan
> interface... well, because lowpan will perhaps grow support for the 6tisch
> (802.15.4e) mode of operation, and the custom IEs need to be scheduled out
> with the other packets.   In particular, you don't want to jump the 6lowpan
> queue of fragments.
> 

I currently think this discussion goes into the wrong direction.

Here exists an issue that transmit AF_PACKET RAW will not work,
DGRAM (tx/rx) sockets has also no sense.

The root of this issue is the "header_create" callback and what's made
for. This callback is used to tell the subsystem "Please add a mac
header here and as parameter you have L2 source and destination address".

This callback will be used by AF_PACKET _DGRAM_ and IPv6 ndisc cache.
Both of them has some point "please add a mac header, here are source
and destination L2 addresses".

So we don't put any mac header there, our use-case is "IPv6 ndisc cache"
only. We need the destination address from the ndisc and this callback
is the super generic way to tel us that by IPv6 stack and I would use
this callback as well, because it seems to be the normal IPv6 way.

I already told that we don't put a mac header there, what we do is
adding into a hidden skb space (skb_headroom) the address information
(important here the L2 daddr). This hidden skb space will be evaluated
inside the xmit callback where we finally replace the IPv6 header with
6LoWPAN and put the mac header in there.

So why we don't replace the header in header_create? This has several
issues:

 - We need to have a unshared skb buf and we cannot unshare in this callback.
 - We need to have the IPv6 view in AF_PACKET RAW receive side and this
   will be caputered between header_create and xmit.

Sending on AF_PACKET RAW sockets will occur that "create header"
callback will not be called and xmit callback directly. The xmit callback will
evaluate the "hidden skb room" (skb_headroom), we don't called "create_header"
before so there is garbage inside this skb_headroom.

btw:

What I mentioned before, this handling is weird but it works for IPv6.
We assume here that nobody runs skb_put/skb_push between "header_create"
and "xmit".

- Alex
