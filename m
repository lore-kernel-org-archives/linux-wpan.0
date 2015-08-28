Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60682 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbbH1I26 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 28 Aug 2015 04:28:58 -0400
Subject: Re: [RFC bluetooth-next 21/21] mrf24j40: change irq trigger type
 behaviour
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-22-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E01BC6.1070905@osg.samsung.com>
Date: Fri, 28 Aug 2015 10:28:54 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-22-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch changes the irq trigger type value while calling
> devm_request_irq by using IRQF_TRIGGER_LOW when no irq type was given.
> Additional we add support for change the irq polarity while hw init if
> high level or rising edge triggered irq type are given.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 560db88..7bd540a 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -20,6 +20,7 @@
>   #include <linux/module.h>
>   #include <linux/regmap.h>
>   #include <linux/ieee802154.h>
> +#include <linux/irq.h>
>   #include <net/cfg802154.h>
>   #include <net/mac802154.h>
>   
> @@ -1082,6 +1083,20 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
>   		regmap_write(devrec->regmap_long, REG_RFCON3, 0x28);
>   	}
>   
> +	switch (irq_get_trigger_type(devrec->spi->irq)) {
> +	case IRQ_TYPE_EDGE_RISING:
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		/* set interrupt polarity to rising */
> +		ret = regmap_update_bits(devrec->regmap_long, REG_SLPCON0,
> +					 0x02, 0x02);
> +		if (ret)
> +			goto err_ret;
> +		break;
> +	default:
> +		/* default is falling edge */
> +		break;
> +	}
> +
>   	return 0;
>   
>   err_ret:
> @@ -1178,7 +1193,7 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
>   
>   static int mrf24j40_probe(struct spi_device *spi)
>   {
> -	int ret = -ENOMEM;
> +	int ret = -ENOMEM, irq_type;
>   	struct ieee802154_hw *hw;
>   	struct mrf24j40 *devrec;
>   
> @@ -1232,9 +1247,13 @@ static int mrf24j40_probe(struct spi_device *spi)
>   
>   	mrf24j40_phy_setup(devrec);
>   
> +	/* request IRQF_TRIGGER_LOW as fallback default */
> +	irq_type = irq_get_trigger_type(spi->irq);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_LOW;
> +
>   	ret = devm_request_irq(&spi->dev, spi->irq, mrf24j40_isr,
> -			       IRQF_TRIGGER_LOW, dev_name(&spi->dev),
> -			       devrec);
> +			       irq_type, dev_name(&spi->dev), devrec);
>   	if (ret) {
>   		dev_err(printdev(devrec), "Unable to get IRQ");
>   		goto err_register_device;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
