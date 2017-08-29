Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:33651
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750779AbdH2HbB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Aug 2017 03:31:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 06390A0D4F
        for <linux-wpan@vger.kernel.org>; Tue, 29 Aug 2017 07:31:29 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dtvKOHJ67SQo for <linux-wpan@vger.kernel.org>;
        Tue, 29 Aug 2017 07:31:28 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id CAB24A06C2
        for <linux-wpan@vger.kernel.org>; Tue, 29 Aug 2017 07:31:27 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <526ff7aa-6342-4a8e-8278-0d76d897044e@email.android.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <6cb1723a-5cd9-acbc-b4c2-57a74a140367@osg.samsung.com>
Date: Tue, 29 Aug 2017 09:30:56 +0200
MIME-Version: 1.0
In-Reply-To: <526ff7aa-6342-4a8e-8278-0d76d897044e@email.android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/26/2017 11:44 PM, Josef Filzmaier wrote:
>     No problems spotted so far. Good job! :)
> 
> Very good :) I am currently on vacation but will be available again late 
> next week. I will then update my patches. Where can i find the net-next 
> repository?

I meant bluetooth-next here. Sorry for giving the wrong name. The repo 
can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/

> 
>     It arrived, thanks a lot. How would I go about flashing it? I build the
>     firmware already but I'm a bit unsure how the flashing would go. Do I
>     need JTAG or SPI or can it be done with the Atmel DFU variant (I think
>     the tool is called dfu-programmer)?
> 
>     What would be the commandline for the flashing? Would be nice if we
>     could document that for others.
> 
> I used the following commands which worked for me:

Thanks.

> 
> avr-objcopy -O ihex -R .signature -R .fuse -R .eeprom hulusb.elf hulusb.hex

We should integrate that into the Makefile when building for hulusb.

> dfu-programmer at90usb1287 flash hulusb.hex

That worked and I was able to flash the device and bring it up with the 
patched driver. It showed up correctly as subHGz device in iwpan. I have 
no other device to test against but I can trust you on this. Please go 
ahead and send your final patches to the list so we can get them into 
the firmware and kernel.

I only have one odd thing related to the flashing process. The device 
you got me comes up in LUFA DFU bootloader mode with the green and red 
led blinking alternately. In this mode I can use the flash command you 
gave me above. After the flashing it will stay in this mode and I have 
to issue a

dfu-programmer at90usb1287 reset

to get into the firmware/application. After that the device enumerates 
and the atusb driver takes care of it.

That would be all fine if it only would be the case for the initial 
flashing. For me the device always comes up in the bootloader mode, 
though. I have to issue the reset command (not the flashing) each time I 
plug it in.

Did I miss something here? Any trick to have the device boot the 
firmware directly and only go into bootloader mode if the program button 
on the back side is pressed?

regards
Stefan Schmidt
