Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43482 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfANSpI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Jan 2019 13:45:08 -0500
Subject: Re: [PATCH] ieee802154: mcr20a: fix indentation, remove tabs
References: <20190114154834.18693-1-colin.king@canonical.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <497c64f0-c242-8ef1-b57b-5d4c8f2557f8@datenfreihafen.org>
Date: Mon, 14 Jan 2019 19:45:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190114154834.18693-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Colin King <colin.king@canonical.com>, Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, "David S . Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 14.01.19 16:48, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The are a couple of statments that are one level too deep, fix this by
> removing tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ieee802154/mcr20a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 44de81e5f140..c589f5ae75bb 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -905,9 +905,9 @@ mcr20a_irq_clean_complete(void *context)
>  		}
>  		break;
>  	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_SEQIRQ):
> -			/* rx is starting */
> -			dev_dbg(printdev(lp), "RX is starting\n");
> -			mcr20a_handle_rx(lp);
> +		/* rx is starting */
> +		dev_dbg(printdev(lp), "RX is starting\n");
> +		mcr20a_handle_rx(lp);
>  		break;
>  	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
>  		if (lp->is_tx) {
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
