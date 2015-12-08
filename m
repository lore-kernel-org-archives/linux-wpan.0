Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bn1bon0063.outbound.protection.outlook.com ([157.56.111.63]:25714
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756693AbbLHOvh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 8 Dec 2015 09:51:37 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v2] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
 <5666E986.8070105@osg.samsung.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <5666ECF7.1000707@analog.com>
Date: Tue, 8 Dec 2015 15:45:11 +0100
MIME-Version: 1.0
In-Reply-To: <5666E986.8070105@osg.samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, alex.aring@gmail.com, stefan@datenfreihafen.org, marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

On 12/08/2015 03:30 PM, Stefan Schmidt wrote:
> Hello.
>
> One last thing, hopefully. :)
>
> On 08/12/15 12:52, michael.hennerich@analog.com wrote:
>
> [snip]
>> +
>> +    dev_info(&spi->dev, "mac802154 IRQ-%d registered\n", spi->irq);
>> +
>> +    return ret;
>> +
>> +    ieee802154_unregister_hw(lp->hw);
>
> The function call after return will never be called. Guess you want to
> make sure the error handling is correct here.


Yeah - this line can be removed completely.
Thanks for pointing out.



>> +err_hw_init:
>> +    mutex_destroy(&lp->bmux);
>> +    ieee802154_free_hw(lp->hw);
>
> regards
> Stefan Schmidt


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
