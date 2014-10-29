Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52533 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaJ2Dwf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 23:52:35 -0400
Received: by mail-pd0-f172.google.com with SMTP id r10so2110788pdi.31
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 20:52:34 -0700 (PDT)
Message-ID: <545063CD.9030806@gmail.com>
Date: Wed, 29 Oct 2014 09:19:33 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 01/17] mac802154: monitor: merge into iface
 implementation
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com> <1414516892-4107-2-git-send-email-alex.aring@gmail.com> <5450617B.8030700@gmail.com>
In-Reply-To: <5450617B.8030700@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On 10/29/2014 09:09 AM, Varka Bhadram wrote:
> On 10/28/2014 10:51 PM, Alexander Aring wrote:
>> This patch removes the monitor implementation file and put all monitor
>> stuff into iface file. It's now small enough to put all necessary
>> handling into iface.
>>
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> ---
>>   net/mac802154/Makefile  |  2 +-
>>   net/mac802154/iface.c   | 30 +++++++++++++++++++++++++
>>   net/mac802154/monitor.c | 59 
>> -------------------------------------------------
>>   3 files changed, 31 insertions(+), 60 deletions(-)
>>   delete mode 100644 net/mac802154/monitor.c
>>
> Hi Alex,
>
> Doing nice work,changing the code view same as mac80211.
>
> But What ever you do in previous patches you are undoing, like moving 
> some of the
> code to iface file from their to main file like that... Please correct 
> me if I am wrong.
>
>
Good to have the cover-letter for all these changes...


-- 
Regards,
Varka Bhadram.

