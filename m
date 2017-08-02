Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:55589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbdHBQAr (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 2 Aug 2017 12:00:47 -0400
Received: from hella-laptop.localnet ([194.96.18.223]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MKpQ4-1dcw4k1GeO-0007Ys for <linux-wpan@vger.kernel.org>; Wed, 02 Aug 2017
 18:00:46 +0200
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: AT86RF212 based USB-Stick (HUL)
Date: Wed, 02 Aug 2017 18:00:45 +0200
Message-ID: <1909067.WLLFt4d09f@hella-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello everyone!

Disclaimer: I am new to kernel driver development

I'm trying to get the BUSWARE HUL stick [1] to work using the atusb driver.
I know this is not officially supported, but this stick is very similar to the 
rzusb stick which is stated work experimentally on the linux-wpan website.

I flashed the stick with the atben firmware using dfu-programmer and it seems to 
be working quite nicely.

I'm on Kernel 4.9 lts with arm architecture (raspberry pi b+)

I have modified the atusb driver to support the at86rf212 chip (inspired by the 
at86rf230 driver). It seems to be working just fine. I can configure the stick 
as i like with the iwpan tool, so the configuration over usb seems to be 
working. Also, i can see the wpan0 interface and can create a lowpan interface 
on top of it (as described on the lowpan website).

However, using the lowpan interface has no effect. No data gets sent over USB. 
I am able to capture the traffic using tshark, but the data never arrives at the 
atusb driver's atusb_xmit() function.

My idea currently is to put printk statements within the kernel to detect 
where the data gets lost. I can capture the data with wireshark so i should be 
able to find my calls somewhere in the kernel code.

Do you have any suggestions as to where i should start my debugging adventure? 
I cannot seem to find where a socket call is initiated and how it is propageted 
down to the driver level.

Any help welcome!

[1] http://www.busware.de/tiki-index.php?page=RF212USB

-- 
Josef Filzmaier
