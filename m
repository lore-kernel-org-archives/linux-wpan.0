Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60660 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbbH1ILm (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 28 Aug 2015 04:11:42 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH bluetooth-next 2/4] at86rf230: interrupt tx with force
 trx_off
References: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
 <1440704960-10515-3-git-send-email-alex.aring@gmail.com>
Message-ID: <55E017BB.5060702@osg.samsung.com>
Date: Fri, 28 Aug 2015 10:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <1440704960-10515-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 27/08/15 21:49, Alexander Aring wrote:
> To abort a TX_ARET_BUSY state it's recommended to switch into TRX_OFF
> state by doing STATE_TRX_FORCE_OFF. This patch will do always a TRX_OFF
> state change when the transceiver stucks in any state. From TRX_OFF we
> can switch to the states which are also possible by TX_ON state.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 39485d0..1e71a97 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -377,14 +377,6 @@ at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
>   	}
>   }
>   
> -static inline u8 at86rf230_state_to_force(u8 state)
> -{
> -	if (state == STATE_TX_ON)
> -		return STATE_FORCE_TX_ON;
> -	else
> -		return STATE_FORCE_TRX_OFF;
> -}
> -
>   static void
>   at86rf230_async_state_assert(void *context)
>   {
> @@ -426,7 +418,7 @@ at86rf230_async_state_assert(void *context)
>   				u8 state = ctx->to_state;
>   
>   				if (lp->tx_retry >= AT86RF2XX_MAX_TX_RETRIES)
> -					state = at86rf230_state_to_force(state);
> +					state = STATE_FORCE_TRX_OFF;
>   				lp->tx_retry++;
>   
>   				at86rf230_async_state_change(lp, ctx, state,

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
