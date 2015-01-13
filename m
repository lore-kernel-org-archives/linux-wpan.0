Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:23005 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbAMK7C (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Jan 2015 05:59:02 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NI400763417MO40@mailout1.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Tue, 13 Jan 2015 11:03:07 +0000 (GMT)
Received: from vwssch ([106.210.244.197])
 by eusync3.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0NI400BVQ3TOMU60@eusync3.samsung.com> for
 linux-wpan@vger.kernel.org; Tue, 13 Jan 2015 10:58:59 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <CAAkG1NMMQ_tXj-1zvJTSxvb8GVrYSSPkT8_vWd8BLqCZTy8N1Q@mail.gmail.com>
In-reply-to: <CAAkG1NMMQ_tXj-1zvJTSxvb8GVrYSSPkT8_vWd8BLqCZTy8N1Q@mail.gmail.com>
Subject: Re: AT86RF230 IRQ flags mismatch with the bcm2708_spi driver
Date: Tue, 13 Jan 2015 10:58:37 +0000
Message-id: <06bb01d02f1f$e250eb70$a6f2c250$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=utf-8
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 13/01/15 11:36, Rohit Kulkarni wrote:
> Hi everyone,
>
> I'm trying to connect the at86rf212b to a raspberry pi model b+ using
> SPI. I'm using the raspberry kernel 3.18.1 from here. (My working
> snapshot is from a couple weeks ago)

Do you have special requirements to use the raspberry pi kernel? The 
mainline kernel should support the basic functionality and it would be 
easier to get help from kernel community.

> To start with, I had trouble registering the at86rf212b device. I did
> a bit of troubleshooting and found that the at86rf230 driver and the
> bcm2708_spi driver do not use the same flags when getting the IRQ
> (IRQ_SPI / 80) and hence the driver would fail loading with the
> "genirq: Flags mismatch" error. I "fixed" this by changing the
> bcm2708_spi driver to also use IRQF_SHARED and IRQF_TRIGGER_RISING
> flags that the at86rf230 driver uses when requesting the IRQ_SPI. This
> causes the device to be successfully registered and the new phy shows
> up with "iz list". Even "iz add" seems to work well!
>
> Any attempt to query the newly registered wpan device after this step
> just hangs the kernel. Even a simple "ifconfig" gets stuck forever.
> I'm guessing that my changes to the bcm2708_spi driver are incorrect
> and hence the hung kernel. But I'm way out of my comfort zone here and
> I'd appreciate any help on how to proceed here.
>
> Btw, I tried using the wpan-tools instead of the linux-zigbee tools. I
> have been able to build the tools but trying to run any "iwpan cmd"
> only prints "nl802154 not found". Again, I'm only guessing that this
> has to do with me running raspberry pi's kernel instead of the
> recommended net-next kernel. Right now I don't care much about this as
> long as the linux-zigbee tools can get me started.

As you are using a 3.18 kernel it is missing the netlink changes that 
you would need for wpan-tools.

I would recommend to use the mainline kernel on your Pi to avoid dealing 
with the rpi kernel specifics. Maybe not what you want to hear.

regards
Stefan Schmidt


