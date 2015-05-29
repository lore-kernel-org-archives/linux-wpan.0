Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34221 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550AbbE2JT1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 05:19:27 -0400
Received: by wicmc15 with SMTP id mc15so10553879wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 02:19:26 -0700 (PDT)
Date: Fri, 29 May 2015 11:19:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 2/4] ieee802154/atusb: Add .set_txpower
 operation to the driver
Message-ID: <20150529091922.GD3709@omega>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
 <1432889488-28420-3-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432889488-28420-3-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <s.schmidt@samsung.com>

On Fri, May 29, 2015 at 10:51:26AM +0200, Stefan Schmidt wrote:
> From: Stefan Schmidt <s.schmidt@samsung.com>
> 
> Atusb uses the at86rf231 transceiver so we can use the same calculation
> for txpower settings for it.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 95d4220..9805ebe 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -453,6 +453,26 @@ static void atusb_stop(struct ieee802154_hw *hw)
>  	atusb_get_and_clear_error(atusb);
>  }
>  
> +#define ATUSB_MAX_TX_POWERS 0xF
> +static const s32 atusb_powers[ATUSB_MAX_TX_POWERS + 1] = {
> +	300, 280, 230, 180, 130, 70, 0, -100, -200, -300, -400, -500, -700,
> +	-900, -1200, -1700,
> +};
> +
> +static int
> +atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
> +{
> +	struct atusb *atusb = hw->priv;
> +	u32 i;
> +
> +	for (i = 0; i < hw->phy->supported.tx_powers_size; i++) {
> +		if (hw->phy->supported.tx_powers[i] == mbm)
> +			return atusb_write_subreg(atusb, SR_TX_PWR_23X, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +

also the mapping looks different in at86rf230. Anyway, it's just a note.

- Alex
