Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:43379 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbbFKNjJ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Jun 2015 09:39:09 -0400
Message-ID: <55798F76.8020708@osg.samsung.com>
Date: Thu, 11 Jun 2015 15:39:02 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: Strategy for permament extended/EUI64 address writing and updating
 in atusb
References: <55782D54.2030508@osg.samsung.com> <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org> <20150610152925.GD6647@omega> <20150610212351.GS5054@ws> <20150611081745.GB972@omega> <CB3536CD-EEC2-48C8-8C52-212B3A6BDEC3@holtmann.org> <55795759.8060306@osg.samsung.com> <20150611124816.GT5054@ws>
In-Reply-To: <20150611124816.GT5054@ws>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Werner Almesberger <werner@almesberger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Hello.

On 11/06/15 14:48, Werner Almesberger wrote:
> Stefan Schmidt wrote:
>> 2) The firmware can issue a MCU reset after the address was written
>> which would force a USB reset and re-enumerate.
> Or just copy EEPROM content to RAM on application start ("reset")
> and on USB bus reset, and make the application that writes the
> EEPROM do a USB bus reset.
Which means we would not write the content from RAM to EEPROM if we pull 
the device out of the pc without doing a usb reset before? How would 
that be more safe compared to what I proposed above?

> That way, the address won't change while the device is in active
> use, no matter how often you write to the EEPROM. And a USB bus
> reset is supposed to reset the whole dependency chain anyway, so
> that should be a safe moment for propagating the address change.

Hmm, I really have a hard time to the the benefit here. Maybe I miss 
some use cases you folks see and I don't.
I see the following:
o Device is connected and the atusb driver is loaded and driving the device.
    o It read the EUI64 from EEPROM during probe and is no further 
touching it at all
    o We write a new EUI64 with a host utility behind the back of the atusb.
    o Its not mapped or anything so the driver will keep working fine 
with the EUI64 it got during probe.
    o Furthermore, after the EEPROM write a mcu_reset() done to 
re-enumerate on the USB bus
    o The atusb driver sees the device going away and tears itself down
    o The device appears again on the bus, atusb gets called and probes 
the device to find the newly written address.
    o Done
o The device is connected but no atusb driver is loaded or accessing the 
device
    o The problem does not exist at all and one can update the EUI64 
without problems.

What do I miss that makes this more problematic?

I have to say that this simple task which I started for my pure 
convenience (and the maybe handful of atusb users) turns out to get 
something way bigger.

> Oh, and for completeness, a plan B could be to attach the address
> to the application binary (so you read it from Flash, not EEPROM).
> Then you could use DFU. But you'd be trading one can of worms for
> another one.
Which would mean each user would have to make sure the firmware gets 
modified before flashing and flashed to the right device for _every_ fw 
update. Not compelling at all if you ask me. We have an EEPROM available 
to store such device properties so we better use it.

regards
Stefan Schmidt
