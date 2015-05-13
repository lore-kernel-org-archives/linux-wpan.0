Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33841 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933026AbbEMRYO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 May 2015 13:24:14 -0400
Received: by ykft189 with SMTP id t189so16512046ykf.1
        for <linux-wpan@vger.kernel.org>; Wed, 13 May 2015 10:24:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150423083052.GA1077@omega>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
	<20150423083052.GA1077@omega>
Date: Wed, 13 May 2015 13:24:13 -0400
Message-ID: <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
Subject: Re: atusb availability
From: Geoff Chapman <geoff.chapman@mmbresearch.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Alex,
I just wanted to thank-you for your reply, it certainly helped with my
understanding.  Initially, I thought the device was a HardMAC device,
so thank-you for correcting me on that.  It seems that the device
simply implements a USB-to-SPI interface.

I have used the schematics at [0] to build a few boards of my own.  I
would like to use the two boards to send data between two laptop
computers running linux.
The description at [1] indicates that the ATMega firmware implements a
"home-brew protocol on top of USB".  My plan is to do the following:

1. Examine the source ATUSB firmware source code to determine the
home-brew protocol.
2. Write some application software in C for the two linux PCs using
Netlink sockets to communicate with the devices and transfer data
between the two PCs.

I was wondering -- do you think I am on the right track?  Do you have
any suggestions?

Thank-you kindly for your time.
--Geoff.

[0] http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/
[1] http://downloads.qi-hardware.com/people/werner/wpan/web/

On Thu, Apr 23, 2015 at 4:30 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> I will try to answer a little bit the questions here.
>
> On Tue, Apr 21, 2015 at 11:55:35AM -0400, Geoff Chapman wrote:
>> Hello Mr. Almesberger,
>>
>> My name is Geoff Chapman, and I am working on project to setup a
>> simple 6loWPAN network between two laptops running Linux.  I am very
>> interested in your work on the atusb device detailed at [0], and would
>> like to use the device in my project.  On each laptop, I would like to
>> use one of your atusb devices to implement the 802.15.4 MAC/PHY, while
>> using the 6loWPAN stack in the linux kernel. I picture something like
>> the following setup for each laptop:
>>
>>
>> Linux Laptop:
>>
>>         | Application Layer |
>>                        |
>>                 socket API
>>                        |
>>         |  6LoWPAN stack |
>>                        |
>>                        |
>>                        <-----------------USB---------------> atusb
>> device implementing 802.15.4 MAC/PHY (ATMega32U2 + at86rf233)
>>
>
> So you want a HardMAC driver here. That's not how atusb works currently.
> The atusb transceiver is a SoftMAC transceiver with _little_ mac
> functionality, this contains checks on dsn/bsn to do some correct
> frame deliviery in the firmware to the usb host, if I remember
> correctly. I think you know that and you want to put full MAC functionality
> into the atusb firmware.
>
> We don't have currently any HardMAC drivers mainline, but the idea is to
> handle the HardMAC transceivers like wireless, so with the existing
> architecture we have a possibility to access HardMAC transceivers and
> write HardMAC drivers. But we don't have a HardMAC driver currently and
> I think you need to making some movements from SoftMAC layer (net/mac802154)
> to cfg802154/netlink (net/ieee802154) layer, or you have workarounds for
> that in your driver layer. I would say for HardMAC drivers go ahead and
> try to implement your stuff and orient you at existing wireless HardMAC
> drivers and simple don't use any functionality from (net/mac802154)
> directory.
>
>
> Another thing is that I don't believe that ATMega32U2 can full store a compliant
> 802.15.4 stack (maybe depends on your use case), because the ATMega32U2 has 32
> KB flash memory. Maybe I am wrong here, if you think you can do that
> then I would give it a try.
>
>
> Another solution would maybe the RZRAVENUSBSTICK [2] which contains and
> AT90USB1287 with at86rf230. In my opinion it's the same like atusb but atusb
> contains an easier to use 802.15.4 transceiver, smaller mcu (bigger one is not
> necessary here), and of course the case is smaller, etc. The AT90USB1287 has a
> 128 KB flash memory. Schematics of RZRAVENUSBSTICK can be found at [3].
>
>>
>> I have tried purchasing two atusb devices at [1] without any luck, as
>> they no longer sell the devices.
>> I have two questions:
>>
>> 1. Do you have any atusb devices available for purchase?
>> 2. If you have none for purchase, do you have the schematics available
>> that I can use to wire-up my own atusb device?  The schematic link on
>> your site [2] seems to be broken.
>>
>
> The schematics for atusb can be found at the ben-wpan repository [0],
> which also includes the firmware, etc., but this requires the great tool
> kicad [1] and _maybe_ some additional libs for electronic components.
>
> - Alex
>
> [0] http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/
> [1] http://www.kicad-pcb.org/display/KICAD/KiCad+EDA+Software+Suite
> [2] http://www.atmel.com/tools/rzusbstick.aspx
> [3] http://www.atmel.com/Images/doc8117.pdf page 22
