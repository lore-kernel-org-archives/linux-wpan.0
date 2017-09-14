Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44731
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751165AbdINNaY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Sep 2017 09:30:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 4FFB5A0CAD
        for <linux-wpan@vger.kernel.org>; Thu, 14 Sep 2017 13:30:52 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jz8DucZPHYAr for <linux-wpan@vger.kernel.org>;
        Thu, 14 Sep 2017 13:30:48 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79C1B.dip0.t-ipconnect.de [217.247.156.27])
        by osg.samsung.com (Postfix) with ESMTPSA id EEC95A097F
        for <linux-wpan@vger.kernel.org>; Thu, 14 Sep 2017 13:30:47 +0000 (UTC)
Subject: Re: [PATCH bluetooth-next v2 1/1] ieee802154: atusb: Driver for
 Busware HUL dongle
References: <20170914123210.3765-1-j.filzmaier@gmx.at>
 <20170914123210.3765-2-j.filzmaier@gmx.at>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <f5e2abce-7232-2493-9fcb-ff28b8f3adec@osg.samsung.com>
Date: Thu, 14 Sep 2017 15:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170914123210.3765-2-j.filzmaier@gmx.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 09/14/2017 02:32 PM, Josef Filzmaier wrote:
> Busware manufactured an USB dongle that is quite similar to
> the atben and rzusb USB dongles. that are already supported.
> This patch aims to support the Busware HUL dongle (called
> hulusb) alongside atusb and rzusb. hulusb is using the
> at86rf212 transceiver which is specifically designed to
> support the 700/800/900 MHz wave band.
> 
> The source code is heavily inspired by the existing atusb
> and at86rf2xx drivers.
> 
> Signed-off-by: Josef Filzmaier <j.filzmaier@gmx.at>

Happy with this one.

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt

