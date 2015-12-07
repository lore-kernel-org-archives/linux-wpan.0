Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:41170 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932796AbbLGPDp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 7 Dec 2015 10:03:45 -0500
Subject: Re: [PATCH] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449220149-14096-1-git-send-email-michael.hennerich@analog.com>
 <566181E6.9070306@osg.samsung.com> <56657FCA.9000502@analog.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56659FCD.8040600@osg.samsung.com>
Date: Mon, 7 Dec 2015 16:03:41 +0100
MIME-Version: 1.0
In-Reply-To: <56657FCA.9000502@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: michael.hennerich@analog.com, alex.aring@gmail.com, marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

On 07/12/15 13:47, Michael Hennerich wrote:
> On 12/04/2015 01:07 PM, Stefan Schmidt wrote:

[snip]

>>> +}
>>> +
>>> +static int adf7242_verify_firmware(struct adf7242_local *lp,
>>> +                   const u8 *data, size_t len)
>>
>> Could it really happen that we upload the firmware, getting fine status
>> codes back from spi_sync and this have a broken firmware in ram? To me
>> it looks like a safety measure for something that should never happen.
>> But I don't know the hardware.
>
> It's a safety measure and should never happen.
> I've added it while working with some broken SPI master driver some 
> time ago. I can remove it.
>

Hmm, I would not have it running for every init as almost all device 
should be fine. On the other hand having it for debugging might be handy 
as you already needed it once. I would say its up to you if you want to 
keep it in the driver. If you do please but is also behind the debugfs 
interface you will add for the status. That way you can keep the code 
around but only use it for its intended debugging purpose.
>>> +
>>> +    db = DIV_ROUND_CLOSEST(db + 29, 2);
>>> +
>>> +    if (db > 15) {
>>> +        dbias = 21;
>>> +        bias_ctrl = 63;
>>> +    } else {
>>> +        dbias = 13;
>>> +        bias_ctrl = 55;
>>
>> What the meaning of the values here? 21, 63, 13, 55
>
> Some BIAS values from the datasheet.
> IIRC starting some power level they need to be set differently.
>

Maybe some define's here instead of some magic values?
>>> +
>>> +static struct ieee802154_ops adf7242_ops = {
>>> +    .owner = THIS_MODULE,
>>> +    .xmit_sync = adf7242_xmit,
>>> +    .ed = adf7242_ed,
>>> +    .set_channel = adf7242_channel,
>>> +    .set_hw_addr_filt = adf7242_set_hw_addr_filt,
>>> +    .start = adf7242_start,
>>> +    .stop = adf7242_stop,
>>> +    .set_csma_params = adf7242_set_csma_params,
>>> +    .set_frame_retries = adf7242_set_frame_retries,
>>> +    .set_txpower = adf7242_set_txpower,
>>> +    .set_promiscuous_mode = adf7242_set_promiscuous_mode,
>>> +    .set_cca_ed_level = adf7242_set_cca_ed_level,
>>
>> Nice to see so many callbacks implemented. The only things I see missing
>> is xmit_async, set_lbt and set_cca_mode. I would not make it a
>> requirements to get these hooked up before merging this patch but we
>> should consider it as todo items.
>
> The part only supports CCA mode Energy above threshold.
> Not sure what this LBT mode does on the AT86RFxxx driver.

Sorry, my bad. Alex already pointed it out in the other mail. That is a 
sub-GHz requirement but adf7242 is a 2.4 GHz driver only so no need for lbt.

> The ADF7242 only supports CSMA-CA and not some other listen before 
> talk flavour. The only oher option is to turn CSMA-CA completly off.
> I'm also not sure if we need to supprot the async mode, while the sync 
> mode is working. For me the async mode looks like it tries to 
> workaround some HW access issues.
>

I will comment on these on the other mails Alex already answered.

>
>> Something worth thinking about might also be the usage of regmap.
>
> Given the number of different spi transaction formats I don't think a 
> regmap only approach can work here.
> Mixing things will not improve things either. So I prefer it the way 
> it is right now.

That would be ok with me. We did it for some other drivers and in my 
opinion it helped readability but if you think it would be worse for 
your driver I'm not demanding it.
>
> Thanks for taking the time to review things!
> I'll send V2 later this week.
>

Cool. Looking forward to it.

regards
Stefan Schmidt
