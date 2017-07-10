Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47135 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753936AbdGJTYU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 10 Jul 2017 15:24:20 -0400
Subject: Re: [PATCH v2] mrf24j40: Fix en error handling path in
 'mrf24j40_probe()'
References: <20170708084013.18620-1-christophe.jaillet@wanadoo.fr>
From: Alan Ott <alan@signal11.us>
Message-ID: <581ccccf-a605-3472-a4a6-9ccb99c78da1@signal11.us>
Date: Mon, 10 Jul 2017 15:24:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170708084013.18620-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alex.aring@gmail.com, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 07/08/2017 04:40 AM, Christophe JAILLET wrote:
> If this check fails, we must release some resources as done everywhere
> else in this function before returning an error code.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: initialization of ret in this erro path ws missing. Stupid me!
> ---
>  drivers/net/ieee802154/mrf24j40.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 7d334963dc08..da8683782ffc 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -1330,7 +1330,8 @@ static int mrf24j40_probe(struct spi_device *spi)
>  	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ) {
>  		dev_warn(&spi->dev, "spi clock above possible maximum: %d",
>  			 MAX_SPI_SPEED_HZ);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_register_device;
>  	}
>
>  	ret = mrf24j40_hw_init(devrec);
>

Acked-by: Alan Ott <alan@signal11.us>

