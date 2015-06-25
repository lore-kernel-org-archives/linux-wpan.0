Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:35065 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbFYIlF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 04:41:05 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t5P8f3uD032174
	for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 10:41:03 +0200
Message-ID: <e40f52299be5331e48dbaedc5a0d819f.squirrel@webmail.itwm.fhg.de>
In-Reply-To: <558BBA95.7020402@gmail.com>
References: <1435213871-2450-1-git-send-email-varkab@cdac.in>
    <558BADCC.6000800@osg.samsung.com>
    <0521e88599aeca4af403568c9739d33e.squirrel@webmail.itwm.fhg.de>
    <558BBA95.7020402@gmail.com>
Date: Thu, 25 Jun 2015 10:40:55 +0200
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

On Thu, June 25, 2015 10:23 am, Varka Bhadram wrote:
> Hi Phoebe Buckheister,
>
> On 06/25/2015 01:13 PM, Phoebe Buckheister wrote:
>> On Thu, June 25, 2015 9:29 am, Stefan Schmidt wrote:
>>> Hello.
>>>
>>> On 25/06/15 08:31, Varka Bhadram wrote:
>>>> This patch rename ieee802154_hdr member seq to sequence_number.
>>> Any good reason for this? I think seq is quite clear in this context
>>> and
>>> making it sequence_number has no real benefit.
>>>
>>> If others disagree I'm fine to let that one in though. No hard feelings
>>> about it.
>> Don't see the in renaming this either.
>
> I didn't get your point. ?

The "point" went missing. I don't see why renaming this symbol is
necessary or useful. Like Stefan said, it is pretty clear from context,
and sequence_number is kind of long too.

> --
> Best regards,
> Varka Bhadram.
>
>


