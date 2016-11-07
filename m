Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59994
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932237AbcKGQLh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Nov 2016 11:11:37 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH bluetooth-next] at86rf230: fix cca ed values for rf233
References: <20160906075004.15915-1-aar@pengutronix.de>
Message-ID: <06d2e518-947a-4806-d6d8-497ab77641af@osg.samsung.com>
Date: Mon, 7 Nov 2016 17:11:17 +0100
MIME-Version: 1.0
In-Reply-To: <20160906075004.15915-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 06/09/16 09:50, Alexander Aring wrote:
> This patch changes the rssi base value to -94 for at86rf33 transceivers.

Small typo here. rf22 instead of rf233. No idea if you want to respin 
for this.

> The code before assumes a rssi base value of -91 which is for the
> at86rf231 transceiver only. This change need to update the cca ed
> threshold mapping table.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> Compile tested only.
>
>  drivers/net/ieee802154/at86rf230.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 9f10da6..0570257 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -990,7 +990,12 @@ at86rf23x_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
>  }
>
>  #define AT86RF2XX_MAX_ED_LEVELS 0xF
> -static const s32 at86rf23x_ed_levels[AT86RF2XX_MAX_ED_LEVELS + 1] = {
> +static const s32 at86rf233_ed_levels[AT86RF2XX_MAX_ED_LEVELS + 1] = {
> +	-9400, -9200, -9000, -8800, -8600, -8400, -8200, -8000, -7800, -7600,
> +	-7400, -7200, -7000, -6800, -6600, -6400,
> +};
> +
> +static const s32 at86rf231_ed_levels[AT86RF2XX_MAX_ED_LEVELS + 1] = {
>  	-9100, -8900, -8700, -8500, -8300, -8100, -7900, -7700, -7500, -7300,
>  	-7100, -6900, -6700, -6500, -6300, -6100,
>  };
> @@ -1343,7 +1348,7 @@ static struct at86rf2xx_chip_data at86rf233_data = {
>  	.t_sleep_to_off = 1000,
>  	.t_frame = 4096,
>  	.t_p_ack = 545,
> -	.rssi_base_val = -91,
> +	.rssi_base_val = -94,
>  	.set_channel = at86rf23x_set_channel,
>  	.set_txpower = at86rf23x_set_txpower,
>  };
> @@ -1557,9 +1562,6 @@ at86rf230_detect_device(struct at86rf230_local *lp)
>  	lp->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
>  		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
>
> -	lp->hw->phy->supported.cca_ed_levels = at86rf23x_ed_levels;
> -	lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf23x_ed_levels);
> -
>  	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
>
>  	switch (part) {
> @@ -1575,6 +1577,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
>  		lp->hw->phy->symbol_duration = 16;
>  		lp->hw->phy->supported.tx_powers = at86rf231_powers;
>  		lp->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf231_powers);
> +		lp->hw->phy->supported.cca_ed_levels = at86rf231_ed_levels;
> +		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf231_ed_levels);
>  		break;
>  	case 7:
>  		chip = "at86rf212";
> @@ -1598,6 +1602,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
>  		lp->hw->phy->symbol_duration = 16;
>  		lp->hw->phy->supported.tx_powers = at86rf233_powers;
>  		lp->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf233_powers);
> +		lp->hw->phy->supported.cca_ed_levels = at86rf233_ed_levels;
> +		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf233_ed_levels);
>  		break;
>  	default:
>  		chip = "unknown";
>


Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
