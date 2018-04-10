Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42759 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeDJJzR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Apr 2018 05:55:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180405162006.GA2199@embeddedor.com>
References: <20180405162006.GA2199@embeddedor.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Tue, 10 Apr 2018 11:54:36 +0200
Message-ID: <CAJuUDwtUUv_nMEwijRydWmseL1aYOAoAfEdLVnoHWPWKdVgS-A@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: mcr20a: Fix memory leak in mcr20a_probe
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hallo,

Thanks for the fix. It looks good.

ACK-by: Xue Liu <liuxuenetmail@gmail.com>

On 5 April 2018 at 18:20, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
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
>         ret = mcr20a_get_platform_data(spi, pdata);
>         if (ret < 0) {
>                 dev_crit(&spi->dev, "mcr20a_get_platform_data failed.\n");
> -               return ret;
> +               goto free_pdata;
>         }
>
>         /* init reset gpio */
> @@ -1275,7 +1275,7 @@ mcr20a_probe(struct spi_device *spi)
>                 ret = devm_gpio_request_one(&spi->dev, pdata->rst_gpio,
>                                             GPIOF_OUT_INIT_HIGH, "reset");
>                 if (ret)
> -                       return ret;
> +                       goto free_pdata;
>         }
>
>         /* reset mcr20a */
> @@ -1291,7 +1291,8 @@ mcr20a_probe(struct spi_device *spi)
>         hw = ieee802154_alloc_hw(sizeof(*lp), &mcr20a_hw_ops);
>         if (!hw) {
>                 dev_crit(&spi->dev, "ieee802154_alloc_hw failed\n");
> -               return -ENOMEM;
> +               ret = -ENOMEM;
> +               goto free_pdata;
>         }
>
>         /* init mcr20a local data */
> @@ -1366,6 +1367,8 @@ mcr20a_probe(struct spi_device *spi)
>
>  free_dev:
>         ieee802154_free_hw(lp->hw);
> +free_pdata:
> +       kfree(pdata);
>
>         return ret;
>  }
> --
> 2.7.4
>
