Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58042 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbdHCO0K (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 3 Aug 2017 10:26:10 -0400
Received: from hella-laptop.localnet ([88.117.90.138]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MI4yc-1dg2EY0ZMk-003scR for <linux-wpan@vger.kernel.org>; Thu, 03 Aug 2017
 16:26:08 +0200
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: Re: AT86RF212 based USB-Stick (HUL)
Date: Thu, 03 Aug 2017 16:26:07 +0200
Message-ID: <5179358.aL3rf9WXy9@hella-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

> Does it use the exact same MCU to drive the transceiver?

It uses the AT90USB1287 so yes, they are the same.

> How did you verify that it works nicely? You said there is no USB 
communication going on.

There actually *is* USB communication going on. I can see it when capturing 
usb traffic and also in dmesg. The atusb_{write,read}_{reg,subreg} functions are 
working. I can read out information like part_num, version_num and man_id_x 
perfectly fine.
Setting channel, tx_power, pan_id etc are all working (or at least the 
communication over USB is working fine)

However, i do believe that the firmware is not fully capable of handling the 
incoming USB traffic. I will describe my problem in more detail at the bottom.

> Did you actually change anything in the firmware at all? Keep in mind that 
the firmware also has some parts of the send and receive logic which might need 
adaption for the 212 as well.

The only thing i have done in the firmware is that i have changed the the NAME 
parameter in the makefile to:
NAME = rzusb

> Hmm, 4.9 is a bit older and might miss some fixes from the stack. Any chance 
you could run that with a newer kernel? Its a USB device which could give you 
a way quicker development env on a normal desktop or laptop machine.

For me it is important that it runs on the raspberry pi with linux 4.9, but 
for development using a laptop/desktop could help out a lot that's true. I'm 
already cross compiling that is also helping a lot.
Maybe i will try it with a more recent development version of the kernel soon, 
just to be sure.

> Do you have the link to the code somewhere? Also the dmesg output of the 
atusb driver when inserting the usb stick would be interesting to see.

I have pushed my modified changes to github [1]. 
All i have done is added the part_num of the at86rf212 (7) case to the 
driver's probe function. (With the same calls as in the at86rf230 driver) Also 
i added the missing set_lbt function because i could not set the interface up 
otherwise. After those modifications there were no errors reported when probing 
the driver.

The full dmesg output when inserting the stick can be found here [2].
I also included the output of tshark with usbmon here [3].

*Detailed Problem Description:*

At the end of the dmesg output you can see that the atusb_xmit function is 
called and it seems to be completing. This is the _only_ atusb_xmit function 
call ever. It does only happen one single time, and then it never occurs 
again, even when actively using the network interface*. This is what makes me 
think:
  - Either the problem is higher up in the network stack. I am currently 
investigating this possibility (looking how sockets work in the kernel)
  - Or the problem occurs after the usb_submit_urb() function.

I do not think that this problem is within the firmware, but i might be wrong.

In either case, the transceiver never transmits any rf data over the 
transmission medium.

* I also have tested this with the at86rf212 transceiver connected directly 
via spi and it is working perfectly. i.e. the driver's xmit function is called 
for every network call.

Thanks!

[1] https://github.com/joseffilzmaier/linux/commit/
d0624efcceb8aa0911178f586d9b82dde5471570
[2] https://pastebin.com/HhzWJvea
[3] https://pastebin.com/HYpEK7LR

-- 
Josef Filzmaier
