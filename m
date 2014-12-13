Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:52721 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966214AbaLMIzr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 13 Dec 2014 03:55:47 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so10855428wgg.39
        for <linux-wpan@vger.kernel.org>; Sat, 13 Dec 2014 00:55:45 -0800 (PST)
Date: Sat, 13 Dec 2014 09:55:39 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141213085537.GA31962@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega>
 <20141207171903.GC9532@omega>
 <5484C900.2020402@fid4.com>
 <20141207215452.GB20260@omega>
 <5489B215.20707@fid4.com>
 <243b01d015e9$45bfdef0$d13f9cd0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <243b01d015e9$45bfdef0$d13f9cd0$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: "'Michael C. Cambria'" <mcc@fid4.com>, linux-wpan@vger.kernel.org

Stefan,

On Fri, Dec 12, 2014 at 08:54:43AM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 11/12/14 16:02, Michael C. Cambria wrote:
> >
> >On 12/07/2014 04:54 PM, Alexander Aring wrote:
> >>
> >>ok. Read introductions at [0]. Begin at "Bring up 6LoWPAN" section.
> >>For the at86rf230 you should have default a wpan0 interface. If you
> >>use wpan-tools simple type "iwpan" and read the help for setting
> >>address information. I think for at86rf230 you need to set the panid
> >>only, phy settings should be transceiver defaults and short address
> >>isn't supported for 6LoWPAN (except broadcast address, of course). The
> >>documentation is a little bit outdated currently.
> >[deleted]
> >>
> >>If you need help simple ask here or for better fast live supporting
> >>you can contact me via IRC #linux-wpan on irc.freenode.net. Ping
> >>between two nodes should be an easy setup. - Alex [0]
> >>http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
> >>
> >>-- To unsubscribe from this list: send the line "unsubscribe
> >>linux-wpan" in the body of a message to majordomo@vger.kernel.org More
> >>majordomo info at http://vger.kernel.org/majordomo-info.html
> >
> >I'm using bluetooth-next, and it boots and seems to find the openlabs.co
> >adapter just fine.
> 
> Thanks for mentioning this adapter. I was looking for something like this
> for a while. Just ordered. :)
> 
> Anyone has some tips about cheap but easy to use sensor nodes with contiki
> and maybe TinyOS support? I don't care about senors or such on them at all.
> My use case would be testing the communication interop between the Linux
> stack and contiki or other embedded OS's.
> 

Maybe again the avr raven are something for you. I don't use the shipped
sensors, but you can connect them to some power supply (don't know which
voltage, but need to solder some pinouts).

My idea is now, you have these sensor node (don't know if they are good
to use) and the USB Stick. The RAVEN USB stick works like atusb but with
a bigger mcu (more ram etc...) maybe you get this wireless kit and I
think you could easy port the atusb firmware to this raven usb stick,
just an idea. With dfu (I know you already an expert in dfu and the
ported atusb firmware (maybe with tweaks because it contains a bigger
mcu).

Just an idea, I have one of the avr raven usb stick and they are much
common as the atusb stick.

For me the idea to have an atusb firmware for the avr raven usb stick
sounds great. Maybe you will start the project "Most used open source
firmware for 802.15.4 USB dongles". ;-)

- Alex

[0] http://store.atmel.com/PartDetail.aspx?q=p:10500059#tc:description
