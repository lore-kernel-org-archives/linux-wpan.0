Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60408 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbH0NYR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:24:17 -0400
Subject: Re: [RFC bluetooth-next 06/21] mrf24j40: add default channel setting
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-7-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF0F7D.2050103@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:24:13 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-7-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> Per default mrf24j40 has the channel 11 after reset. This patch adds the
> right phy default value for the channel setting.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 7df80d8..4051310 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -720,6 +720,11 @@ err_ret:
>   	return ret;
>   }
>   
> +static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
> +{
> +	devrec->hw->phy->current_channel = 11;
> +}
> +

I was about to write here that a new function just for this might be a 
bit to much but looking down further the patchset I can see that you are 
adding more and more phy related bits here so its fine to introduce it here.
>   static int mrf24j40_probe(struct spi_device *spi)
>   {
>   	int ret = -ENOMEM;
> @@ -753,6 +758,8 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	if (ret)
>   		goto err_register_device;
>   
> +	mrf24j40_phy_setup(devrec);
> +
>   	ret = devm_request_threaded_irq(&spi->dev,
>   					spi->irq,
>   					NULL,

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
