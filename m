Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49773 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbaJ2FiQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 01:38:16 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2282361pdb.13
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 22:38:15 -0700 (PDT)
Message-ID: <54507C98.4060804@gmail.com>
Date: Wed, 29 Oct 2014 11:05:20 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 14/17] mac802154: remove channel attributes
 from sdata
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com> <1414516892-4107-15-git-send-email-alex.aring@gmail.com> <54506471.40007@gmail.com> <20141029052247.GA4709@omega>
In-Reply-To: <20141029052247.GA4709@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On 10/29/2014 10:52 AM, Alexander Aring wrote:
>>> -	    sdata->local->phy->current_page != sdata->page) {
>>> -		mutex_unlock(&sdata->local->phy->pib_lock);
>>> -
>>> -		work = kzalloc(sizeof(*work), GFP_ATOMIC);
>>> -		if (!work)
>>> -			return;
>>> -
>>> -		INIT_WORK(&work->work, phy_chan_notify);
>>> -		work->dev = dev;
>>> -		queue_work(sdata->local->workqueue, &work->work);
>>> +	res = drv_set_channel(local, page, chan);
>>> +	if (res) {
>>> +		pr_debug("set_channel failed\n");
>> Why don't we use netdev_dbg() here...?
>>
>>>   	} else {
> because there comming more patches and I am not at the finally cleanup.
> This code will be part of the deprecated netlink interface. I don't want
> to fix anything here. It should only work for the things which we
> support in the official userspace software and that is. Channel setting,
> interface add/del and setting address filter.
>
> I don't want to send a patch series which contains more than 20 patches.
>
> This patch I could also add an another patch for removing the worker
> here and I really don't have an idea why we have a worker here. This
> channel setting patch is more a rework. In further all phy settings are
> directly  calls to the driver. MAC settings are stored at each interface
> and setted by a open/close or rather ifup and ifdown.

I think when we do ifup the open function will be called..?

> There will come a new netlink interface which use the framework like
> wireless. The old one will also be functional but we will remove it some
> or later.

What is the New netlink interface..?

I would like to know.


-- 
Thanks and Regards,
Varka Bhadram.

