Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34785 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbbGEKVI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Jul 2015 06:21:08 -0400
Received: by wgqq4 with SMTP id q4so118147325wgq.1
        for <linux-wpan@vger.kernel.org>; Sun, 05 Jul 2015 03:21:07 -0700 (PDT)
Date: Sat, 4 Jul 2015 17:36:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150704153629.GA12767@omega>
References: <CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
 <CAPpUg6OiRu2XWb_xMXDVzuSLYP7=JeD1ULcksCh=WjprxxCbKA@mail.gmail.com>
 <20150701151653.GA969@omega>
 <CAPpUg6Obeifuy8eistOir7yjEkZOfbW8WEM8JTJ6v5LwY711EA@mail.gmail.com>
 <20150702161239.GA1258@omega>
 <CAPpUg6MxRFgcwyUfd7joz=7AxtbhUgCdfukthk7qzv5k2ADCCg@mail.gmail.com>
 <20150703154724.GA24800@omega>
 <CAPpUg6NSwRpHQX71jeHqLyvZayVonzBLiwQjh6_MQ+erEcTMxw@mail.gmail.com>
 <20150703173729.GA2651@omega>
 <CAPpUg6Pvt6-YQO6aKSC13=+12pbugCoZGCGTJaJV9JG88KHsuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6Pvt6-YQO6aKSC13=+12pbugCoZGCGTJaJV9JG88KHsuQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Sat, Jul 04, 2015 at 12:13:53AM +0200, Baptiste Clenet wrote:
...
> 
> Yes spi-mt7621. Warning at line 146 concerning the length of the message [0].
> I think I will have to rewrite a bit the driver in order to send more
> than 32 Bytes. I think I just need to keep CS pin for the transceiver
> low and send all messages in a loop. Will try that on Monday. I will
> let you know how it goes.
> 
> 
> [0]
> https://dev.openwrt.org/browser/trunk/target/linux/ramips/patches-3.18/0061-SPI-ralink-add-mt7621-SoC-spi-driver.patch

Not sure what I should say now here but the spi-mt7621 isn't mainline. I
think you need to ask the openwrt people which is actual the state of
this spi controller driver.

In my opinions it has some limitations and why the hell isn't this
driver mainline? Maybe there exists already known issues with this
driver which are also related to the spi_async receiving buffer issue.

I can't help you at this point to fix the spi controller driver.

- Alex
