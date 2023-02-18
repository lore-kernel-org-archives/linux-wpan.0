Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA2C636CC
	for <linux-wpan@archiver.kernel.org>; Sat, 18 Feb 2023 15:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBRP1k (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 18 Feb 2023 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRP1j (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 18 Feb 2023 10:27:39 -0500
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3915CB3
        for <linux-wpan@vger.kernel.org>; Sat, 18 Feb 2023 07:27:37 -0800 (PST)
Received: from [IPV6:2003:e9:d720:e79c:c160:8694:42f3:16db] (p200300e9d720e79cc160869442f316db.dip0.t-ipconnect.de [IPv6:2003:e9:d720:e79c:c160:8694:42f3:16db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 745D8C01A9;
        Sat, 18 Feb 2023 16:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1676734055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uO88gdoKY6We3Y39RM2dz1ze4/hpDZf3uwi5hX0I9BU=;
        b=vlyJyTKcWCTVbBCZw/ZEOkozkPQWKAaduLashsGztgSCb/5VT2GftCz1p9b5xLk8No0qn6
        6Tp2sXzqhCp0D5/tRw8uK8mngeQHat+tSbFeqDcFWdqZBVIrrtc/pu5y5KXEbsi++8LqfT
        Q3aCJVtaZ88GwBDwLCfSb7lTzx4Lgt0lqPkooCXA4Ror5KGKuxVgxOY8Pk7YrLcQ4wAas7
        JeUe1yJbDV1lsCubIMQ2wKjqhZbQHTBh1qVX7jC+ULHyhlBGvqYDjKeajWNn7CQG5Wh1+g
        KskMIPgVn5PyAthMKx8jvi+7LYLsYa9vgMPrneZOkI98C1bN6Km/+16Cqw+/nA==
Message-ID: <706b939f-8f84-6da1-38b0-9146874d19e1@datenfreihafen.org>
Date:   Sat, 18 Feb 2023 16:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH wpan] ca8210: fix mac_len negative array access
To:     Alexander Aring <aahringo@redhat.com>, linux-wpan@vger.kernel.org
Cc:     bluetlh@gmail.com
References: <20230217042504.3303396-1-aahringo@redhat.com>
Content-Language: en-US
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230217042504.3303396-1-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 17.02.23 05:25, Alexander Aring wrote:
> This patch fixes a buffer overflow access of skb->data if
> ieee802154_hdr_peek_addrs() fails.
> 
> Reported-by: lianhui tang <bluetlh@gmail.com>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>   drivers/net/ieee802154/ca8210.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index e1a569b99e4a..0b0c6c0764fe 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1913,6 +1913,8 @@ static int ca8210_skb_tx(
>   	 * packet
>   	 */
>   	mac_len = ieee802154_hdr_peek_addrs(skb, &header);
> +	if (mac_len < 0)
> +		return mac_len;
>   
>   	secspec.security_level = header.sec.level;
>   	secspec.key_id_mode = header.sec.key_id_mode;

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
