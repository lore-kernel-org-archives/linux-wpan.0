Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32898 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbFYJXv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 05:23:51 -0400
Received: by padev16 with SMTP id ev16so46634470pad.0
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 02:23:50 -0700 (PDT)
Message-ID: <558BC886.6080208@gmail.com>
Date: Thu, 25 Jun 2015 14:53:18 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
References: <1435213871-2450-1-git-send-email-varkab@cdac.in>    <558BADCC.6000800@osg.samsung.com>    <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de>    <558BBA95.7020402@gmail.com> <e40f52299be5331e48dbaedc5a0d819f.squirrel@webmail.itwm.fhg.de>
In-Reply-To: <e40f52299be5331e48dbaedc5a0d819f.squirrel@webmail.itwm.fhg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: phoebe.buckheister@itwm.fraunhofer.de
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hello,

On 06/25/2015 02:10 PM, Phoebe Buckheister wrote:

> On Thu, June 25, 2015 10:23 am, Varka Bhadram wrote:
>> Hi Phoebe Buckheister,
>>
>> On 06/25/2015 01:13 PM, Phoebe Buckheister wrote:
>>> On Thu, June 25, 2015 9:29 am, Stefan Schmidt wrote:
>>>> Hello.
>>>>
>>>> On 25/06/15 08:31, Varka Bhadram wrote:
>>>>> This patch rename ieee802154_hdr member seq to sequence_number.
>>>> Any good reason for this? I think seq is quite clear in this context
>>>> and
>>>> making it sequence_number has no real benefit.
>>>>
>>>> If others disagree I'm fine to let that one in though. No hard feelings
>>>> about it.
>>> Don't see the in renaming this either.
>> I didn't get your point. ?
> The "point" went missing. I don't see why renaming this symbol is
> necessary or useful. Like Stefan said, it is pretty clear from context,
> and sequence_number is kind of long too.
>
As part of the rework on frame parsing, Alex used this naming convention [1].

If you think that it's too long, can we use *seq_num* instead of *seq* ?

[1]: https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/include/net/ieee802154.h#L160

-- 
Varka Bhadram.

