Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47815 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdKFPdS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:33:18 -0500
Subject: Re: [PATCH] ieee802154: mrf24j40: fix incorrect mask in mrf24j40_stop
References: <20171031063127.GA6032@embeddedor.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <40d83766-cb5a-69c7-2882-1a9ff01004b1@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171031063127.GA6032@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Alan Ott <alan@signal11.us>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

Hello.

On 31.10.2017 07:31, Gustavo A. R. Silva wrote:
> It seems that this is a copy/paste error and the proper bit masking is:
> BIT_TXNIE | BIT_RXIE
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Fixes: 7d840545e5b9 ("mrf24j40: replace magic numbers")
> ---
>  drivers/net/ieee802154/mrf24j40.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index ee7084b..cf4788d 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -635,7 +635,7 @@ static void mrf24j40_stop(struct ieee802154_hw *hw)
>  
>  	/* Set TXNIE and RXIE. Disable Interrupts */
>  	regmap_update_bits(devrec->regmap_short, REG_INTCON,
> -			   BIT_TXNIE | BIT_TXNIE, BIT_TXNIE | BIT_TXNIE);
> +			   BIT_TXNIE | BIT_RXIE, BIT_TXNIE | BIT_RXIE);
>  }
>  
>  static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
