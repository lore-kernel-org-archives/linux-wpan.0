Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53780 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753918AbdJPUW1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 16 Oct 2017 16:22:27 -0400
Subject: Re: [PATCH] 802154:netlink - fix typo of the name of struct genl_ops
References: <1507648665-14932-1-git-send-email-liuxuenetmail@gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <8a07285b-bba1-66d1-9fa0-5cd6fdae0ffd@datenfreihafen.org>
Date: Mon, 16 Oct 2017 22:14:11 +0200
MIME-Version: 1.0
In-Reply-To: <1507648665-14932-1-git-send-email-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello

On 10.10.2017 17:17, Xue Liu wrote:
> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
> ---
>  net/ieee802154/netlink.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
> index 6bde9e5..96636e3 100644
> --- a/net/ieee802154/netlink.c
> +++ b/net/ieee802154/netlink.c
> @@ -89,7 +89,7 @@ int ieee802154_nl_reply(struct sk_buff *msg, struct genl_info *info)
>  	return genlmsg_reply(msg, info);
>  }
>  
> -static const struct genl_ops ieee8021154_ops[] = {
> +static const struct genl_ops ieee802154_ops[] = {
>  	/* see nl-phy.c */
>  	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
>  			ieee802154_dump_phy),
> @@ -137,8 +137,8 @@ struct genl_family nl802154_family __ro_after_init = {
>  	.version	= 1,
>  	.maxattr	= IEEE802154_ATTR_MAX,
>  	.module		= THIS_MODULE,
> -	.ops		= ieee8021154_ops,
> -	.n_ops		= ARRAY_SIZE(ieee8021154_ops),
> +	.ops		= ieee802154_ops,
> +	.n_ops		= ARRAY_SIZE(ieee802154_ops),
>  	.mcgrps		= ieee802154_mcgrps,
>  	.n_mcgrps	= ARRAY_SIZE(ieee802154_mcgrps),
>  };
> 

Applied to my wpan-next tree. It will be part of my next pull request to
the net tree.

I took the freedom to adjust the patch subject slightly to match our
style:
ieee802154: netlink: fix typo of the name of struct genl_ops

regards
Stefan Schmidt
