Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53049 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418AbbEVMd6 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 May 2015 08:33:58 -0400
Message-ID: <555F2232.50500@osg.samsung.com>
Date: Fri, 22 May 2015 14:33:54 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 4/4] mac802154: use atomic ops for sequence
 incrementation
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com> <1432285031-3360-5-git-send-email-alex.aring@gmail.com> <555EEFF1.90603@pengutronix.de> <555F0560.8060805@osg.samsung.com> <555F062B.3010107@pengutronix.de> <20150522121238.GA748@omega>
In-Reply-To: <20150522121238.GA748@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 22/05/15 14:12, Alexander Aring wrote:
> On Fri, May 22, 2015 at 12:34:19PM +0200, Marc Kleine-Budde wrote:
>> On 05/22/2015 12:30 PM, Stefan Schmidt wrote:
>>> Hello.
>>>
>>> On 22/05/15 10:59, Marc Kleine-Budde wrote:
>>>> On 05/22/2015 10:57 AM, Alexander Aring wrote:
>>>>> This patch will use atomic operations for sequence number incrementation
>>>>> while MAC header generation. Upper layers like af_802154 or 6LoWPAN
>>>>> could call this function in a parallel context while generating 802.15.4
>>>>> MAC header before queuing into wpan interfaces transmit queue.
>>>> what about swapping patch 3 and 4?
>>> To avoid having problems during a git bisect later one? E.g. having the
>>> lock removed but no atomic in place?
>> Yes, that's what I was thinking about. I don't know the code to tell if
>> this is an issue here.
>>
> The problem is more difficult because the dsn incrementation which I do
> atomic now had never a locking mechanism. So this was always not working
> correctly. Somebody need to scream now "hey fix that in net, not next".

Hey, fix that in net not next! :P

If we know it causes problems in current net we should indeed try to 
submit it there.
Given it is only a few lines it might be worth the effort even now. Some 
people might be using kernel releases for their work and thus they could 
get this fix one release (3 months) earlier.

> I do at the moment only critical things fixed in net, like [0].
>
Sure, these are the most important ones. I leave it to you to decide if 
you think this one is worth the extra effort.

> But we should swap it because I first wrote some "TODO we should use
> atomic here" and then later I decide to implement this TODO. At the end
> this results in some cherry-pick orgy and I did not change it.
>
ok, cool.

regards
Stefan Schmidt
