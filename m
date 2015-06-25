Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35023 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbFYMdO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 08:33:14 -0400
Received: by pactm7 with SMTP id tm7so49176284pac.2
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 05:33:14 -0700 (PDT)
Message-ID: <558BF4EA.40404@gmail.com>
Date: Thu, 25 Jun 2015 18:02:42 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
References: <1435213871-2450-1-git-send-email-varkab@cdac.in> <558BADCC.6000800@osg.samsung.com> <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de> <558BBA95.7020402@gmail.com> <e40f52299be5331e48dbaedc5a0d819f.squirrel@webmail.itwm.fhg.de> <558BC886.6080208@gmail.com> <20150625121641.GA3653@omega>
In-Reply-To: <20150625121641.GA3653@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: phoebe.buckheister@itwm.fraunhofer.de, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

On 06/25/2015 05:46 PM, Alexander Aring wrote:

> Hi,
>
> On Thu, Jun 25, 2015 at 02:53:18PM +0530, Varka Bhadram wrote:
>> Hello,
>>
>> On 06/25/2015 02:10 PM, Phoebe Buckheister wrote:
>>
>>> On Thu, June 25, 2015 10:23 am, Varka Bhadram wrote:
>>>> Hi Phoebe Buckheister,
>>>>
>>>> On 06/25/2015 01:13 PM, Phoebe Buckheister wrote:
>>>>> On Thu, June 25, 2015 9:29 am, Stefan Schmidt wrote:
>>>>>> Hello.
>>>>>>
>>>>>> On 25/06/15 08:31, Varka Bhadram wrote:
>>>>>>> This patch rename ieee802154_hdr member seq to sequence_number.
>>>>>> Any good reason for this? I think seq is quite clear in this context
>>>>>> and
>>>>>> making it sequence_number has no real benefit.
>>>>>>
>>>>>> If others disagree I'm fine to let that one in though. No hard feelings
>>>>>> about it.
>>>>> Don't see the in renaming this either.
>>>> I didn't get your point. ?
>>> The "point" went missing. I don't see why renaming this symbol is
>>> necessary or useful. Like Stefan said, it is pretty clear from context,
>>> and sequence_number is kind of long too.
>>>
>> As part of the rework on frame parsing, Alex used this naming convention [1].
>>
>> If you think that it's too long, can we use *seq_num* instead of *seq* ?
>>
> Yea, shame on me. The rework dev branch was just fun for me, I was
> looking for mechanism like (nl802154, cfg802154, (frame parsing?)) which
> wireless/mac80211 do.
>
> I think I deleted for that the complete actual frame parsing stuff. Then
> I grab the 802.15.4 standard and simple use the naming convention from
> there.
>
> Nevertheless in the C programmers nature is to use short names. I am
> fine with "seq", maybe add comments that seq means sequence_number.
>
> I need also to remember that doing things in a dirty dev branch and
> bringing things mainline are complete different parts. Bringing things
> mainline will be a longer process that all people are fine with the new
> solution. Maybe we should first start a new mailing thread to talking
> about the new strategies and listing the pros and cons of each solution.
>
>
> Another point is: when you try to bring this frame parsing stuff
> mainline (which is similar like mac80211 stuff), I don't ack patches
> until we have some working llsec state in nl802154 and wpan-tools.
>
> Because the llsec module is a core part of the frame parsing stuff.
> The actual state for doing the frame parsing stuff in the control block
> of skb (skb->cb (mac_cb)) will occur many side effects when we changing
> something in there, which I can't ack at the moment without a working
> llsec layer.
>
>
> The second thing is: don't make per day 1-2 patches. If you plan to do
> something big, then send patch series (please 20 patches at maximum per
> patch series).
>
> - Alex

Noted. Please drop it.

Thanks.

-- 
Varka Bhadram.

