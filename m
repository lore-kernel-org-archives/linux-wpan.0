Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46131 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbcLOLir (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 15 Dec 2016 06:38:47 -0500
Subject: Re: Flashing firmware onto atusb
References: <20161215094534.sc5awrane6eeud6f@bogon.m.sigxcpu.org>
 <6fb4e9b3-75f7-751c-01df-3e1551a3d619@osg.samsung.com>
 <20161215112529.bkvkhtvj3ufpc6in@bogon.m.sigxcpu.org>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <2b11ed7b-ba35-e680-086c-818acca21af3@pengutronix.de>
Date: Thu, 15 Dec 2016 12:38:44 +0100
MIME-Version: 1.0
In-Reply-To: <20161215112529.bkvkhtvj3ufpc6in@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org


Hi,

On 12/15/2016 12:25 PM, Guido Günther wrote:
> Hi Stefan,
> 
> On Thu, Dec 15, 2016 at 11:44:53AM +0100, Stefan Schmidt wrote:
>> Hello.
>>
>> On 15/12/16 10:45, Guido Günther wrote:
>>> Hi,
>>> I'm trying to flash firmware onto a new atusb dongle but:
>>
>>
>> Is this one of the dongles from the recent builds or is it an old one?
>> The new ones already come with version 0.3 of the firmware. :-)
> 
> ...but I want to be able to flash my own in the future ;)
> 
>>
>>>
>>>     # lsusb  | grep Qi
>>>     Bus 001 Device 014: ID 20b7:1540 Qi Hardware ben-wpan, AT86RF230-based
>>>
>>>     # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
>>>     dfu-util 0.9
>>>
>>>     Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
>>>     Copyright 2010-2016 Tormod Volden and Stefan Schmidt
>>>     This program is Free Software and has ABSOLUTELY NO WARRANTY
>>>     Please report bugs to http://sourceforge.net/p/dfu-util/tickets/
>>>
>>>     dfu-util: Invalid DFU suffix signature
>>>     dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
>>>     dfu-util: Device has DFU interface, but has no DFU functional descriptor
>>>     Deducing device DFU version from functional descriptor length
>>>     Opening DFU capable USB device...
>>>     ID 20b7:1540
>>>     Run-time device DFU version 0100
>>>     Claiming USB DFU Runtime Interface...
>>>     Determining device status: state = appIDLE, status = 0
>>>     Device really in Runtime Mode, send DFU detach request...
>>>     Resetting USB...
>>>     dfu-util: Device has DFU interface, but has no DFU functional descriptor
>>>     Deducing device DFU version from functional descriptor length
>>>     dfu-util: Lost device after RESET?
>>>     # echo $?
>>>     74
>>>
>>> dmesg has:
>>>
>>>     # dmesg
>>>     [ 2802.216273] usb 1-1: reset full-speed USB device number 14 using xhci_hcd
>>>     [ 2807.496177] usb 1-1: USB disconnect, device number 14
>>>     [ 2807.760001] usb 1-1: new full-speed USB device number 15 using xhci_hcd
>>>     [ 2807.901993] usb 1-1: New USB device found, idVendor=20b7, idProduct=1540
>>>     [ 2807.901997] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=1
>>>     [ 2807.902000] usb 1-1: SerialNumber: 47303530353015102717
>>>
>>> Is there anything obvious I am missing?
>>
>> Seems you tried to flash the device when already out of the bootloader mode.
>> Please try the above command again when inserting the dongle. The device is
>> in the bootloader, waiting for firmware updates, as long as the red LED is
>> on after insertion.
> 
> That worked:
> 
>     # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
>     dfu-util 0.9
> 
>     Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
>     Copyright 2010-2016 Tormod Volden and Stefan Schmidt
>     This program is Free Software and has ABSOLUTELY NO WARRANTY
>     Please report bugs to http://sourceforge.net/p/dfu-util/tickets/
> 
>     Opening DFU capable USB device...
>     ID 20b7:1540
>     Run-time device DFU version 0101
>     Claiming USB DFU Interface...
>     Setting Alternate Setting #0 ...
>     Determining device status: state = dfuDNLOAD-IDLE, status = 8
>     aborting previous incomplete transfer
>     Determining device status: state = dfuIDLE, status = 0
>     dfuIDLE, continuing
>     DFU mode device DFU version 0101
>     Device returned transfer size 64
>     Copying data from PC to DFU device
>     Download	[=========================] 100%         6026 bytes
>     Download done.
>     state(2) = dfuIDLE, status(0) = No error condition is present
>     Done!
> 
> I was thinking about s.th. like bootloader mode in the first place but
> this deceived me:
> 
>     Device really in Runtime Mode, send DFU detach request...
>     Resetting USB...
>     dfu-util: Device has DFU interface, but has no DFU functional descriptor
> 
> so I thought dfu-util would be able to get the device back into
> bootloader mode. And in fact if the device is in runtime mode already I
> do see a device reset (the red led turns back on) but it the fails. Is
> this a bug in dfu-util or expected? If so should it be documented like
> in the attache patch?

maybe this is actual the difference between dfu-util 0.7 and 0.9...

I expierenced issues with dfu-util greather than 0.7, can you recheck
with 0.7?

I think there is some timing issue in dfu firmware part of atusb... :-/

- Alex
