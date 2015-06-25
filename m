Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:39294 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbFYJhQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 05:37:16 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t5P9bD2x024297
	for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 11:37:13 +0200
Message-ID: <9c922bf461d7e4dfb8da507ba34f03cd.squirrel@webmail.itwm.fhg.de>
In-Reply-To: <558BC886.6080208@gmail.com>
References: <1435213871-2450-1-git-send-email-varkab@cdac.in>
    <558BADCC.6000800@osg.samsung.com>
    <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de>
    <558BBA95.7020402@gmail.com>
    <e40f52299be5331e48dbaedc5a0d819f.squirrel@webmail.itwm.fhg.de>
    <558BC886.6080208@gmail.com>
Date: Thu, 25 Jun 2015 11:37:10 +0200
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
From: "Phoebe Buckheister" <phoebe.buckheister@itwm.fraunhofer.de>
Reply-To: phoebe.buckheister@itwm.fraunhofer.de
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: phoebe.buckheister@itwm.fraunhofer.de, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

On Thu, June 25, 2015 11:23 am, Varka Bhadram wrote:
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
> As part of the rework on frame parsing, Alex used this naming convention
> [1].
>
> If you think that it's too long, can we use *seq_num* instead of *seq* ?

Sure. Just avoid overly long names when a shorter one will do.
Still not a friend of remaining that now if it'll be replaced anyway.
>
> [1]:
> https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/include/net/ieee802154.h#L160
>
> --
> Varka Bhadram.
>
>


