Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34814 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbaJGIyO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:54:14 -0400
Received: by mail-pd0-f173.google.com with SMTP id g10so4746741pdj.18
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:54:13 -0700 (PDT)
Message-ID: <5433A9A0.5090407@gmail.com>
Date: Tue, 07 Oct 2014 14:21:44 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 3/9] at86rf230: correct aret lifs and sifs
 handling
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com> <1412671113-26675-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-4-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de

Hi Alex,

On 10/07/2014 02:08 PM, Alexander Aring wrote:

> This patch adds lifs/sifs handling only if max_frame_retries is above
> zero. The at86rf2xx datasheets says nothing about phy lifs/sifs
> handling. I asked the atmel support and they said lifs/sifs is done
> by phy when max_frame_retries is above zero.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 44d2f1d..2a25324 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -89,6 +89,7 @@ struct at86rf230_local {
>   	struct at86rf230_state_change irq;
>   
>   	bool tx_aret;
> +	s8 max_frame_retries;

Why s8 here..? Is there any reason..

>   	bool is_tx;
>   	/* spinlock for is_tx protection */
>   	spinlock_t lock;
> @@ -1001,6 +1002,9 @@ at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
>   		return -ETIMEDOUT;
>   	}
>   
> +	if (lp->max_frame_retries > 0)
> +		return 0;
> +
>   	/* Interfame spacing time, which is phy depend.
>   	 * TODO
>   	 * Move this handling in MAC 802.15.4 layer.
> @@ -1230,6 +1234,7 @@ at86rf230_set_frame_retries(struct ieee802154_dev *dev, s8 retries)
>   		return -EINVAL;
>   
>   	lp->tx_aret = retries >= 0;
> +	lp->max_frame_retries = retries;
>   
>   	if (retries >= 0)
>   		rc = at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);

-- 
Regards,
Varka Bhadram.

