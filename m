Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:52957 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaISK3B (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 06:29:01 -0400
Message-ID: <541C04DA.5030707@gmail.com>
Date: Fri, 19 Sep 2014 15:56:34 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next v2 0/3] cleanup for mrf24j40 driver
References: <1411101911-12462-1-git-send-email-varkab@cdac.in> <20140919090611.GA17051@omega> <541BF7F4.4020508@gmail.com> <20140919094052.GA19085@omega> <541BFAEB.5050102@gmail.com> <20140919094830.GB19085@omega>
In-Reply-To: <20140919094830.GB19085@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, alan@signal11.us, Varka Bhadram <varkab@cdac.in>

On 09/19/2014 03:18 PM, Alexander Aring wrote:
> On Fri, Sep 19, 2014 at 03:14:11PM +0530, Varka Bhadram wrote:
>> On 09/19/2014 03:11 PM, Alexander Aring wrote:
>>> On Fri, Sep 19, 2014 at 03:01:32PM +0530, Varka Bhadram wrote:
>>>> Hi Alex,
>>>>
>>>> On 09/19/2014 02:36 PM, Alexander Aring wrote:
>>>>> Hi Varka,
>>>>>
>>>>> nice to read you again. :-) I already thought that I was maybe a little
>>>>> bit too harsh to you for explaining changing dev->add_len during runtime
>>>>> will occur in unexcept behaviour. Sorry.
>>>> For dev->addr_len, i think David asked a question.. Isn't it..?
>>>>
>>> yes, I didn't answer. I decide now to put this issue at the last item of
>>> my todo queue. If you like you can try it. I will answer him that I do
>>> other things right now and this issue is more complex.
>>>
>>>
>>> Also you did the cc2520 driver, you can add you as maintainer for this
>>> driver. I have such devices here but on contiki nodes.
>>>
>> You mean to say that i need to add an entry in MAINTAINER file or ..?
>>
> not need, only if you like. I have no idea about the cc2520 driver.
>
> If there cames patches in, I can only look for syntax and according
> interaction with mac802154 stack.

Ya.. I can be maintainer for CC2520 driver.

I will look into the cc2520 driver patches.

Thanks

-- 
Regards,
Varka Bhadram.

