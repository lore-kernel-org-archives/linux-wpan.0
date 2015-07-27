Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33098 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbG0HjY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 03:39:24 -0400
Received: by wicmv11 with SMTP id mv11so127366322wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 00:39:23 -0700 (PDT)
Date: Mon, 27 Jul 2015 09:39:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: testing and building for RPI
Message-ID: <20150727073925.GA1187@omega>
References: <19096.1431373298@sandelman.ca>
 <55517906.2060204@gmail.com>
 <7829.1437848841@dooku.sandelman.ca>
 <6138.1437963289@sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6138.1437963289@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, unstrung-hackers <unstrung-hackers@lists.sandelman.ca>

Hi Michael,

On Sun, Jul 26, 2015 at 10:14:49PM -0400, Michael Richardson wrote:
> 
> Michael Richardson <mcr@sandelman.ca> wrote:
>     >> Please see the blog: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/
> 
>     > I have some edits for this; mostly unfortunate typos or copy/pastes.
>     > I did get it working; my major stumbling block had to do with u-boot
>     > apparently not really sending out multiple DHCPs messages.
> 
>     > The first goes out, and if the network is truly ready, it works.
>     > Why wouldn't it be ready?  Cisco switches with STP enabled... plugging in a
>     > trusty 8-port 100Mb/s stupid switch solved the problem, but cross-over cable to my
>     > laptop showed me that it was really only sending out a single DHCP request,
>     > not 8.  Once I put the "boot.scr" in place, it seems to boot very reliably,
>     > but I haven't removed the 100Mb/s switch yet.
> 
>     > The suggested "agx" tree's defconfig didn't seem to enable the correct set of
>     > kernel CONFIG options for the AT86*, etc. I'll post my whole recipe when I'm
>     > back from the cottage.  You need to enable the IEEE802154, to then see
>     > MAC802154 (and enable it) options before you'll see the AT86 drivers
>     > available if you are using menuconfig.
> 
> After doing:
>       make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2835_defconfig
> 
> I had to enable:
> CONFIG_6LOWPAN=y
> CONFIG_6LOWPAN_NHC=y
> CONFIG_6LOWPAN_NHC_DEST=y
> CONFIG_6LOWPAN_NHC_FRAGMENT=y
> CONFIG_6LOWPAN_NHC_HOP=y
> CONFIG_6LOWPAN_NHC_IPV6=y
> CONFIG_6LOWPAN_NHC_MOBILITY=y
> CONFIG_6LOWPAN_NHC_ROUTING=y
> CONFIG_6LOWPAN_NHC_UDP=y
> CONFIG_IEEE802154=y
> CONFIG_IEEE802154_SOCKET=y
> CONFIG_IEEE802154_6LOWPAN=y
> CONFIG_MAC802154=y
> 
> CONFIG_IEEE802154_FAKELB=y
> CONFIG_IEEE802154_AT86RF230=y
> CONFIG_IEEE802154_MRF24J40=y
> CONFIG_IEEE802154_CC2520=y
> 
> and then I had a kernel that saw my at86 device.  (I'm sure that the CC2520
> and MRF24J40 enable was gratuitous).
> 

congratulation. :-)

> I haven't yet interoperated with contiki; just ran out of time.
> 

Okay, I see also you use a builtin CONFIG_IEEE802154_FAKELB, this module
generates two virtual phys which can "transmit <-> receive" some data
between them - if the page/channel setting are the same. This module
will register two phys by default.

It's just a note, that you might have 3 phys registered.

- Alex
