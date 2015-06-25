Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:49817 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbbFYJkQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 25 Jun 2015 05:40:16 -0400
Message-ID: <558BCC7C.508@osg.samsung.com>
Date: Thu, 25 Jun 2015 11:40:12 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
References: <1435213871-2450-1-git-send-email-varkab@cdac.in> <558BADCC.6000800@osg.samsung.com> <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de> <558BBA95.7020402@gmail.com> <e40f52299be5331e48dbaedc5a0d819f.squirrel@webmail.itwm.fhg.de> <558BC886.6080208@gmail.com>
In-Reply-To: <558BC886.6080208@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, phoebe.buckheister@itwm.fraunhofer.de
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hello.

On 25/06/15 11:23, Varka Bhadram wrote:
> Hello,
>
> On 06/25/2015 02:10 PM, Phoebe Buckheister wrote:
>
>> On Thu, June 25, 2015 10:23 am, Varka Bhadram wrote:
>>> Hi Phoebe Buckheister,
>>>
>>> On 06/25/2015 01:13 PM, Phoebe Buckheister wrote:
>>>> On Thu, June 25, 2015 9:29 am, Stefan Schmidt wrote:
>>>>> Hello.
>>>>>
>>>>> On 25/06/15 08:31, Varka Bhadram wrote:
>>>>>> This patch rename ieee802154_hdr member seq to sequence_number.
>>>>> Any good reason for this? I think seq is quite clear in this context
>>>>> and
>>>>> making it sequence_number has no real benefit.
>>>>>
>>>>> If others disagree I'm fine to let that one in though. No hard 
>>>>> feelings
>>>>> about it.
>>>> Don't see the in renaming this either.
>>> I didn't get your point. ?
>> The "point" went missing. I don't see why renaming this symbol is
>> necessary or useful. Like Stefan said, it is pretty clear from context,
>> and sequence_number is kind of long too.
>>
> As part of the rework on frame parsing, Alex used this naming 
> convention [1].
>
> If you think that it's too long, can we use *seq_num* instead of *seq* ?
>
> [1]: 
> https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/include/net/ieee802154.h#L160
>

I still miss the benefit of this change. What else do you think seq 
would stand for in the context of the ieee802154 header?

Guess we can leave that up to Alex. Seq_num would be a compromise 
considering the length.

regards
Stefan Schmidt

