Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:36439 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbEZS33 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 14:29:29 -0400
Received: by yhrr66 with SMTP id r66so33145227yhr.3
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 11:29:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555F29B1.4010503@osg.samsung.com>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
	<20150423083052.GA1077@omega>
	<CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
	<555F29B1.4010503@osg.samsung.com>
Date: Tue, 26 May 2015 14:29:28 -0400
Message-ID: <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com>
Subject: Re: atusb availability
From: Geoff Chapman <geoff.chapman@mmbresearch.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Stefan,

>Nice, that you used the same schematics and build your boards!

>Do you by any chance have the infrastructure to handle a bigger run of these? We often get asked about such a device >for easy hacking with ieee802154 from a laptop or desktop without any SPI connections available.

This is exactly the reason I am interested in the device.  I want to
set up a simple 6LoWPAN network, but do not have any SPI connections.

>The run Werner did was around 100 - 120 pieces for atusb IIRC. My best guess would be that there could be interest for >another 50-100 depending on the promotions.

So-far, we have only built two atusb modules.  We are in the process
of loading the firmware and testing, so I am not sure if the boards
are functional yet.  At this time, we are not set up to produce
numbers in the 50-100 range.   This may change once we successfully
test the boards.

>Werner did a great job on documenting the whole design to deliver process so most pitfalls should be known and the risk >reduced. If you stay with the same chips the firmware and factory testing things are also ready.

Yes, Werner's web-site has lots of useful info.  I will report our
status once we complete testing :)

>>Hmm, you really only want to transmit some data between two linux hosts here, right?
Correct.

>In that case you can simply use the now mainline atusb driver and its 0.2 frimware and tranbsmit your data over the >ipv6 sockets we offer with 6lowpan.

>Unless I misunderstood you and you wanted to to something more low level with ieee802165 there would be no need for >you to hack on the firmware. You are welcome to if you want, but I see no need for you right now. :)

Ok that is great info Stephan.  I am not intimately familiar with the
Linux networking stack, so I am not sure exactly how to communicate
with the device.  As you indicated, I assumed I would communicate with
the device via a socket interface. Since I don't really know what kind
of interface is presented by the device, I was thinking that I would
have to dig into the firmware to discover the underlying protocol
needed to control the device.  In other words, once I open a socket, I
am not entirely sure what to do next.   Do you have any suggestions or
references that might help with my understanding?

I hope to be experimenting with the device soon.  When I am
successful, I will share my experiences.

--Geoff
