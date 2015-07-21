Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:40094 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbbGUQhc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Jul 2015 12:37:32 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: testing and building for RPI
In-Reply-To: <55517906.2060204@gmail.com>
References: <19096.1431373298@sandelman.ca> <55517906.2060204@gmail.com>
Date: Tue, 21 Jul 2015 12:37:30 -0400
Message-ID: <12393.1437496650@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, unstrung-hackers <unstrung-hackers@lists.sandelman.ca>


Varka Bhadram <varkabhadram@gmail.com> wrote:
    > You can directly use linux-wpan-next tree directly, which has the basic
    > support for RPI. No need to rebase it on rpi kernel.

    > Please see the blog: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

I finally got back to working on this.
Some minor edits:

you copy the kernel to the name rpi.img:
    scp bluetooth-next/arch/arm/boot/zImage ${TFTP_IP}:/tftpboot/rpi.img
but you tell the system to load zImage:
    dhcp ${kernel_addr_r} zImage

According to the manual, I can take my image from a different machine than
the dhcp server:

U-Boot> dhcp ${kernel_addr_r} 172.30.2.231:zImage
U-Boot> tftp ${fdt_addr_r} 172.30.2.231:${fdtfile}
U-Boot> bootz ${kernel_addr_r} - ${fdt_addr_r}
Bad Linux ARM zImage magic!

I'm still debugging what's going on...
I think the dhcp did not work correctly, as a md of the ${kernel_addr_r}
does not match a hexdump of the zImage that I built.

%file arch/arm/boot/zImage
arch/arm/boot/zImage: Linux kernel ARM boot executable zImage (little-endian)

{BTW: I will be bringing this code base to the ETSI 6lo plugfest in Yokohama
in November}

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

