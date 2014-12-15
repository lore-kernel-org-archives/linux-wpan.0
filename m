Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59928 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaLOI3u (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:29:50 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGM00HO87SMWV10@mailout1.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Mon, 15 Dec 2014 08:33:58 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-2-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418599232-6267-2-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/5] at86rf230: remove if branch
Date: Mon, 15 Dec 2014 08:29:24 +0000
Message-id: <250701d01841$3bd6fb30$b384f190$@samsung.com>
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
> index 1c01356..4e983b3 100644
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
> +	ieee802154_xmit_complete(lp->hw, skb, lp->max_frame_retries <= 0);
>   }

It surely saves us some lines but personally I find it harder to read 
this way. Having the condition inside the function call breaks the 
reading flow for me. Is this the preferred coding style in the kernel?

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


