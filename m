Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:43992 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbbG0CPF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Jul 2015 22:15:05 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: testing and building for RPI
In-Reply-To: <7829.1437848841@dooku.sandelman.ca>
References: <19096.1431373298@sandelman.ca> <55517906.2060204@gmail.com> <7829.1437848841@dooku.sandelman.ca>
Date: Sun, 26 Jul 2015 22:14:49 -0400
Message-ID: <6138.1437963289@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, unstrung-hackers <unstrung-hackers@lists.sandelman.ca>


Michael Richardson <mcr@sandelman.ca> wrote:
    >> Please see the blog: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

    > I have some edits for this; mostly unfortunate typos or copy/pastes.
    > I did get it working; my major stumbling block had to do with u-boot
    > apparently not really sending out multiple DHCPs messages.

    > The first goes out, and if the network is truly ready, it works.
    > Why wouldn't it be ready?  Cisco switches with STP enabled... plugging in a
    > trusty 8-port 100Mb/s stupid switch solved the problem, but cross-over cable to my
    > laptop showed me that it was really only sending out a single DHCP request,
    > not 8.  Once I put the "boot.scr" in place, it seems to boot very reliably,
    > but I haven't removed the 100Mb/s switch yet.

    > The suggested "agx" tree's defconfig didn't seem to enable the correct set of
    > kernel CONFIG options for the AT86*, etc. I'll post my whole recipe when I'm
    > back from the cottage.  You need to enable the IEEE802154, to then see
    > MAC802154 (and enable it) options before you'll see the AT86 drivers
    > available if you are using menuconfig.

After doing:
      make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2835_defconfig

I had to enable:
CONFIG_6LOWPAN=y
CONFIG_6LOWPAN_NHC=y
CONFIG_6LOWPAN_NHC_DEST=y
CONFIG_6LOWPAN_NHC_FRAGMENT=y
CONFIG_6LOWPAN_NHC_HOP=y
CONFIG_6LOWPAN_NHC_IPV6=y
CONFIG_6LOWPAN_NHC_MOBILITY=y
CONFIG_6LOWPAN_NHC_ROUTING=y
CONFIG_6LOWPAN_NHC_UDP=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_IEEE802154_6LOWPAN=y
CONFIG_MAC802154=y

CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_AT86RF230=y
CONFIG_IEEE802154_MRF24J40=y
CONFIG_IEEE802154_CC2520=y

and then I had a kernel that saw my at86 device.  (I'm sure that the CC2520
and MRF24J40 enable was gratuitous).

I haven't yet interoperated with contiki; just ran out of time.



