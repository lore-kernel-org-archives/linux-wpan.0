Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55772 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeHWL7l (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Aug 2018 07:59:41 -0400
Subject: Re: [PATCH net-next] ieee802154: Use kmemdup instead of duplicating
 it in ca8210_test_int_driver_write
References: <20180809064429.13348-1-yuehaibing@huawei.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <dad727d7-93b2-626a-fd4d-c0ff69f84f34@datenfreihafen.org>
Date: Thu, 23 Aug 2018 10:31:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180809064429.13348-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, h.morris@cascoda.com, alex.aring@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

Hello.

On 08/09/2018 08:44 AM, YueHaibing wrote:
> Replace calls to kmalloc followed by a memcpy with a direct call to
> kmemdup.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ieee802154/ca8210.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 58299fb..e21279d 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -634,10 +634,9 @@ static int ca8210_test_int_driver_write(
>  	for (i = 0; i < len; i++)
>  		dev_dbg(&priv->spi->dev, "%#03x\n", buf[i]);
>  
> -	fifo_buffer = kmalloc(len, GFP_KERNEL);
> +	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
>  	if (!fifo_buffer)
>  		return -ENOMEM;
> -	memcpy(fifo_buffer, buf, len);
>  	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
>  	wake_up_interruptible(&priv->test.readq);
>  


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
