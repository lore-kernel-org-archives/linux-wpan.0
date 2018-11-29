Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:39310 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeK3Jry (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 30 Nov 2018 04:47:54 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so6367963itl.4
        for <linux-wpan@vger.kernel.org>; Thu, 29 Nov 2018 14:40:50 -0800 (PST)
Date: Thu, 29 Nov 2018 17:40:47 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH wpan] ieee802154: hwsim: fix off-by-one in parse nested
Message-ID: <20181129224047.axjkdzj5gg2boup5@x220t>
References: <20181129223837.6719-1-aring@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129223837.6719-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org

On Thu, Nov 29, 2018 at 05:38:37PM -0500, Alexander Aring wrote:
> This patch fixes a off-by-one mistake in nla_parse_nested() functions of
> mac802154_hwsim driver. I had to enabled stack protector so I was able
> to reproduce it.
> 
> Reference: https://github.com/linux-wpan/wpan-tools/issues/17
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index bf70ab892e69..fbcbf55ce744 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -500,7 +500,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
>  	    !info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE])
>  		return -EINVAL;
>  
> -	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX + 1,
> +	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX,
>  			     info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE],
>  			     hwsim_edge_policy, NULL))
>  		return -EINVAL;
> @@ -543,6 +543,7 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
>  	struct hwsim_edge_info *einfo;
>  	struct hwsim_phy *phy_v0;
>  	struct hwsim_edge *e;
> +

grml, I will fix that...

- Alex
