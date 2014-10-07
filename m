Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41459 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaJGI4r (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:56:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so4735041pdb.17
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:56:46 -0700 (PDT)
Message-ID: <5433AA3A.1080001@gmail.com>
Date: Tue, 07 Oct 2014 14:24:18 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 1/9] at86rf230: fix errno on tx timeout
 handling
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com> <1412671113-26675-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de

On 10/07/2014 02:08 PM, Alexander Aring wrote:
> The rc variable is zero if we get a timeout. Instead of pass the rc
> variable to the async error handling function which try to recover the
> phy, we use a static -ETIMEOUT errno.

s/ETIMEOUT/ETIMEDOUT

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index c9d2a75..6857038 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -995,7 +995,7 @@ at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
>   	rc = wait_for_completion_interruptible_timeout(&lp->tx_complete,
>   						       msecs_to_jiffies(lp->data->t_tx_timeout));
>   	if (!rc) {
> -		at86rf230_async_error(lp, ctx, rc);
> +		at86rf230_async_error(lp, ctx, -ETIMEDOUT);
>   		return -ETIMEDOUT;
>   	}
>   


-- 
Regards,
Varka Bhadram.

