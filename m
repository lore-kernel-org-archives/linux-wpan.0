Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45640 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeLBLTo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Dec 2018 06:19:44 -0500
Subject: Re: [PATCHv2 wpan] ieee802154: hwsim: fix off-by-one in parse nested
References: <20181129224154.7525-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <717b624d-b61f-8de2-8d7b-aeacd71a7786@datenfreihafen.org>
Date: Sun, 2 Dec 2018 12:19:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181129224154.7525-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 29.11.18 23:41, Alexander Aring wrote:
> This patch fixes a off-by-one mistake in nla_parse_nested() functions of
> mac802154_hwsim driver. I had to enabled stack protector so I was able
> to reproduce it.
> 
> Reference: https://github.com/linux-wpan/wpan-tools/issues/17
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index bf70ab892e69..624bff4d3636 100644
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
> @@ -550,7 +550,7 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
>  	    !info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE])
>  		return -EINVAL;
>  
> -	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX + 1,
> +	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX,
>  			     info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE],
>  			     hwsim_edge_policy, NULL))
>  		return -EINVAL;
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
