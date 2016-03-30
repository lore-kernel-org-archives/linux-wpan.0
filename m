Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59231 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbcC3Ipl (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 04:45:41 -0400
Subject: Re: [PATCH v2 2/3] mrf24j40: fix security-enabled processing on
 inbound frames
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
 <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
 <1457988374-31220-2-git-send-email-web+oss@zopieux.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FB9231.8030108@osg.samsung.com>
Date: Wed, 30 Mar 2016 10:45:37 +0200
MIME-Version: 1.0
In-Reply-To: <1457988374-31220-2-git-send-email-web+oss@zopieux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandre Macabies <web+oss@zopieux.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Alan Ott <alan@signal11.us>

Hello.

Added Alan Ott in CC.

regards
Stefan Schmidt

On 14/03/16 21:46, Alexandre Macabies wrote:
> When receiving a security-enabled IEEE 802.15.4 frame, the MRF24J40
> triggers a SECIF interrupt that needs to be handled for RX processing
> to keep functioning properly.
>
> This patch enables the SECIF interrupt and makes the MRF ignores all
> hardware processing of security-enabled frames, that is handled by the
> ieee802154 stack instead.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 764a2bd..adc67be 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -85,10 +85,13 @@
>   #define REG_INTSTAT	0x31  /* Interrupt Status */
>   #define BIT_TXNIF	BIT(0)
>   #define BIT_RXIF	BIT(3)
> +#define BIT_SECIF	BIT(4)
> +#define BIT_SECIGNORE	BIT(7)
>   
>   #define REG_INTCON	0x32  /* Interrupt Control */
>   #define BIT_TXNIE	BIT(0)
>   #define BIT_RXIE	BIT(3)
> +#define BIT_SECIE	BIT(4)
>   
>   #define REG_GPIO	0x33  /* GPIO */
>   #define REG_TRISGPIO	0x34  /* GPIO direction */
> @@ -616,7 +619,7 @@ static int mrf24j40_start(struct ieee802154_hw *hw)
>   
>   	/* Clear TXNIE and RXIE. Enable interrupts */
>   	return regmap_update_bits(devrec->regmap_short, REG_INTCON,
> -				  BIT_TXNIE | BIT_RXIE, 0);
> +				  BIT_TXNIE | BIT_RXIE | BIT_SECIE, 0);
>   }
>   
>   static void mrf24j40_stop(struct ieee802154_hw *hw)
> @@ -1025,6 +1028,11 @@ static void mrf24j40_intstat_complete(void *context)
>   
>   	enable_irq(devrec->spi->irq);
>   
> +	/* Ignore Rx security decryption */
> +	if (intstat & BIT_SECIF)
> +		regmap_write_async(devrec->regmap_short, REG_SECCON0,
> +				   BIT_SECIGNORE);
> +
>   	/* Check for TX complete */
>   	if (intstat & BIT_TXNIF)
>   		ieee802154_xmit_complete(devrec->hw, devrec->tx_skb, false);

