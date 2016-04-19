Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42103 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933183AbcDSSvs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Apr 2016 14:51:48 -0400
Subject: Re: [PATCH bluetooth-next] at86rf230: increase sleep to off timings
References: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
 <5716439D.4030404@osg.samsung.com> <57167341.2040902@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <57167E41.50508@pengutronix.de>
Date: Tue, 19 Apr 2016 20:51:45 +0200
MIME-Version: 1.0
In-Reply-To: <57167341.2040902@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Oleg Hahm <oliver.hahm@inria.fr>

Am 04/19/2016 um 08:04 PM schrieb Alexander Aring:
> Hi,
>
> Am 04/19/2016 um 04:41 PM schrieb Stefan Schmidt:
>> Hello.
>>
>> On 19/04/16 15:34, Alexander Aring wrote:
>>> I expierenced when setting channel while sleep mode it didn't changed
>>> the channel inside the hardware registers. Then I got another report of
>>> an user which has similar issues.
>>>
>>> I increased the sleep to off state change timing, which is according
>>> at86rf233 at maximum 1000 us. After this change I got no similar effects
>>> again.
>>>
>>> I tried another option to wait on AWAKE_END irq, which can be used to
>>> wait until the transceiver is awaked. I tested it and the IRQ took 4
>>> seconds after starting state change. I don't believe it takes 4 seconds
>>> to go into the TRX_OFF state from SLEEP state. The alternative is to
>>> increase the timings which seems to work.
>> Nicely spotted. Increasing the timing is fine here I think. Given the datasheet actually assumes a maximum of 1000 us we should allow for it as well.
>>
>> Did you also check the maximum timing for 231 and 212 in the datasheet? Just to make sure they are not different (for example higher).
> No the datasheets differs much here, there are 380 us only. I set it now to 1 ms,
> because it's not really a hotpath yet where this is used.
>
> Alternative would be to use IRQ_CCA_ED, which is multi-funcional irq. That means
> it can also used to indicate (IRQ_AWAKE) to be sure the transceiver is _really_
> awake when doing spi cmds. I tested it and saw it took 4 seconds to get such IRQ

Also I saw a discussion on netdev that it's usual you cannot set PHY (link)
settings (in this case it was etherner, with ethtool)  when the interface is
down. [0]

I think they have similar hardware where the registers are not accessable
when the interface is down (means hardware is in sleep state).

Also a colleague means we should switch to pm calls and use dev_get/dev_put,
but for networking this differs, our sleep/awake states depends on interface is
down or up. If up it's in receive mode and is in sleep mode until all interfaces
for this phy are down.

Maybe we should discuss "when going into sleep mode" and "when allow
phy (link) settings". It is also maybe very transceiver specific because the
at86rf2xx simple doesn't allow register manipulating while sleep mode.
So far I know the mrf24j40 allows it. And [0] describes the issue for some
hardware such at86rf2xx.

- Alex

[0] http://marc.info/?l=systemd-devel&m=146042512722479&w=2
