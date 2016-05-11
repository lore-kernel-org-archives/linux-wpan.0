Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60463 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333AbcEKJ5R (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 05:57:17 -0400
Subject: Re: Problems with 6lowpan on at91: ping (truncated)
References: <CAPzmaijHiW7fyS8hnx0Gg6Gb6PhTCqh3bVf5WTQQ+tOQUFG7Ww@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <afb79e59-4e4b-ef4a-6955-f426f4afd01f@pengutronix.de>
Date: Wed, 11 May 2016 11:57:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAPzmaijHiW7fyS8hnx0Gg6Gb6PhTCqh3bVf5WTQQ+tOQUFG7Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: zulberti.luca@gmail.com, linux-wpan@vger.kernel.org
Cc: jukka.rissanen@linux.intel.com, giometti@hce-engineering.com

Hi,

On 05/10/2016 01:43 PM, Luca Zulberti wrote:
> Hi all!
> 
> I'm using two boards with an at91 CPU and the at86rf233 xplained pro from Atmel.
> Linux kernel: 4.1.
> SPI max freq: 4MHz
> Xtal-trim line removed.
> 
> To make the things work i had to remove "xtal-trim = /bits/ <0x0F>"
> and change the interrupt type in the dts file to be activated on
> rising edge because after each normally served interrupt routine, the
> driver goes to read the interrupt register of the chip even if there
> isn't any interrupt signal on the line, it reads 0x00 and warns about
> the error.
> 

Sorry, this should never happens. Reading zero in an irq status register
when only one IRQ is not masked and irq orccured.

This all smells like a wrong board configuration with spi/muxing/etc.

Also you told that it's half-working somehow afterwards, but this issue
should not happen and everything which based on such not working
low-level stuff will occur issues in upper-layers.

I can't help here.

- Alex
