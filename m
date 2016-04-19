Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45345 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754766AbcDSSEx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Apr 2016 14:04:53 -0400
Subject: Re: [PATCH bluetooth-next] at86rf230: increase sleep to off timings
References: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
 <5716439D.4030404@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <57167341.2040902@pengutronix.de>
Date: Tue, 19 Apr 2016 20:04:49 +0200
MIME-Version: 1.0
In-Reply-To: <5716439D.4030404@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Oleg Hahm <oliver.hahm@inria.fr>

Hi,

Am 04/19/2016 um 04:41 PM schrieb Stefan Schmidt:
> Hello.
>
> On 19/04/16 15:34, Alexander Aring wrote:
>> I expierenced when setting channel while sleep mode it didn't changed
>> the channel inside the hardware registers. Then I got another report of
>> an user which has similar issues.
>>
>> I increased the sleep to off state change timing, which is according
>> at86rf233 at maximum 1000 us. After this change I got no similar effects
>> again.
>>
>> I tried another option to wait on AWAKE_END irq, which can be used to
>> wait until the transceiver is awaked. I tested it and the IRQ took 4
>> seconds after starting state change. I don't believe it takes 4 seconds
>> to go into the TRX_OFF state from SLEEP state. The alternative is to
>> increase the timings which seems to work.
>
> Nicely spotted. Increasing the timing is fine here I think. Given the datasheet actually assumes a maximum of 1000 us we should allow for it as well.
>
> Did you also check the maximum timing for 231 and 212 in the datasheet? Just to make sure they are not different (for example higher).

No the datasheets differs much here, there are 380 us only. I set it now to 1 ms,
because it's not really a hotpath yet where this is used.

Alternative would be to use IRQ_CCA_ED, which is multi-funcional irq. That means
it can also used to indicate (IRQ_AWAKE) to be sure the transceiver is _really_
awake when doing spi cmds. I tested it and saw it took 4 seconds to get such IRQ
after state switch from SLEEP to TRX_OFF.

This occurs that commands like link up commands for the first time on one phy
for one interface can took above ~10 seconds. It's better we wait 1ms to be sure
and I think the IRQ_AWAKE mechanism isn't good to use in practice.

btw: I expierence similar issues with recalibrate PLL with registers to recalibrate the
PLL. But doing a state change to OFF and RX_ON/TX_ON will do the same and works
better.

- Alex
