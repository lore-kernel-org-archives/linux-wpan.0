Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED7C6FA8E
	for <linux-wpan@archiver.kernel.org>; Thu,  2 Mar 2023 13:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCBNqJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 2 Mar 2023 08:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCBNqI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Mar 2023 08:46:08 -0500
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC71C4E5FD;
        Thu,  2 Mar 2023 05:46:00 -0800 (PST)
Received: from [IPV6:2003:e9:d718:cfbb:38f2:5c92:aa89:2f41] (p200300e9d718cfbb38f25c92aa892f41.dip0.t-ipconnect.de [IPv6:2003:e9:d718:cfbb:38f2:5c92:aa89:2f41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id D899DC07BA;
        Thu,  2 Mar 2023 14:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1677764758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZCPZSKhbTKMI9ANLSz5262Q7X3GfPT6XC8uS5lY7qk=;
        b=fBZ4rfHIexqzhJT4l1lwk4KZk/qrxSK3U2UZLcHu93tRvX6o3n6h1282+xT3uLovVOv4sb
        EGogcqdQcwnSkXnthTl22OV+XBWaVuQ0CvkAMBM2njn4QPEncjGOr1IlPJRWE2Vz8jC8nS
        3X40cgDGqTgUy1DDrvQikNCNwCBUsgWe0SL9jlkpOT2kWjId3ywFmqWSuMTDJ5DMC55M63
        7XHA5E+kDpPuMCuj1alWre7P1WyxmA1dZqV4MsuPsfoxcQdL2OEfhcPXv0f0Qp+QsqxJun
        yqa9yqlkohiwav9YJSTE1agwbX1XIu5Lj+kieo9wykbYY1YXEEhjaAqibcJzqw==
Message-ID: <28bb37d5-6294-f0fc-bbd5-02ac7cda7983@datenfreihafen.org>
Date:   Thu, 2 Mar 2023 14:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH net] ieee802154: Prevent user from crashing the host
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
References: <20230301154450.547716-1-miquel.raynal@bootlin.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230301154450.547716-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 01.03.23 16:44, Miquel Raynal wrote:
> Avoid crashing the machine by checking
> info->attrs[NL802154_ATTR_SCAN_TYPE] presence before de-referencing it,
> which was the primary intend of the blamed patch.
> 
> Reported-by: Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: a0b6106672b5 ("ieee802154: Convert scan error messages to extack")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   net/ieee802154/nl802154.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 88380606af2c..a18fb98a4b09 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -1412,7 +1412,7 @@ static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (!nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE])) {
> +	if (!info->attrs[NL802154_ATTR_SCAN_TYPE]) {
>   		NL_SET_ERR_MSG(info->extack, "Malformed request, missing scan type");
>   		return -EINVAL;
>   	}

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
