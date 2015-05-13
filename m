Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38636 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbEMUFz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 May 2015 16:05:55 -0400
Received: by wicnf17 with SMTP id nf17so69480704wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 13 May 2015 13:05:53 -0700 (PDT)
Date: Wed, 13 May 2015 22:05:51 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: atusb availability
Message-ID: <20150513200547.GB820@omega>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
 <20150423083052.GA1077@omega>
 <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Geoff Chapman <geoff.chapman@mmbresearch.com>
Cc: linux-wpan@vger.kernel.org

On Wed, May 13, 2015 at 01:24:13PM -0400, Geoff Chapman wrote:
> Hi Alex,
> I just wanted to thank-you for your reply, it certainly helped with my
> understanding.  Initially, I thought the device was a HardMAC device,
> so thank-you for correcting me on that.  It seems that the device
> simply implements a USB-to-SPI interface.
> 
> I have used the schematics at [0] to build a few boards of my own.  I
> would like to use the two boards to send data between two laptop
> computers running linux.
> The description at [1] indicates that the ATMega firmware implements a
> "home-brew protocol on top of USB".  My plan is to do the following:
> 
> 1. Examine the source ATUSB firmware source code to determine the
> home-brew protocol.

that should work, this is what we try to do with the rzusbstick [0],
which have much identically parts like atusb (but atusb is much better
;-))

Then we just need to port the firmware to the rzusbstick.

> 2. Write some application software in C for the two linux PCs using
> Netlink sockets to communicate with the devices and transfer data
> between the two PCs.
> 

No netlink sockets, it's simple an IPv6 socket. What you missing here is
the atusb driver which is not mainline, but I recently send a patch to
support basic operation for atusb. I hope we getting this driver
mainline the next days, if you speak the exactly protocols then it
should work. But _note_ the protocol contains at86rf231 specific
commands which do a register write, look for function:

atusb_write_reg and atusb_read_reg.

Then maybe you need to insert runtime decisions when you not using the
same transceiver. Of course you can send patches for this to make this
behaviour more generic or runtime change that a different register
setting is used.

What I mean is that the protocol isn't a generic 802.15.4 protocol for
all transceivers, but we could make it to somewhat like that. Or you
make different runtime changes when detecting device type while probing.

- Alex

[0] http://www.atmel.com/tools/rzusbstick.aspx
