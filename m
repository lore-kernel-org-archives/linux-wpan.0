Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34231 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbCXDmS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Mar 2015 23:42:18 -0400
Received: by pdbni2 with SMTP id ni2so207840180pdb.1
        for <linux-wpan@vger.kernel.org>; Mon, 23 Mar 2015 20:42:17 -0700 (PDT)
Message-ID: <5510DD02.5030902@gmail.com>
Date: Tue, 24 Mar 2015 09:11:54 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bluetooth-next 1/4] nl802154: add set wpan phy cmd
References: <1427125541-28708-1-git-send-email-alex.aring@gmail.com> <1427125541-28708-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1427125541-28708-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

On 03/23/2015 09:15 PM, Alexander Aring wrote:

> This patch adds NL802154_CMD_SET_WPAN_PHY command to set all wpan phy
> attributes instead of doing separate commands. This will improve
> userspace application handling of nl802154.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/nl802154.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index a4daf91..c12c07f 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -437,6 +437,49 @@ static int nl802154_get_wpan_phy(struct sk_buff *skb, struct genl_info *info)
>   	return genlmsg_reply(msg, info);
>   }
>   
> +static int nl802154_set_wpan_phy(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> +	int ret;
> +
> +	if (info->attrs[NL802154_ATTR_PAGE] &&
> +	    info->attrs[NL802154_ATTR_CHANNEL]) {
> +		u8 channel, page;
> +
> +		page = nla_get_u8(info->attrs[NL802154_ATTR_PAGE]);
> +		channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
> +		if (page > IEEE802154_MAX_PAGE ||
> +		    channel > IEEE802154_MAX_CHANNEL)
> +			return -EINVAL;
> +
> +		ret = rdev_set_channel(rdev, page, channel);
> +		if (ret < 0)
> +			return ret;

Why dont we return directly rdev_set_channel..
Is there any significance to the check on *ret*...?

> +	}
> +
> +	if (info->attrs[NL802154_ATTR_CCA_MODE]) {
> +		struct wpan_phy_cca cca;
> +
> +		cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
> +		if (cca.mode < NL802154_CCA_ENERGY ||
> +		    cca.mode > NL802154_CCA_ATTR_MAX)
> +			return -EINVAL;
> +
> +		if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
> +			if (!info->attrs[NL802154_ATTR_CCA_OPT])
> +				return -EINVAL;
> +
> +			cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
> +			if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
> +				return -EINVAL;
> +		}
> +
> +		return rdev_set_cca_mode(rdev, &cca);
> +	}
> +
> +	return 0;
> +}
> +
>   static inline u64 wpan_dev_id(struct wpan_dev *wpan_dev)
>   {
>   	return (u64)wpan_dev->identifier |
> @@ -896,6 +939,14 @@ static const struct genl_ops nl802154_ops[] = {
>   				  NL802154_FLAG_NEED_RTNL,
>   	},
>   	{
> +		.cmd = NL802154_CMD_SET_WPAN_PHY,
> +		.doit = nl802154_set_wpan_phy,
> +		.policy = nl802154_policy,
> +		.flags = GENL_ADMIN_PERM,
> +		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
> +				  NL802154_FLAG_NEED_RTNL,
> +	},
> +	{
>   		.cmd = NL802154_CMD_GET_INTERFACE,
>   		.doit = nl802154_get_interface,
>   		.dumpit = nl802154_dump_interface,

Thanks

-- 
Varka Bhadram

