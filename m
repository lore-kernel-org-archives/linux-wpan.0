Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:32771 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbCTP2R (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 11:28:17 -0400
Received: by weop45 with SMTP id p45so84883983weo.0
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 08:28:16 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:28:10 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/3] ieee802154: add set transmit power
 support
Message-ID: <20150320152804.GA3952@omega>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426836141-21528-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

there exist _maybe_ some general issues with the current interface and the
tx_power handling:

1.
   The at86rf2xx has also settings for a more fine granularity tx power
   setting. For example the at86rf233 has these values:
     - 4 dBm
     - 3.7 dBm
     - 3.4 dBm
     - 3 dBm
     - 2.5 dBm
     - 2 dBm
     ...
   I don't know if we should simple "round-down" and use the nearest
   value in this case. For the moment I am fine to handle the nearest value.

2.
   It seems that, for example the at86rf212 [1] which operates in
   700, 800 or 900 Mhz, the tx_power setting depends on the current setting of
   page and channel. I believe we can completely handle this inside the
   driver layer, but I am not 100% sure.

btw:
   What I am know is that the set_txpower driver callback in at86rf230
   need to decide if at86rf233, at86rf231 or at86rf212 and making some
   special handling. Especially the at86rf212 needs to check the current
   page and channel setting, because the register values differs here.
   Current behaviour is broken.


On Fri, Mar 20, 2015 at 12:52:18PM +0530, Varka Bhadram wrote:
> This patch adds transmission power setting support to nl802154.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  include/net/cfg802154.h   |    1 +
>  net/ieee802154/nl802154.c |   20 ++++++++++++++++++++
>  net/ieee802154/rdev-ops.h |    7 +++++++
>  net/mac802154/cfg.c       |   19 +++++++++++++++++++
>  4 files changed, 47 insertions(+)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index eeda676..b163d4e 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -57,6 +57,7 @@ struct cfg802154_ops {
>  					 s8 max_frame_retries);
>  	int	(*set_lbt_mode)(struct wpan_phy *wpan_phy,
>  				struct wpan_dev *wpan_dev, bool mode);
> +	int	(*set_tx_power)(struct wpan_phy *wpan_phy, s8 power);

put this into the sequence of the others phy settings like channel,
page. cca. etc...

>  };
>  
>  struct wpan_phy_cca {
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index a4daf91..8288fcb 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -794,6 +794,18 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
>  	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
>  }
>  
> +static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> +	s8 power;
> +
> +	if (!info->attrs[NL802154_ATTR_TX_POWER])
> +		return -EINVAL;
> +
> +	power = nla_get_s8(info->attrs[NL802154_ATTR_TX_POWER]);
> +	return rdev_set_tx_power(rdev, power);
> +}
> +
>  #define NL802154_FLAG_NEED_WPAN_PHY	0x01
>  #define NL802154_FLAG_NEED_NETDEV	0x02
>  #define NL802154_FLAG_NEED_RTNL		0x04
> @@ -984,6 +996,14 @@ static const struct genl_ops nl802154_ops[] = {
>  		.internal_flags = NL802154_FLAG_NEED_NETDEV |
>  				  NL802154_FLAG_NEED_RTNL,
>  	},
> +	{
> +		.cmd = NL802154_CMD_SET_TX_POWER,
> +		.doit = nl802154_set_tx_power,
> +		.policy = nl802154_policy,
> +		.flags = GENL_ADMIN_PERM,
> +		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
> +				  NL802154_FLAG_NEED_RTNL,
> +	},
>  };
>  

I posted ~4 days ago [0] a series which makes this kind of set cmd
obsolete. We should not introduce new commands if we decide to set phy
settings with only one cmd only. I will create a new thread about which
are the advantages and disadvantage about the new setting commands, then
we can decide there if we still use the old interface or switch to the
new behaviour. If we decide to use the new interface then you can rebase
your work on it.

>  /* initialisation/exit functions */
> diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
> index 7c46732..3de05a8 100644
> --- a/net/ieee802154/rdev-ops.h
> +++ b/net/ieee802154/rdev-ops.h
> @@ -91,6 +91,13 @@ rdev_set_lbt_mode(struct cfg802154_registered_device *rdev,
>  		  struct wpan_dev *wpan_dev, bool mode)
>  {
>  	return rdev->ops->set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
> +

remove this whitespace.

>  }
>  
> +static inline int
> +rdev_set_tx_power(struct cfg802154_registered_device *rdev,
> +		  u8 power)

s/u8/s8/

> +{
> +	return rdev->ops->set_tx_power(&rdev->wpan_phy, power);
> +}

also move this to the other phy rdev-ops wrappers.

>  #endif /* __CFG802154_RDEV_OPS */
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 5d9f68c..dde26f1 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -212,6 +212,24 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
>  	return 0;
>  }
>  
> +static int
> +ieee802154_set_tx_power(struct wpan_phy *wpan_phy, s8 power)
> +{
> +	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
> +	int ret;
> +
> +	ASSERT_RTNL();
> +
> +	if (!(local->hw.flags & IEEE802154_HW_TXPOWER))
> +		return -EOPNOTSUPP;
> +
> +	ret = drv_set_tx_power(local, power);
> +	if (!ret)
> +		wpan_phy->transmit_power = power;
> +
> +	return ret;
> +}

also move this to the other phy handlers.

> +
>  const struct cfg802154_ops mac802154_config_ops = {
>  	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
>  	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
> @@ -225,4 +243,5 @@ const struct cfg802154_ops mac802154_config_ops = {
>  	.set_max_csma_backoffs = ieee802154_set_max_csma_backoffs,
>  	.set_max_frame_retries = ieee802154_set_max_frame_retries,
>  	.set_lbt_mode = ieee802154_set_lbt_mode,
> +	.set_tx_power = ieee802154_set_tx_power,

same here.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01550.html
[1] http://www.atmel.com/images/doc8168.pdf
