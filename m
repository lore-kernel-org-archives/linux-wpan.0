Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60664 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbbH1IPW (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 28 Aug 2015 04:15:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH bluetooth-next 4/4] at86rf230: detailed edge triggered irq
 warning
References: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
 <1440704960-10515-5-git-send-email-alex.aring@gmail.com>
Message-ID: <55E01897.2070004@osg.samsung.com>
Date: Fri, 28 Aug 2015 10:15:19 +0200
MIME-Version: 1.0
In-Reply-To: <1440704960-10515-5-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 27/08/15 21:49, Alexander Aring wrote:
> This patch introduce a more detailed information why edge triggered
> irq's are currently not recommended. It could be that rising/falling
> edge detection can happen while the irq is disabled.
>
> Suggested-by: Stefan Schmidt<stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 19c16b9..b8b0628 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1376,7 +1376,7 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
>   	if (irq_type == IRQ_TYPE_EDGE_RISING ||
>   	    irq_type == IRQ_TYPE_EDGE_FALLING)
>   		dev_warn(&lp->spi->dev,
> -			 "Using edge triggered irq's are not recommended!\n");
> +			 "Using edge triggered irq's are not recommended, because it can cause races and result in a non-functional driver!\n");
>   	if (irq_type == IRQ_TYPE_EDGE_FALLING ||
>   	    irq_type == IRQ_TYPE_LEVEL_LOW)
>   		irq_pol = IRQ_ACTIVE_LOW;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
