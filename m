Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:52986
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751065AbdIKLN4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Sep 2017 07:13:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 07BBDA0D4E
        for <linux-wpan@vger.kernel.org>; Mon, 11 Sep 2017 11:14:24 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3m9nbyFormkH for <linux-wpan@vger.kernel.org>;
        Mon, 11 Sep 2017 11:14:23 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id 11C64A0B2A
        for <linux-wpan@vger.kernel.org>; Mon, 11 Sep 2017 11:14:22 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <526ff7aa-6342-4a8e-8278-0d76d897044e@email.android.com>
 <6cb1723a-5cd9-acbc-b4c2-57a74a140367@osg.samsung.com>
 <1650467.HkNtZu56h0@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <ea442c4b-98be-5d97-bee2-f964342960f1@osg.samsung.com>
Date: Mon, 11 Sep 2017 13:13:52 +0200
MIME-Version: 1.0
In-Reply-To: <1650467.HkNtZu56h0@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 09/04/2017 06:22 PM, Josef Filzmaier wrote:
> Hello
> 
>> That worked and I was able to flash the device and bring it up with the
>> patched driver. It showed up correctly as subHGz device in iwpan. I have
>> no other device to test against but I can trust you on this. Please go
>> ahead and send your final patches to the list so we can get them into
>> the firmware and kernel.
> 
> I have used git send-mail to do so. However, i have found a small bug within
> the firmware after i sent the patch. (Caused by moving code between commits)
> What is the procedure if i want to re-submit a patch(set) to the mailing list?

You would re-send the updated patches with a v2 or similar in the 
subject prefix.

> Also, how does the review process work?

I will have a look at your patches again, review the code, run them 
through some scripts and build testing here and give you feedback.
Once I am happy with them I will give you my Acked-By line in a reply 
for the kernel patch and it should get picked up in a git tree and find 
its way to Linus tree from there.

The firmware patch I will take directly into the corresponding git repo. 
And once I do a new release of the frimware I will generate the binaries 
and make sure they are updated in linux-firmware.

>> I only have one odd thing related to the flashing process. The device
>> you got me comes up in LUFA DFU bootloader mode with the green and red
>> led blinking alternately. In this mode I can use the flash command you
>> gave me above. After the flashing it will stay in this mode and I have
>> to issue a
>>
>> dfu-programmer at90usb1287 reset
>>
>> to get into the firmware/application. After that the device enumerates
>> and the atusb driver takes care of it.
>>
>> That would be all fine if it only would be the case for the initial
>> flashing. For me the device always comes up in the bootloader mode,
>> though. I have to issue the reset command (not the flashing) each time I
>> plug it in.
>>
>> Did I miss something here? Any trick to have the device boot the
>> firmware directly and only go into bootloader mode if the program button
>> on the back side is pressed?
> 
> We did apply a custom bootloader here because this is the behaviour we need
> in order to deliver updates.

Oh, that explains it. :) For my use case of testing the driver against 
the hardware I can deal with it. Having a bootloader available to be 
flashed which jumps directly into the firmware might be nice for others 
though.

regards
Stefan Schmidt
