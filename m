Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:54877 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeDJK6W (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 10 Apr 2018 06:58:22 -0400
Subject: Re: [PATCH] ieee802154: mcr20a: Fix memory leak in mcr20a_probe
References: <20180405162006.GA2199@embeddedor.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <59fce20c-0450-e59b-4db4-94bbb2372c9c@osg.samsung.com>
Date: Tue, 10 Apr 2018 12:58:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180405162006.GA2199@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.


On 04/05/2018 06:20 PM, Gustavo A. R. Silva wrote:
> Free allocated memory for pdata before return.
>
> Addresses-Coverity-ID: 1466096 ("Resource leak")
> Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ieee802154/mcr20a.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 55a22c7..944470d 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -1267,7 +1267,7 @@ mcr20a_probe(struct spi_device *spi)
>  	ret = mcr20a_get_platform_data(spi, pdata);
>  	if (ret < 0) {
>  		dev_crit(&spi->dev, "mcr20a_get_platform_data failed.\n");
> -		return ret;
> +		goto free_pdata;
>  	}
>  
>  	/* init reset gpio */
> @@ -1275,7 +1275,7 @@ mcr20a_probe(struct spi_device *spi)
>  		ret = devm_gpio_request_one(&spi->dev, pdata->rst_gpio,
>  					    GPIOF_OUT_INIT_HIGH, "reset");
>  		if (ret)
> -			return ret;
> +			goto free_pdata;
>  	}
>  
>  	/* reset mcr20a */
> @@ -1291,7 +1291,8 @@ mcr20a_probe(struct spi_device *spi)
>  	hw = ieee802154_alloc_hw(sizeof(*lp), &mcr20a_hw_ops);
>  	if (!hw) {
>  		dev_crit(&spi->dev, "ieee802154_alloc_hw failed\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto free_pdata;
>  	}
>  
>  	/* init mcr20a local data */
> @@ -1366,6 +1367,8 @@ mcr20a_probe(struct spi_device *spi)
>  
>  free_dev:
>  	ieee802154_free_hw(lp->hw);
> +free_pdata:
> +	kfree(pdata);
>  
>  	return ret;
>  }

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
