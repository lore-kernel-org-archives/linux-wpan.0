Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56800 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaJ2GAs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 02:00:48 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so2293647pdb.39
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 23:00:48 -0700 (PDT)
Message-ID: <545081E1.8000508@gmail.com>
Date: Wed, 29 Oct 2014 11:27:53 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 07/17] mac802154: remove might_sleep from
 driver layer
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com> <1414516892-4107-8-git-send-email-alex.aring@gmail.com> <5450601D.8040608@gmail.com> <20141029055303.GC4709@omega>
In-Reply-To: <20141029055303.GC4709@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On 10/29/2014 11:23 AM, Alexander Aring wrote:
> Hi Varka,
>
> On Wed, Oct 29, 2014 at 09:03:49AM +0530, Varka Bhadram wrote:
>> On 10/28/2014 10:51 PM, Alexander Aring wrote:
>>> This patch removes all might_sleep calls from driver layer. This
>>> handling is already done by mac802154 layer.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>   drivers/net/ieee802154/at86rf230.c | 3 ---
>>>   drivers/net/ieee802154/cc2520.c    | 1 -
>>>   drivers/net/ieee802154/fakelb.c    | 4 ----
>>>   3 files changed, 8 deletions(-)
>>>
>> For CC2520 driver
>>
> I would Cc you here if you stand in the MAINTAINERS file for cc2520
> driver. I asked you some months ago if you like to be there. I didn't
> saw any patches for that. I thought it's out of interest by you that you
> want to be maintainer for this driver.  When these changes are very trivial
> like this one, it's okay for you when Marcel simple apply these patches
> without any ack? I already told him that we don't need to wait of Alan's
> ack for the mrf24j40 driver.
>
> Nevertheless if you want to add really a Acked here and we need to wait
> then please insert you in the MAINTAINERS file. When I run
> get_maintainers it's currently me who is maintainer for the cc2520 driver.
>
> If you want to take care of this driver, please see my improvements and
> fixes for the at86rf230. I am sure you could also take some code for the
> cc2520 from it. Also I would be very happy for async xmit handling or
> regmap support. Most of the cc2520 code is lowlevel spi api calls.
>
> - Alex

I think i clarified you that i want to be the CC2520 driver maintainer.

I asked you to submit the patche for MAINTAINER file, you told that its
not required.

If i run get_maintainer on the cc2520 driver , my name is there for the commit_signer

I will improve this driver regmap suuport.


-- 
Regards,
Varka Bhadram.

