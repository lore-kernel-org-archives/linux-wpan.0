Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59514 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbcFUJys (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 21 Jun 2016 05:54:48 -0400
Subject: Re: [PATCH bluetooth-next] atusb: don't change csma settings while
 set channel
References: <20160620150135.13250-1-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <57690AAF.2070000@osg.samsung.com>
Date: Tue, 21 Jun 2016 11:36:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160620150135.13250-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 20/06/16 17:01, Alexander Aring wrote:
> This patch fixes the behaviour to not overwrite csma settings when
> set channel afterwards.
>
> Cc: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   drivers/net/ieee802154/atusb.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 52c9051..1056ed1 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -366,11 +366,7 @@ static int atusb_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>   	struct atusb *atusb = hw->priv;
>   	int ret;
>   
> -	/* This implicitly sets the CCA (Clear Channel Assessment) mode to 0,
> -	 * "Mode 3a, Carrier sense OR energy above threshold".
> -	 * We should probably make this configurable. @@@
> -	 */
> -	ret = atusb_write_reg(atusb, RG_PHY_CC_CCA, channel);
> +	ret = atusb_write_subreg(atusb, SR_CHANNEL, channel);
>   	if (ret < 0)
>   		return ret;
>   	msleep(1);	/* @@@ ugly synchronization */

Good point. We have csma ops and iwpan support for csma now this setting 
is no longer needed.

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
