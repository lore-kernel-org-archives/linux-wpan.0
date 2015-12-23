Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33424 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbbLWJzs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Dec 2015 04:55:48 -0500
Received: by mail-wm0-f44.google.com with SMTP id p187so138315357wmp.0
        for <linux-wpan@vger.kernel.org>; Wed, 23 Dec 2015 01:55:47 -0800 (PST)
Date: Wed, 23 Dec 2015 10:55:43 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 1/1] ieee802154: cc2520: Check CRC & add promiscuous
Message-ID: <20151223095542.GB2075@omega>
References: <1450858678-59333-1-git-send-email-bradjc5@gmail.com>
 <1450858678-59333-2-git-send-email-bradjc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450858678-59333-2-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Wed, Dec 23, 2015 at 03:17:58AM -0500, Brad Campbell wrote:
> This patch adds checking the "CRC_OK" bit at the end of packets coming
> from the CC2520 radio. It also adds support for putting the radio in
> promiscuous mode (in which packets are not dropped if the CRC fails).
> In order to provide monitors information about CRC pass/fail, the CRC is
> recreated in the driver and appended to the packet before being passed
> to higher layers. If the CRC failed, a dummy CRC is appended.
> 

Why append a dummy CRC? There is a CRC and leave it there.

There could be one reason to do this:

There is no CRC appended when CRC failed.

Is this true? I don't know how the CC2520 is working and why it should
do this.



> NOTE: This is an API breaking change for the CC2520 radio. The radio now
> defaults to frame filtering (checking that the destination and PANID in
> the incoming packet matches the local node). This matches the other
> 15.4 radios and is what a user would expect to be the default.
> 

Was the frame filtering stuff disabled before? Then this is no API
change, it's an improvement for CC2520.

It would be an API change if the frame filtering of CC2520 is not
802.15.4 compliant.

Maybe it breaks API now but then this is a TODO/BUG in mac802154.