> ---
>   drivers/net/ieee802154/atusb.c | 317 +++++++++++++++++++++++++++++++++++------
>   drivers/net/ieee802154/atusb.h |   8 ++
>   2 files changed, 285 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index ef688518ad77..115fa3f37a86 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -21,6 +21,9 @@
>    *
>    * USB initialization is
>    * Copyright (c) 2013 Alexander Aring <alex.aring@gmail.com>
> + *
> + * Busware HUL support is
> + * Copyright (c) 2017 Josef Filzmaier <j.filzmaier@gmx.at>
>    */
>   
>   #include <linux/kernel.h>
> @@ -42,9 +45,12 @@
>   #define ATUSB_ALLOC_DELAY_MS	100	/* delay after failed allocation */
>   #define ATUSB_TX_TIMEOUT_MS	200	/* on the air timeout */
>   
> +struct atusb_chip_data;
> +
>   struct atusb {
>   	struct ieee802154_hw *hw;
>   	struct usb_device *usb_dev;
> +	struct atusb_chip_data *data;
>   	int shutdown;			/* non-zero if shutting down */
>   	int err;			/* set by first error */
>   
> @@ -65,6 +71,14 @@ struct atusb {
>   	unsigned char fw_hw_type;	/* Firmware hardware type */
>   };
>   
> +struct atusb_chip_data {
> +	u16 t_channel_switch;
> +	int rssi_base_val;
> +
> +	int (*set_channel)(struct ieee802154_hw*, u8, u8);
> +	int (*set_txpower)(struct ieee802154_hw*, s32);
> +};
> +
>   /* ----- USB commands without data ----------------------------------------- */
>   
>   /* To reduce the number of error checks in the code, we record the first error
> @@ -163,6 +177,18 @@ static int atusb_write_subreg(struct atusb *atusb, uint8_t reg, uint8_t mask,
>   	return ret;
>   }
>   
> +static int atusb_read_subreg(struct atusb *lp,
> +			     unsigned int addr, unsigned int mask,
> +			     unsigned int shift)
> +{
> +	int rc;
> +
> +	rc = atusb_read_reg(lp, addr);
> +	rc = (rc & mask) >> shift;
> +
> +	return rc;
> +}
> +
>   static int atusb_get_and_clear_error(struct atusb *atusb)
>   {
>   	int err = atusb->err;
> @@ -379,18 +405,6 @@ static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>   	return ret;
>   }
>   
> -static int atusb_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> -{
> -	struct atusb *atusb = hw->priv;
> -	int ret;
> -
> -	ret = atusb_write_subreg(atusb, SR_CHANNEL, channel);
> -	if (ret < 0)
> -		return ret;
> -	msleep(1);	/* @@@ ugly synchronization */
> -	return 0;
> -}
> -
>   static int atusb_ed(struct ieee802154_hw *hw, u8 *level)
>   {
>   	BUG_ON(!level);
> @@ -474,6 +488,17 @@ static const s32 atusb_powers[ATUSB_MAX_TX_POWERS + 1] = {
>   	-900, -1200, -1700,
>   };
>   
> +static int
> +atusb_txpower(struct ieee802154_hw *hw, s32 mbm)
> +{
> +	struct atusb *atusb = hw->priv;
> +
> +	if (atusb->data)
> +		return atusb->data->set_txpower(hw, mbm);
> +	else
> +		return -ENOTSUPP;
> +}
> +
>   static int
>   atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
>   {
> @@ -488,12 +513,43 @@ atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
>   	return -EINVAL;
>   }
>   
> +static int
> +hulusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < hw->phy->supported.tx_powers_size; i++) {
> +		if (hw->phy->supported.tx_powers[i] == mbm)
> +			return atusb_write_subreg(hw->priv, SR_TX_PWR_212, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   #define ATUSB_MAX_ED_LEVELS 0xF
>   static const s32 atusb_ed_levels[ATUSB_MAX_ED_LEVELS + 1] = {
>   	-9100, -8900, -8700, -8500, -8300, -8100, -7900, -7700, -7500, -7300,
>   	-7100, -6900, -6700, -6500, -6300, -6100,
>   };
>   
> +#define AT86RF212_MAX_TX_POWERS 0x1F
> +static const s32 at86rf212_powers[AT86RF212_MAX_TX_POWERS + 1] = {
> +	500, 400, 300, 200, 100, 0, -100, -200, -300, -400, -500, -600, -700,
> +	-800, -900, -1000, -1100, -1200, -1300, -1400, -1500, -1600, -1700,
> +	-1800, -1900, -2000, -2100, -2200, -2300, -2400, -2500, -2600,
> +};
> +
> +#define AT86RF2XX_MAX_ED_LEVELS 0xF
> +static const s32 at86rf212_ed_levels_100[AT86RF2XX_MAX_ED_LEVELS + 1] = {
> +	-10000, -9800, -9600, -9400, -9200, -9000, -8800, -8600, -8400, -8200,
> +	-8000, -7800, -7600, -7400, -7200, -7000,
> +};
> +
> +static const s32 at86rf212_ed_levels_98[AT86RF2XX_MAX_ED_LEVELS + 1] = {
> +	-9800, -9600, -9400, -9200, -9000, -8800, -8600, -8400, -8200, -8000,
> +	-7800, -7600, -7400, -7200, -7000, -6800,
> +};
> +
>   static int
>   atusb_set_cca_mode(struct ieee802154_hw *hw, const struct wpan_phy_cca *cca)
>   {
> @@ -527,6 +583,30 @@ atusb_set_cca_mode(struct ieee802154_hw *hw, const struct wpan_phy_cca *cca)
>   	return atusb_write_subreg(atusb, SR_CCA_MODE, val);
>   }
>   
> +static int hulusb_set_cca_ed_level(struct atusb *lp, int rssi_base_val)
> +{
> +	unsigned int cca_ed_thres;
> +
> +	cca_ed_thres = atusb_read_subreg(lp, SR_CCA_ED_THRES);
> +
> +	switch (rssi_base_val) {
> +	case -98:
> +		lp->hw->phy->supported.cca_ed_levels = at86rf212_ed_levels_98;
> +		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf212_ed_levels_98);
> +		lp->hw->phy->cca_ed_level = at86rf212_ed_levels_98[cca_ed_thres];
> +		break;
> +	case -100:
> +		lp->hw->phy->supported.cca_ed_levels = at86rf212_ed_levels_100;
> +		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf212_ed_levels_100);
> +		lp->hw->phy->cca_ed_level = at86rf212_ed_levels_100[cca_ed_thres];
> +		break;
> +	default:
> +		WARN_ON(1);
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   atusb_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
>   {
> @@ -541,6 +621,92 @@ atusb_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
>   	return -EINVAL;
>   }
>   
> +static int atusb_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> +{
> +	struct atusb *atusb = hw->priv;
> +	int ret = -ENOTSUPP;
> +
> +	if (atusb->data) {
> +		ret = atusb->data->set_channel(hw, page, channel);
> +		/* @@@ ugly synchronization */
> +		msleep(atusb->data->t_channel_switch);
> +	}
> +
> +	return ret;
> +}
> +
> +static int atusb_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> +{
> +	struct atusb *atusb = hw->priv;
> +	int ret;
> +
> +	ret = atusb_write_subreg(atusb, SR_CHANNEL, channel);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
> +static int hulusb_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> +{
> +	int rc;
> +	int rssi_base_val;
> +
> +	struct atusb *lp = hw->priv;
> +
> +	if (channel == 0)
> +		rc = atusb_write_subreg(lp, SR_SUB_MODE, 0);
> +	else
> +		rc = atusb_write_subreg(lp, SR_SUB_MODE, 1);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (page == 0) {
> +		rc = atusb_write_subreg(lp, SR_BPSK_QPSK, 0);
> +		rssi_base_val = -100;
> +	} else {
> +		rc = atusb_write_subreg(lp, SR_BPSK_QPSK, 1);
> +		rssi_base_val = -98;
> +	}
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = hulusb_set_cca_ed_level(lp, rssi_base_val);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* This sets the symbol_duration according frequency on the 212.
> +	 * TODO move this handling while set channel and page in cfg802154.
> +	 * We can do that, this timings are according 802.15.4 standard.
> +	 * If we do that in cfg802154, this is a more generic calculation.
> +	 *
> +	 * This should also protected from ifs_timer. Means cancel timer and
> +	 * init with a new value. For now, this is okay.
> +	 */
> +	if (channel == 0) {
> +		if (page == 0) {
> +			/* SUB:0 and BPSK:0 -> BPSK-20 */
> +			lp->hw->phy->symbol_duration = 50;
> +		} else {
> +			/* SUB:1 and BPSK:0 -> BPSK-40 */
> +			lp->hw->phy->symbol_duration = 25;
> +		}
> +	} else {
> +		if (page == 0)
> +			/* SUB:0 and BPSK:1 -> OQPSK-100/200/400 */
> +			lp->hw->phy->symbol_duration = 40;
> +		else
> +			/* SUB:1 and BPSK:1 -> OQPSK-250/500/1000 */
> +			lp->hw->phy->symbol_duration = 16;
> +	}
> +
> +	lp->hw->phy->lifs_period = IEEE802154_LIFS_PERIOD *
> +				   lp->hw->phy->symbol_duration;
> +	lp->hw->phy->sifs_period = IEEE802154_SIFS_PERIOD *
> +				   lp->hw->phy->symbol_duration;
> +
> +	return atusb_write_subreg(lp, SR_CHANNEL, channel);
> +}
> +
>   static int
>   atusb_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be, u8 retries)
>   {
> @@ -558,6 +724,14 @@ atusb_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be, u8 retries
>   	return atusb_write_subreg(atusb, SR_MAX_CSMA_RETRIES, retries);
>   }
>   
> +static int
> +hulusb_set_lbt(struct ieee802154_hw *hw, bool on)
> +{
> +	struct atusb *atusb = hw->priv;
> +
> +	return atusb_write_subreg(atusb, SR_CSMA_LBT_MODE, on);
> +}
> +
>   static int
>   atusb_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
>   {
> @@ -593,6 +767,20 @@ atusb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
>   	return 0;
>   }
>   
> +struct atusb_chip_data atusb_chip_data = {
> +	.t_channel_switch = 1,
> +	.rssi_base_val = -91,
> +	.set_txpower = atusb_set_txpower,
> +	.set_channel = atusb_set_channel,
> +};
> +
> +struct atusb_chip_data hulusb_chip_data = {
> +	.t_channel_switch = 11,
> +	.rssi_base_val = -100,
> +	.set_txpower = hulusb_set_txpower,
> +	.set_channel = hulusb_set_channel,
> +};
> +
>   static const struct ieee802154_ops atusb_ops = {
>   	.owner			= THIS_MODULE,
>   	.xmit_async		= atusb_xmit,
> @@ -601,7 +789,8 @@ static const struct ieee802154_ops atusb_ops = {
>   	.start			= atusb_start,
>   	.stop			= atusb_stop,
>   	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
> -	.set_txpower		= atusb_set_txpower,
> +	.set_txpower		= atusb_txpower,
> +	.set_lbt		= hulusb_set_lbt,
>   	.set_cca_mode		= atusb_set_cca_mode,
>   	.set_cca_ed_level	= atusb_set_cca_ed_level,
>   	.set_csma_params	= atusb_set_csma_params,
> @@ -614,6 +803,7 @@ static const struct ieee802154_ops atusb_ops = {
>   static int atusb_get_and_show_revision(struct atusb *atusb)
>   {
>   	struct usb_device *usb_dev = atusb->usb_dev;
> +	char *hw_name;
>   	unsigned char *buffer;
>   	int ret;
>   
> @@ -630,9 +820,31 @@ static int atusb_get_and_show_revision(struct atusb *atusb)
>   		atusb->fw_ver_min = buffer[1];
>   		atusb->fw_hw_type = buffer[2];
>   
> +		switch (atusb->fw_hw_type) {
> +		case ATUSB_HW_TYPE_100813:
> +		case ATUSB_HW_TYPE_101216:
> +		case ATUSB_HW_TYPE_110131:
> +			hw_name = "ATUSB";
> +			atusb->data = &atusb_chip_data;
> +			break;
> +		case ATUSB_HW_TYPE_RZUSB:
> +			hw_name = "RZUSB";
> +			atusb->data = &atusb_chip_data;
> +			break;
> +		case ATUSB_HW_TYPE_HULUSB:
> +			hw_name = "HULUSB";
> +			atusb->data = &hulusb_chip_data;
> +			break;
> +		default:
> +			hw_name = "UNKNOWN";
> +			atusb->err = -ENOTSUPP;
> +			ret = -ENOTSUPP;
> +			break;
> +		}
> +
>   		dev_info(&usb_dev->dev,
> -			 "Firmware: major: %u, minor: %u, hardware type: %u\n",
> -			 atusb->fw_ver_maj, atusb->fw_ver_min, atusb->fw_hw_type);
> +			 "Firmware: major: %u, minor: %u, hardware type: %s (%d)\n",
> +			 atusb->fw_ver_maj, atusb->fw_ver_min, hw_name, atusb->fw_hw_type);
>   	}
>   	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 2) {
>   		dev_info(&usb_dev->dev,
> @@ -667,11 +879,12 @@ static int atusb_get_and_show_build(struct atusb *atusb)
>   	return ret;
>   }
>   
> -static int atusb_get_and_show_chip(struct atusb *atusb)
> +static int atusb_get_and_conf_chip(struct atusb *atusb)
>   {
>   	struct usb_device *usb_dev = atusb->usb_dev;
>   	uint8_t man_id_0, man_id_1, part_num, version_num;
>   	const char *chip;
> +	struct ieee802154_hw *hw = atusb->hw;
>   
>   	man_id_0 = atusb_read_reg(atusb, RG_MAN_ID_0);
>   	man_id_1 = atusb_read_reg(atusb, RG_MAN_ID_1);
> @@ -681,6 +894,22 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
>   	if (atusb->err)
>   		return atusb->err;
>   
> +	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> +		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
> +
> +	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL |
> +			 WPAN_PHY_FLAG_CCA_MODE;
> +
> +	hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
> +				       BIT(NL802154_CCA_CARRIER) |
> +				       BIT(NL802154_CCA_ENERGY_CARRIER);
> +	hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
> +				      BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
> +
> +	hw->phy->cca.mode = NL802154_CCA_ENERGY;
> +
> +	hw->phy->current_page = 0;
> +
>   	if ((man_id_1 << 8 | man_id_0) != ATUSB_JEDEC_ATMEL) {
>   		dev_err(&usb_dev->dev,
>   			"non-Atmel transceiver xxxx%02x%02x\n",
> @@ -691,9 +920,36 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
>   	switch (part_num) {
>   	case 2:
>   		chip = "AT86RF230";
> +		atusb->hw->phy->supported.channels[0] = 0x7FFF800;
> +		atusb->hw->phy->current_channel = 11;	/* reset default */
> +		atusb->hw->phy->symbol_duration = 16;
> +		atusb->hw->phy->supported.tx_powers = atusb_powers;
> +		atusb->hw->phy->supported.tx_powers_size = ARRAY_SIZE(atusb_powers);
> +		hw->phy->supported.cca_ed_levels = atusb_ed_levels;
> +		hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(atusb_ed_levels);
>   		break;
>   	case 3:
>   		chip = "AT86RF231";
> +		atusb->hw->phy->supported.channels[0] = 0x7FFF800;
> +		atusb->hw->phy->current_channel = 11;	/* reset default */
> +		atusb->hw->phy->symbol_duration = 16;
> +		atusb->hw->phy->supported.tx_powers = atusb_powers;
> +		atusb->hw->phy->supported.tx_powers_size = ARRAY_SIZE(atusb_powers);
> +		hw->phy->supported.cca_ed_levels = atusb_ed_levels;
> +		hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(atusb_ed_levels);
> +		break;
> +	case 7:
> +		chip = "AT86RF212";
> +		atusb->hw->flags |= IEEE802154_HW_LBT;
> +		atusb->hw->phy->supported.channels[0] = 0x00007FF;
> +		atusb->hw->phy->supported.channels[2] = 0x00007FF;
> +		atusb->hw->phy->current_channel = 5;
> +		atusb->hw->phy->symbol_duration = 25;
> +		atusb->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
> +		atusb->hw->phy->supported.tx_powers = at86rf212_powers;
> +		atusb->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf212_powers);
> +		atusb->hw->phy->supported.cca_ed_levels = at86rf212_ed_levels_100;
> +		atusb->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf212_ed_levels_100);
>   		break;
>   	default:
>   		dev_err(&usb_dev->dev,
> @@ -702,6 +958,9 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
>   		goto fail;
>   	}
>   
> +	hw->phy->transmit_power = hw->phy->supported.tx_powers[0];
> +	hw->phy->cca_ed_level = hw->phy->supported.cca_ed_levels[7];
> +
>   	dev_info(&usb_dev->dev, "ATUSB: %s version %d\n", chip, version_num);
>   
>   	return 0;
> @@ -794,32 +1053,9 @@ static int atusb_probe(struct usb_interface *interface,
>   		goto fail;
>   
>   	hw->parent = &usb_dev->dev;
> -	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> -		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
> -
> -	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL |
> -			 WPAN_PHY_FLAG_CCA_MODE;
> -
> -	hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
> -		BIT(NL802154_CCA_CARRIER) | BIT(NL802154_CCA_ENERGY_CARRIER);
> -	hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
> -		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
> -
> -	hw->phy->supported.cca_ed_levels = atusb_ed_levels;
> -	hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(atusb_ed_levels);
> -
> -	hw->phy->cca.mode = NL802154_CCA_ENERGY;
> -
> -	hw->phy->current_page = 0;
> -	hw->phy->current_channel = 11;	/* reset default */
> -	hw->phy->supported.channels[0] = 0x7FFF800;
> -	hw->phy->supported.tx_powers = atusb_powers;
> -	hw->phy->supported.tx_powers_size = ARRAY_SIZE(atusb_powers);
> -	hw->phy->transmit_power = hw->phy->supported.tx_powers[0];
> -	hw->phy->cca_ed_level = hw->phy->supported.cca_ed_levels[7];
>   
>   	atusb_command(atusb, ATUSB_RF_RESET, 0);
> -	atusb_get_and_show_chip(atusb);
> +	atusb_get_and_conf_chip(atusb);
>   	atusb_get_and_show_revision(atusb);
>   	atusb_get_and_show_build(atusb);
>   	atusb_set_extended_addr(atusb);
> @@ -941,5 +1177,6 @@ MODULE_AUTHOR("Alexander Aring <alex.aring@gmail.com>");
>   MODULE_AUTHOR("Richard Sharpe <realrichardsharpe@gmail.com>");
>   MODULE_AUTHOR("Stefan Schmidt <stefan@datenfreihafen.org>");
>   MODULE_AUTHOR("Werner Almesberger <werner@almesberger.net>");
> +MODULE_AUTHOR("Josef Filzmaier <j.filzmaier@gmx.at>");
>   MODULE_DESCRIPTION("ATUSB IEEE 802.15.4 Driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ieee802154/atusb.h b/drivers/net/ieee802154/atusb.h
> index b22bbaa77590..555d14bf14a3 100644
> --- a/drivers/net/ieee802154/atusb.h
> +++ b/drivers/net/ieee802154/atusb.h
> @@ -50,6 +50,14 @@ enum atusb_requests {
>   	ATUSB_EUI64_READ,
>   };
>   
> +enum {
> +	ATUSB_HW_TYPE_100813,	/* 2010-08-13 */
> +	ATUSB_HW_TYPE_101216,	/* 2010-12-16 */
> +	ATUSB_HW_TYPE_110131,	/* 2011-01-31, ATmega32U2-based */
> +	ATUSB_HW_TYPE_RZUSB,	/* Atmel Raven USB dongle with at86rf230 */
> +	ATUSB_HW_TYPE_HULUSB,	/* Busware HUL USB dongle with at86rf212 */
> +};
> +
>   /*
>    * Direction	bRequest		wValue		wIndex	wLength
>    *
> 
