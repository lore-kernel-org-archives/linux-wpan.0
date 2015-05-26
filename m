Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37868 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbEZNBI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 09:01:08 -0400
Received: by wifw1 with SMTP id w1so29784056wif.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 05:59:27 -0700 (PDT)
Date: Tue, 26 May 2015 11:07:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] ieee802154: add set transmit power
 support
Message-ID: <20150526090706.GC2747@omega>
References: <1432478793-17254-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432478793-17254-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Sun, May 24, 2015 at 08:16:33PM +0530, Varka Bhadram wrote:
> This patch adds transmission power setting support for IEEE-802.15.4
> devices via nl802154.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  include/net/cfg802154.h   |    1 +
>  net/ieee802154/nl802154.c |   21 +++++++++++++++++++++
>  net/ieee802154/rdev-ops.h |   12 ++++++++++++
>  net/ieee802154/trace.h    |   15 +++++++++++++++
>  net/mac802154/cfg.c       |   19 +++++++++++++++++++
>  5 files changed, 68 insertions(+)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 4de59aa..2e3bb01 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -44,6 +44,7 @@ struct cfg802154_ops {
>  	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
>  	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
>  				const struct wpan_phy_cca *cca);
> +	int     (*set_tx_power)(struct wpan_phy *wpan_phy, s32 power);
>  	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
>  			      struct wpan_dev *wpan_dev, __le16 pan_id);
>  	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 54f4959..42bc3d7 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -783,6 +783,19 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
>  	return rdev_set_cca_mode(rdev, &cca);
>  }
>  
> +static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> +	s32 power;
> +
> +	if (!info->attrs[NL802154_ATTR_TX_POWER])
> +		return -EINVAL;
> +

Uou also should check on phy tx power setting. That the phy is support
TX_POWER I moved this now, because it's phy setting (which ends into a
direct driver layer call) in the wpan_phy.

it's (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER), so please do a:

if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
	return -EOPNOTSUPP;

before the if (!info->attrs[NL802154_ATTR_TX_POWER]) condition.


Also we have now the option to first check on "if we support the
receiving mbm value". Please iterate over all these values before and
lookup if we support it.

Since the TX_POWER is a direct layer call, normally the driver could
also report about "we don't support this value", but this depends on
driver implementation. So please check the value inside the cfg802154
layer, which makes it sure that the represented from capabilities can
really reach the driver layer only.

How you iterate over the tx power values, you can lookup in capabilities
dump functionality.

- Alex
