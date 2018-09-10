Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:46167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbeIJHPC (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 10 Sep 2018 03:15:02 -0400
Subject: Re: [PATCH net-next] ieee802154: ca8210: Use kmemdup instead of
 duplicating it in ca8210_test_int_driver_write
References: <20180906034228.7660-1-yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <bb6d1de2-cb0c-73cb-e09a-a1a4c2357fb0@huawei.com>
Date: Mon, 10 Sep 2018 10:08:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180906034228.7660-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, h.morris@cascoda.com, alex.aring@gmail.com, stefan@datenfreihafen.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

sorry, Pls ignore this duplicated patch.

On 2018/9/6 11:42, YueHaibing wrote:
> Replace calls to kmalloc followed by a memcpy with a direct call tokmemdup.
> 
> Patch found using coccinelle.
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
> 
