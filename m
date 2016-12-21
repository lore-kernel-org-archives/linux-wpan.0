Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59738
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757170AbcLUNLo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Dec 2016 08:11:44 -0500
Subject: Re: [PATCH] at86rf230: Allow slow GPIO pins for "rstn"
References: <1482103533-13187-1-git-send-email-andrew.smirnov@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <7435a0a2-3f0f-a0db-9e0e-cb1ac838737c@osg.samsung.com>
Date: Wed, 21 Dec 2016 14:11:39 +0100
MIME-Version: 1.0
In-Reply-To: <1482103533-13187-1-git-send-email-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>

Hello.

On 19/12/16 00:25, Andrey Smirnov wrote:
> Driver code never touches "rstn" signal in atomic context, so there's
> no need to implicitly put such restriction on it by using gpio_set_value
> to manipulate it. Replace gpio_set_value to gpio_set_value_cansleep to
> fix that.

We need to make sure we are not assuming it can be called  in such a 
context in the future now. But that is something we can worry about if 
it comes up.

> As a an example of where such restriction might be inconvenient,
> consider a hardware design where "rstn" is connected to a pin of I2C/SPI
> GPIO expander chip.

Is this a real life issue you run into?

> Cc: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/net/ieee802154/at86rf230.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 9f10da6..7700690 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1710,9 +1710,9 @@ static int at86rf230_probe(struct spi_device *spi)
>  	/* Reset */
>  	if (gpio_is_valid(rstn)) {
>  		udelay(1);
> -		gpio_set_value(rstn, 0);
> +		gpio_set_value_cansleep(rstn, 0);
>  		udelay(1);
> -		gpio_set_value(rstn, 1);
> +		gpio_set_value_cansleep(rstn, 1);
>  		usleep_range(120, 240);
>  	}
>
>


Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
