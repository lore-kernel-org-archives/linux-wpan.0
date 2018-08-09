Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46522 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHIKhm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Aug 2018 06:37:42 -0400
Subject: Re: [PATCH net-next] ieee802154: Use kmemdup instead of duplicating
 it in ca8210_test_int_driver_write
References: <20180809064429.13348-1-yuehaibing@huawei.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <488f54b7-cfe2-f64b-168e-11f79d4d4e96@datenfreihafen.org>
Date: Thu, 9 Aug 2018 10:13:57 +0200
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

Is Yue your forname and Haibing your surname? In that case having it
written as

Yue Haibing <yuehaibing@huawei.com>

in the from line as well as in the SOB would be better.

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

Is this some kernel tree wide change you are submitting patches for or
only for the ca8210 driver? Is there any specific problem you see with
the kmalloc and memcpy code here? To me it looks fine.

The reason I ask is to understand if this is bug fix or a cleanup.

Harry, if you are ok with this one let me know with an Acked-By

regards
Stefan Schmidt
