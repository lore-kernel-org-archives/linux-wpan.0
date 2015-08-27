Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60393 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbbH0NGT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:06:19 -0400
Subject: Re: [RFC bluetooth-next 03/21] mrf24j40: calling
 ieee802154_register_hw at last
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-4-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF0B48.1040202@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:06:16 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-4-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> The function ieee802154_register_hw should always called at last.
> Currently we do hardware init and such things after register hardware
> into the subsystem. It could be that the subsystem already call driver
> operations while running hardware init.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 1023cd2..de63cba 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -753,14 +753,9 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	mutex_init(&devrec->buffer_mutex);
>   	init_completion(&devrec->tx_complete);
>   
> -	dev_dbg(printdev(devrec), "registered mrf24j40\n");
> -	ret = ieee802154_register_hw(devrec->hw);
> -	if (ret)
> -		goto err_register_device;
> -
>   	ret = mrf24j40_hw_init(devrec);
>   	if (ret)
> -		goto err_hw_init;
> +		goto err_register_device;
>   
>   	ret = devm_request_threaded_irq(&spi->dev,
>   					spi->irq,
> @@ -772,14 +767,16 @@ static int mrf24j40_probe(struct spi_device *spi)
>   
>   	if (ret) {
>   		dev_err(printdev(devrec), "Unable to get IRQ");
> -		goto err_irq;
> +		goto err_register_device;
>   	}
>   
> +	dev_dbg(printdev(devrec), "registered mrf24j40\n");
> +	ret = ieee802154_register_hw(devrec->hw);
> +	if (ret)
> +		goto err_register_device;
> +
>   	return 0;
>   
> -err_irq:
> -err_hw_init:
> -	ieee802154_unregister_hw(devrec->hw);
>   err_register_device:
>   	ieee802154_free_hw(devrec->hw);
>   err_ret:

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
