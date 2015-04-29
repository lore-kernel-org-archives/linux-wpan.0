Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34515 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031455AbbD2Iv0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 04:51:26 -0400
Received: by pacyx8 with SMTP id yx8so22049859pac.1
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 01:51:26 -0700 (PDT)
Message-ID: <55409B78.8050002@gmail.com>
Date: Wed, 29 Apr 2015 14:21:04 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2 wpan-next 4/6] at86rf230: remove unnecessary tx state
 change
References: <1430292893-5752-1-git-send-email-alex.aring@gmail.com> <1430292893-5752-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430292893-5752-5-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On 04/29/2015 01:04 PM, Alexander Aring wrote:

> All supported transceivers can do a valid state change from TRX_OFF to
> AACK_ON. This patach removes the state change chain from TRX_OFF ->

s/patach/patch

> TX_ON -> AACK_ON instead we doing a directly state change from TRX_OFF
> to AACK_ON.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  drivers/net/ieee802154/at86rf230.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index f99dce5..6285145 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -781,16 +781,6 @@ at86rf230_tx_on(void *context)
>  }
>  
>  static void
> -at86rf230_tx_trac_error(void *context)
> -{
> -	struct at86rf230_state_change *ctx = context;
> -	struct at86rf230_local *lp = ctx->lp;
> -
> -	at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
> -				     at86rf230_tx_on, true);
> -}
> -
> -static void
>  at86rf230_tx_trac_check(void *context)
>  {
>  	struct at86rf230_state_change *ctx = context;
> @@ -799,12 +789,12 @@ at86rf230_tx_trac_check(void *context)
>  	const u8 trac = (buf[1] & 0xe0) >> 5;
>  
>  	/* If trac status is different than zero we need to do a state change
> -	 * to STATE_FORCE_TRX_OFF then STATE_TX_ON to recover the transceiver
> -	 * state to TX_ON.
> +	 * to STATE_FORCE_TRX_OFF then STATE_RX_AACK_ON to recover the
> +	 * transceiver.
>  	 */
>  	if (trac)
>  		at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
> -					     at86rf230_tx_trac_error, true);
> +					     at86rf230_tx_on, true);
>  	else
>  		at86rf230_tx_on(context);
>  }

-- 
Varka Bhadram

