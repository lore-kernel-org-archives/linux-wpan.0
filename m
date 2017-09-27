Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58755
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752694AbdI0Ihs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Sep 2017 04:37:48 -0400
Subject: Re: new atusb firmware candidate
References: <CAOHTApjuwS_tsaHzzvsT=LGDTM+8Ekc8=qLLRTqkdSANST20bw@mail.gmail.com>
 <3b39d66c-9ec5-56b1-c612-2bfdf10d6a93@osg.samsung.com>
 <CAOHTApikoARGd19nhX=D2dxh6rrd1OFPvxOtXYdDSA1hw_wuZw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <49acc630-ebc4-974d-243e-4eed5fa65811@osg.samsung.com>
Date: Wed, 27 Sep 2017 10:37:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAOHTApikoARGd19nhX=D2dxh6rrd1OFPvxOtXYdDSA1hw_wuZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello.

On 09/26/2017 02:07 PM, Alexander Aring wrote:
> Hi,
> 
> On Tue, Sep 26, 2017 at 5:26 AM, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>> Hello.
>>
>> On 09/25/2017 03:35 PM, Alexander Aring wrote:
>>> Hi,
>>>
>>> according to qi-hardware irc channel, I got notice about this transceivers [0].
>>> Maybe a new atusb candidate? Or maybe they already use a non-upstream
>>> implementation? :-)
>>
>> Looking at their manual they are focuses on delivering a Arduino compatible solution.
>>
>>> Prices are okay (better than the very expensive one from atmel).
>>
>> Prices are good and they are still available.
>>
>> I had a quick look at their schematics in the user manuals:
>> http://freaklabsstore.com/pub/FREAKUSB-900MHz%20v1.1%20Datasheet.pdf
>> http://freaklabsstore.com/pub/FREAKUSB-2.4GHZ%20v1.1a%20Datasheet.pdf
>>
>> They use the at86rf231 and at86rf212 transceivers (I still hope for a 215 device)
>>
>> The problem I see is that USB is connected to a FTDI usb serial bridge chip instead directly to the Atmel MCU.
>>
>> I have no idea if the FTDI can be swichted into a passthrough mode. If that is the case re-using the existing atusb firmware and USB
>> protocol to the kernel driver should not be to hard for someone interested.
>>
>> If the passthrough is not possible and the whole communication protocol has to go over the serial line that would be significant more work.
>> Adapting the protocol over a serial line, adapting firmware and adapting the kernel driver.
>>
> 
> I see, yes it sounds for me like bring back the serial protocol [0].
> Also bluetooth has a lot of uart connected transceiver... but serial
> over bus protocol is specified by bluetooth...
>
> Next time I need to look deeper into it, just saw MCU and USB
> connector... it's bad that the USB feature is for UART only... I
> lookup the MCU datasheet, the USB doesn't has any USB support. :-(
> 
> Serial protocol driver is of course more work but also another
> possibility to write a Contiki/RIOT/*zephyr* app to use these
> operating systems as a firmware to access transceivers.

Yeah, it basically brings back the old host controller interface (HCI) discussion we had before.

> [0] https://github.com/linux-wpan/ieee802154-serial-protocol-version2/blob/master/ieee802154-serial-protocol-2.md

This could indeed be a good start. If someone wants to work on a generic protocol and mainline serial driver I would be all ears.

regards
Stefan Schmidt
