Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33724 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbH0RtT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 13:49:19 -0400
Received: by wicge2 with SMTP id ge2so466199wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 10:49:18 -0700 (PDT)
Date: Thu, 27 Aug 2015 19:49:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 17/21] mrf24j40: add cca mode support
Message-ID: <20150827174912.GC686@omega>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-18-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1439468568-22288-18-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com

On Thu, Aug 13, 2015 at 02:22:44PM +0200, Alexander Aring wrote:
> This patch supports cca mode handling for mrf24j40.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  drivers/net/ieee802154/mrf24j40.c | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index fdb0b84..0fc7628 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -789,6 +789,37 @@ mrf24j40_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
>  	return regmap_update_bits(devrec->regmap_short, REG_TXMCR, 0x1f, val);
>  }
>  
> +static int mrf24j40_set_cca_mode(struct ieee802154_hw *hw,
> +				 const struct wpan_phy_cca *cca)
> +{
> +	struct mrf24j40 *devrec = hw->priv;
> +	u8 val;
> +
> +	/* mapping 802.15.4 to driver spec */
> +	switch (cca->mode) {
> +	case NL802154_CCA_ENERGY:
> +		val = 2;
> +		break;
> +	case NL802154_CCA_CARRIER:
> +		val = 1;
> +		break;
> +	case NL802154_CCA_ENERGY_CARRIER:
> +		switch (cca->opt) {
> +		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:

changed NL802154_CCA_OPT_ENERGY_CARRIER_OR to
NL802154_CCA_OPT_ENERGY_CARRIER_AND.

Reason see below.

> +			val = 3;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(devrec->regmap_short, REG_BBREG2, 0xc0,
> +				  val << 6);
> +}
> +
>  static const struct ieee802154_ops mrf24j40_ops = {
>  	.owner = THIS_MODULE,
>  	.xmit_async = mrf24j40_tx,
> @@ -798,6 +829,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
>  	.set_channel = mrf24j40_set_channel,
>  	.set_hw_addr_filt = mrf24j40_filter,
>  	.set_csma_params = mrf24j40_csma_params,
> +	.set_cca_mode = mrf24j40_set_cca_mode,
>  };
>  
>  static void mrf24j40_intstat_complete(void *context)
> @@ -999,6 +1031,12 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
>  	/* We assume max_be is 802.15.4 default */
>  	devrec->hw->phy->supported.min_maxbe = 5;
>  	devrec->hw->phy->supported.max_maxbe = 5;
> +
> +	devrec->hw->phy->cca.mode = NL802154_CCA_CARRIER;;
> +	devrec->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
> +					       BIT(NL802154_CCA_CARRIER) |
> +					       BIT(NL802154_CCA_ENERGY_CARRIER);
> +	devrec->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND);

We set "NL802154_CCA_OPT_ENERGY_CARRIER_AND" here, I was not sure about
that and had "NL802154_CCA_OPT_ENERGY_CARRIER_OR" before.

I think it's "and" because there is a "and" in the explanation and no
"or".

"CCA Mode 3: Carrier sense with energy above threshold. CCA shall report
a busy medium only upon the detection of a signal with the modulation and
spreading characteristics of IEEE 802.15.4 with energy above the energy
Detection (ED) threshold."

I mean "...modulation and spreading...", otherwise I don't know if it's
or XOR and, but it must one of them.

- Alex
