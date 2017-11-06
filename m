Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47841 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbdKFPem (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:34:42 -0500
Subject: Re: [PATCH 11/14] ieee802154: cc2520: fix some kernel coding style
 errors
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-12-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <f36e18d0-8418-dbbb-aa06-66093b70c507@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:34:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-12-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

On 22.09.2017 14:14, Stefan Schmidt wrote:
> Fix some spacing and needed new line.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/cc2520.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index d50add705a79..9c1d1768a36f 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -648,7 +648,7 @@ cc2520_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>  	BUG_ON(channel > CC2520_MAXCHANNEL);
>  
>  	ret = cc2520_write_register(priv, CC2520_FREQCTRL,
> -				    11 + 5*(channel - 11));
> +				    11 + 5 * (channel - 11));
>  
>  	return ret;
>  }
> @@ -929,6 +929,7 @@ static int cc2520_get_platform_data(struct spi_device *spi,
>  
>  	if (!np) {
>  		struct cc2520_platform_data *spi_pdata = spi->dev.platform_data;
> +
>  		if (!spi_pdata)
>  			return -ENOENT;
>  		*pdata = *spi_pdata;
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
