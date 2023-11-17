Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37046C072A2
	for <linux-wpan@archiver.kernel.org>; Fri, 17 Nov 2023 12:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjKQMLj (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 17 Nov 2023 07:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQMLi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Nov 2023 07:11:38 -0500
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 04:11:34 PST
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28E196;
        Fri, 17 Nov 2023 04:11:34 -0800 (PST)
Received: from [192.168.2.51] (p4fe71630.dip0.t-ipconnect.de [79.231.22.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 48B82C0979;
        Fri, 17 Nov 2023 13:05:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1700222752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tjp8QbfFX1V9Jgb0mU/KGvDIlzk+uM7B4fwMIunZXXw=;
        b=BidlP4MEVMK+Px6Eqeub5GZlV+GjxUso4VEbjATeX4nICduDsSK8CTroZBsah/h9W+jMiB
        raETlsQIq07EN/ySZy1Aj+ji4D/H4VsyBFIvfJ7dUmc5L0LsIx04Od+JMWpip6XlpqHe4L
        Xcm07vmDW+uZyo9C/HDtgX24Yuya0EASgt4G66K0gnlAI2UQLhB8xwO3SJX/9n0VH7++IF
        5mGHgdoJrp3+kiWrkluSlYRi6jrBwvzYBV4OyoZEbnEDmwinLH3ynGaS+P33Z6oivUtsSV
        WwwnOI+n044PqA2/oI9N814AMjv+4Z2wBohzpCWSFGlcmRaUYICHSIvfQTXy+w==
Message-ID: <27dadb9d-e905-e019-a320-c078325724f8@datenfreihafen.org>
Date:   Fri, 17 Nov 2023 13:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 09/10] ieee802154: fakelb: Convert to platform
 remove callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexander Aring <alex.aring@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
 <20231117095922.876489-10-u.kleine-koenig@pengutronix.de>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231117095922.876489-10-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 17.11.23 10:59, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/net/ieee802154/fakelb.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
> index 523d13ee02bf..35e55f198e05 100644
> --- a/drivers/net/ieee802154/fakelb.c
> +++ b/drivers/net/ieee802154/fakelb.c
> @@ -221,7 +221,7 @@ static int fakelb_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> -static int fakelb_remove(struct platform_device *pdev)
> +static void fakelb_remove(struct platform_device *pdev)
>   {
>   	struct fakelb_phy *phy, *tmp;
>   
> @@ -229,14 +229,13 @@ static int fakelb_remove(struct platform_device *pdev)
>   	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
>   		fakelb_del(phy);
>   	mutex_unlock(&fakelb_phys_lock);
> -	return 0;
>   }
>   
>   static struct platform_device *ieee802154fake_dev;
>   
>   static struct platform_driver ieee802154fake_driver = {
>   	.probe = fakelb_probe,
> -	.remove = fakelb_remove,
> +	.remove_new = fakelb_remove,
>   	.driver = {
>   			.name = "ieee802154fakelb",
>   	},


Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
