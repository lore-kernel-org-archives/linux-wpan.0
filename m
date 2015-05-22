Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53162 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114AbbEVNF4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 May 2015 09:05:56 -0400
Message-ID: <555F29B1.4010503@osg.samsung.com>
Date: Fri, 22 May 2015 15:05:53 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: atusb availability
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com> <20150423083052.GA1077@omega> <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
In-Reply-To: <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Geoff Chapman <geoff.chapman@mmbresearch.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 13/05/15 19:24, Geoff Chapman wrote:
> Hi Alex,
> I just wanted to thank-you for your reply, it certainly helped with my
> understanding.  Initially, I thought the device was a HardMAC device,
> so thank-you for correcting me on that.  It seems that the device
> simply implements a USB-to-SPI interface.

Funny enough our first driver for it was actually a fake spi master 
driver which did nothing else but connected to the normal at86rf23x 
driver and transmitted all SPI message over usb to the device. :)

That worked ok-ish but was a performance problem for transmit and 
receive. Thus this part was moved into the firmware. We kept the way of 
setting register for configurations like this though.

> I have used the schematics at [0] to build a few boards of my own.  I
> would like to use the two boards to send data between two laptop
> computers running linux.

Nice, that you used the same schematics and build your boards!

Do you by any chance have the infrastructure to handle a bigger run of 
these? We often get asked about such a device for easy hacking with 
ieee802154 from a laptop or desktop without any SPI connections available.

The run Werner did was around 100 - 120 pieces for atusb IIRC. My best 
guess would be that there could be interest for another 50-100 depending 
on the promotions.

Werner did a great job on documenting the whole design to deliver 
process so most pitfalls should be known and the risk reduced. If you 
stay with the same chips the firmware and factory testing things are 
also ready.

I'm not doing hardware myself so I'm not sure how risky this all could 
be but I see a need for this kind of devices. Especially with good 
plug'n'play support in the mainline kernel this could have potential. 
Still not talking thousands here as it will stay a developer/hacker only 
device.

If you have no time/interest/infrastructure for this but someone else 
has please speak up here. Going a route through indigogo or kickstarter 
might also help to determine the interest to have a better idea who big 
a run should be.
> The description at [1] indicates that the ATMega firmware implements a
> "home-brew protocol on top of USB".  My plan is to do the following:
>
> 1. Examine the source ATUSB firmware source code to determine the
> home-brew protocol.
> 2. Write some application software in C for the two linux PCs using
> Netlink sockets to communicate with the devices and transfer data
> between the two PCs.
>
> I was wondering -- do you think I am on the right track?  Do you have
> any suggestions?

Hmm, you really only want to transmit some data between two linux hosts 
here, right?
In that case you can simply use the now mainline atusb driver and its 
0.2 frimware and tranbsmit your data over the ipv6 sockets we offer with 
6lowpan.

Unless I misunderstood you and you wanted to to something more low level 
with ieee802165 there would be no need for you to hack on the firmware. 
You are welcome to if you want, but I see no need for you right now. :)

regards
Stefan Schmidt
