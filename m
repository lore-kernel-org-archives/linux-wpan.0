Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:55033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753847AbdIDQWr (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 4 Sep 2017 12:22:47 -0400
Received: from hella-laptop.localnet ([178.191.192.168]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MEbYb-1dhy8K1fVR-00FnGo for <linux-wpan@vger.kernel.org>; Mon, 04 Sep 2017
 18:22:45 +0200
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Date: Mon, 04 Sep 2017 18:22:44 +0200
Message-ID: <1650467.HkNtZu56h0@hella-laptop>
In-Reply-To: <6cb1723a-5cd9-acbc-b4c2-57a74a140367@osg.samsung.com>
References: <526ff7aa-6342-4a8e-8278-0d76d897044e@email.android.com> <6cb1723a-5cd9-acbc-b4c2-57a74a140367@osg.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello

> That worked and I was able to flash the device and bring it up with the 
> patched driver. It showed up correctly as subHGz device in iwpan. I have 
> no other device to test against but I can trust you on this. Please go 
> ahead and send your final patches to the list so we can get them into 
> the firmware and kernel.

I have used git send-mail to do so. However, i have found a small bug within
the firmware after i sent the patch. (Caused by moving code between commits)
What is the procedure if i want to re-submit a patch(set) to the mailing list?

Also, how does the review process work?

> I only have one odd thing related to the flashing process. The device 
> you got me comes up in LUFA DFU bootloader mode with the green and red 
> led blinking alternately. In this mode I can use the flash command you 
> gave me above. After the flashing it will stay in this mode and I have 
> to issue a
> 
> dfu-programmer at90usb1287 reset
> 
> to get into the firmware/application. After that the device enumerates 
> and the atusb driver takes care of it.
> 
> That would be all fine if it only would be the case for the initial 
> flashing. For me the device always comes up in the bootloader mode, 
> though. I have to issue the reset command (not the flashing) each time I 
> plug it in.
> 
> Did I miss something here? Any trick to have the device boot the 
> firmware directly and only go into bootloader mode if the program button 
> on the back side is pressed?

We did apply a custom bootloader here because this is the behaviour we need
in order to deliver updates.

Greetings,
Josef


-- 
Josef Filzmaier
