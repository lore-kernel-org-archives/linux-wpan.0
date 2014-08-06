Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:63538 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaHFLiH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Aug 2014 07:38:07 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so3005884wib.8
        for <linux-wpan@vger.kernel.org>; Wed, 06 Aug 2014 04:38:05 -0700 (PDT)
Date: Wed, 6 Aug 2014 13:37:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140806113754.GA3995@omega>
References: <1407320016-2808-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1407320016-2808-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH linux-wpan] Add support for MRF24J40MC
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org, alan@signal11.us

Hi,

On Wed, Aug 06, 2014 at 11:13:36AM +0100, Simon Vincent wrote:
> The MRF24J40MC module has an external amplifier which should be enabled.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  drivers/net/ieee802154/mrf24j40.c | 40 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 9e6a124..7950d01 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -43,6 +43,8 @@
>  #define REG_TXSTBL   0x2E  /* TX Stabilization */
>  #define REG_INTSTAT  0x31  /* Interrupt Status */
>  #define REG_INTCON   0x32  /* Interrupt Control */
> +#define REG_GPIO     0x33  /* GPIO */
> +#define REG_TRISGPIO 0x34  /* GPIO direction */
>  #define REG_RFCTL    0x36  /* RF Control Mode Register */
>  #define REG_BBREG1   0x39  /* Baseband Registers */
>  #define REG_BBREG2   0x3A  /* */
> @@ -63,6 +65,7 @@
>  #define REG_SLPCON1    0x220
>  #define REG_WAKETIMEL  0x222  /* Wake-up Time Match Value Low */
>  #define REG_WAKETIMEH  0x223  /* Wake-up Time Match Value High */
> +#define REG_TESTMODE   0x22F  /* Test mode */
>  #define REG_RX_FIFO    0x300  /* Receive FIFO */
>  
>  /* Device configuration: Only channels 11-26 on page 0 are supported. */
> @@ -75,6 +78,8 @@
>  #define RX_FIFO_SIZE 144 /* From datasheet */
>  #define SET_CHANNEL_DELAY_US 192 /* From datasheet */
>  
> +enum modules { MRF24J40, MRF24J40MA, MRF24J40MC };
> +
>  /* Device Private Data */
>  struct mrf24j40 {
>  	struct spi_device *spi;
> @@ -690,6 +695,35 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
>  	if (ret)
>  		goto err_ret; 
> 
> +	if (spi_get_device_id(devrec->spi)->driver_data == MRF24J40MC) {
> +		/* Enable external amplifier */
> +		ret = write_long_reg(devrec, REG_TESTMODE, 0xF);
> +		if (ret)
> +			goto err_ret;
> +
> +		ret = read_short_reg(devrec, REG_TRISGPIO, &val);
> +		if (ret)
> +			goto err_ret;
> +
> +		val |= 0x8;
> +		ret = write_short_reg(devrec, REG_TRISGPIO, val);
> +		if (ret)
> +			goto err_ret;
> +
> +		ret = read_short_reg(devrec, REG_GPIO, &val);
> +		if (ret)
> +			goto err_ret;
> +
> +		val |= 0x8;
> +		ret = write_short_reg(devrec, REG_GPIO, val);
> +		if (ret)
> +			goto err_ret;
> +
> +		ret = write_long_reg(devrec, REG_RFCON3, 0x28);
> +		if (ret)
> +			goto err_ret;
> +	}
> +
>  	return 0;
>  
>  err_ret:
> @@ -778,8 +813,9 @@ static int mrf24j40_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id mrf24j40_ids[] = {
> -	{ "mrf24j40", 0 },
> -	{ "mrf24j40ma", 0 },
> +	{ "mrf24j40", MRF24J40 },
> +	{ "mrf24j40ma", MRF24J40MA },
> +	{ "mrf24j40mc", MRF24J40MC },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(spi, mrf24j40_ids);

this patch looks ok for me, can you please add "ieee802154: mrf24j40:"
at beginning of the first line of this commit msg?

For v2, please add linux-wpan@vger.kernel.org in cc.

Alan is this also okay for you?

- Alex
