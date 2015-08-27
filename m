Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60399 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbbH0NOf (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:14:35 -0400
Subject: Re: [RFC bluetooth-next 04/21] mrf24j40: remove spi settings
 overwrite
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-5-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF0D37.4080508@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:14:31 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-5-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> This patch removes spi settings while mrf24j40 probing. These settings
> cannot be overwrite while device probing where spi controller should be
> already configured. These settings need to be setup by device tree or
> platform data.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index de63cba..d16bef3 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -746,10 +746,6 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	if (!devrec->buf)
>   		goto err_register_device;
>   
> -	spi->mode = SPI_MODE_0; /* TODO: Is this appropriate for right here? */
> -	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ)
> -		spi->max_speed_hz = MAX_SPI_SPEED_HZ;
> -
>   	mutex_init(&devrec->buffer_mutex);
>   	init_completion(&devrec->tx_complete);
>   

So far I only have been setting the SPI speed but never the mode via 
devicetree. Digging for it I found that we can set the various modes 
easily via devicetree.
Documentation/devicetree/bindings/spi/spi-bus.txt

- spi-cpol        - (optional) Empty property indicating device requires
     		inverse clock polarity (CPOL) mode
- spi-cpha        - (optional) Empty property indicating device requires
     		shifted clock phase (CPHA) mode
- spi-cs-high     - (optional) Empty property indicating device requires
     		chip select active high
- spi-3wire       - (optional) Empty property indicating device requires
     		    3-wire mode.
- spi-lsb-first   - (optional) Empty property indicating device requires
		LSB first mode.


Platform data could always do that anyway so we are good here.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
