Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35364 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbFYIYU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 04:24:20 -0400
Received: by pdbci14 with SMTP id ci14so48679215pdb.2
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 01:24:20 -0700 (PDT)
Message-ID: <558BBA95.7020402@gmail.com>
Date: Thu, 25 Jun 2015 13:53:49 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
References: <1435213871-2450-1-git-send-email-varkab@cdac.in>    <558BADCC.6000800@osg.samsung.com> <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de>
In-Reply-To: <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: phoebe.buckheister@itwm.fraunhofer.de, Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Phoebe Buckheister,

On 06/25/2015 01:13 PM, Phoebe Buckheister wrote:
> On Thu, June 25, 2015 9:29 am, Stefan Schmidt wrote:
>> Hello.
>>
>> On 25/06/15 08:31, Varka Bhadram wrote:
>>> This patch rename ieee802154_hdr member seq to sequence_number.
>> Any good reason for this? I think seq is quite clear in this context and
>> making it sequence_number has no real benefit.
>>
>> If others disagree I'm fine to let that one in though. No hard feelings
>> about it.
> Don't see the in renaming this either.

I didn't get your point. ?

-- 
Best regards,
Varka Bhadram.

