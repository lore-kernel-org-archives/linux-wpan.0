Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60458 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbbH0OAn (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 10:00:43 -0400
Subject: Re: [RFC bluetooth-next 20/21] mrf24j40: add promiscuous mode support
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-21-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF1808.8010000@osg.samsung.com>
Date: Thu, 27 Aug 2015 16:00:40 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-21-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch adds support for promiscuous mode by setting promiscuous (no
> frame filtering), disable automatic ack handling and not filtering
> frames where the crc is invalid.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index e9a03fd..560db88 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -922,6 +922,24 @@ static int mrf24j40_set_txpower(struct ieee802154_hw *hw, s32 mbm)
>   	return regmap_update_bits(devrec->regmap_long, REG_RFCON3, 0xf8, val);
>   }
>   
> +static int mrf24j40_set_promiscuous_mode(struct ieee802154_hw *hw, bool on)
> +{
> +	struct mrf24j40 *devrec = hw->priv;
> +	int ret;
> +
> +	if (on) {
> +		/* set PROMI, ERRPKT and NOACKRSP */
> +		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x23,
> +					 0x23);
> +	} else {
> +		/* clear PROMI, ERRPKT and NOACKRSP */
> +		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x23,
> +					 0x00);

More magic numbers.

> +	}
> +
> +	return ret;
> +}
> +
>   static const struct ieee802154_ops mrf24j40_ops = {
>   	.owner = THIS_MODULE,
>   	.xmit_async = mrf24j40_tx,
> @@ -934,6 +952,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
>   	.set_cca_mode = mrf24j40_set_cca_mode,
>   	.set_cca_ed_level = mrf24j40_set_cca_ed_level,
>   	.set_txpower = mrf24j40_set_txpower,
> +	.set_promiscuous_mode = mrf24j40_set_promiscuous_mode,
>   };
>   
>   static void mrf24j40_intstat_complete(void *context)
> @@ -1178,7 +1197,8 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	devrec->hw->parent = &spi->dev;
>   	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
>   	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> -			    IEEE802154_HW_CSMA_PARAMS;
> +			    IEEE802154_HW_CSMA_PARAMS |
> +			    IEEE802154_HW_PROMISCUOUS;
>   
>   	devrec->hw->phy->flags = WPAN_PHY_FLAG_CCA_MODE |
>   				 WPAN_PHY_FLAG_CCA_ED_LEVEL;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
