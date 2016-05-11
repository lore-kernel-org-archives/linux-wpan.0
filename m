Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46858 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111AbcEKPTi (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 11:19:38 -0400
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: allow netns create of
 lowpan interface
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
 <1462959859-6669-3-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <57334D81.8040302@osg.samsung.com>
Date: Wed, 11 May 2016 17:19:29 +0200
MIME-Version: 1.0
In-Reply-To: <1462959859-6669-3-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Hello.

On 11/05/16 11:44, Alexander Aring wrote:
> This patch reverts commit f9d1ce8f81eb ("ieee802154: fix netns settings").
> The lowpan interface need to be created inside the net namespace where
> the wpan interface is available. The wpan namespace can be changed only
> by nl802154 before. Without this patch it's not possible to create a
> lowpan interface for a wpan interface which isn't inside init_net
> namespace.
>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/ieee802154/6lowpan/core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index dd085db..096e3db 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -131,8 +131,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
>   
>   	pr_debug("adding new link\n");
>   
> -	if (!tb[IFLA_LINK] ||
> -	    !net_eq(dev_net(ldev), &init_net))
> +	if (!tb[IFLA_LINK])
>   		return -EINVAL;
>   	/* find and hold wpan device */
>   	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
