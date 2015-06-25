Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33267 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbbFYIWH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 04:22:07 -0400
Received: by pdjn11 with SMTP id n11so48740230pdj.0
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 01:22:07 -0700 (PDT)
Message-ID: <558BBA10.10805@gmail.com>
Date: Thu, 25 Jun 2015 13:51:36 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
References: <1435213871-2450-1-git-send-email-varkab@cdac.in> <558BADCC.6000800@osg.samsung.com>
In-Reply-To: <558BADCC.6000800@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Stefan,

On 06/25/2015 12:59 PM, Stefan Schmidt wrote:
> Hello.
>
> On 25/06/15 08:31, Varka Bhadram wrote:
>> This patch rename ieee802154_hdr member seq to sequence_number.
>
> Any good reason for this? I think seq is quite clear in this context 
> and making it sequence_number has no real benefit.
>
> If others disagree I'm fine to let that one in though. No hard 
> feelings about it.
>
No good reason. For me *sequence_number* is more clear than *seq*
while looking at the IEEE-802.15.4 header structure.

Right now I am working on new parsing style on frame. I did this work as part of that.

-- 
Best regards,
Varka Bhadram.

