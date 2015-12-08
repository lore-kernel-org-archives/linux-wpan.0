Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46494 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383AbbLHPNM (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 8 Dec 2015 10:13:12 -0500
Subject: Re: [PATCH v2] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
 <5666DD06.1080005@osg.samsung.com> <5666E3BE.60808@osg.samsung.com>
 <5666EFB5.2040706@analog.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5666F383.1010006@osg.samsung.com>
Date: Tue, 8 Dec 2015 16:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <5666EFB5.2040706@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: michael.hennerich@analog.com, alex.aring@gmail.com, stefan@datenfreihafen.org, marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

On 08/12/15 15:56, Michael Hennerich wrote:
> On 12/08/2015 03:05 PM, Stefan Schmidt wrote:
>>
>>
>> On 08/12/15 14:37, Stefan Schmidt wrote:
>>> Hello.
>>>
>>> On 08/12/15 12:52, michael.hennerich@analog.com wrote:
>
>
>>>> +++ b/drivers/net/ieee802154/adf7242.c
>>>> @@ -0,0 +1,1251 @@
>>>> +/*
>>>> + * Analog Devices ADF7242 Low-Power IEEE 802.15.4 Transceiver
>>>> + *
>>>> + * Copyright 2009-2015 Analog Devices Inc.
>>>> + *
>>>> + * Licensed under the GPL-2 or later.
>>>> + *
>>>> + * http://www.analog.com/ADF7242
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/workqueue.h>
>>>> +#include <linux/spinlock.h>
>>>> +#include <linux/firmware.h>
>>>> +#include <linux/spi/spi.h>
>>>> +#include <linux/skbuff.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/irq.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/ieee802154.h>
>>>> +#include <net/mac802154.h>
>>>> +#include <net/cfg802154.h>
>>>> +
>>>> +#define FIRMWARE "adf7242_firmware.bin"
>>>> +#define MAX_POLL_LOOPS 200
>>>
>>> You increased the MAX_POLL_LOOPS to 200 from 50 here since the last
>>> version. Any reason for it?
>
> Hi Stefan,
>
> Two reasons.
> I added a wait for RC_STATUS_PHY_RDY at the top of the threaded ISR 
> handler. Depending on the state it may now poll a little bit longer. 
> Typical loop counts I've seen were around 20-30.
> The platform I'm currently testing with requires a FPGA bitsream 
> rebuild to change the SPI clock rate. In case SPI clock moved to the 
> fast end 50 loops might not be sufficient anymore.
> I then added 100% on top of it to be on the safe side.
>

Interesting platform :)

As the loop count normally goes only to 30 this number does indeed not 
really matter. I was just curious because I saw the change but noting 
mentioned in the log for the new version. So I thought I might ask :)

regards
Stefan Schmidt

