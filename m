Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32901 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbbFFTtL (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sat, 6 Jun 2015 15:49:11 -0400
Message-ID: <55734EB2.9020508@osg.samsung.com>
Date: Sat, 06 Jun 2015 21:49:06 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 3/8] mac802154: remove aack hw flag
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com> <1433604653-9585-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-4-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Stefan Schmidt <s.schmidt@samsung.com>, Varka Bhadram <varkab@cdac.in>, Alan Ott <alan@signal11.us>

Hello.

On 06/06/15 17:30, Alexander Aring wrote:
> This patch removes the hardware auto acknowdledge flag which indicates
> that the transceiver supports this handling. This flag is never
> evaluated inside mac802154 and all transceivers should support this
> handling by default per hardware.
>
> Suggested-by: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Stefan Schmidt <s.schmidt@samsung.com>
> Cc: Varka Bhadram <varkab@cdac.in>
> Cc: Alan Ott <alan@signal11.us>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   drivers/net/ieee802154/atusb.c     | 2 +-
>   drivers/net/ieee802154/cc2520.c    | 3 +--
>   drivers/net/ieee802154/mrf24j40.c  | 3 +--
>   include/net/mac802154.h            | 2 --
>   5 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 6e20e9c..1bf86d2 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1443,7 +1443,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
>   		return -EINVAL;
>   	}
>   
> -	lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
> +	lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM |
>   			IEEE802154_HW_CSMA_PARAMS |
>   			IEEE802154_HW_FRAME_RETRIES | IEEE802154_HW_AFILT |
>   			IEEE802154_HW_PROMISCUOUS;
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 3d25678..80dfc72 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -628,7 +628,7 @@ static int atusb_probe(struct usb_interface *interface,
>   
>   	hw->parent = &usb_dev->dev;
>   	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> -		    IEEE802154_HW_AACK | IEEE802154_HW_PROMISCUOUS;
> +		    IEEE802154_HW_PROMISCUOUS;
>   
>   	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
>   
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index a8bafd6..15f263c 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -746,8 +746,7 @@ static int cc2520_register(struct cc2520_private *priv)
>   
>   	/* We do support only 2.4 Ghz */
>   	priv->hw->phy->supported.channels[0] = 0x7FFF800;
> -	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> -			  IEEE802154_HW_AFILT;
> +	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
>   
>   	priv->hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
>   
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index f2a1bd1..99c7676 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -751,8 +751,7 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	devrec->hw->priv = devrec;
>   	devrec->hw->parent = &devrec->spi->dev;
>   	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
> -	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
> -			    IEEE802154_HW_AFILT;
> +	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
>   
>   	dev_dbg(printdev(devrec), "registered mrf24j40\n");
>   	ret = ieee802154_register_hw(devrec->hw);
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 845e4f8..a20ba28 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -90,8 +90,6 @@ struct ieee802154_hw {
>   
>   /* Indicates that xmitter will add FCS on it's own. */
>   #define IEEE802154_HW_TX_OMIT_CKSUM	0x00000001
> -/* Indicates that receiver will autorespond with ACK frames. */
> -#define IEEE802154_HW_AACK		0x00000002
>   /* Indicates that transceiver will support listen before transmit. */
>   #define IEEE802154_HW_LBT		0x00000004
>   /* Indicates that transceiver will support csma (max_be, min_be, csma retries)

For the atusb hunk:
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
