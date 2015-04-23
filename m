Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35051 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbbDWIbD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 04:31:03 -0400
Received: by wgyo15 with SMTP id o15so10404273wgy.2
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 01:31:02 -0700 (PDT)
Date: Thu, 23 Apr 2015 10:30:55 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: atusb availability
Message-ID: <20150423083052.GA1077@omega>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Geoff Chapman <geoff.chapman@mmbresearch.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

Hi,

I will try to answer a little bit the questions here.

On Tue, Apr 21, 2015 at 11:55:35AM -0400, Geoff Chapman wrote:
> Hello Mr. Almesberger,
> 
> My name is Geoff Chapman, and I am working on project to setup a
> simple 6loWPAN network between two laptops running Linux.  I am very
> interested in your work on the atusb device detailed at [0], and would
> like to use the device in my project.  On each laptop, I would like to
> use one of your atusb devices to implement the 802.15.4 MAC/PHY, while
> using the 6loWPAN stack in the linux kernel. I picture something like
> the following setup for each laptop:
> 
> 
> Linux Laptop:
> 
>         | Application Layer |
>                        |
>                 socket API
>                        |
>         |  6LoWPAN stack |
>                        |
>                        |
>                        <-----------------USB---------------> atusb
> device implementing 802.15.4 MAC/PHY (ATMega32U2 + at86rf233)
> 

So you want a HardMAC driver here. That's not how atusb works currently.
The atusb transceiver is a SoftMAC transceiver with _little_ mac
functionality, this contains checks on dsn/bsn to do some correct
frame deliviery in the firmware to the usb host, if I remember
correctly. I think you know that and you want to put full MAC functionality
into the atusb firmware.

We don't have currently any HardMAC drivers mainline, but the idea is to
handle the HardMAC transceivers like wireless, so with the existing
architecture we have a possibility to access HardMAC transceivers and
write HardMAC drivers. But we don't have a HardMAC driver currently and
I think you need to making some movements from SoftMAC layer (net/mac802154)
to cfg802154/netlink (net/ieee802154) layer, or you have workarounds for
that in your driver layer. I would say for HardMAC drivers go ahead and
try to implement your stuff and orient you at existing wireless HardMAC
drivers and simple don't use any functionality from (net/mac802154)
directory.


Another thing is that I don't believe that ATMega32U2 can full store a compliant
802.15.4 stack (maybe depends on your use case), because the ATMega32U2 has 32
KB flash memory. Maybe I am wrong here, if you think you can do that
then I would give it a try.


Another solution would maybe the RZRAVENUSBSTICK [2] which contains and
AT90USB1287 with at86rf230. In my opinion it's the same like atusb but atusb
contains an easier to use 802.15.4 transceiver, smaller mcu (bigger one is not
necessary here), and of course the case is smaller, etc. The AT90USB1287 has a
128 KB flash memory. Schematics of RZRAVENUSBSTICK can be found at [3]. 

> 
> I have tried purchasing two atusb devices at [1] without any luck, as
> they no longer sell the devices.
> I have two questions:
> 
> 1. Do you have any atusb devices available for purchase?
> 2. If you have none for purchase, do you have the schematics available
> that I can use to wire-up my own atusb device?  The schematic link on
> your site [2] seems to be broken.
> 

The schematics for atusb can be found at the ben-wpan repository [0],
which also includes the firmware, etc., but this requires the great tool
kicad [1] and _maybe_ some additional libs for electronic components.

- Alex

[0] http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/
[1] http://www.kicad-pcb.org/display/KICAD/KiCad+EDA+Software+Suite
[2] http://www.atmel.com/tools/rzusbstick.aspx
[3] http://www.atmel.com/Images/doc8117.pdf page 22
