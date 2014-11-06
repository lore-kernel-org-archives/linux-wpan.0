Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:48487 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaKFFwq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 00:52:46 -0500
Received: by mail-yh0-f52.google.com with SMTP id v1so1048149yhn.39
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 21:52:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415217089-24919-16-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
	<1415217089-24919-16-git-send-email-alex.aring@gmail.com>
Date: Thu, 6 Nov 2014 11:22:45 +0530
Message-ID: <CAEUmHyb8VNaXVZKPuP-81ywMG_soVduT69sogD1Qa3DqR1SeiQ@mail.gmail.com>
Subject: Re: [PATCH bluetooth-next 15/18] at86rf230: generate random perm
 extended address
From: Varka Bhadram <varkabhadram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc: kernel@pengutronix.de

On Thursday 06 November 2014 01:21 AM, Alexander Aring wrote:
> This patch adds support for a random generated perm extended address for
> the at86rf230 driver.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index bf47785..a6db768 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1534,6 +1534,7 @@ static int at86rf230_probe(struct spi_device *spi)
>   lp->spi = spi;
>   hw->parent = &spi->dev;
>   hw->vif_data_size = sizeof(*lp);
> + ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
>
>   lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
>   if (IS_ERR(lp->regmap)) {

You are getting this extended address here and configuring at the time
of iface add.

This change should be there for other drivers ( CC2520 & MRF24J40 ) also ..?

-- 
Thanks and Regards,
Varka Bhadram.
