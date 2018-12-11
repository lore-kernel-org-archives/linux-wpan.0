Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55545 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeLKIjI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Dec 2018 03:39:08 -0500
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow in
 ca8210_rx_done
References: <20181211031339.21048-1-yuehaibing@huawei.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <843d7614-7a79-2108-076e-a56bb33cb283@datenfreihafen.org>
Date: Tue, 11 Dec 2018 09:39:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181211031339.21048-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, h.morris@cascoda.com, alex.aring@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

Hello.

On 11.12.18 04:13, YueHaibing wrote:
> gcc warning this:
> 
> drivers/net/ieee802154/ca8210.c:730:10: warning:
>  comparison is always false due to limited range of data type [-Wtype-limits]
> 
> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
> This patch change the type of 'len' to unsigned int to avoid this,also fix
> the gcc warning.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ieee802154/ca8210.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 0ff5a40..b2ff903 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -721,7 +721,7 @@ static void ca8210_mlme_reset_worker(struct work_struct *work)
>  static void ca8210_rx_done(struct cas_control *cas_ctl)
>  {
>  	u8 *buf;
> -	u8 len;
> +	unsigned int len;
>  	struct work_priv_container *mlme_reset_wpc;
>  	struct ca8210_priv *priv = cas_ctl->priv;
>  
> @@ -730,7 +730,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
>  	if (len > CA8210_SPI_BUF_SIZE) {
>  		dev_crit(
>  			&priv->spi->dev,
> -			"Received packet len (%d) erroneously long\n",
> +			"Received packet len (%u) erroneously long\n",
>  			len
>  		);
>  		goto finish;
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
