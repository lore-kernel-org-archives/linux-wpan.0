Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from postout2.mail.lrz.de ([129.187.255.138]:47117 "EHLO
        postout2.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdGJL7q (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Jul 2017 07:59:46 -0400
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
 <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega>
 <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega>
 <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega>
 <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
 <20170710094026.4urdv5bovwiztku7@omega>
From: Balz <s.balz@hm.edu>
Message-ID: <2a9f19f9-ce76-7855-0d8a-57c0b93859b7@hm.edu>
Date: Mon, 10 Jul 2017 13:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170710094026.4urdv5bovwiztku7@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

thank you as far.

i do have next Thursday the possibility to get a rpi.
I'am sorry.
yes i'am using it as monitor.
the configuration is :
     sudo iwpan "$wpan" del
     sudo iwpan "$phy" interface add "$wpan" type monitor
     sudo iwpan "$phy" set channel 0 "$channel"
     sudo ifconfig "$wpan" up

with $wpan == wpan0, $phy == phy0 and $channel = 26

So i try to get in touch with Atmel/Micochip and report the result.

Best Regards

Sebastian Balz

Am 10.07.2017 um 11:40 schrieb Alexander Aring:
 > Hi,
 >
 > On Mon, Jul 10, 2017 at 10:39:34AM +0200, Balz wrote:
 >> hi,
 >>
 >> I figured out that you can disable the shadow registers (in the 
regmap dir)
 >> by writing "y" to "cache_bypass" by the command "echo y > 
cache_bypass", ore
 >> by setting the third char to y (in the corresponding line ) in the file
 >> access but this you cannot do in user space.
 >>
 >> I've checked it out that if you write a "y" to "cache_bypass" that 
the drive
 >> reads all defined registers (seen in "range") from the device.
 >> The value of ref 0x0C stays unchanged.
 >>
 >> I would be very grateful if you could use you connections to Atmel.
 >> Of cause you can refer to my proved logic-dump and pcap file in my 
dropbox
 >>
 > tried it, gave up... seems to be everything has changed because
 > microchip & atmel stuff. You could try it...
 >
 > You didn't answered my other question:
 >
 > Do you transmit over monitor interface?
 >
 > Also I don't have such issues with RPi, do you have some RPi around and
 > use _mainline_ Linux kernel. Very important _mainline_.
 >
 > - Alex


