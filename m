Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:42257 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932673AbcDSTaE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Apr 2016 15:30:04 -0400
Subject: Re: [PATCH bluetooth-next] at86rf230: increase sleep to off timings
References: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
 <5716439D.4030404@osg.samsung.com> <57167341.2040902@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <57168737.5030800@osg.samsung.com>
Date: Tue, 19 Apr 2016 21:29:59 +0200
MIME-Version: 1.0
In-Reply-To: <57167341.2040902@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Oleg Hahm <oliver.hahm@inria.fr>

Hello.

On 19/04/16 20:04, Alexander Aring wrote:
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

I only was worried that the 231 or 212 need _longer_ than the 1ms for 
this. If the datasheet mentions a shorter maximum time this patch is 
fine as is.
As you said, its not a hotpath and we are ok with this 1ms for setting 
the channel.

I already gave my reviewed by and I think the patch is fine as is to be 
applied.

regards
Stefan Schmidt

