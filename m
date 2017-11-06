Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47809 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdKFPci (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:32:38 -0500
Subject: Re: [PATCH 13/14] ieee802154: cc2520: switch from BUG_ON() to
 WARN_ON() on problem
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-14-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <a173ae21-4a1f-c238-3988-3d4397d5f7e5@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:32:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-14-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

On 22.09.2017 14:14, Stefan Schmidt wrote:
> The check is valid but it does not warrant to crash the kernel. A
> WARN_ON() is good enough here.
> Found by checkpatch.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/cc2520.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 735b9f5f9754..0c89d3edf901 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -517,7 +517,7 @@ cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
>  	}
>  
>  	spin_lock_irqsave(&priv->lock, flags);
> -	BUG_ON(priv->is_tx);
> +	WARN_ON(priv->is_tx);
>  	priv->is_tx = 1;
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> @@ -643,9 +643,9 @@ cc2520_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>  
>  	dev_dbg(&priv->spi->dev, "trying to set channel\n");
>  
> -	BUG_ON(page != 0);
> -	BUG_ON(channel < CC2520_MINCHANNEL);
> -	BUG_ON(channel > CC2520_MAXCHANNEL);
> +	WARN_ON(page != 0);
> +	WARN_ON(channel < CC2520_MINCHANNEL);
> +	WARN_ON(channel > CC2520_MAXCHANNEL);
>  
>  	ret = cc2520_write_register(priv, CC2520_FREQCTRL,
>  				    11 + 5 * (channel - 11));
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
