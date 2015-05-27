Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54678 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbbE0NSU (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 May 2015 09:18:20 -0400
Message-ID: <5565C417.70505@osg.samsung.com>
Date: Wed, 27 May 2015 15:18:15 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: atusb availability
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com> <20150423083052.GA1077@omega> <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com> <555F29B1.4010503@osg.samsung.com> <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com> <11929.1432731633@sandelman.ca>
In-Reply-To: <11929.1432731633@sandelman.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>, Geoff Chapman <geoff.chapman@mmbresearch.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 27/05/15 15:00, Michael Richardson wrote:
> Geoff Chapman <geoff.chapman@mmbresearch.com> wrote:
>      > Hi Stefan,
>
>      >> Nice, that you used the same schematics and build your boards!
>
>      >> Do you by any chance have the infrastructure to handle a bigger run of
>      >>these? We often get asked about such a device >for easy hacking with
>      >>ieee802154 from a laptop or desktop without any SPI connections
>      >>available.
>
>      > This is exactly the reason I am interested in the device.  I want to
>      > set up a simple 6LoWPAN network, but do not have any SPI connections.
>
> I also want to be able to speak 15.4 from a laptop system for diagnostics
> and ease-of-coding purposes.  It did take me awhile to figure out that the
> atusb was not a product I could buy... I too would be interested.

Jupp, development convenience really pays off here. Alex is working on 
supporting the Atmel usb dongle as well.

http://www.atmel.com/tools/rzusbstick.aspx

It is very similar to the atusb device and Alex already have it working 
with the atusb firmware and the atusb mainline driver. So this could be 
a device for you. Needs a avr programmer for the firmware writing though.

>
>      >> The run Werner did was around 100 - 120 pieces for atusb IIRC. My best
>      >>guess would be that there could be interest for another 50-100
>      >>depending on the promotions.
>
>      > So-far, we have only built two atusb modules.  We are in the process
>      > of loading the firmware and testing, so I am not sure if the boards
>      > are functional yet.  At this time, we are not set up to produce
>      > numbers in the 50-100 range.   This may change once we successfully
>      > test the boards.
>
> Put it on kickstarter?

Yeah, that could work. Problems is that someone has to run this. 
Production wise but even more logistics and biz wise. I'm not that one, 
sorry.

Given that atusb is open hardware with all schematics, production 
testing software, firmare, etc available a lot more people could do this 
if they are interested.

regards
Stefan Schmidt
