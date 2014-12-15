Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:62693 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaLOI3x (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:29:53 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGM005QQ7SJVI10@mailout4.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Mon, 15 Dec 2014 08:33:55 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-4-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418599232-6267-4-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/5] at86rf230: fix context pointer handling
Date: Mon, 15 Dec 2014 08:29:30 +0000
Message-id: <250901d01841$49cbac90$dd6305b0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 15/12/14 00:20, Alexander Aring wrote:
> This patch changes the context pointer to the parameter given one inside
> function at86rf230_async_state_change_start. This could occur problem if
> context isn't pointed to lp->state.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 430d3bd..08b2f9f 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -655,7 +655,7 @@ at86rf230_async_state_change_start(void *context)
>   		if (ctx->irq_enable)
>   			enable_irq(lp->spi->irq);
>
> -		at86rf230_async_error(lp, &lp->state, rc);
> +		at86rf230_async_error(lp, ctx, rc);
>   	}
>   }
>
>

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


