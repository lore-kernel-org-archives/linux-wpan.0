Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:62693 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbaLOI3w (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:29:52 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGM007NM7SG4310@mailout4.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Mon, 15 Dec 2014 08:33:52 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-3-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418599232-6267-3-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/5] at86rf230: make at86rf230_async_error
 inline
Date: Mon, 15 Dec 2014 08:29:26 +0000
Message-id: <250801d01841$3d4a6150$b7df23f0$@samsung.com>
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
> This patch makes the at86rf230_async_error inline. This function is
> small enough to handle inline.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 4e983b3..430d3bd 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -450,7 +450,7 @@ at86rf230_async_error_recover(void *context)
>   	ieee802154_wake_queue(lp->hw);
>   }
>
> -static void
> +static inline void
>   at86rf230_async_error(struct at86rf230_local *lp,
>   		      struct at86rf230_state_change *ctx, int rc)
>   {

Hopefully we would not need this error function often enough to have a 
real benefit for inline but with only two function calls it should be 
small enough anyway for inline.

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


