Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36371 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbbEGLCp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 07:02:45 -0400
Received: by wizk4 with SMTP id k4so237685608wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 07 May 2015 04:02:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150504183515.GD2385@omega.Speedport_W_921V_1_37_000>
References: <20150504183515.GD2385@omega.Speedport_W_921V_1_37_000>
Date: Thu, 7 May 2015 13:02:44 +0200
Message-ID: <CAG9Fz+umQurgYs36+8EnB+KmjrX=247BH9nxHk4iZtp3-FxZ+A@mail.gmail.com>
Subject: Re: for all openlabs tranceiver users
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, stilwellt@openlabs.co

Thanks for the information Alexander, 6MHz works for me as well. I've
configured 2 RPi Model B with 6 MHz max SPI frequency and can ping
back and forth with a packet loss rate of 1% to 8%, most often it is
around 3%, rtt ~8.7 ms. Distance is about 1 - 2 meters.

2015-05-04 20:35 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> Hi,
>
> maybe you read the other mail about the RPi and openlabs transceiver
> module.
>
> at86rf233 datasheet says 7.5 Mhz is the highest clock, but since the RPi
> clock can run at 7.35 Mhz I expierence issues with the openlabs transceiver.
>
> Set the max spi clock to 6 Mhz solved this issue. Please update the
> device tree according to that value.
>
> I tested two different transceivers with the same issue at 7.35 Mhz spi
> clock.
>
> Thanks.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Christoffer Holmstedt
