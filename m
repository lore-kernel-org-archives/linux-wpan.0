Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:62693 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaLOI3y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:29:54 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGM005QS7SKVI10@mailout4.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Mon, 15 Dec 2014 08:33:56 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-5-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418599232-6267-5-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 4/5] at86rf230: cleanup check on trac status
Date: Mon, 15 Dec 2014 08:29:48 +0000
Message-id: <250b01d01841$4a167130$de435390$@samsung.com>
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
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 08b2f9f..7b0a17e 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -750,13 +750,11 @@ at86rf230_tx_trac_check(void *context)
>   	 * to STATE_FORCE_TRX_OFF then STATE_TX_ON to recover the
> transceiver
>   	 * state to TX_ON.
>   	 */
> -	if (trac) {
> +	if (trac)
>   		at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
>   					     at86rf230_tx_trac_error,
> true);
> -		return;
> -	}
> -
> -	at86rf230_tx_on(context);
> +	else
> +		at86rf230_tx_on(context);
>   }
>

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


