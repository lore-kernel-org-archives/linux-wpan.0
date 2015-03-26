Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37084 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbCZJGd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 05:06:33 -0400
Received: by wiaa2 with SMTP id a2so12753760wia.0
        for <linux-wpan@vger.kernel.org>; Thu, 26 Mar 2015 02:06:31 -0700 (PDT)
Date: Thu, 26 Mar 2015 10:06:25 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: hardware recommendation
Message-ID: <20150326090622.GA5394@omega>
References: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
 <20150323075818.GA4069@omega>
 <4E57CCC9-A879-457C-9471-9A83BA417CE5@cisco.com>
 <CAFUtXGzGeMmbSNtbP2xdjr6uitzFwPZCb3Yo-GV2+2gV3uz6+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUtXGzGeMmbSNtbP2xdjr6uitzFwPZCb3Yo-GV2+2gV3uz6+w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: "Ralph Droms (rdroms)" <rdroms@cisco.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On Thu, Mar 26, 2015 at 07:44:26AM +0100, Maciej Wasilak wrote:
> Dear Ralph,
> 
> I confirm it's possible to use USB and Ethernet on RaspberryPi with
> bluetooth-next. You have to enable kernel options:
> 
> CONFIG_USB_DWC2_HOST
> CONFIG_USB_DWC2_PLATFORM
>
CONFIG_USB_NET_SMSC95XX

> These options may not be enabled by default in bcm2835 config.
> 

I test it and can confirm that it does do "more" reaction on probing.
I get now:

[    1.822208] usbcore: registered new interface driver smsc95xx
...
[    2.151861] dwc2 20980000.usb: 256 invalid for host_nperio_tx_fifo_size. Check HW configuration.
[    2.160701] dwc2 20980000.usb: 512 invalid for host_perio_tx_fifo_size. Check HW configuration.
[    4.251299] dwc2 20980000.usb: dwc2_core_reset() HANG! Soft Reset GRSTCTL=80000001
[    4.258922] dwc2 20980000.usb: dwc2_core_init(): Reset failed, aborting
[    4.265577] dwc2 20980000.usb: dwc2_hcd_init() FAILED, returning -16
[    4.271977] dwc2: probe of 20980000.usb failed with error -16


Don't know why I get it, I use the current mainline dts files for the RPi.
Maybe somebody can help me here?

Nevetheless I think it's hurts to use an Ethernet PHY which is connected
via USB. Additional I have no good experience with RPi and USB. :-/

- Alex
