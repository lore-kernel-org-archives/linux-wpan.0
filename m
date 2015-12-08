Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46435 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbbLHOae (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 8 Dec 2015 09:30:34 -0500
Subject: Re: [PATCH v2] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5666E986.8070105@osg.samsung.com>
Date: Tue, 8 Dec 2015 15:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: michael.hennerich@analog.com, alex.aring@gmail.com, stefan@datenfreihafen.org, marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

One last thing, hopefully. :)

On 08/12/15 12:52, michael.hennerich@analog.com wrote:

[snip]
> +
> +	dev_info(&spi->dev, "mac802154 IRQ-%d registered\n", spi->irq);
> +
> +	return ret;
> +
> +	ieee802154_unregister_hw(lp->hw);

The function call after return will never be called. Guess you want to 
make sure the error handling is correct here.
> +err_hw_init:
> +	mutex_destroy(&lp->bmux);
> +	ieee802154_free_hw(lp->hw);

regards
Stefan Schmidt
