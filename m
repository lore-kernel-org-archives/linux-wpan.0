Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34554 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbbDHOQn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 10:16:43 -0400
Received: by widjs5 with SMTP id js5so34129434wid.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 07:16:41 -0700 (PDT)
Date: Wed, 8 Apr 2015 16:16:35 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 3/4] ieee802154: add several phy supported
 handling
Message-ID: <20150408141634.GA1917@omega>
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
 <1428491912-14027-4-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1428491912-14027-4-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hi,

On Wed, Apr 08, 2015 at 01:18:31PM +0200, Alexander Aring wrote:
> This patch adds support for phy supported handling for all other already
> existing handling 802.15.4 functionality. We assume now a fully 802.15.4
> complaint transceiver at phy allocation. If a transceiver can support
> 802.15.4 default values only, then the values should be overwirtten by
> values the transceiver supports.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
> ---
>  include/net/cfg802154.h   |  5 +++++
>  net/ieee802154/nl802154.c | 31 +++++++++++++++++++++----------
>  net/mac802154/main.c      | 10 ++++++++++
>  3 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index c4d42ad..c9d09b1 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -61,6 +61,11 @@ struct cfg802154_ops {
>  
>  struct wpan_phy_supported {
>  	u32 channels[IEEE802154_MAX_PAGE + 1];
> +	u8 cca_modes, cca_opts;
> +	u8 min_minbe, max_minbe, min_maxbe, max_maxbe;
> +	s8 min_frame_retries, max_frame_retries;
> +	u8 min_csma_backoffs, max_csma_backoffs;
> +	bool lbt;
>  };
>  
>  struct wpan_phy_cca {
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 4ea64ef..7e3b2cc 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -625,11 +625,8 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
>  	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
>  
>  	/* check 802.15.4 constraints */
> -	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL)
> -		return -EINVAL;
> -
> -	/* check if phy support this setting */
> -	if (!(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
> +	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL ||
> +	    !(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
>  		return -EINVAL;
>  

better I do this cleanup in the previous patch, which moves this check
out of SoftMAC layer.

>  	return rdev_set_channel(rdev, page, channel);
> @@ -645,7 +642,9 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
>  
>  	cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
>  	/* checking 802.15.4 constraints */
> -	if (cca.mode < NL802154_CCA_ENERGY || cca.mode > NL802154_CCA_ATTR_MAX)
> +	if (cca.mode < NL802154_CCA_ENERGY ||
> +	    cca.mode > NL802154_CCA_ATTR_MAX ||
> +	    !(rdev->wpan_phy.supported.cca_modes & BIT(cca.mode)))
>  		return -EINVAL;
>  
>  	if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
> @@ -653,7 +652,8 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
>  			return -EINVAL;
>  
>  		cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
> -		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
> +		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX ||
> +		    !(rdev->wpan_phy.supported.cca_opts & BIT(cca.opt)))
>  			return -EINVAL;
>  	}
>  
> @@ -726,7 +726,11 @@ nl802154_set_backoff_exponent(struct sk_buff *skb, struct genl_info *info)
>  	max_be = nla_get_u8(info->attrs[NL802154_ATTR_MAX_BE]);
>  
>  	/* check 802.15.4 constraints */

remove the comment here, it's not anymore just 802.15.4. It's what the
phy supports.

> -	if (max_be < 3 || max_be > 8 || min_be > max_be)
> +	if (max_be < 3 || max_be > 8 || min_be > max_be ||

I will remove the "max_be < 3 || max_be > 8" it's not required here that
we have some "valid 802.15.4 range here" this should be replaced by
handle with:

max_be < rdev->wpan_phy.supported.min_maxbe ||
max_be > rdev->wpan_phy.supported.max_maxbe...

It could be that a driver set the supported values outside of 802.15.4
but this is then a bug inside the driver. For running transceivers out
of spec, we should introduce _maybe_ some vendor specific nl802154
command. If somebody wants to do that.

> +	    min_be < rdev->wpan_phy.supported.min_minbe ||
> +	    min_be > rdev->wpan_phy.supported.max_minbe ||
> +	    max_be < rdev->wpan_phy.supported.min_maxbe ||
> +	    max_be > rdev->wpan_phy.supported.max_maxbe)
>  		return -EINVAL;
>  
>  	return rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
> @@ -751,7 +755,9 @@ nl802154_set_max_csma_backoffs(struct sk_buff *skb, struct genl_info *info)
>  			info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]);
>  
>  	/* check 802.15.4 constraints */
> -	if (max_csma_backoffs > 5)
> +	if (max_csma_backoffs > 5 ||

same here.

> +	    max_csma_backoffs < rdev->wpan_phy.supported.min_csma_backoffs ||
> +	    max_csma_backoffs > rdev->wpan_phy.supported.max_csma_backoffs)
>  		return -EINVAL;
>  
>  	return rdev_set_max_csma_backoffs(rdev, wpan_dev, max_csma_backoffs);
> @@ -775,7 +781,9 @@ nl802154_set_max_frame_retries(struct sk_buff *skb, struct genl_info *info)
>  			info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]);
>  
>  	/* check 802.15.4 constraints */
> -	if (max_frame_retries < -1 || max_frame_retries > 7)
> +	if (max_frame_retries < -1 || max_frame_retries > 7 ||

here, too.

> +	    max_frame_retries < rdev->wpan_phy.supported.min_frame_retries ||
> +	    max_frame_retries > rdev->wpan_phy.supported.max_frame_retries)
>  		return -EINVAL;
>  
>  	return rdev_set_max_frame_retries(rdev, wpan_dev, max_frame_retries);
> @@ -795,6 +803,9 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
>  		return -EINVAL;
>  
>  	mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
> +	if (mode && !rdev->wpan_phy.supported.lbt)
> +		return -ENOTSUPP;
> +

I am still not sure about checking lbt mode. But I think it's different
between "check if the value is allowed" or "check if operation is
supported". With this patch a non lbt phy can set the lbt value to
false (which is allowed), but the SoftMAC layer will tell then "sorry,
operation not supported".

Maybe we should check in SoftMAC if the value is really changed before
and if not do nothing and remove the check on if the driver_ops supports
the operation. [0]

>  	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
>  }
>  
> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 8500378..a92eb5f 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -107,6 +107,16 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>  
>  	skb_queue_head_init(&local->skb_queue);
>  
> +	/* init supported flags with 802.15.4 constraints */
> +	phy->supported.max_minbe = 8;
> +	phy->supported.min_maxbe = 3;
> +	phy->supported.max_maxbe = 8;
> +	phy->supported.min_frame_retries = -1;
> +	phy->supported.max_frame_retries = 7;
> +	phy->supported.max_csma_backoffs = 5;
> +	phy->supported.cca_modes = 0xFF;
> +	phy->supported.cca_opts = 0xFF;

ehm, yes I will better use the real full possible bitmask here for
cca_modes and cca_opts.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac802154/cfg.c#L191
