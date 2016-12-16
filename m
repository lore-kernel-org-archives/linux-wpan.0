Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:41750
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754882AbcLPJ3T (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Dec 2016 04:29:19 -0500
Subject: Re: Flashing firmware onto atusb
References: <20161215094534.sc5awrane6eeud6f@bogon.m.sigxcpu.org>
 <6fb4e9b3-75f7-751c-01df-3e1551a3d619@osg.samsung.com>
 <20161215112529.bkvkhtvj3ufpc6in@bogon.m.sigxcpu.org>
 <2b11ed7b-ba35-e680-086c-818acca21af3@pengutronix.de>
 <87ca723b-ff0d-97db-0817-03930ddfc0ee@osg.samsung.com>
 <530ec350-374b-07fa-7a19-f743b7973932@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <3384ca21-35b9-0e54-7c89-3500ab3bd4ef@osg.samsung.com>
Date: Fri, 16 Dec 2016 10:05:50 +0100
MIME-Version: 1.0
In-Reply-To: <530ec350-374b-07fa-7a19-f743b7973932@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, linux-wpan@vger.kernel.org

Hello.

On 15/12/16 20:24, Alexander Aring wrote:
>
> Hi,
>
> On 12/15/2016 06:57 PM, Stefan Schmidt wrote:
>> Hello.
>>
>> On 15/12/16 12:38, Alexander Aring wrote:
>>>
>>> Hi,
>>>
>>> On 12/15/2016 12:25 PM, Guido Günther wrote:
>>>> Hi Stefan,
>>>>
>>>> On Thu, Dec 15, 2016 at 11:44:53AM +0100, Stefan Schmidt wrote:
>>>>> Hello.
>>>>>
>>>>> On 15/12/16 10:45, Guido Günther wrote:
>>>>>> Hi,
>>>>>> I'm trying to flash firmware onto a new atusb dongle but:
>>>>>
>>>>>
>>>>> Is this one of the dongles from the recent builds or is it an old one?
>>>>> The new ones already come with version 0.3 of the firmware. :-)
>>>>
>>>> ...but I want to be able to flash my own in the future ;)
>>>>
>>>>>
>>>>>>
>>>>>>     # lsusb  | grep Qi
>>>>>>     Bus 001 Device 014: ID 20b7:1540 Qi Hardware ben-wpan, AT86RF230-based
>>>>>>
>>>>>>     # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
>>>>>>     dfu-util 0.9
>>>>>>
>>>>>>     Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
>>>>>>     Copyright 2010-2016 Tormod Volden and Stefan Schmidt
>>>>>>     This program is Free Software and has ABSOLUTELY NO WARRANTY
>>>>>>     Please report bugs to http://sourceforge.net/p/dfu-util/tickets/
>>>>>>
>>>>>>     dfu-util: Invalid DFU suffix signature
>>>>>>     dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
>>>>>>     dfu-util: Device has DFU interface, but has no DFU functional descriptor
>>>>>>     Deducing device DFU version from functional descriptor length
>>>>>>     Opening DFU capable USB device...
>>>>>>     ID 20b7:1540
>>>>>>     Run-time device DFU version 0100
>>>>>>     Claiming USB DFU Runtime Interface...
>>>>>>     Determining device status: state = appIDLE, status = 0
>>>>>>     Device really in Runtime Mode, send DFU detach request...
>>>>>>     Resetting USB...
>>>>>>     dfu-util: Device has DFU interface, but has no DFU functional descriptor
>>>>>>     Deducing device DFU version from functional descriptor length
>>>>>>     dfu-util: Lost device after RESET?
>>>>>>     # echo $?
>>>>>>     74
>>>>>>
>>>>>> dmesg has:
>>>>>>
>>>>>>     # dmesg
>>>>>>     [ 2802.216273] usb 1-1: reset full-speed USB device number 14 using xhci_hcd
>>>>>>     [ 2807.496177] usb 1-1: USB disconnect, device number 14
>>>>>>     [ 2807.760001] usb 1-1: new full-speed USB device number 15 using xhci_hcd
>>>>>>     [ 2807.901993] usb 1-1: New USB device found, idVendor=20b7, idProduct=1540
>>>>>>     [ 2807.901997] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=1
>>>>>>     [ 2807.902000] usb 1-1: SerialNumber: 47303530353015102717
>>>>>>
>>>>>> Is there anything obvious I am missing?
>>>>>
>>>>> Seems you tried to flash the device when already out of the bootloader mode.
>>>>> Please try the above command again when inserting the dongle. The device is
>>>>> in the bootloader, waiting for firmware updates, as long as the red LED is
>>>>> on after insertion.
>>>>
>>>> That worked:
>>>>
>>>>     # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
>>>>     dfu-util 0.9
>>>>
>>>>     Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
>>>>     Copyright 2010-2016 Tormod Volden and Stefan Schmidt
>>>>     This program is Free Software and has ABSOLUTELY NO WARRANTY
>>>>     Please report bugs to http://sourceforge.net/p/dfu-util/tickets/
>>>>
>>>>     Opening DFU capable USB device...
>>>>     ID 20b7:1540
>>>>     Run-time device DFU version 0101
>>>>     Claiming USB DFU Interface...
>>>>     Setting Alternate Setting #0 ...
>>>>     Determining device status: state = dfuDNLOAD-IDLE, status = 8
>>>>     aborting previous incomplete transfer
>>>>     Determining device status: state = dfuIDLE, status = 0
>>>>     dfuIDLE, continuing
>>>>     DFU mode device DFU version 0101
>>>>     Device returned transfer size 64
>>>>     Copying data from PC to DFU device
>>>>     Download    [=========================] 100%         6026 bytes
>>>>     Download done.
>>>>     state(2) = dfuIDLE, status(0) = No error condition is present
>>>>     Done!
>>>>
>>>> I was thinking about s.th. like bootloader mode in the first place but
>>>> this deceived me:
>>>>
>>>>     Device really in Runtime Mode, send DFU detach request...
>>>>     Resetting USB...
>>>>     dfu-util: Device has DFU interface, but has no DFU functional descriptor
>>>>
>>>> so I thought dfu-util would be able to get the device back into
>>>> bootloader mode. And in fact if the device is in runtime mode already I
>>>> do see a device reset (the red led turns back on) but it the fails. Is
>>>> this a bug in dfu-util or expected? If so should it be documented like
>>>> in the attache patch?
>>>
>>> maybe this is actual the difference between dfu-util 0.7 and 0.9...
>>>
>>> I expierenced issues with dfu-util greather than 0.7, can you recheck
>>> with 0.7?
>>
>> I have been using version 0.8 for all flashing of the hundred new devices which have been produced without a single problem when flashing while the device is in the bootloader. On the other hand it never ever worked for me when doing it while the device was already in the firmware. If you are sure that it worked for you before that would be new to me. In that case it would be a regression.
>>
>
> I always flashed with dfu when the device was in firmware. The device
> resets and dfu-util upload the firmware....
>
> mhh, I am not sure if I ever tested it after this patch [0].
>
> It solved for me to use atusb in qemu above 1.6.2 but maybe has other
> side effects.
>
> My expierence with atusb firmware is that I never need to fiddle some
> right timing to call dfu-util while booting. :-/

Interesting that this worked for you while I can't remember it ever 
worked for me. Maybe my old patch to make it work with newer Qemu's did 
indeed break it.

For anybody wanting to dig into this it would indeed be a good starting 
point. As I wrote before, for me its very much at the bottom of my todo 
list.

regards
Stefan Schmidt

