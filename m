Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9589 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934018AbaLLIvN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 03:51:13 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGG0063FOS5TH30@mailout2.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Fri, 12 Dec 2014 08:55:17 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418339480-26681-1-git-send-email-andrey@snupi.com>
In-reply-to: <1418339480-26681-1-git-send-email-andrey@snupi.com>
Subject: Re: [PATCH] at86rf230: remove version check for AT86RF212
Date: Fri, 12 Dec 2014 08:50:50 +0000
Message-id: <243a01d015e8$bb7cf930$3276eb90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Andrey Yurovsky' <andrey@snupi.com>, linux-wpan@vger.kernel.org
Cc: 'Andrey Yurovsky' <yurovsky@gmail.com>, alex.aring@gmail.com

Hello.

On 12/12/14 00:11, Andrey Yurovsky wrote:
> From: Andrey Yurovsky <yurovsky@gmail.com>
>
> This version check allows the driver to only work with v1 hardware
> however there is no driver-facing difference with newer versions
> (confirmed by Atmel FAEs) so this check needlessly prevents the driver
> from being used with radios now in production.

Has anyone tested the driver with this new hardware yet? Or are the 
productions so early that there are now samples yet?

> Signed-off-by: Andrey Yurovsky <yurovsky@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 1c01356..007470f 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1429,16 +1429,12 @@ at86rf230_detect_device(struct at86rf230_local
> *lp)
>   		break;
>   	case 7:
>   		chip = "at86rf212";
> -		if (version == 1) {
> -			lp->data = &at86rf212_data;
> -			lp->hw->flags |= IEEE802154_HW_LBT;
> -			lp->hw->phy->channels_supported[0] = 0x00007FF;
> -			lp->hw->phy->channels_supported[2] = 0x00007FF;
> -			lp->hw->phy->current_channel = 5;
> -			lp->hw->phy->symbol_duration = 25;
> -		} else {
> -			rc = -ENOTSUPP;
> -		}
> +		lp->data = &at86rf212_data;
> +		lp->hw->flags |= IEEE802154_HW_LBT;
> +		lp->hw->phy->channels_supported[0] = 0x00007FF;
> +		lp->hw->phy->channels_supported[2] = 0x00007FF;
> +		lp->hw->phy->current_channel = 5;
> +		lp->hw->phy->symbol_duration = 25;
>   		break;
>   	case 11:
>   		chip = "at86rf233";
>

Change looks good.

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


