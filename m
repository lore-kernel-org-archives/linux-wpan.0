Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60388 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbbH0NDI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:03:08 -0400
Subject: Re: [RFC bluetooth-next 02/21] mrf24j40: use ieee802154_alloc_hw for
 private data
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF0A89.80208@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:03:05 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch removes the own private dataroom allocation by calling
> devm_kzalloc for devrec and assign this pointer to "devrec->hw->priv".
> Instead we using like all other drivers ieee802154_alloc_hw and give the
> size for the private driver dataroom at the first argument.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 31 +++++++++++++++----------------
>   1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 2b7fc00..1023cd2 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -723,16 +723,28 @@ err_ret:
>   static int mrf24j40_probe(struct spi_device *spi)
>   {
>   	int ret = -ENOMEM;
> +	struct ieee802154_hw *hw;
>   	struct mrf24j40 *devrec;
>   
>   	dev_info(&spi->dev, "probe(). IRQ: %d\n", spi->irq);
>   
> -	devrec = devm_kzalloc(&spi->dev, sizeof(struct mrf24j40), GFP_KERNEL);
> -	if (!devrec)
> +	/* Register with the 802154 subsystem */
> +
> +	hw = ieee802154_alloc_hw(sizeof(*devrec), &mrf24j40_ops);
> +	if (!hw)
>   		goto err_ret;
> +
> +	devrec = hw->priv;
> +	devrec->spi = spi;
> +	spi_set_drvdata(spi, devrec);
> +	devrec->hw = hw;
> +	devrec->hw->parent = &spi->dev;
> +	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
> +	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
> +
>   	devrec->buf = devm_kzalloc(&spi->dev, 3, GFP_KERNEL);
>   	if (!devrec->buf)
> -		goto err_ret;
> +		goto err_register_device;
>   
>   	spi->mode = SPI_MODE_0; /* TODO: Is this appropriate for right here? */
>   	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ)
> @@ -740,19 +752,6 @@ static int mrf24j40_probe(struct spi_device *spi)
>   
>   	mutex_init(&devrec->buffer_mutex);
>   	init_completion(&devrec->tx_complete);
> -	devrec->spi = spi;
> -	spi_set_drvdata(spi, devrec);
> -
> -	/* Register with the 802154 subsystem */
> -
> -	devrec->hw = ieee802154_alloc_hw(0, &mrf24j40_ops);
> -	if (!devrec->hw)
> -		goto err_ret;
> -
> -	devrec->hw->priv = devrec;
> -	devrec->hw->parent = &devrec->spi->dev;
> -	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
> -	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
>   
>   	dev_dbg(printdev(devrec), "registered mrf24j40\n");
>   	ret = ieee802154_register_hw(devrec->hw);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
