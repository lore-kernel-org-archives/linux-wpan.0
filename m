Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53956 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbbE0JG2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 May 2015 05:06:28 -0400
Message-ID: <55658910.70103@osg.samsung.com>
Date: Wed, 27 May 2015 11:06:24 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: atusb availability
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com> <20150423083052.GA1077@omega> <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com> <555F29B1.4010503@osg.samsung.com> <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com>
In-Reply-To: <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Geoff Chapman <geoff.chapman@mmbresearch.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 26/05/15 20:29, Geoff Chapman wrote:
> Hi Stefan,
>
>> Nice, that you used the same schematics and build your boards!
>> Do you by any chance have the infrastructure to handle a bigger run of these? We often get asked about such a device >for easy hacking with ieee802154 from a laptop or desktop without any SPI connections available.
> This is exactly the reason I am interested in the device.  I want to
> set up a simple 6LoWPAN network, but do not have any SPI connections.
>
>> The run Werner did was around 100 - 120 pieces for atusb IIRC. My best guess would be that there could be interest for >another 50-100 depending on the promotions.
> So-far, we have only built two atusb modules.  We are in the process
> of loading the firmware and testing, so I am not sure if the boards
> are functional yet.  At this time, we are not set up to produce
> numbers in the 50-100 range.   This may change once we successfully
> test the boards.

Sure, just wanted to lay out what might make sense. Its really up to you 
if you want or can do this. A small run might not even be worth the 
involved work. Hard to say.

>> Werner did a great job on documenting the whole design to deliver process so most pitfalls should be known and the risk >reduced. If you stay with the same chips the firmware and factory testing things are also ready.
> Yes, Werner's web-site has lots of useful info.  I will report our
> status once we complete testing :)

Cool. Looking forward to it.
>>> Hmm, you really only want to transmit some data between two linux hosts here, right?
> Correct.
>
>> In that case you can simply use the now mainline atusb driver and its 0.2 frimware and tranbsmit your data over the >ipv6 sockets we offer with 6lowpan.
>> Unless I misunderstood you and you wanted to to something more low level with ieee802165 there would be no need for >you to hack on the firmware. You are welcome to if you want, but I see no need for you right now. :)
> Ok that is great info Stephan.  I am not intimately familiar with the
> Linux networking stack, so I am not sure exactly how to communicate
> with the device.  As you indicated, I assumed I would communicate with
> the device via a socket interface.
That is all you really need I think. See below:

>   Since I don't really know what kind
> of interface is presented by the device, I was thinking that I would
> have to dig into the firmware to discover the underlying protocol
> needed to control the device.

Ah, nah. That is what the abstraction should be for. :) The high level 
view on how it works is more like this:

o Application open a IPv6 socket to the address it wants to communicate to.
o This socket is offered by the linix IPv6 stack which uses the 6lowpan 
adaption layer to work with ieee802154
o The ieee802154 kernel stack plus driver (plus atusb fw in your case) 
handles the actual frame sending etc
>    In other words, once I open a socket, I
> am not entirely sure what to do next.   Do you have any suggestions or
> references that might help with my understanding?

If you have two device in the same PAN and with configured ipv6 
addresses (test with ping6 for example) opening the socket is all you 
need to do in your app. After that all normal sendmsg, sendto, recvfrom, 
etc should work like being on normal ipv6. There have been floating 
around some example snippets on the list. Maybe we should have some 
basic examples inside wpan-tools as well.

regards
Stefan Schmidt
