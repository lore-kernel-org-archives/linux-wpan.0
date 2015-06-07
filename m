Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35840 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbbFGCqo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 22:46:44 -0400
Received: by pabqy3 with SMTP id qy3so71833277pab.3
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 19:46:43 -0700 (PDT)
Message-ID: <5573B08D.2040709@gmail.com>
Date: Sun, 07 Jun 2015 08:16:37 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
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

Hi,

On Saturday 06 June 2015 09:00 PM, Alexander Aring wrote:

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

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

Thanks.

-- 
Varka Bhadram.

