Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:32878 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbbE2JRV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 05:17:21 -0400
Received: by wgez8 with SMTP id z8so57237613wge.0
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 02:17:20 -0700 (PDT)
Date: Fri, 29 May 2015 11:17:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 3/4] ieee802154/atusb: Add
 .set_promiscuous_mode driver operation
Message-ID: <20150529091713.GC3709@omega>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
 <1432889488-28420-4-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432889488-28420-4-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

Hi Stefan,

On Fri, May 29, 2015 at 10:51:27AM +0200, Stefan Schmidt wrote:
> From: Stefan Schmidt <s.schmidt@samsung.com>
> 
> Allow monitor mode operation with disabled AACK in hardware.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 9805ebe..3d25678 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -473,6 +473,33 @@ atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
>  	return -EINVAL;
>  }
>  
> +static int
> +atusb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
> +{
> +	struct atusb *atusb = hw->priv;
> +	int ret;
> +
> +	if (on) {
> +		ret = atusb_write_subreg(atusb, SR_AACK_DIS_ACK, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = atusb_write_subreg(atusb, SR_AACK_PROM_MODE, 1);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = atusb_write_subreg(atusb, SR_AACK_PROM_MODE, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = atusb_write_subreg(atusb, SR_AACK_DIS_ACK, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

In case of rzusb which have an at86rf230 it doesn't support these
registers. There is no support for promiscuous mode. It's then a
broken behaviour when somebody sets this in rzusb.

Anyway rzusb isn't currently supported and I just want to leave a note
here. It's fine for me. Something for later to fix it in driver or
firmware handling.

- Alex
