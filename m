Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35123 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbbFSKUD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2015 06:20:03 -0400
Received: by pacyx8 with SMTP id yx8so82634039pac.2
        for <linux-wpan@vger.kernel.org>; Fri, 19 Jun 2015 03:20:02 -0700 (PDT)
Message-ID: <5583ECB4.8050404@gmail.com>
Date: Fri, 19 Jun 2015 15:49:32 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next 2/2] mac802154: add suspend and resume callbacks
References: <1433912028-17267-1-git-send-email-varkab@cdac.in> <1433912028-17267-3-git-send-email-varkab@cdac.in> <20150614143241.GB982@omega>
In-Reply-To: <20150614143241.GB982@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Alex,

On 06/14/2015 08:02 PM, Alexander Aring wrote:

> On Wed, Jun 10, 2015 at 10:23:48AM +0530, Varka Bhadram wrote:
>> This patch introduces suspend and resume callbacks to mac802154,
>> allowing mac802154 to quiesce its state (bringing down interfaces etc)
>> in preparation for suspend.  cfg802154 will call the suspend hook
>> before the device suspend, and resume hook after the device resume.
>>
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Thank you for the review. I noted all of your comments.

Please send the series with the updated patches.

-- 
Best regards,
Varka Bhadram.

