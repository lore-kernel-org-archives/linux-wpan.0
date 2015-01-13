Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57240 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbbAMKgh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Jan 2015 05:36:37 -0500
Received: by mail-wg0-f44.google.com with SMTP id y19so2072897wgg.3
        for <linux-wpan@vger.kernel.org>; Tue, 13 Jan 2015 02:36:36 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 13 Jan 2015 16:06:35 +0530
Message-ID: <CAAkG1NMMQ_tXj-1zvJTSxvb8GVrYSSPkT8_vWd8BLqCZTy8N1Q@mail.gmail.com>
Subject: AT86RF230 IRQ flags mismatch with the bcm2708_spi driver
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi everyone,

I'm trying to connect the at86rf212b to a raspberry pi model b+ using
SPI. I'm using the raspberry kernel 3.18.1 from here. (My working
snapshot is from a couple weeks ago)

To start with, I had trouble registering the at86rf212b device. I did
a bit of troubleshooting and found that the at86rf230 driver and the
bcm2708_spi driver do not use the same flags when getting the IRQ
(IRQ_SPI / 80) and hence the driver would fail loading with the
"genirq: Flags mismatch" error. I "fixed" this by changing the
bcm2708_spi driver to also use IRQF_SHARED and IRQF_TRIGGER_RISING
flags that the at86rf230 driver uses when requesting the IRQ_SPI. This
causes the device to be successfully registered and the new phy shows
up with "iz list". Even "iz add" seems to work well!

Any attempt to query the newly registered wpan device after this step
just hangs the kernel. Even a simple "ifconfig" gets stuck forever.
I'm guessing that my changes to the bcm2708_spi driver are incorrect
and hence the hung kernel. But I'm way out of my comfort zone here and
I'd appreciate any help on how to proceed here.

Btw, I tried using the wpan-tools instead of the linux-zigbee tools. I
have been able to build the tools but trying to run any "iwpan cmd"
only prints "nl802154 not found". Again, I'm only guessing that this
has to do with me running raspberry pi's kernel instead of the
recommended net-next kernel. Right now I don't care much about this as
long as the linux-zigbee tools can get me started.

Thanks,
Rohit
