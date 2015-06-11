Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:43009 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbbFKJjm (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Jun 2015 05:39:42 -0400
Message-ID: <55795759.8060306@osg.samsung.com>
Date: Thu, 11 Jun 2015 11:39:37 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: Strategy for permament extended/EUI64 address writing and updating
 in atusb
References: <55782D54.2030508@osg.samsung.com> <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org> <20150610152925.GD6647@omega> <20150610212351.GS5054@ws> <20150611081745.GB972@omega> <CB3536CD-EEC2-48C8-8C52-212B3A6BDEC3@holtmann.org>
In-Reply-To: <CB3536CD-EEC2-48C8-8C52-212B3A6BDEC3@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, Alexander Aring <alex.aring@gmail.com>
Cc: Werner Almesberger <werner@almesberger.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Hello.

I'm surprised how much interest this sparked. :)

Let's try to sum things up here from my view. See below.

On 11/06/15 10:23, Marcel Holtmann wrote:
> Hi Alex,
>
>>>> I think the endpoint 0 is different between bootloader (dfu) and the
>>>> application (atusb). Maybe then add this functionality for the
>>>> bootloader only.
>>> If you add it to the boot loader, then you need to flash your
>>> enhanced boot loader via in-circuit programming (or find a way
>>> to bypass the write protection. NB: no such way should exist.)
>>> Not everyone may find that convenient ;)
>>>
>>> I'd leave the boot loader as it is and just add a new operation
>>> to the application part of the firmware.
>>>
>> yea, this was just an idea because Marcel said:
>>
>> "... you might want to push that device into a special mode to allow
>> programming of these settings"
>>
>> and that's for me the dfu mode. My idea was just make the "new
>> operation" accessable in dfu endpoint only.
>>
>> Nevertheless I am also fine with normal application operation, or making
>> some special bus access cycles to get into "privileged mode" or
>> something else, everything is possible.
> I would not do that at runtime mode unless you have an easy way to re-enmuerate that device. Reason is that changing settings like the address should be only be done when the device is in a special mode.
>
> So at minimum that needs to be when the device is powered off or something. And if you change the address it re-enumerates again so that userspace can know that the address has changed.
>
> For a permanent address, that is normally done in a special mode when you provision it. Be that DFU mode or some other mode you push the device into.
>

Lets quickly handle the kernel driver side as this is easier and people 
should be able to agree on.

As a summary for the kernel driver side this is what I want it to be:
o During probe we check if the firmware version is 0.3 (not released but 
should contain this feature)
o If fw is to old we use a random address
o If the fw is new enough we read the address from EEPROM
o If the address is != 00:00:00:00:00:00:00:00 and a valid EUI64 we use 
that one, if not fall back to random
o No write access what so ever is going through the driver (no sysfs, etc)


Coming back to the fw side now. I agree that the best point in time for 
writing this information is when you provision it. In the case of ATUSB 
this happened when the bootloader got flashed. This happens with a avr 
programmer I don't have (like almost all users of the current ATUSB 
devices). The bootloader is not much more besides a steppi9ng stone to 
offer DFU functionality and executing an application which in our case 
is the real firmware for ATUSB. While I can change bootloader as well as 
application code I can only flash the later one.

Which means I need to implement the EUI64 writing to EEPROM solution 
over an interface that is available when the application runs, normal 
runtime. I see two things I can offer to make you a bit more comfortable 
with this.
1) The host utility which changes the address can try to detach the 
kernel driver over libusb
2) The firmware can issue a MCU reset after the address was written 
which would force a USB reset and re-enumerate.

How does that sound to you?

The perfect solution would be to have this done during 
production/provisioning or at least as part of the bootloader. I don't 
think this is feasible for the current ATUSB devices out there but if 
there will ever be another production run of them we should try to 
handle it that way.

regards
Stefan Schmidt
