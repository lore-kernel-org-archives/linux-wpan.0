Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfC0PLS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Mar 2019 11:11:18 -0400
Subject: Re: [PATCH] net: ieee802154: fix missing checks for
 regmap_update_bits
References: <20190324231856.2664-1-kjlu@umn.edu>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <60649d69-5a89-cf42-8690-ec30a112da8f@codeaurora.org>
Date: Wed, 27 Mar 2019 20:41:07 +0530
MIME-Version: 1.0
In-Reply-To: <20190324231856.2664-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 3/25/2019 4:48 AM, Kangjie Lu wrote:
> regmap_update_bits could fail and deserves a check.
>
> The patch adds the checks and if it fails, returns its error
> code upstream.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/net/ieee802154/mcr20a.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index c589f5ae75bb..8bb53ec8d9cf 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -533,6 +533,8 @@ mcr20a_start(struct ieee802154_hw *hw)
>   	dev_dbg(printdev(lp), "no slotted operation\n");
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>   				 DAR_PHY_CTRL1_SLOTTED, 0x0);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* enable irq */
>   	enable_irq(lp->spi->irq);
> @@ -540,11 +542,15 @@ mcr20a_start(struct ieee802154_hw *hw)
>   	/* Unmask SEQ interrupt */
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
>   				 DAR_PHY_CTRL2_SEQMSK, 0x0);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* Start the RX sequence */
>   	dev_dbg(printdev(lp), "start the RX sequence\n");
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>   				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
> +	if (ret < 0)
> +		return ret;
>   
>   	return 0;
>   }
