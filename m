Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60701 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbbH1InY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 28 Aug 2015 04:43:24 -0400
Subject: Re: [RFC bluetooth-next 10/21] mrf24j40: use regmap for register
 access
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-11-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E01F28.4030303@osg.samsung.com>
Date: Fri, 28 Aug 2015 10:43:20 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-11-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch uses the regmap functions for transceiver register settings
> where it's possible. This means everything except the hotpaths like
> receive/transmit handling.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 147 +++++++++++++-------------------------
>   1 file changed, 50 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 6578f68..32de5d6 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -543,35 +543,6 @@ static int read_long_reg(struct mrf24j40 *devrec, u16 reg, u8 *value)
>   	return ret;
>   }
>   
> -static int write_long_reg(struct mrf24j40 *devrec, u16 reg, u8 val)
> -{
> -	int ret;
> -	u16 cmd;
> -	struct spi_message msg;
> -	struct spi_transfer xfer = {
> -		.len = 3,
> -		.tx_buf = devrec->buf,
> -		.rx_buf = devrec->buf,
> -	};
> -
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -
> -	cmd = MRF24J40_WRITELONG(reg);
> -	mutex_lock(&devrec->buffer_mutex);
> -	devrec->buf[0] = cmd >> 8 & 0xff;
> -	devrec->buf[1] = cmd & 0xff;
> -	devrec->buf[2] = val;
> -
> -	ret = spi_sync(devrec->spi, &msg);
> -	if (ret)
> -		dev_err(printdev(devrec),
> -			"SPI write Failed for long register 0x%hx\n", reg);
> -
> -	mutex_unlock(&devrec->buffer_mutex);
> -	return ret;
> -}
> -
>   /* This function relies on an undocumented write method. Once a write command
>      and address is set, as many bytes of data as desired can be clocked into
>      the device. The datasheet only shows setting one byte at a time. */
> @@ -755,33 +726,23 @@ static int mrf24j40_ed(struct ieee802154_hw *hw, u8 *level)
>   static int mrf24j40_start(struct ieee802154_hw *hw)
>   {
>   	struct mrf24j40 *devrec = hw->priv;
> -	u8 val;
> -	int ret;
>   
>   	dev_dbg(printdev(devrec), "start\n");
>   
> -	ret = read_short_reg(devrec, REG_INTCON, &val);
> -	if (ret)
> -		return ret;
> -	val &= ~(0x1|0x8); /* Clear TXNIE and RXIE. Enable interrupts */
> -	write_short_reg(devrec, REG_INTCON, val);
> -
> -	return 0;
> +	/* Clear TXNIE and RXIE. Enable interrupts */
> +	return regmap_update_bits(devrec->regmap_short, REG_INTCON,
> +				  0x01 | 0x08, 0x00);
>   }
>   
>   static void mrf24j40_stop(struct ieee802154_hw *hw)
>   {
>   	struct mrf24j40 *devrec = hw->priv;
> -	u8 val;
> -	int ret;
>   
>   	dev_dbg(printdev(devrec), "stop\n");
>   
> -	ret = read_short_reg(devrec, REG_INTCON, &val);
> -	if (ret)
> -		return;
> -	val |= 0x1|0x8; /* Set TXNIE and RXIE. Disable Interrupts */
> -	write_short_reg(devrec, REG_INTCON, val);
> +	/* Set TXNIE and RXIE. Disable Interrupts */
> +	regmap_update_bits(devrec->regmap_short, REG_INTCON, 0x01 | 0x08,
> +			   0x01 | 0x08);
>   }
>   
>   static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> @@ -798,20 +759,20 @@ static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>   
>   	/* Set Channel TODO */
>   	val = (channel-11) << 4 | 0x03;
> -	write_long_reg(devrec, REG_RFCON0, val);
> +	ret = regmap_update_bits(devrec->regmap_long, REG_RFCON0, 0xf0, val);
> +	if (ret)
> +		return ret;
>   
>   	/* RF Reset */
> -	ret = read_short_reg(devrec, REG_RFCTL, &val);
> +	ret = regmap_update_bits(devrec->regmap_short, REG_RFCTL, 0x04, 0x04);
>   	if (ret)
>   		return ret;
> -	val |= 0x04;
> -	write_short_reg(devrec, REG_RFCTL, val);
> -	val &= ~0x04;
> -	write_short_reg(devrec, REG_RFCTL, val);
>   
> -	udelay(SET_CHANNEL_DELAY_US); /* per datasheet */
> +	ret = regmap_update_bits(devrec->regmap_short, REG_RFCTL, 0x04, 0x00);
> +	if (!ret)
> +		udelay(SET_CHANNEL_DELAY_US); /* per datasheet */
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int mrf24j40_filter(struct ieee802154_hw *hw,
> @@ -829,8 +790,8 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
>   		addrh = le16_to_cpu(filt->short_addr) >> 8 & 0xff;
>   		addrl = le16_to_cpu(filt->short_addr) & 0xff;
>   
> -		write_short_reg(devrec, REG_SADRH, addrh);
> -		write_short_reg(devrec, REG_SADRL, addrl);
> +		regmap_write(devrec->regmap_short, REG_SADRH, addrh);
> +		regmap_write(devrec->regmap_short, REG_SADRL, addrl);
>   		dev_dbg(printdev(devrec),
>   			"Set short addr to %04hx\n", filt->short_addr);
>   	}
> @@ -841,7 +802,8 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
>   
>   		memcpy(addr, &filt->ieee_addr, 8);
>   		for (i = 0; i < 8; i++)
> -			write_short_reg(devrec, REG_EADR0 + i, addr[i]);
> +			regmap_write(devrec->regmap_short, REG_EADR0 + i,
> +				     addr[i]);
>   
>   #ifdef DEBUG
>   		pr_debug("Set long addr to: ");
> @@ -857,8 +819,8 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
>   
>   		panidh = le16_to_cpu(filt->pan_id) >> 8 & 0xff;
>   		panidl = le16_to_cpu(filt->pan_id) & 0xff;
> -		write_short_reg(devrec, REG_PANIDH, panidh);
> -		write_short_reg(devrec, REG_PANIDL, panidl);
> +		regmap_write(devrec->regmap_short, REG_PANIDH, panidh);
> +		regmap_write(devrec->regmap_short, REG_PANIDL, panidl);
>   
>   		dev_dbg(printdev(devrec), "Set PANID to %04hx\n", filt->pan_id);
>   	}
> @@ -868,14 +830,14 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
>   		u8 val;
>   		int ret;
>   
> -		ret = read_short_reg(devrec, REG_RXMCR, &val);
> -		if (ret)
> -			return ret;
>   		if (filt->pan_coord)
> -			val |= 0x8;
> +			val = 0x8;
>   		else
> -			val &= ~0x8;
> -		write_short_reg(devrec, REG_RXMCR, val);
> +			val = 0x0;
> +		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x8,
> +					 val);
> +		if (ret)
> +			return ret;
>   
>   		/* REG_SLOTTED is maintained as default (unslotted/CSMA-CA).
>   		 * REG_ORDER is maintained as default (no beacon/superframe).
> @@ -976,80 +938,73 @@ out:
>   static int mrf24j40_hw_init(struct mrf24j40 *devrec)
>   {
>   	int ret;
> -	u8 val;
>   
>   	/* Initialize the device.
>   		From datasheet section 3.2: Initialization. */
> -	ret = write_short_reg(devrec, REG_SOFTRST, 0x07);
> +	ret = regmap_write(devrec->regmap_short, REG_SOFTRST, 0x07);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_PACON2, 0x98);
> +	ret = regmap_write(devrec->regmap_short, REG_PACON2, 0x98);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_TXSTBL, 0x95);
> +	ret = regmap_write(devrec->regmap_short, REG_TXSTBL, 0x95);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_RFCON0, 0x03);
> +	ret = regmap_write(devrec->regmap_long, REG_RFCON0, 0x03);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_RFCON1, 0x01);
> +	ret = regmap_write(devrec->regmap_long, REG_RFCON1, 0x01);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_RFCON2, 0x80);
> +	ret = regmap_write(devrec->regmap_long, REG_RFCON2, 0x80);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_RFCON6, 0x90);
> +	ret = regmap_write(devrec->regmap_long, REG_RFCON6, 0x90);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_RFCON7, 0x80);
> +	ret = regmap_write(devrec->regmap_long, REG_RFCON7, 0x80);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_RFCON8, 0x10);
> +	ret = regmap_write(devrec->regmap_long, REG_RFCON8, 0x10);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_long_reg(devrec, REG_SLPCON1, 0x21);
> +	ret = regmap_write(devrec->regmap_long, REG_SLPCON1, 0x21);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_BBREG2, 0x80);
> +	ret = regmap_write(devrec->regmap_short, REG_BBREG2, 0x80);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_CCAEDTH, 0x60);
> +	ret = regmap_write(devrec->regmap_short, REG_CCAEDTH, 0x60);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_BBREG6, 0x40);
> +	ret = regmap_write(devrec->regmap_short, REG_BBREG6, 0x40);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_RFCTL, 0x04);
> +	ret = regmap_write(devrec->regmap_short, REG_RFCTL, 0x04);
>   	if (ret)
>   		goto err_ret;
>   
> -	ret = write_short_reg(devrec, REG_RFCTL, 0x0);
> +	ret = regmap_write(devrec->regmap_short, REG_RFCTL, 0x0);
>   	if (ret)
>   		goto err_ret;
>   
>   	udelay(192);
>   
>   	/* Set RX Mode. RXMCR<1:0>: 0x0 normal, 0x1 promisc, 0x2 error */
> -	ret = read_short_reg(devrec, REG_RXMCR, &val);
> -	if (ret)
> -		goto err_ret;
> -
> -	val &= ~0x3; /* Clear RX mode (normal) */
> -
> -	ret = write_short_reg(devrec, REG_RXMCR, val);
> +	ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x03, 0x00);
>   	if (ret)
>   		goto err_ret;
>   
> @@ -1057,22 +1012,20 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
>   		/* Enable external amplifier.
>   		 * From MRF24J40MC datasheet section 1.3: Operation.
>   		 */
> -		read_long_reg(devrec, REG_TESTMODE, &val);
> -		val |= 0x7; /* Configure GPIO 0-2 to control amplifier */
> -		write_long_reg(devrec, REG_TESTMODE, val);
> +		regmap_update_bits(devrec->regmap_long, REG_TESTMODE, 0x07,
> +				   0x07);
>   
> -		read_short_reg(devrec, REG_TRISGPIO, &val);
> -		val |= 0x8; /* Set GPIO3 as output. */
> -		write_short_reg(devrec, REG_TRISGPIO, val);
> +		/* Set GPIO3 as output. */
> +		regmap_update_bits(devrec->regmap_short, REG_TRISGPIO, 0x08,
> +				   0x08);
>   
> -		read_short_reg(devrec, REG_GPIO, &val);
> -		val |= 0x8; /* Set GPIO3 HIGH to enable U5 voltage regulator */
> -		write_short_reg(devrec, REG_GPIO, val);
> +		/* Set GPIO3 HIGH to enable U5 voltage regulator */
> +		regmap_update_bits(devrec->regmap_short, REG_GPIO, 0x08, 0x08);
>   
>   		/* Reduce TX pwr to meet FCC requirements.
>   		 * From MRF24J40MC datasheet section 3.1.1
>   		 */
> -		write_long_reg(devrec, REG_RFCON3, 0x28);
> +		regmap_write(devrec->regmap_long, REG_RFCON3, 0x28);
>   	}
>   
>   	return 0;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
