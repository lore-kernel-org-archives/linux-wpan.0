Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60487 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752418AbdARJ7U (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Jan 2017 04:59:20 -0500
Subject: Re: please help me to integrate RPL in kernel
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
 <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <865f1a70-68e3-b947-f37d-ee856147c341@pengutronix.de>
Date: Wed, 18 Jan 2017 10:59:17 +0100
MIME-Version: 1.0
In-Reply-To: <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Jo=c3=a3o_Pedro_Taveira?= <joao.p.taveira@gmail.com>
Cc: JANARDHANACHARI KELLA <eni.chari@gmail.com>, linux-wpan@vger.kernel.org


Hi,

On 01/18/2017 10:46 AM, João Pedro Taveira wrote:
> Hi JANARDHANACHARI KELLA,
> 
> Just a little of context.
> 
> For the last 2 or 3 years I've been working in projects related with smartgrids and LV powergrids. Among the huge list of requirements of the projects, let me just refer two (or three).
> 	• Sensors mesh networks must use wireless connectivity (not PLC, nor ethernet, or some kind of wired links)
> 	• Sensors were deployed on Street Lighting poles (thus, would require power provider cranes and "brave" guys to install them)
> 	• One of sensors features is to detect power outages, thus it would require some kind of backup power to make them work, but... usage of any kind of batteries were forbidden.
> Long story short, RPL was simply part of the solution. At the time there were only one good implementation of RPL: contiki's one. For sensors it were a good approach. Anyway, in some use cases, contiki was not enough. After a search for RPL implementations for linux, I only found 2 or 3 which worked on linux userland which required huge resources, so I give it a try and started a linux RPL implementation on kernel land.
> 
> 	• https://github.com/joaopedrotaveira/linux-rpl (kernel patches)
> 	• https://github.com/joaopedrotaveira/rpl-userspace-tools (userspace tools like iwpan, based on libnl)
> To figure out the SoC power consumption of those on the market and decide which one to use, it was required to test several boards (rpi, beagleboard, beaglebones, olinuxinos, Atheros AR9330 boards, ...), check power consumptions and test RPL implementation with some contiki based sensors. It was also required to use 868band radios, which were very dificult to find. It was very hard to implement RPL in kernel and port it for every single kernel versions of each kind of ARM SoCs, which exoteric patches from this or that SoC vendor to best support for power management (namely pm3).
> 
> After Linux RPL Implementation in kernel space being tested, on several SoCs, with transceivers 802.15.4 on 2.4GHz and/or 868, I tried to get in touch with kernel wpan group, but no one seamed to be interested in my contributions. ROLL ietf group was very receptive to know that a kernel land implementation was in development, but wpan-linux had other ideas for the wpan stack, some kind of scorn about RPL, they simply ignored my issues and questions.
> 
> After this "kindly" and "warm" acceptance from wpan-group and the lack of interest in merge efforts, I was forced to give up on get RPL implementation in kernel.
> 

It's not OUR job to merge ICMPv6 protocol into kernel! I already told
you - you need to send your patches to netdev mailinglist... but I think
you need to switch some stuff there, so far I remember sysfs is used ->
switch to netlink.

We didn't ignore anything...

> RPL standards require information about transceivers link quality, stats about physical layer of 802.15.4 radios, and wpan-linux simply ignored my calls.
> 

Oh I have patches which provides some per-neighbor LQI information. :-)

If you see lack of support, just: send-patches!

> After months trying to get things working with dozens of different kernel-trees, from different SoCs, different kernel versions and almost no interest, I was forced to come across on unfair and insulting reviews: http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html
> 
> After months trying to get fully RPL supported kernel with following goals:
> 	• RFC6550 RPL: IPv6 Routing Protocol for Low-Power and Lossy
> 	• RFC6551 Routing Metrics Used for Path Calculation in Low-Power and Lossy Networks
> 	• RFC6552 Objective Function Zero for the Routing Protocol for Low-Power and Lossy Networks (RPL)
> 	• RFC6719 The Minimum Rank with Hysteresis Objective Function
> 	• RFC6206 The Trickle Algorithm
> 	• Support for adding new Objective Functions Modules
> 	• Kernel Network Namespace support
> 	• Userland tools
> ... I was forced to stop working on this, and move forward on the project I was working on, when I get a nice surprise reading conclusion of the already mentioned review:
> "Conclusions
> RPL for Linux is usable. Joao Pedro Taveira's implementation seems to work with Linux 3.17 and 6LoWPAN (after minimal patching). This is very surprising, that implementation is no longer developed. Linux box is a superior solution for Border Router than any embedded system. Open Source's inefficiency is sometimes amazing."
> 
> Right now, I don't know the current status of wpan-linux stack. I recall that wpan-linux was merged with bluetooth-stack or something, but I assume that the required changes to netdev that allow me (or anybody else) to get RPL really working as expected in kernel, are still missing.
> 
> When there will be interest, will and gumption to resume linux-rpl project, simply let me know.
> 

I don't know if the ipv6 folks want's to have a RPL implementation in
kernel. For non-storing mode kernel handling is needed but currently
e.g. unstrung (which use storing mode) -> no kernel handling is requirement.

You need to ask on the netdev mailinglist how to maybe deal with that, I
am _not_ an ipv6 maintainer -> you can always send RFC patches there.

It's a big challenge to look how we can deal non-storing mode in future.

- Alex
