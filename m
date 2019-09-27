Return-Path: <SRS0=ipMm=XW=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E469C4360C
	for <linux-wpan@archiver.kernel.org>; Fri, 27 Sep 2019 20:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CA820863
	for <linux-wpan@archiver.kernel.org>; Fri, 27 Sep 2019 20:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfI0UBN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:01:13 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:51977 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfI0UBN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Sep 2019 16:01:13 -0400
Received: from localhost.localdomain (p200300E9D742D296A393C26E681B47E6.dip0.t-ipconnect.de [IPv6:2003:e9:d742:d296:a393:c26e:681b:47e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 890E7C1B22;
        Fri, 27 Sep 2019 22:01:10 +0200 (CEST)
Subject: Re: [PATCH] ieee802154: ca8210: prevent memory leak
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Harry Morris <h.morris@cascoda.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190917224713.26371-1-navid.emamdoost@gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <cda67450-267f-3c94-68b6-73ea8c4dfe2f@datenfreihafen.org>
Date:   Fri, 27 Sep 2019 22:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917224713.26371-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 18.09.19 00:47, Navid Emamdoost wrote:
> In ca8210_probe the allocated pdata needs to be assigned to
> spi_device->dev.platform_data before calling ca8210_get_platform_data.
> Othrwise when ca8210_get_platform_data fails pdata cannot be released.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>   drivers/net/ieee802154/ca8210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index b188fce3f641..229d70a897ca 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -3152,12 +3152,12 @@ static int ca8210_probe(struct spi_device *spi_device)
>   		goto error;
>   	}
>   
> +	priv->spi->dev.platform_data = pdata;
>   	ret = ca8210_get_platform_data(priv->spi, pdata);
>   	if (ret) {
>   		dev_crit(&spi_device->dev, "ca8210_get_platform_data failed\n");
>   		goto error;
>   	}
> -	priv->spi->dev.platform_data = pdata;
>   
>   	ret = ca8210_dev_com_init(priv);
>   	if (ret) {
> 

As Harry seems to be unavailable I am taking this patch directly.


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
