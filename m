Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35440 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaLOIf2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:35:28 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so8060405wiw.1
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 00:35:26 -0800 (PST)
Date: Mon, 15 Dec 2014 09:35:21 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141215083519.GA7153@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega>
 <20141207171903.GC9532@omega>
 <5484C900.2020402@fid4.com>
 <20141207215452.GB20260@omega>
 <5489B215.20707@fid4.com>
 <243b01d015e9$45bfdef0$d13f9cd0$@samsung.com>
 <20141213085537.GA31962@omega>
 <250601d01841$3a514590$aef3d0b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <250601d01841$3a514590$aef3d0b0$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: "'Michael C. Cambria'" <mcc@fid4.com>, linux-wpan@vger.kernel.org

On Mon, Dec 15, 2014 at 08:29:21AM +0000, Stefan Schmidt wrote:
> >My idea is now, you have these sensor node (don't know if they are good
> >to use) and the USB Stick. The RAVEN USB stick works like atusb but with
> >a bigger mcu (more ram etc...) maybe you get this wireless kit and I
> >think you could easy port the atusb firmware to this raven usb stick,
> >just an idea. With dfu (I know you already an expert in dfu and the
> >ported atusb firmware (maybe with tweaks because it contains a bigger
> >mcu).
> >
> >Just an idea, I have one of the avr raven usb stick and they are much
> >common as the atusb stick.
> >
> >For me the idea to have an atusb firmware for the avr raven usb stick
> >sounds great. Maybe you will start the project "Most used open source
> >firmware for 802.15.4 USB dongles". ;-)
> 
> The idea is interesting but for now I would like to focus on the Linux side
> of things. Firmware hacking is not at the top of my list. :)
> 

oh, I can help you with firmware hacking. Just we both have atusb and
avr raven sticks. But too many things need to be done.

I think with the avr raven sticks we get an huge increment of users for
this stack.

Okay here's the deal:

I wait until you finished the atusb firmware hacking, then I will check
how possible it is to port the atusb to the raven stick. Maybe I can
comibine it with some course at my university so I have _really_ time
for it.

I could try it to market it as "master project", but seems that is not
science enough. (And I would be fast done with that.)

- Alex
