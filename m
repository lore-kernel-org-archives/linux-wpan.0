Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60378 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbbH0M4t (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 08:56:49 -0400
Subject: Re: [RFC bluetooth-next 1/2] at86rf230: change trac status check
 behaviour
References: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
 <1438874501-19971-2-git-send-email-alex.aring@gmail.com>
 <55DEDEDB.1010302@osg.samsung.com> <20150827101318.GA2609@omega>
 <55DF0142.90608@osg.samsung.com> <20150827123123.GB2609@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF090E.5040600@osg.samsung.com>
Date: Thu, 27 Aug 2015 14:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <20150827123123.GB2609@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 27/08/15 14:31, Alexander Aring wrote:
> On Thu, Aug 27, 2015 at 02:23:30PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 27/08/15 12:13, Alexander Aring wrote:
>>> On Thu, Aug 27, 2015 at 11:56:43AM +0200, Stefan Schmidt wrote:
>>>> Hello.
>>>>
>>>> On 06/08/15 17:21, Alexander Aring wrote:
>>>>> When transmit is done, indicated by trx_end irq, we do first a force
>>>>> state change to TX_ON and then checking the trac status, if the trac
>>>>> status is unequal zero we do a state change to TRX_OFF.
>>>>>
>>>>> This patch changes to the following behaviour, we first check on trac
>>>>> status after trx_end occurs and then doing a normal change to TX_ON
>>>>> without do the state change to TRX_OFF when trac status is unequal zero.
>>>>>
>>>>> The reasons are that the datasheet doesn't described when the trac
>>>>> status register is cleared, we should doing to evaluate the trac status
>>>>> at first. The reason to remove the TRX_OFF change if the trac status is
>>>>> unequal to zero and it was force is the following paragraph inside The
>>>>> at86rf2xx datasheets:
>>>>>
>>>>> "Using FORCE_PLL_ON to interrupt an TX_ARET transaction, it is
>>>>>   recommended to check register bits [7:5] of register address 0x32 for
>>>>>   value 0. If this value is different, TRX_CMD sequence FORCE_TRX_OFF shall
>>>>>   be used immediately followed by TRX_CMD sequence PLL_ON. This performs a
>>>>>   state transition to PLL_ON."
>>>> I had a hard time finding a register description of 0x32 in my copies. Are
>>>> they outdated or am I just blind? Any hints appreciated. :)
>>>>
>>> I think this is a mistake in the datasheet, they mean the "TRAC_STATUS"
>>> here, which is the only value which fits in the range of [7:5] in
>>> Register 0x02.
>> This makes more sense. Thanks.
>> Code 4 and 6 and marked as reserved which is what you are counting
>> aggregated in the reserved counter.
>> Not sure if that really buys us anything. We don't know if we get them at
>> all (something we will see over time with your patches), we don't know which
>> one comes in (count be changed when counting them separately) but most
>> important we don't know what they mean and what we should do. :)
>>
>> I would say ignore them. The counter has no meaning for us.
> ok. I will include this in the default branch which do a "dev_warn" then.
>
> - Alex

Sounds good to me. Maybe think about rate limiting it.

regards
Stefan Schmidt
