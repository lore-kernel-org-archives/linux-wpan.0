Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43162 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933725AbbFPJT4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 05:19:56 -0400
Message-ID: <1434446394.3559.21.camel@pengutronix.de>
Subject: Re: [PATCHv2 bluetooth-next 1/3] at86rf230: fix phy settings while
 sleeping
From: Lucas Stach <l.stach@pengutronix.de>
Date: Tue, 16 Jun 2015 11:19:54 +0200
In-Reply-To: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Am Dienstag, den 16.06.2015, 11:07 +0200 schrieb Alexander Aring:
> While in sleep state then we can't access the at86rf2xx registers. This
> patch checks if the transceiver is in sleep state before sending spi
> messages via regmap. Regmap is used on every driver ops callback except
> for receive and xmit handling, but while receive and xmit handling the
> phy should not be inside the sleep state.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> change since v2:
>  - I detect an issue with cca ed level setting in v1, there was a return in the
>    middle of awake and sleep transceiver. This results that the transceiver
>    wasn't again turn into sleep state afterwards.
>    To avoid such behaviour I moved the awake and sleep into lowlevel register io
>    functions. These functions "could" be called only when the phy is in sleep
>    state.
> 
> 
>  drivers/net/ieee802154/at86rf230.c | 88 +++++++++++++++++++++++++++++---------
>  1 file changed, 68 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 6b31f47..b839bbd 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -90,6 +90,7 @@ struct at86rf230_local {
>  	struct at86rf2xx_chip_data *data;
>  	struct regmap *regmap;
>  	int slp_tr;
> +	bool sleep;

This should probably be a reference count instead of a simple bool. I
suppose there are more locations in the driver where you want to keep
the PHY awake.

Also this would allow you to throw away all those "if (sleep)" checks at
the callers. Just call at86rf230_phy_wake_get() before you do something
that needs the phy to be awake and increment the refcount there and have
a similar ..._put() function to decrement the refcount. Then toggle the
GPIO when the refcount is going 0->1 and the other way around.

Regards,
Lucas

>  
>  	struct completion state_complete;
>  	struct at86rf230_state_change state;
> @@ -114,18 +115,66 @@ at86rf230_async_state_change(struct at86rf230_local *lp,
>  			     const u8 state, void (*complete)(void *context),
>  			     const bool irq_enable);
>  
> +static inline void
> +at86rf230_sleep(struct at86rf230_local *lp)
> +{
> +	if (gpio_is_valid(lp->slp_tr)) {
> +		gpio_set_value(lp->slp_tr, 1);
> +		usleep_range(lp->data->t_off_to_sleep,
> +			     lp->data->t_off_to_sleep + 10);
> +		lp->sleep = true;
> +	}
> +}
> +
> +static inline void
> +at86rf230_awake(struct at86rf230_local *lp)
> +{
> +	if (gpio_is_valid(lp->slp_tr)) {
> +		gpio_set_value(lp->slp_tr, 0);
> +		usleep_range(lp->data->t_sleep_to_off,
> +			     lp->data->t_sleep_to_off + 100);
> +		lp->sleep = false;
> +	}
> +}
> +
>  static inline int
>  __at86rf230_write(struct at86rf230_local *lp,
>  		  unsigned int addr, unsigned int data)
>  {
> -	return regmap_write(lp->regmap, addr, data);
> +	bool sleep = lp->sleep;
> +	int ret;
> +
> +	/* awake for register setting if sleep */
> +	if (sleep)
> +		at86rf230_awake(lp);
> +
> +	ret = regmap_write(lp->regmap, addr, data);
> +
> +	/* sleep again if was sleeping */
> +	if (sleep)
> +		at86rf230_sleep(lp);
> +
> +	return ret;
>  }
>  
>  static inline int
>  __at86rf230_read(struct at86rf230_local *lp,
>  		 unsigned int addr, unsigned int *data)
>  {
> -	return regmap_read(lp->regmap, addr, data);
> +	bool sleep = lp->sleep;
> +	int ret;
> +
> +	/* awake for register setting if sleep */
> +	if (sleep)
> +		at86rf230_awake(lp);
> +
> +	ret = regmap_read(lp->regmap, addr, data);
> +
> +	/* sleep again if was sleeping */
> +	if (sleep)
> +		at86rf230_sleep(lp);
> +
> +	return ret;
>  }
>  
>  static inline int
> @@ -147,7 +196,20 @@ at86rf230_write_subreg(struct at86rf230_local *lp,
>  		       unsigned int addr, unsigned int mask,
>  		       unsigned int shift, unsigned int data)
>  {
> -	return regmap_update_bits(lp->regmap, addr, mask, data << shift);
> +	bool sleep = lp->sleep;
> +	int ret;
> +
> +	/* awake for register setting if sleep */
> +	if (sleep)
> +		at86rf230_awake(lp);
> +
> +	ret = regmap_update_bits(lp->regmap, addr, mask, data << shift);
> +
> +	/* sleep again if was sleeping */
> +	if (sleep)
> +		at86rf230_sleep(lp);
> +
> +	return ret;
>  }
>  
>  static inline void
> @@ -873,12 +935,7 @@ at86rf230_start(struct ieee802154_hw *hw)
>  {
>  	struct at86rf230_local *lp = hw->priv;
>  
> -	if (gpio_is_valid(lp->slp_tr)) {
> -		gpio_set_value(lp->slp_tr, 0);
> -		usleep_range(lp->data->t_sleep_to_off,
> -			     lp->data->t_sleep_to_off + 100);
> -	}
> -
> +	at86rf230_awake(lp);
>  	enable_irq(lp->spi->irq);
>  
>  	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
> @@ -892,12 +949,7 @@ at86rf230_stop(struct ieee802154_hw *hw)
>  	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
>  
>  	disable_irq(lp->spi->irq);
> -
> -	if (gpio_is_valid(lp->slp_tr)) {
> -		gpio_set_value(lp->slp_tr, 1);
> -		usleep_range(lp->data->t_off_to_sleep,
> -			     lp->data->t_off_to_sleep + 10);
> -	}
> +	at86rf230_sleep(lp);
>  }
>  
>  static int
> @@ -1672,11 +1724,7 @@ static int at86rf230_probe(struct spi_device *spi)
>  	disable_irq(spi->irq);
>  
>  	/* going into sleep by default */
> -	if (gpio_is_valid(slp_tr)) {
> -		gpio_set_value(slp_tr, 1);
> -		usleep_range(lp->data->t_off_to_sleep,
> -			     lp->data->t_off_to_sleep + 10);
> -	}
> +	at86rf230_sleep(lp);
>  
>  	rc = ieee802154_register_hw(lp->hw);
>  	if (rc)

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

