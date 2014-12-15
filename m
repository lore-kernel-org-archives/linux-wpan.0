Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:11471 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbaLOI3z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:29:55 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGM00CUD7SNAK80@mailout2.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Mon, 15 Dec 2014 08:33:59 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-6-git-send-email-alex.aring@gmail.com>
In-reply-to: <1418599232-6267-6-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 5/5] at86rf230: remove unnecessary assign
Date: Mon, 15 Dec 2014 08:29:48 +0000
Message-id: <250a01d01841$49f04b90$ddd0e2b0$@samsung.com>
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
> The attribute extra_tx_headroom should already be zero.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 7b0a17e..89589d8 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1405,7 +1405,6 @@ at86rf230_detect_device(struct at86rf230_local *lp)
>   		return -EINVAL;
>   	}
>
> -	lp->hw->extra_tx_headroom = 0;
>   	lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
>   			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
>   			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
>

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


