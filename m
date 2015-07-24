Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54319 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbbGXQ3i (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 24 Jul 2015 12:29:38 -0400
Subject: Re: [PATCH bluetooth-next 0/2] ieee802154: multiple lowpan interface
 support and fix mac setting
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
 <55B25342.3070005@osg.samsung.com> <20150724150945.GA6594@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55B267EF.8030908@osg.samsung.com>
Date: Fri, 24 Jul 2015 18:29:35 +0200
MIME-Version: 1.0
In-Reply-To: <20150724150945.GA6594@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, marcel@holtmann.org

Hello.

On 24/07/15 17:10, Alexander Aring wrote:
> On Fri, Jul 24, 2015 at 05:01:22PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 24/07/15 15:01, Alexander Aring wrote:
>>> Hi,
>>>
>>> this patch series contains two patches. At first we remove the multiple
>>> lowpan interface support. I don't see any use case for that, if somebody
>>> has an use case for it. Please report your use case.
>> I had to read the commit message to find out that you mean multiple lowpan
>> interfaces on one wpan interface here. And not multiple lowpan interface on
>> one machine which I thought first. :)
>>
> ok, I will remember that. I should say more detailed information, but
> yes it's multiple lowpan interface per wpan interface.
>
> I think the reason why we have it is that some parts of the code is
> grabbed from the eth bridge rtnl code. And multiple bridges for one
> ethernet interface makes sense.
>
> In our case, we don't have any use case, I see no sense to have multiple
> lowpan interface.
>
>> The later has for sure enough use cases :)
>>
>> I don't have a use case for the former (the one you remove here) either.
>> Still we might want to consider this as an RFC here to give folks a moment
>> to speak up with they use this.
>>
> ok. Keeping this functionaltiy makes things much complicated to deal
> with it and I don't know that somebody use this functionaltiy which
> makes for me no sense. I thought already 2 years long about to remove
> this functionaltiy. :-)

Sure, fair enough. I'm not saying we have to keep it just that we might 
one a bit longer than the usual patch-on-list-to-apply cycle to give 
people time to speak up.
I don't have a use case for it either right now but maybe we just miss 
something.

regards
Stefan Schmidt
