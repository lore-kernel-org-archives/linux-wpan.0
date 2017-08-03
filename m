Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:57036
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750937AbdHCG7U (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Aug 2017 02:59:20 -0400
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <1909067.WLLFt4d09f@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <29a009df-433e-2855-dc44-5e81d1a7a3d6@osg.samsung.com>
Date: Thu, 3 Aug 2017 08:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <1909067.WLLFt4d09f@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Josef Filzmaier <j.filzmaier@gmx.at>, linux-wpan@vger.kernel.org

Hello.

On 08/02/2017 06:00 PM, Josef Filzmaier wrote:
> Hello everyone!
> 
> Disclaimer: I am new to kernel driver development
> 
> I'm trying to get the BUSWARE HUL stick [1] to work using the atusb driver.

Interesting. First time I see this device. Pity its now longr available. 
It would be nice to play around with the RF212 version of the atmel chips.

> I know this is not officially supported, but this stick is very similar to the
> rzusb stick which is stated work experimentally on the linux-wpan website.

Does it use the exact same MCU to drive the transceiver?

> I flashed the stick with the atben firmware using dfu-programmer and it seems to
> be working quite nicely.

How did you verify that it works nicely? You said there is no USB 
communication going on.

Did you actually change anything in the firmware at all? Keep in mind 
that the firmware also has some parts of the send and receive logic 
which might need adaption for the 212 as well.

> I'm on Kernel 4.9 lts with arm architecture (raspberry pi b+)

Hmm, 4.9 is a bit older and might miss some fixes from the stack. Any 
chance you could run that with a newer kernel? Its a USB device which 
could give you a way quicker development env on a normal desktop or 
laptop machine.

> I have modified the atusb driver to support the at86rf212 chip (inspired by the
> at86rf230 driver). It seems to be working just fine.

Do you have the link to the code somewhere? Also the dmesg output of the 
atusb driver when inserting the usb stick would be interesting to see.

  I can configure the stick
> as i like with the iwpan tool, so the configuration over usb seems to be
> working. Also, i can see the wpan0 interface and can create a lowpan interface
> on top of it (as described on the lowpan website).

This mostly depends on how you changed the atusb driver code. Its the 
driver who sets up the device and that makes it visible to the userspace 
tools.

> However, using the lowpan interface has no effect. No data gets sent over USB.
> I am able to capture the traffic using tshark, but the data never arrives at the
> atusb driver's atusb_xmit() function.
> 
> My idea currently is to put printk statements within the kernel to detect
> where the data gets lost. I can capture the data with wireshark so i should be
> able to find my calls somewhere in the kernel code.
> 
> Do you have any suggestions as to where i should start my debugging adventure?
> I cannot seem to find where a socket call is initiated and how it is propageted
> down to the driver level.

To be honest I would first want to verify that your communication 
between the atusb driver and the firmware is actually working correctly.

If you flashed a unmodified rzusb firmware on the device you would have 
to be very lucky that everything would just work out of the box. If this 
design uses the same MCU  it would help a lot (please confirm) but the 
state handling of the rx/tx logic inside the firmware might still be 
slightly different for the 212 compared top the 230/231. The actual 212 
kernel driver might give some hints about that. I do not know off hand.

regards
Stefan Schmidt
