Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38878 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbbH0RoU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 13:44:20 -0400
Received: by wicgk12 with SMTP id gk12so16426536wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 10:44:19 -0700 (PDT)
Date: Thu, 27 Aug 2015 19:44:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 18/21] mrf24j40: add cca ed level support
Message-ID: <20150827174400.GA686@omega>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-19-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1439468568-22288-19-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com

On Thu, Aug 13, 2015 at 02:22:45PM +0200, Alexander Aring wrote:
> This patch supports handling to set the cca energy detection level for
> the mrf24j40 transceiver.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  drivers/net/ieee802154/mrf24j40.c | 51 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 0fc7628..00fd97e 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -820,6 +820,49 @@ static int mrf24j40_set_cca_mode(struct ieee802154_hw *hw,
>  				  val << 6);
>  }
>  
> +/* array for representing ed levels */
> +static const s32 mrf24j40_ed_levels[] = {
> +	-9000, -8900, -8800, -8700, -8600, -8500, -8400, -8300, -8200, -8100,
> +	-8000, -7900, -7800, -7700, -7600, -7500, -7400, -7300, -7200, -7100,
> +	-7000, -6900, -6800, -6700, -6600, -6500, -6400, -6300, -6200, -6100,
> +	-6000, -5900, -5800, -5700, -5600, -5500, -5400, -5300, -5200, -5100,
> +	-5000, -4900, -4800, -4700, -4600, -4500, -4400, -4300, -4200, -4100,
> +	-4000, -3900, -3800, -3700, -3600, -3500
> +};
> +
> +/* map ed levels to register value */
> +static const s32 mrf24j40_ed_levels_map[][2] = {
> +	{ -9000, 0 }, { -8900, 1 }, { -8800, 2 }, { -8700, 5 }, { -8600, 9 },
> +	{ -8500, 13 }, { -8400, 18 }, { -8300, 23 }, { -8200, 27 },
> +	{ -8100, 32 }, { -8000, 37 }, { -7900, 43 }, { -7800, 48 },
> +	{ -7700, 53 }, { -7600, 58 }, { -7500, 63 }, { -7400, 68 },
> +	{ -7300, 73 }, { -7200, 78 }, { -7100, 83 }, { -7000, 89 },
> +	{ -6900, 95 }, { -6800, 100 }, { -6700, 107 }, { -6600, 111 },
> +	{ -6500, 117 }, { -6400, 121 }, { -6300, 125 }, { -6200, 129 },
> +	{ -6100, 133 },	{ -6000, 138 }, { -5900, 143 }, { -5800, 148 },
> +	{ -5700, 153 }, { -5600, 159 },	{ -5500, 165 }, { -5400, 170 },
> +	{ -5300, 176 }, { -5200, 183 }, { -5100, 188 }, { -5000, 193 },
> +	{ -4900, 198 }, { -4800, 203 }, { -4700, 207 }, { -4600, 212 },
> +	{ -4500, 216 }, { -4400, 221 }, { -4300, 225 }, { -4200, 228 },
> +	{ -4100, 233 }, { -4000, 239 }, { -3900, 245 }, { -3800, 250 },
> +	{ -3700, 253 }, { -3600, 254 }, { -3500, 255 },
> +};
> +
> +static int mrf24j40_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
> +{
> +	struct mrf24j40 *devrec = hw->priv;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mrf24j40_ed_levels_map); i++) {
> +		if (mrf24j40_ed_levels_map[i][0] == mbm)
> +			return regmap_update_bits(devrec->regmap_short,
> +						  REG_CCAEDTH, 0xff,
> +						  mrf24j40_ed_levels_map[i][1]);

I changed this function from regmap_update_bits to regmap_write, the
mask is "0xff" here and then regmap_write is enough.

- Alex
