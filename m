Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bn1bon0061.outbound.protection.outlook.com ([157.56.111.61]:46928
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933242AbbLHPDT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 8 Dec 2015 10:03:19 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v2] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
 <5666DD06.1080005@osg.samsung.com> <5666E3BE.60808@osg.samsung.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <5666EFB5.2040706@analog.com>
Date: Tue, 8 Dec 2015 15:56:53 +0100
MIME-Version: 1.0
In-Reply-To: <5666E3BE.60808@osg.samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, alex.aring@gmail.com, stefan@datenfreihafen.org, marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

On 12/08/2015 03:05 PM, Stefan Schmidt wrote:
>
>
> On 08/12/15 14:37, Stefan Schmidt wrote:
>> Hello.
>>
>> On 08/12/15 12:52, michael.hennerich@analog.com wrote:


>>> +++ b/drivers/net/ieee802154/adf7242.c
>>> @@ -0,0 +1,1251 @@
>>> +/*
>>> + * Analog Devices ADF7242 Low-Power IEEE 802.15.4 Transceiver
>>> + *
>>> + * Copyright 2009-2015 Analog Devices Inc.
>>> + *
>>> + * Licensed under the GPL-2 or later.
>>> + *
>>> + * http://www.analog.com/ADF7242
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/workqueue.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/firmware.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/skbuff.h>
>>> +#include <linux/of.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/debugfs.h>
>>> +#include <linux/ieee802154.h>
>>> +#include <net/mac802154.h>
>>> +#include <net/cfg802154.h>
>>> +
>>> +#define FIRMWARE "adf7242_firmware.bin"
>>> +#define MAX_POLL_LOOPS 200
>>
>> You increased the MAX_POLL_LOOPS to 200 from 50 here since the last
>> version. Any reason for it?

Hi Stefan,

Two reasons.
I added a wait for RC_STATUS_PHY_RDY at the top of the threaded ISR 
handler. Depending on the state it may now poll a little bit longer. 
Typical loop counts I've seen were around 20-30.
The platform I'm currently testing with requires a FPGA bitsream rebuild 
to change the SPI clock rate. In case SPI clock moved to the fast end 50 
loops might not be sufficient anymore.
I then added 100% on top of it to be on the safe side.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
