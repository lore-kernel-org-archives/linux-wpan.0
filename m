Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58717
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751211AbdHCPuw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Aug 2017 11:50:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id EC897A0D4E
        for <linux-wpan@vger.kernel.org>; Thu,  3 Aug 2017 15:51:19 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9PJKy-52hzsw for <linux-wpan@vger.kernel.org>;
        Thu,  3 Aug 2017 15:51:19 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79E7F.dip0.t-ipconnect.de [217.247.158.127])
        by osg.samsung.com (Postfix) with ESMTPSA id ACA72A05EE
        for <linux-wpan@vger.kernel.org>; Thu,  3 Aug 2017 15:51:18 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <5179358.aL3rf9WXy9@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <71bd7b82-4e76-b129-c459-7bed5cba8fb0@osg.samsung.com>
Date: Thu, 3 Aug 2017 17:50:46 +0200
MIME-Version: 1.0
In-Reply-To: <5179358.aL3rf9WXy9@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/03/2017 04:26 PM, Josef Filzmaier wrote:
>> Does it use the exact same MCU to drive the transceiver?
> 
> It uses the AT90USB1287 so yes, they are the same.

Great. That means we can indeed use the rzusb board logic from the 
firmware to setup USB and SPI, etc on the MCU side.
> 
>> How did you verify that it works nicely? You said there is no USB
> communication going on.
> 
> There actually *is* USB communication going on. I can see it when capturing
> usb traffic and also in dmesg. The atusb_{write,read}_{reg,subreg} functions are
> working. I can read out information like part_num, version_num and man_id_x
> perfectly fine.
> Setting channel, tx_power, pan_id etc are all working (or at least the
> communication over USB is working fine)

I have to say this is way better than I expected. :) Being able to read 
out registers and have the basic USB communication working is already a 
good step in the right direction.

> However, i do believe that the firmware is not fully capable of handling the
> incoming USB traffic. I will describe my problem in more detail at the bottom.
> 
>> Did you actually change anything in the firmware at all? Keep in mind that
> the firmware also has some parts of the send and receive logic which might need
> adaption for the 212 as well.
> 
> The only thing i have done in the firmware is that i have changed the the NAME
> parameter in the makefile to:
> NAME = rzusb

Based on this name we set the atmel MCU but we also set the transceiver 
right now. So far we only had two boards which made it easier to just do 
both in one step.

If you look at the tiny mac part of the firmware you will see that we 
adjust teh state handling based on the transceiver. I haven't checked 
but I think at least that parts needs to be adapted as the 212 and 230 
will be different for for the state handling (also see Alex's reply on this)

http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/atusb/fw/mac.c

>> Hmm, 4.9 is a bit older and might miss some fixes from the stack. Any chance
> you could run that with a newer kernel? Its a USB device which could give you
> a way quicker development env on a normal desktop or laptop machine.
> 
> For me it is important that it runs on the raspberry pi with linux 4.9, but
> for development using a laptop/desktop could help out a lot that's true. I'm
> already cross compiling that is also helping a lot.
> Maybe i will try it with a more recent development version of the kernel soon,
> just to be sure.

Sure, I understand that your final goal is the pi with this specific 
version. It just might be easier for you to have the development on a 
different system until its working and you can worry about backporting 
and deployment.

>> Do you have the link to the code somewhere? Also the dmesg output of the
> atusb driver when inserting the usb stick would be interesting to see.
> 
> I have pushed my modified changes to github [1].
> All i have done is added the part_num of the at86rf212 (7) case to the
> driver's probe function. (With the same calls as in the at86rf230 driver) Also
> i added the missing set_lbt function because i could not set the interface up
> otherwise. After those modifications there were no errors reported when probing
> the driver.

Its impressive that it needs so litle code to get some basic stuff 
working :) I'm looking forward to get this into shape and into mailine 
once it is all working.

Is there any source where I still would be able to buy/get one of these 
devices from? The main link indicates they are no longer available. I 
would love to add one to my collection. At the minimum to make sure I do 
not break it when I do a new firmware or driver updates.

> The full dmesg output when inserting the stick can be found here [2].
> I also included the output of tshark with usbmon here [3].

Thanks for the links. I will go through them over the next days. I bit 
busy right now. I wanted to get you at least the info in here to help 
you dig deeper. I hope to come to it over the next days and give you 
some more comments.

> *Detailed Problem Description:*
> 
> At the end of the dmesg output you can see that the atusb_xmit function is
> called and it seems to be completing. This is the _only_ atusb_xmit function
> call ever. It does only happen one single time, and then it never occurs
> again, even when actively using the network interface*. This is what makes me
> think:
>    - Either the problem is higher up in the network stack. I am currently
> investigating this possibility (looking how sockets work in the kernel)
>    - Or the problem occurs after the usb_submit_urb() function.

My guess here is that the first calls hits the firmware at due to the 
different state handling of 230 we use to drive the 212 the hardware and 
the fw/driver are no longer in sync and things break down. Its a guess 
only but one that should be followed at least.

> I do not think that this problem is within the firmware, but i might be wrong.

I think its a combination of fw and driver, but I might be wrong as well.

> In either case, the transceiver never transmits any rf data over the
> transmission medium.
> 
> * I also have tested this with the at86rf212 transceiver connected directly
> via spi and it is working perfectly. i.e. the driver's xmit function is called
> for every network call.

Good to know. Interesting that you prefer to use a usb dongle on the pi 
instead of a transceiver hooked up over SPI.

regards
Stefan Schmidt