> Other changes:
> 
> 1. Adds LQI calculation
> 2. Makes #defines for relevant bit fields in CC2520 registers
> 
> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> ---
>  drivers/net/ieee802154/cc2520.c | 128 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 111 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index e65b605..3d66717 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -21,6 +21,8 @@
>  #include <linux/skbuff.h>
>  #include <linux/of_gpio.h>
>  #include <linux/ieee802154.h>
> +#include <linux/crc-ccitt.h>
> +#include <asm/unaligned.h>
>  
>  #include <net/mac802154.h>
>  #include <net/cfg802154.h>
> @@ -189,6 +191,18 @@
>  #define	CC2520_RXFIFOCNT		0x3E
>  #define	CC2520_TXFIFOCNT		0x3F
>  
> +/* CC2520_FRMFILT0 */
> +#define FRMFILT0_FRAME_FILTER_EN	BIT(0)
> +#define FRMFILT0_PAN_COORDINATOR	BIT(1)
> +
> +/* CC2520_FRMCTRL0 */
> +#define FRMCTRL0_AUTOACK		BIT(5)
> +#define FRMCTRL0_AUTOCRC		BIT(6)
> +
> +/* CC2520_FRMCTRL1 */
> +#define FRMCTRL1_SET_RXENMASK_ON_TX	BIT(0)
> +#define FRMCTRL1_IGNORE_TX_UNDERF	BIT(1)
> +
>  /* Driver private information */
>  struct cc2520_private {
>  	struct spi_device *spi;		/* SPI device structure */
> @@ -201,6 +215,7 @@ struct cc2520_private {
>  	struct work_struct fifop_irqwork;/* Workqueue for FIFOP */
>  	spinlock_t lock;		/* Lock for is_tx*/
>  	struct completion tx_complete;	/* Work completion for Tx */
> +	bool promiscuous;               /* Flag for promiscuous mode */
>  };
>  
>  /* Generic Functions */
> @@ -414,7 +429,7 @@ cc2520_write_txfifo(struct cc2520_private *priv, u8 *data, u8 len)
>  }
>  
>  static int
> -cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len, u8 *lqi)
> +cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len)
>  {
>  	int status;
>  	struct spi_message msg;
> @@ -516,24 +531,67 @@ err_tx:
>  static int cc2520_rx(struct cc2520_private *priv)
>  {
>  	u8 len = 0, lqi = 0, bytes = 1;
> +	bool crc_ok;
> +	u16 crc;
>  	struct sk_buff *skb;
>  
> -	cc2520_read_rxfifo(priv, &len, bytes, &lqi);
> +	/* Read single length byte from the radio. */
> +	cc2520_read_rxfifo(priv, &len, bytes);
>  
> -	if (len < 2 || len > IEEE802154_MTU)
> -		return -EINVAL;
> +	if (!ieee802154_is_valid_psdu_len(len)) {
> +		/* Corrupted frame received, clear frame buffer by
> +		 * reading entire buffer.
> +		 */
> +		dev_dbg(&priv->spi->dev, "corrupted frame received\n");
> +		len = IEEE802154_MTU;
> +	}
>  
>  	skb = dev_alloc_skb(len);
>  	if (!skb)
>  		return -ENOMEM;
>  
> -	if (cc2520_read_rxfifo(priv, skb_put(skb, len), len, &lqi)) {
> +	if (cc2520_read_rxfifo(priv, skb_put(skb, len), len)) {
>  		dev_dbg(&priv->spi->dev, "frame reception failed\n");
>  		kfree_skb(skb);
>  		return -EINVAL;
>  	}
>  
> -	skb_trim(skb, skb->len - 2);

This code told me before it was there: we cut off the CRC for delivery.

> +	/* Check if the CRC is valid and calculate LQI. With AUTOCRC set,
> +	 * the most significant bit of the last byte returned from the CC2520
> +	 * is CRC_OK flag. See section 20.3.4 of the datasheet. To calculate
> +	 * LQI, the lower 7 bits of the last byte (the correlation value
> +	 * provided by the radio) must be scaled to the range 0-255. According
> +	 * to section 20.6, the correlation value ranges from 50-110. Ideally
> +	 * this would be calibrated per hardware design, but we use roughly the
> +	 * datasheet values to get close enough while avoiding floating point.
> +	 */
> +	crc_ok = skb->data[len - 1] & BIT(7);
> +	lqi = skb->data[len - 1] & 0x7f;
> +	if (lqi < 50)
> +		lqi = 50;
> +	else if (lqi > 113)
> +		lqi = 113;
> +	lqi = (lqi - 50) * 4;
> +
> +	/* If we failed CRC and we are not in promiscuous mode, drop the
> +	 * packet in the driver layer.
> +	 */
> +	if (!crc_ok && !priv->promiscuous) {
> +		dev_dbg(&priv->spi->dev, "CRC check failed\n");
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
> +	/* We pass the packet up to the mac layer if the CRC is valid or
> +	 * unconditionally in promiscuous mode. We do need to append the
> +	 * original CRC bytes for the upper layer, and we calculate them
> +	 * here so that we can ensure that we append a bad CRC if the check
> +	 * failed.
> +	 */
> +	crc = crc_ccitt(0, skb->data, skb->len - 2);
> +	if (!crc_ok)
> +		crc = ~crc;
> +	put_unaligned_le16(crc, skb->data + len - 2);
>  

Now you append one again, but in an area which is not prepared to put
some data there, because there is no "skb_put" again. I don't understand
this part, is there no CRC comming from cc2520 transceiver, but then I
don't understand the "skb_trim(skb, skb->len - 2);" which was before
there and I think it was the CRC.

I think it's fine to remove this part, did you test it with monitor
interface and node interface?

>  	ieee802154_rx_irqsafe(priv->hw, skb, lqi);
>  
> @@ -619,14 +677,19 @@ cc2520_filter(struct ieee802154_hw *hw,
>  	}
>  
>  	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
> +		u8 frmfilt0;
> +
>  		dev_vdbg(&priv->spi->dev,
>  			 "cc2520_filter called for panc change\n");
> +
> +		cc2520_read_register(priv, CC2520_FRMFILT0, &frmfilt0);
> +
>  		if (filt->pan_coord)
> -			ret = cc2520_write_register(priv, CC2520_FRMFILT0,
> -						    0x02);
> +			frmfilt0 |= FRMFILT0_PAN_COORDINATOR;
>  		else
> -			ret = cc2520_write_register(priv, CC2520_FRMFILT0,
> -						    0x00);
> +			frmfilt0 &= ~FRMFILT0_PAN_COORDINATOR;
> +
> +		ret = cc2520_write_register(priv, CC2520_FRMFILT0, frmfilt0);
>  	}
>  
>  	return ret;

You need to be sure here that this function does not enable again some
filtering stuff bit's which was set by "set_promiscuous_mode". Is this
the case then we need to do more handling here (maybe with
priv->promiscuous).

This functionality should really only set the address filtering stuff
_not_ enable it (if possible). Is this the case, then the function
should be fine.

> @@ -723,6 +786,30 @@ cc2520_set_txpower(struct ieee802154_hw *hw, s32 mbm)
>  	return cc2520_cc2591_set_tx_power(priv, mbm);
>  }
>  
> +static int
> +cc2520_set_promiscuous_mode(struct ieee802154_hw *hw, bool on)
> +{
> +	struct cc2520_private *priv = hw->priv;
> +	u8 frmfilt0;
> +
> +	dev_dbg(&priv->spi->dev, "%s : mode %d\n", __func__, on);
> +
> +	priv->promiscuous = on;
> +
> +	cc2520_read_register(priv, CC2520_FRMFILT0, &frmfilt0);
> +
> +	if (on) {
> +		/* Disable automatic ACK and frame filtering. */
> +		cc2520_write_register(priv, CC2520_FRMCTRL0, FRMCTRL0_AUTOCRC);
> +		frmfilt0 &= ~FRMFILT0_FRAME_FILTER_EN;
The frmfilt0 was readout before doing:
"cc2520_write_register(priv, CC2520_FRMCTRL0, FRMCTRL0_AUTOCRC);"

Are you sure that this will not change again the setting og
FRMCTRL0_AUTOCRC when set it again below.

Simple do all manipulations (update bits) in "frmfilt0", then write it
below.

> +	} else {
> +		cc2520_write_register(priv, CC2520_FRMCTRL0, FRMCTRL0_AUTOACK |
> +							     FRMCTRL0_AUTOCRC);
> +		frmfilt0 |= FRMFILT0_FRAME_FILTER_EN;
> +	}

Maybe the FRMCTRL0_AUTOCRC will unset here it's the same register.

> +	return cc2520_write_register(priv, CC2520_FRMFILT0, frmfilt0);
> +}
> +
>  static const struct ieee802154_ops cc2520_ops = {
>  	.owner = THIS_MODULE,
>  	.start = cc2520_start,
> @@ -732,6 +819,7 @@ static const struct ieee802154_ops cc2520_ops = {
>  	.set_channel = cc2520_set_channel,
>  	.set_hw_addr_filt = cc2520_filter,
>  	.set_txpower = cc2520_set_txpower,
> +	.set_promiscuous_mode = cc2520_set_promiscuous_mode,
>  };
>  
>  static int cc2520_register(struct cc2520_private *priv)
> @@ -749,7 +837,8 @@ static int cc2520_register(struct cc2520_private *priv)
>  
>  	/* We do support only 2.4 Ghz */
>  	priv->hw->phy->supported.channels[0] = 0x7FFF800;
> -	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
> +	priv->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> +			  IEEE802154_HW_PROMISCUOUS;
>  
>  	priv->hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
>  
> @@ -919,6 +1008,11 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  	}
>  
>  	/* Registers default value: section 28.1 in Datasheet */
> +
> +	/* Set the CCA threshold to -50 dBm. This seems to have been copied
> +	 * from the TinyOS CC2520 driver and is much higher than the -84 dBm
> +	 * threshold suggested in the datasheet.
> +	 */

I think the CCA isn't working here inside the CC2520, because the CC2520
do _not_ CSMA handling on transceiver side. There need to be a handling
(maybe with hrtimers) which adds CSMA handling and doing CCA scans
before transmit, but the CC2520 driver doesn't has such functionality to
support CSMA-CA.

See my comments on this at [0].

>  	ret = cc2520_write_register(priv, CC2520_CCACTRL0, 0x1A);
>  	if (ret)
>  		goto err_ret;
> @@ -955,15 +1049,15 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  	if (ret)
>  		goto err_ret;
>  
> -	ret = cc2520_write_register(priv, CC2520_FRMCTRL0, 0x60);
> -	if (ret)
> -		goto err_ret;
> -
> -	ret = cc2520_write_register(priv, CC2520_FRMCTRL1, 0x03);
> +	/* Configure registers correctly for this driver. */
> +	ret = cc2520_write_register(priv, CC2520_FRMCTRL0, FRMCTRL0_AUTOACK |
> +							   FRMCTRL0_AUTOCRC);
>  	if (ret)
>  		goto err_ret;
>  
> -	ret = cc2520_write_register(priv, CC2520_FRMFILT0, 0x00);
> +	ret = cc2520_write_register(priv, CC2520_FRMCTRL1,
> +				    FRMCTRL1_SET_RXENMASK_ON_TX |
> +				    FRMCTRL1_IGNORE_TX_UNDERF);

I think:
You don't need to set this. Before calling "start" callback we will call
"set_promiscuous_mode" with on/off depends on monitor/node type.

same for enable the FRMCTRL0_AUTOACK. What you should enable here is
FRMCTRL0_AUTOCRC (I suppose for transmit).

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg03198.html
