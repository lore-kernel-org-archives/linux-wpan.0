Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37012 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbCQIG4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 04:06:56 -0400
Received: by wixw10 with SMTP id w10so3921045wix.0
        for <linux-wpan@vger.kernel.org>; Tue, 17 Mar 2015 01:06:54 -0700 (PDT)
Date: Tue, 17 Mar 2015 09:06:52 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 1/2] cc2520: Do not store platform_data in spi_device
Message-ID: <20150317080649.GB1303@omega>
References: <1426544203-60585-1-git-send-email-bradjc5@gmail.com>
 <1426544203-60585-2-git-send-email-bradjc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426544203-60585-2-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Mar 16, 2015 at 06:16:42PM -0400, Brad Campbell wrote:
> Storing the `platform_data` struct inside of the SPI struct when using
> the device tree allows for a later function to edit the content of that
> struct. This patch refactors the `cc2520_get_platformat_data` function
> to accept a pointer to a `cc2520_platform_data` struct and populates
> the fields inside of it.
> 
> This changes mirrors a similar change in the at86rf230.c driver.

For referencing other fixes use $COMMIT_ID ("$SHORT_COMMIT_MSG").

like: aaa1c4d226e4cd730075d3dac99a6d599a0190c7 ("at86rf230: copy pdata
to driver allocated space")

> 
> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> ---
>  drivers/net/ieee802154/cc2520.c | 93 +++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 181b349..275e6fb 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -714,6 +714,31 @@ static irqreturn_t cc2520_sfd_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int cc2520_get_platform_data(struct spi_device *spi,
> +				    struct cc2520_platform_data *pdata)
> +{
> +	struct device_node *np = spi->dev.of_node;
> +	struct cc2520_private *priv = spi_get_drvdata(spi);
> +
> +	if (!np) {
> +		struct cc2520_platform_data *spi_pdata = spi->dev.platform_data;

This can be null if somebody given no platform_data data.
Additional check with on (!spi_pdata) is required.

something like:

if (!spi_pdata)
	return -ENOENT;

before dereferencing.

> +		*pdata = *spi_pdata;
> +		return 0;
> +	}
> 

Otherwise looking good.

- Alex
