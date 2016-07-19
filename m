Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:58083 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcGSOvW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Jul 2016 10:51:22 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [RFC bluetooth-next 18/20] 6lowpan: move multicast flags to generic
In-Reply-To: <1468408545.3075.21.camel@linux.intel.com>
References: <20160711195044.25343-1-aar@pengutronix.de> <20160711195044.25343-19-aar@pengutronix.de> <1295fe6f-280f-90c1-bb06-a507ecd6dc2b@pengutronix.de> <1468408545.3075.21.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21543.1468939881.1@obiwan.sandelman.ca>
Date: Tue, 19 Jul 2016 10:51:21 -0400
Message-ID: <21544.1468939881@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com

Jukka Rissanen <jukka.rissanen@linux.intel.com> wrote:
    > According to packet(7), the "Packet sockets are used to receive or send
    > raw packets at the device driver (OSI Layer 2) level."
    > But lowpan0 interface is meant to compress IPv6 header so it is working
    > on L3 data (or more precisely between L2 and L3).
    > So I am wondering how this is suppose to work and what kind of use case
    > you have for this?

First, one might want to send 802.15.4 packets with custom Information
Elements. So you ask why we would want to do this through the lowpan
interface... well, because lowpan will perhaps grow support for the 6tisch
(802.15.4e) mode of operation, and the custom IEs need to be scheduled out
with the other packets.   In particular, you don't want to jump the 6lowpan
queue of fragments.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

