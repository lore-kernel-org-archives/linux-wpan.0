Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60441 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbbH0NrC (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:47:02 -0400
Subject: Re: [RFC bluetooth-next 16/21] mrf24j40: add csma params support
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-17-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF14D3.2030700@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:46:59 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-17-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch adds supports to change the CSMA parameters. The datasheet
> doesn't say anything about max_be value. Seems not configurable and we
> assume the 802.15.4 default. But this value must exists because there is
> a min_be value.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index e992bff..fdb0b84 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -769,6 +769,26 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
>   	return spi_async(devrec->spi, &devrec->rx_msg);
>   }
>   
> +static int
> +mrf24j40_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
> +		     u8 retries)
> +{
> +	struct mrf24j40 *devrec = hw->priv;
> +	u8 val;
> +
> +	/* datasheet doesn't say anything about max_be, but we have min_be
> +	 * So we assume the max_be default.
> +	 */
> +	WARN_ON(max_be != 5);
Hmm, the WARN_ON here should never trigger as long as no change is made 
to the driver, right? You advertise min_maxbe and max_maxbe both to 5 
below and this is the only value that could come from userspace. Maybe 
remove the WARN_ON here and move the comment below?

> +
> +	/* min_be */
> +	val = min_be << 3;
> +	/* csma backoffs */
> +	val |= retries;
> +
> +	return regmap_update_bits(devrec->regmap_short, REG_TXMCR, 0x1f, val);
> +}
> +
>   static const struct ieee802154_ops mrf24j40_ops = {
>   	.owner = THIS_MODULE,
>   	.xmit_async = mrf24j40_tx,
> @@ -777,6 +797,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
>   	.stop = mrf24j40_stop,
>   	.set_channel = mrf24j40_set_channel,
>   	.set_hw_addr_filt = mrf24j40_filter,
> +	.set_csma_params = mrf24j40_csma_params,
>   };
>   
>   static void mrf24j40_intstat_complete(void *context)
> @@ -972,6 +993,12 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
>   {
>   	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
>   	devrec->hw->phy->current_channel = 11;
> +
> +	/* mrf24j40 supports max_minbe 0 - 3 */
> +	devrec->hw->phy->supported.max_minbe = 3;
> +	/* We assume max_be is 802.15.4 default */
> +	devrec->hw->phy->supported.min_maxbe = 5;
> +	devrec->hw->phy->supported.max_maxbe = 5;
>   }
>   
>   static int mrf24j40_probe(struct spi_device *spi)
> @@ -994,7 +1021,8 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	devrec->hw = hw;
>   	devrec->hw->parent = &spi->dev;
>   	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
> -	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
> +	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> +			    IEEE802154_HW_CSMA_PARAMS;
>   
>   	mrf24j40_setup_tx_spi_messages(devrec);
>   	mrf24j40_setup_rx_spi_messages(devrec);

regards
Stefan Schmidt
