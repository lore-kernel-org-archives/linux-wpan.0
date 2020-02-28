Return-Path: <SRS0=DF8r=4Q=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E8DC3F2D2
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Feb 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457C2469F
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Feb 2020 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgB1PWH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:22:07 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:55736 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgB1PWH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Feb 2020 10:22:07 -0500
Received: from localhost.localdomain (p200300E9D71B9939E2C0865DB6B8C4EC.dip0.t-ipconnect.de [IPv6:2003:e9:d71b:9939:e2c0:865d:b6b8:c4ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id EBB8DC08EE;
        Fri, 28 Feb 2020 16:22:04 +0100 (CET)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH][next] cfg802154: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200228135959.GA30464@embeddedor>
Message-ID: <2711894b-b78d-aebe-79fd-aa274d4ff977@datenfreihafen.org>
Date:   Fri, 28 Feb 2020 16:22:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228135959.GA30464@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 28.02.20 14:59, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>          int stuff;
>          struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   include/net/cfg802154.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 6f86073a5d7d..6ed07844eb24 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -214,7 +214,7 @@ struct wpan_phy {
>   	/* the network namespace this phy lives in currently */
>   	possible_net_t _net;
>   
> -	char priv[0] __aligned(NETDEV_ALIGN);
> +	char priv[] __aligned(NETDEV_ALIGN);
>   };
>   
>   static inline struct net *wpan_phy_net(struct wpan_phy *wpan_phy)
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
