Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35984 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbFGCgj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 22:36:39 -0400
Received: by pdjm12 with SMTP id m12so76987377pdj.3
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 19:36:38 -0700 (PDT)
Message-ID: <5573AE28.6060803@gmail.com>
Date: Sun, 07 Jun 2015 08:06:24 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 1/8] mac802154: remove unneeded vif struct
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com> <1433604653-9585-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>

Hi,

On Saturday 06 June 2015 09:00 PM, Alexander Aring wrote:

> This patch removes the virtual interface structure from sub if data
> struct, because it isn't used anywhere. This structure could be useful
> for give per interface information at softmac driver layer. Nevertheless
> there exist no use case currently and it contains the interface type
> information currently. This information is also stored inside wpan dev
> which is now used to check on the wpan dev interface type.
>
> Cc: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 1 -
>   drivers/net/ieee802154/cc2520.c    | 1 -
>   include/net/mac802154.h            | 8 --------
>   net/mac802154/ieee802154_i.h       | 2 --
>   net/mac802154/iface.c              | 9 ++++-----
>   net/mac802154/rx.c                 | 4 ++--
>   6 files changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 2f25a5e..6e20e9c 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1602,7 +1602,6 @@ static int at86rf230_probe(struct spi_device *spi)
>   	lp->spi = spi;
>   	lp->slp_tr = slp_tr;
>   	hw->parent = &spi->dev;
> -	hw->vif_data_size = sizeof(*lp);
>   	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
>   
>   	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 8141353..a8bafd6 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -742,7 +742,6 @@ static int cc2520_register(struct cc2520_private *priv)
>   	priv->hw->priv = priv;
>   	priv->hw->parent = &priv->spi->dev;
>   	priv->hw->extra_tx_headroom = 0;
> -	priv->hw->vif_data_size = sizeof(*priv);
>   	ieee802154_random_extended_addr(&priv->hw->phy->perm_extended_addr);
>   

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

Thanks.

-- 
Varka Bhadram.

