Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63936 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaLOJeX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 04:34:23 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGM00HHRAS1F630@mailout3.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Mon, 15 Dec 2014 09:38:25 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
 <1418635557-6670-2-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418635557-6670-2-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/5] at86rf230: remove if branch
Date: Mon, 15 Dec 2014 09:34:02 +0000
Message-id: <250d01d0184a$43390040$c9ab00c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 15/12/14 10:25, Alexander Aring wrote:
> This patch removes an unnecessary if branch inside the tx complete
> handler.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 1c01356..434efc5 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -715,10 +715,7 @@ at86rf230_tx_complete(void *context)
>
>   	enable_irq(lp->spi->irq);
>
> -	if (lp->max_frame_retries <= 0)
> -		ieee802154_xmit_complete(lp->hw, skb, true);
> -	else
> -		ieee802154_xmit_complete(lp->hw, skb, false);
> +	ieee802154_xmit_complete(lp->hw, skb, !lp->tx_aret);
>   }
>
>   static void
>

Thanks!

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt



