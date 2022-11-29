Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B782FC4321E
	for <linux-wpan@archiver.kernel.org>; Tue, 29 Nov 2022 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiK2OAu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiK2OAs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Nov 2022 09:00:48 -0500
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FF2D76D
        for <linux-wpan@vger.kernel.org>; Tue, 29 Nov 2022 06:00:46 -0800 (PST)
Received: from [IPV6:2003:e9:d724:11f3:6a8a:fec:d223:2c22] (p200300e9d72411f36a8a0fecd2232c22.dip0.t-ipconnect.de [IPv6:2003:e9:d724:11f3:6a8a:fec:d223:2c22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id BAF11C0438;
        Tue, 29 Nov 2022 15:00:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1669730444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRv3fXRd7PBdtlXn8y8T6vjzAPHszSuKiOgDSZOYJK0=;
        b=GvXVn82h3KepJIBnHmTeTPOXcBNiuMvEnNkLGjpJlaX8rvc2bTePVsxZlUabQ6C8bM4qZo
        u7/nQv66biC4VS7RjYC7RulAvKvdqts0J98GcAaR4ZIjRwk4dAcqgVDTYcU5qCxqgMKx3z
        UQLitGul80ycwSxpgB0LxMI8CPxxOyd/wqZnpB7T8U4kiwztP2qmU5t8E1klNA1cXIV8Li
        lgJaShHiuEnSNx8vmaZP27PzYPTOGN9aQ94KmECQicbwdWSivPjfN5BQwsGH+Vxx2759Ku
        R0AGfRTJlncnsVda2ED0/lB/S/ZpHgX/zpOn2gY9K4lJCwC73weOoSDQBVSuug==
Message-ID: <beed8318-924b-09cd-da0e-5ff38da0bf8e@datenfreihafen.org>
Date:   Tue, 29 Nov 2022 15:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ca8210: Fix crash by zero initializing data
Content-Language: en-US
To:     Hauke Mehrtens <hauke@hauke-m.de>, alex.aring@gmail.com
Cc:     linux-wpan@vger.kernel.org, harrymorris12@gmail.com
References: <20221121002201.1339636-1-hauke@hauke-m.de>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20221121002201.1339636-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 21.11.22 01:22, Hauke Mehrtens wrote:
> The struct cas_control embeds multiple generic SPI structures and we
> have to make sure these structures are initialized to default values.
> This driver does not set all attributes. When using kmalloc before some
> attributes were not initialized and contained random data which caused
> random crashes at bootup.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   drivers/net/ieee802154/ca8210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 450b16ad40a4..e1a569b99e4a 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -885,7 +885,7 @@ static int ca8210_spi_transfer(
>   
>   	dev_dbg(&spi->dev, "%s called\n", __func__);
>   
> -	cas_ctl = kmalloc(sizeof(*cas_ctl), GFP_ATOMIC);
> +	cas_ctl = kzalloc(sizeof(*cas_ctl), GFP_ATOMIC);
>   	if (!cas_ctl)
>   		return -ENOMEM;
>   

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
