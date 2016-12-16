Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:57134 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758987AbcLPIS3 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 16 Dec 2016 03:18:29 -0500
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Subject: RE: Bluetooth 6lowpan ping6 slab corruption
Date: Fri, 16 Dec 2016 08:18:18 +0000
Message-ID: <E3B98393E6037849B63EA428240A65135BCA89@PGSMSX103.gar.corp.intel.com>
References: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
 <c70d7129-be2d-4764-6f09-1153192c49be@pengutronix.de>
In-Reply-To: <c70d7129-be2d-4764-6f09-1153192c49be@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: "alex.aring@gmail.com" <alex.aring@gmail.com>, "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On 12/16/2016 07:46 AM, Wong, Joshua Weng Onn wrote:
> Hi,
> 
> I have enabled 6lowpan and bluetooth 6lowpan in the kernel configuration on two systems. Both these systems are running linux and one act as a master and another act as a slave.
> I am facing a bug while in a bluetooth 6lowpan connection. This happens during a ping6. The kernel version that I am using is 4.1.27 with BlueZ 5.40 on a x86_64 architecture. The kernel reports regarding slab corruption.
> 
> The steps that I have performed are as follows:
> Slave device:
> $ modprobe 6lowpan
> $ modprobe Bluetooth_6lowpan
> $ echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
> $ hciconfig hci0 leadv
> 
> Master device:
> $ modprobe 6lowpan
> $ modprobe bluetooth_6lowpan
> $ echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
> $ hcitool lescan << to obtain slave BT ADDR $ echo "connect 
> <remote_BT_MAC> 1" > /sys/kernel/debug/bluetooth/6lowpan_control
> $ ifconfig (look for bt0 interface) << to obtain IPv6 address of slave device
> $ ping6 -I bt0 <IPV6_ADDR>     <<<<------ The console message starts to appear here during ping6
> 
> The output of the console message:
> 
> [  794.985623] Slab corruption (Tainted: G     U         ): skbuff_head_cache start=ffff8801f568f700, len=232
> [  795.008755] 050: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  
> ....kkkkkkkkkkkk [  795.029380] Prev obj: start=ffff8801f568f600, 
> len=232 [  795.044743] 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  795.061310] 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  795.076752] Next obj: start=ffff8801f568f800, len=232 [  
> 795.088448] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  
> kkkkkkkkkkkkkkkk [  795.102365] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 
> 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> 
> The 6lowpan connection between the two devices is connected.
> I observed that the console message appears once when the master initiates the connection to the slave and nothing happens after that.
> Once I start doing the ping6 from master to slave, the same message appears again. This same set of message continues to be printed every 5 seconds or so.
> This also persists when ping6 is done from the slave to the master. 
> 
> Do you know what could possibly cause this issue?
> 
> Please let me know if you require further information.
> 

In short:

BTLE 6LoWPAN is broken. Patch-Series which needs some love to fix some issues (mostly races/L2 address handling with L3 stuff, use ndisc stuff, still exists open question which L2 address should be used) exists at [0].

Maybe YOU want to bring it mainline -> I have no time currently to do that.
Of maybe you can test it and tell me your expierence. :-)

If you want still to use the current code, I recommend to disable SMP...
but races still exists. Also update the kernel version to a recent one.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg04124.html

Thank you for informing me about this. Sorry as I was not aware of the newer patches that you submitted to mainline.
At the moment I am not able to upgrade the kernel to a recent version as the other teams in my department are using kernel version 4.1.27 and I have to follow it strictly.

I just got an idea. Perhaps what I can do is backport the patches and apply them to this version of the kernel. I am not sure if it will work entirely. I'll discuss this with my lead first if he wants me to do this and let you know if I am pursuing this.

Best regards,
Joshua
 
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
