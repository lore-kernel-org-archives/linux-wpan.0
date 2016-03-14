Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53612 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbcCNLFh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 14 Mar 2016 07:05:37 -0400
Subject: Re: [PATCH 2/3] mrf24j40: fix security-enabled processing on inbound
 frames
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
 <1457633643-12535-2-git-send-email-web+oss@zopieux.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56E69AFD.7010604@osg.samsung.com>
Date: Mon, 14 Mar 2016 12:05:33 +0100
MIME-Version: 1.0
In-Reply-To: <1457633643-12535-2-git-send-email-web+oss@zopieux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: web+oss@zopieux.com, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

Hello.

On 10/03/16 19:14, web+oss@zopieux.com wrote:
> From: Alexandre Macabies <web+oss@zopieux.com>
>
> When receiving a security-enabled IEEE 802.15.4 frame, the MRF24J40
> triggers a SECIF interrupt that needs to be handled for RX processing
> to keep functioning properly.
>
> This patch enables the SECIF interrupt and makes the MRF ignores all
> hardware processing of security-enabled frames, that is handled by the
> ieee802154 stack instead.

Missing SOB again.

> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Reported-by: Alexandre Macabies <web+oss@zopieux.com>
> Tested-by: Alexandre Macabies <web+oss@zopieux.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 764a2bd..96814cf 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -85,10 +85,12 @@
>   #define REG_INTSTAT	0x31  /* Interrupt Status */
>   #define BIT_TXNIF	BIT(0)
>   #define BIT_RXIF	BIT(3)
> +#define BIT_SECIF	BIT(4)
>   
>   #define REG_INTCON	0x32  /* Interrupt Control */
>   #define BIT_TXNIE	BIT(0)
>   #define BIT_RXIE	BIT(3)
> +#define BIT_SECIE	BIT(4)
>   
>   #define REG_GPIO	0x33  /* GPIO */
>   #define REG_TRISGPIO	0x34  /* GPIO direction */
> @@ -616,7 +618,7 @@ static int mrf24j40_start(struct ieee802154_hw *hw)
>   
>   	/* Clear TXNIE and RXIE. Enable interrupts */
>   	return regmap_update_bits(devrec->regmap_short, REG_INTCON,
> -				  BIT_TXNIE | BIT_RXIE, 0);
> +				  BIT_TXNIE | BIT_RXIE | BIT_SECIE, 0);
>   }
>   
>   static void mrf24j40_stop(struct ieee802154_hw *hw)
> @@ -1025,6 +1027,9 @@ static void mrf24j40_intstat_complete(void *context)
>   
>   	enable_irq(devrec->spi->irq);
>   
> +	if (intstat & BIT_SECIF)
> +		regmap_write_async(devrec->regmap_short, REG_SECCON0, 0x80);

Not sure I like the magic number 0x80 here. Maybe a define for it?
> +
>   	/* Check for TX complete */
>   	if (intstat & BIT_TXNIF)
>   		ieee802154_xmit_complete(devrec->hw, devrec->tx_skb, false);


With the SOB and the magic number fixed you get my:

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
