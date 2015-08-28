Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60718 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbbH1I5f (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 28 Aug 2015 04:57:35 -0400
Subject: Re: [RFC bluetooth-next 15/21] mrf24j40: async interrupt handling
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-16-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E0227B.2090604@osg.samsung.com>
Date: Fri, 28 Aug 2015 10:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-16-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch removes the threaded irq handling and do a hardirq instead.
> We need to switch to spi_async for this step for getting the irq status
> register.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 93 +++++++++++++++++----------------------
>   1 file changed, 40 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 044d6c6..e992bff 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -181,8 +181,10 @@ struct mrf24j40 {
>   	u8 rx_fifo_buf[RX_FIFO_SIZE];
>   	struct spi_transfer rx_fifo_buf_trx;
>   
> -	struct mutex buffer_mutex; /* only used to protect buf */
> -	u8 *buf; /* 3 bytes. Used for SPI single-register transfers. */
> +	/* isr handling for reading intstat */
> +	struct spi_message irq_msg;
> +	u8 irq_buf[2];
> +	struct spi_transfer irq_trx;
>   };
>   
>   /* regmap information for short address register access */
> @@ -486,34 +488,6 @@ static const struct regmap_bus mrf24j40_long_regmap_bus = {
>   	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>   };
>   
> -static int read_short_reg(struct mrf24j40 *devrec, u8 reg, u8 *val)
> -{
> -	int ret = -1;
> -	struct spi_message msg;
> -	struct spi_transfer xfer = {
> -		.len = 2,
> -		.tx_buf = devrec->buf,
> -		.rx_buf = devrec->buf,
> -	};
> -
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -
> -	mutex_lock(&devrec->buffer_mutex);
> -	devrec->buf[0] = MRF24J40_READSHORT(reg);
> -	devrec->buf[1] = 0;
> -
> -	ret = spi_sync(devrec->spi, &msg);
> -	if (ret)
> -		dev_err(printdev(devrec),
> -			"SPI read Failed for short register 0x%hhx\n", reg);
> -	else
> -		*val = devrec->buf[1];
> -
> -	mutex_unlock(&devrec->buffer_mutex);
> -	return ret;
> -}
> -
>   static void write_tx_buf_complete(void *context)
>   {
>   	struct mrf24j40 *devrec = context;
> @@ -805,16 +779,12 @@ static const struct ieee802154_ops mrf24j40_ops = {
>   	.set_hw_addr_filt = mrf24j40_filter,
>   };
>   
> -static irqreturn_t mrf24j40_isr(int irq, void *data)
> +static void mrf24j40_intstat_complete(void *context)
>   {
> -	struct mrf24j40 *devrec = data;
> -	u8 intstat;
> -	int ret;
> +	struct mrf24j40 *devrec = context;
> +	u8 intstat = devrec->irq_buf[1];
>   
> -	/* Read the interrupt status */
> -	ret = read_short_reg(devrec, REG_INTSTAT, &intstat);
> -	if (ret)
> -		goto out;
> +	enable_irq(devrec->spi->irq);
>   
>   	/* Check for TX complete */
>   	if (intstat & 0x1)
> @@ -823,8 +793,23 @@ static irqreturn_t mrf24j40_isr(int irq, void *data)
>   	/* Check for Rx */
>   	if (intstat & 0x8)
>   		mrf24j40_handle_rx(devrec);
> +}
> +
> +static irqreturn_t mrf24j40_isr(int irq, void *data)
> +{
> +	struct mrf24j40 *devrec = data;
> +	int ret;
> +
> +	disable_irq_nosync(irq);
> +
> +	devrec->irq_buf[0] = MRF24J40_READSHORT(REG_INTSTAT);
> +	/* Read the interrupt status */
> +	ret = spi_async(devrec->spi, &devrec->irq_msg);
> +	if (ret) {
> +		enable_irq(irq);
> +		return IRQ_NONE;
> +	}
>   
> -out:
>   	return IRQ_HANDLED;
>   }
>   
> @@ -971,6 +956,18 @@ mrf24j40_setup_rx_spi_messages(struct mrf24j40 *devrec)
>   	spi_message_add_tail(&devrec->rx_lqi_trx, &devrec->rx_buf_msg);
>   }
>   
> +static void
> +mrf24j40_setup_irq_spi_messages(struct mrf24j40 *devrec)
> +{
> +	spi_message_init(&devrec->irq_msg);
> +	devrec->irq_msg.context = devrec;
> +	devrec->irq_msg.complete = mrf24j40_intstat_complete;
> +	devrec->irq_trx.len = 2;
> +	devrec->irq_trx.tx_buf = devrec->irq_buf;
> +	devrec->irq_trx.rx_buf = devrec->irq_buf;
> +	spi_message_add_tail(&devrec->irq_trx, &devrec->irq_msg);
> +}
> +
>   static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
>   {
>   	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
> @@ -1001,6 +998,7 @@ static int mrf24j40_probe(struct spi_device *spi)
>   
>   	mrf24j40_setup_tx_spi_messages(devrec);
>   	mrf24j40_setup_rx_spi_messages(devrec);
> +	mrf24j40_setup_irq_spi_messages(devrec);
>   
>   	devrec->regmap_short = devm_regmap_init_spi(spi,
>   						    &mrf24j40_short_regmap);
> @@ -1021,26 +1019,15 @@ static int mrf24j40_probe(struct spi_device *spi)
>   		goto err_register_device;
>   	}
>   
> -	devrec->buf = devm_kzalloc(&spi->dev, 3, GFP_KERNEL);
> -	if (!devrec->buf)
> -		goto err_register_device;
> -
> -	mutex_init(&devrec->buffer_mutex);
> -
>   	ret = mrf24j40_hw_init(devrec);
>   	if (ret)
>   		goto err_register_device;
>   
>   	mrf24j40_phy_setup(devrec);
>   
> -	ret = devm_request_threaded_irq(&spi->dev,
> -					spi->irq,
> -					NULL,
> -					mrf24j40_isr,
> -					IRQF_TRIGGER_LOW|IRQF_ONESHOT,
> -					dev_name(&spi->dev),
> -					devrec);
> -
> +	ret = devm_request_irq(&spi->dev, spi->irq, mrf24j40_isr,
> +			       IRQF_TRIGGER_LOW, dev_name(&spi->dev),
> +			       devrec);
>   	if (ret) {
>   		dev_err(printdev(devrec), "Unable to get IRQ");
>   		goto err_register_device;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
