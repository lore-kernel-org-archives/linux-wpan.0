Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50461 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0Vea (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Sep 2018 17:34:30 -0400
Subject: Re: [PATCH] ieee802154: ca8210: remove redundant condition check
 before debugfs_remove
References: <1536901477-28375-1-git-send-email-zhongjiang@huawei.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <1501d440-c509-862e-c945-94665ec75c83@datenfreihafen.org>
Date: Thu, 27 Sep 2018 17:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <1536901477-28375-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: zhong jiang <zhongjiang@huawei.com>, h.morris@cascoda.com, alex.aring@gmail.com, davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Zhong.

On 14/09/2018 07:04, zhong jiang wrote:
> debugfs_remove has taken the IS_ERR into account. Just
> remove the unnecessary condition.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/ieee802154/ca8210.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 58299fb..46b4818 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -3044,8 +3044,7 @@ static void ca8210_test_interface_clear(struct ca8210_priv *priv)
>  {
>  	struct ca8210_test *test = &priv->test;
>  
> -	if (!IS_ERR(test->ca8210_dfs_spi_int))
> -		debugfs_remove(test->ca8210_dfs_spi_int);
> +	debugfs_remove(test->ca8210_dfs_spi_int);
>  	kfifo_free(&test->up_fifo);
>  	dev_info(&priv->spi->dev, "Test interface removed\n");
>  }
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
