Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37271 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750897AbdABPj4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2017 10:39:56 -0500
Subject: Re: [PATCH bluetooth] ieee802154: atusb: fix driver to work with
 older firmware versions
References: <1483369210-23893-1-git-send-email-stefan@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <9fef164c-cba0-ba75-30ea-15f933f0a5c5@pengutronix.de>
Date: Mon, 2 Jan 2017 16:39:53 +0100
MIME-Version: 1.0
In-Reply-To: <1483369210-23893-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org


Hi Stefan,

thanks for the fix!

On 01/02/2017 04:00 PM, Stefan Schmidt wrote:
> After the addition of the frame_retries callback we could run into cases where
> a ATUSB device with an older firmware version would now longer be able to bring
> the interface up.
> 
> We keep this functionality disabled now if the minimum firmware version for this
> feature is not available.
> 
> Fixes: 5d82288b93db3bc ("ieee802154: atusb: implement .set_frame_retries
> ops callback")
> Reported-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---

Acked-by: Alexander Aring <aar@pengutronix.de>

>  drivers/net/ieee802154/atusb.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 63cb679..ac32029 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -562,13 +562,6 @@ static int
>  atusb_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
>  {
>  	struct atusb *atusb = hw->priv;
> -	struct device *dev = &atusb->usb_dev->dev;
> -
> -	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 3) {
> -		dev_info(dev, "Automatic frame retransmission is only available from "
> -			"firmware version 0.3. Please update if you want this feature.");
> -		return -EINVAL;
> -	}
>  
>  	return atusb_write_subreg(atusb, SR_MAX_FRAME_RETRIES, retries);
>  }
> @@ -802,8 +795,7 @@ static int atusb_probe(struct usb_interface *interface,
>  
>  	hw->parent = &usb_dev->dev;
>  	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> -		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS |
> -		    IEEE802154_HW_FRAME_RETRIES;
> +		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
>  
>  	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL |
>  			 WPAN_PHY_FLAG_CCA_MODE;
> @@ -832,6 +824,10 @@ static int atusb_probe(struct usb_interface *interface,
>  	atusb_get_and_show_build(atusb);
>  	atusb_set_extended_addr(atusb);
>  
> +	if (atusb->fw_ver_maj >= 0 && atusb->fw_ver_min >= 3) {
> +		hw->flags |= IEEE802154_HW_FRAME_RETRIES;
> +	}
> +

nitpick, remove brackets? Checkpatch should complain about that, I
suppose.

- Alex
