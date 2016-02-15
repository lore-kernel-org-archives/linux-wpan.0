Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53283 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751440AbcBOIK0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 15 Feb 2016 03:10:26 -0500
Subject: Re: at86rf233 on AT91SAM9G35
References: <DUB115-W1015835A78DABA43B25FD538DA80@phx.gbl>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <56C187F0.4050403@pengutronix.de>
Date: Mon, 15 Feb 2016 09:10:24 +0100
MIME-Version: 1.0
In-Reply-To: <DUB115-W1015835A78DABA43B25FD538DA80@phx.gbl>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luca Zulberti <zulberti.luca@hotmail.it>
Cc: linux-wpan@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>

Hi,

sorry for my late reply.

Am 02/11/2016 um 08:59 AM schrieb Luca Zulberti:
> Good morning,
>
> I'm apologize for the previous email format.I have put the dts configuration and the output in these files.
>
> Best regards,
> Luca.   		  

You said in a previous mail that you get a lot of

"irq 00 recevied"

for me looks like that you reading zeros only from the SPI bus.
I can't really help you, to setup the at86rf233 in your device tree looks a little
bit unusal but correct.

I can't help you here because this setup is very board-specific and has nothing
todo with linux-wpan project. Maybe contact the maintainers for AT91.

I don't see you muxing the SPI pins, but maybe it works because there was
a spidev before.

And also check your wiring. If it's connected to the right pins.
Please also cc linux-wpan in the next time, maybe somebody has exactly
your configuration.

- Alex
