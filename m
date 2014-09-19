Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58661 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750926AbaISEZV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 19 Sep 2014 00:25:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by gateway2.nyi.internal (Postfix) with ESMTP id 988902081D
	for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 00:25:20 -0400 (EDT)
Message-ID: <541BB033.6030603@signal11.us>
Date: Fri, 19 Sep 2014 00:25:23 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: mrf24j40: use pr_* / dev_*
References: <1410842922-10564-1-git-send-email-varkab@cdac.in> <1410842922-10564-4-git-send-email-varkab@cdac.in> <541B6430.80108@signal11.us> <541BA2AB.2030503@gmail.com>
In-Reply-To: <541BA2AB.2030503@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

On 09/18/2014 11:27 PM, Varka Bhadram wrote:
>>> @@ -482,12 +482,10 @@ static int mrf24j40_filter(struct
>>> ieee802154_dev *dev,
>>>           for (i = 0; i < 8; i++)
>>>               write_short_reg(devrec, REG_EADR0 + i, addr[i]);
>>>   -#ifdef DEBUG
>>> -        printk(KERN_DEBUG "Set long addr to: ");
>>> +        pr_debug("Set long addr to: ");
>>>           for (i = 0; i < 8; i++)
>>> -            printk("%02hhx ", addr[7 - i]);
>>> -        printk(KERN_DEBUG "\n");
>>> -#endif
>>> +            pr_debug("%02hhx ", addr[7 - i]);
>>> +        pr_debug("\n");
>>
>> Hmm... You took out the #ifdef DEBUG, but there's still a loop in
>> there that will execute (optimizer aside). The pr_debug is ok, but
>> leave it all inside the #ifdef DEBUG.
>>
> I think if we use the pr_debug(), no need to need put*#ifdef DEBUG*...?
>
> I didn't get your point here...
>

What I mean is, even though pr_debug() is taken out by the preprocessor 
when DEBUG is not defined, the for-loop is not. Most likely, the empty 
loop gets optimized out by the compiler, but either way it's better to 
have the code be representative of what's going to execute. Therefore, I 
think we should keep the #ifdef DEBUG.

Alan.

