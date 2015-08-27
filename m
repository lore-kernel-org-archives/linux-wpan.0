Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60422 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556AbbH0Nai (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:30:38 -0400
Subject: Re: [RFC bluetooth-next 11/21] mrf24j40: change to frame delivery
 with crc
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-12-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF10FA.7000800@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:30:34 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-12-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch changes the frame delivery to mac802154 with crc. This is
> useful for monitor interface types which deliver the crc to userspace.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 32de5d6..7e6a038 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -881,9 +881,6 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
>   		goto out;
>   	}
>   
> -	/* Cut off the checksum */
> -	skb_trim(skb, len-2);
> -
>   	/* TODO: Other drivers call ieee20154_rx_irqsafe() here (eg: cc2040,
>   	 * also from a workqueue).  I think irqsafe is not necessary here.
>   	 * Can someone confirm? */
> @@ -1060,7 +1057,7 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	devrec->hw = hw;
>   	devrec->hw->parent = &spi->dev;
>   	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
> -	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
> +	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
>   
>   	devrec->regmap_short = devm_regmap_init_spi(spi,
>   						    &mrf24j40_short_regmap);

Good change. Let the stack handle this part and decide on what the user 
wants (monitor mode or normal)

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
