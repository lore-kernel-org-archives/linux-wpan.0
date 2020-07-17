Return-Path: <SRS0=NfXf=A4=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F2FC433E0
	for <linux-wpan@archiver.kernel.org>; Fri, 17 Jul 2020 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FE22070E
	for <linux-wpan@archiver.kernel.org>; Fri, 17 Jul 2020 09:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGQJxD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:53:03 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:54006 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQJxB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Jul 2020 05:53:01 -0400
X-Greylist: delayed 1582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2020 05:53:01 EDT
Received: from localhost.localdomain (p200300e9d737160bc31b0c5d63306033.dip0.t-ipconnect.de [IPv6:2003:e9:d737:160b:c31b:c5d:6330:6033])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id A38ADC0486;
        Fri, 17 Jul 2020 11:52:59 +0200 (CEST)
Subject: Re: [PATCH net-next] ieee802154: fix one possible memleak in
 adf7242_probe
To:     Liu Jian <liujian56@huawei.com>, michael.hennerich@analog.com,
        alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        kjlu@umn.edu, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
References: <20200717090121.2143-1-liujian56@huawei.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <79b20791-e78b-f2af-5355-7715aa3146b7@datenfreihafen.org>
Date:   Fri, 17 Jul 2020 11:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717090121.2143-1-liujian56@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 17.07.20 11:01, Liu Jian wrote:
> When probe fail, we should destroy the workqueue.
> 
> Fixes: 2795e8c25161 ("net: ieee802154: fix a potential NULL pointer dereference")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>   drivers/net/ieee802154/adf7242.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index 5a37514e4234..8dbccec6ac86 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1262,7 +1262,7 @@ static int adf7242_probe(struct spi_device *spi)
>   					     WQ_MEM_RECLAIM);
>   	if (unlikely(!lp->wqueue)) {
>   		ret = -ENOMEM;
> -		goto err_hw_init;
> +		goto err_alloc_wq;
>   	}
>   
>   	ret = adf7242_hw_init(lp);
> @@ -1294,6 +1294,8 @@ static int adf7242_probe(struct spi_device *spi)
>   	return ret;
>   
>   err_hw_init:
> +	destroy_workqueue(lp->wqueue);
> +err_alloc_wq:
>   	mutex_destroy(&lp->bmux);
>   	ieee802154_free_hw(lp->hw);
>   
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
