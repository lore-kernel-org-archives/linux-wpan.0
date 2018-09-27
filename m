Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50472 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0VqM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Sep 2018 17:46:12 -0400
Subject: Re: [PATCH 1/2] ieee802154: mcr20a: Replace magic number with
 constants
References: <20180831214642.30711-1-liuxuenetmail@gmail.com>
 <20180831214642.30711-2-liuxuenetmail@gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <3c1d6d02-8669-62a6-b6bc-adb2a4238908@datenfreihafen.org>
Date: Thu, 27 Sep 2018 17:27:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180831214642.30711-2-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hello Xue.

On 31/08/2018 23:46, Xue Liu wrote:
> The combination of defined constants are used to present the
> state of IRQ so the magic numbers has been replaced.
> 
> This is a simple coding style change which should have no impact on
> runtime code execution.
> 
> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
> ---
>  drivers/net/ieee802154/mcr20a.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index e428277781ac..04891429a554 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -903,19 +903,19 @@ mcr20a_irq_clean_complete(void *context)
>  
>  	switch (seq_state) {
>  	/* TX IRQ, RX IRQ and SEQ IRQ */
> -	case (0x03):
> +	case (DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
>  		if (lp->is_tx) {
>  			lp->is_tx = 0;
>  			dev_dbg(printdev(lp), "TX is done. No ACK\n");
>  			mcr20a_handle_tx_complete(lp);
>  		}
>  		break;
> -	case (0x05):
> +	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_SEQIRQ):
>  			/* rx is starting */
>  			dev_dbg(printdev(lp), "RX is starting\n");
>  			mcr20a_handle_rx(lp);
>  		break;
> -	case (0x07):
> +	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
>  		if (lp->is_tx) {
>  			/* tx is done */
>  			lp->is_tx = 0;
> @@ -927,7 +927,7 @@ mcr20a_irq_clean_complete(void *context)
>  			mcr20a_handle_rx(lp);
>  		}
>  		break;
> -	case (0x01):
> +	case (DAR_IRQSTS1_SEQIRQ):
>  		if (lp->is_tx) {
>  			dev_dbg(printdev(lp), "TX is starting\n");
>  			mcr20a_handle_tx(lp);
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

I decided to put this into wpan directly as it clearly is cleanup
material. The second patch will need to go through wpan-next though.

regards
Stefan Schmidt
