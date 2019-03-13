Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38488 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfCMJJh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Mar 2019 05:09:37 -0400
Subject: Re: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
References: <20190311072517.29740-1-kjlu@umn.edu>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <3e612944-e54c-a694-405e-f73582a690c5@datenfreihafen.org>
Date: Wed, 13 Mar 2019 10:09:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190311072517.29740-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

[please ignore the first mail, hit send to early]

On 11.03.19 08:25, Kangjie Lu wrote:
> In case alloc_ordered_workqueue fails, the fix releases
> sources and returns -ENOMEM to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ieee802154/adf7242.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index cd1d8faccca5..cd6b95e673a5 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
>  	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
>  	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
>  					     WQ_MEM_RECLAIM);
> +	if (unlikely(!lp->wqueue)) {
> +		ret = -ENOMEM;
> +		goto err_hw_init;
> +	}
>  
>  	ret = adf7242_hw_init(lp);
>  	if (ret)
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
