Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:42502 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbbEFMCL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 08:02:11 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t46C28Gx025533
	for <linux-wpan@vger.kernel.org>; Wed, 6 May 2015 14:02:08 +0200
Date: Wed, 6 May 2015 14:02:04 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [PATCHv2 wpan-next 09/16] ieee802154: add support for get tx
 powers
Message-ID: <20150506140204.59159002@zoidberg>
In-Reply-To: <1430912428-17284-10-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
	<1430912428-17284-10-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed,  6 May 2015 13:40:21 +0200
Alexander Aring <alex.aring@gmail.com> wrote:

> This patch adds support for get transmit power levels. The driver
> needs to implement a driver ops callback which can iterate over each
> transmit power level index. This callback can return zero for
> successful iteration, 1 for ending the iteration, 2 for continue the
> iteration which an index increment and values below 0 zero if failed.

Now that every tx power value can be represented, why not just return a
const s32* and a number of elements in that array?

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/net/cfg802154.h    |  1 +
>  include/net/mac802154.h    | 10 +++++++++-
>  net/ieee802154/rdev-ops.h  | 11 +++++++++++
>  net/ieee802154/trace.h     | 31 +++++++++++++++++++++++++++++++
>  net/mac802154/cfg.c        | 11 +++++++++++
>  net/mac802154/driver-ops.h | 12 ++++++++++++
>  6 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 387db39..6758e61 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -44,6 +44,7 @@ struct cfg802154_ops {
>  	int	(*set_channel)(struct wpan_phy *wpan_phy, u8
> page, u8 channel); int	(*set_cca_mode)(struct wpan_phy
> *wpan_phy, const struct wpan_phy_cca *cca);
> +	int	(*get_tx_powers)(struct wpan_phy *wpan_phy, s32
> *mbm, u32 idx); int	(*set_pan_id)(struct wpan_phy *wpan_phy,
>  			      struct wpan_dev *wpan_dev, __le16
> pan_id); int	(*set_short_addr)(struct wpan_phy *wpan_phy,
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 3b76aab..be8d3de 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -174,6 +174,12 @@ struct ieee802154_hw {
>   *	  Set radio transmit power in mBm. Called with pib_lock
> held.
>   *	  Returns either zero, or negative errno.
>   *
> + * get_txpowers:
> + *	  Get radio transmit powers in mBm. Called when rtnl lock
> is held.
> + *	  Parameter idx descibes the index of transmit power which
> is supported.
> + *	  Returns either zero or negative errno. One should be
> returned for
> + *	  indicate to break the iteration of tx power settings.
> + *
>   * set_lbt
>   *	  Enables or disables listen before talk on the device.
> Called with
>   *	  pib_lock held.
> @@ -213,7 +219,9 @@ struct ieee802154_ops {
>  	int		(*set_hw_addr_filt)(struct ieee802154_hw
> *hw, struct ieee802154_hw_addr_filt *filt,
>  					    unsigned long changed);
> -	int		(*set_txpower)(struct ieee802154_hw *hw,
> s32 dbm);
> +	int		(*set_txpower)(struct ieee802154_hw *hw,
> s32 mbm);
> +	int		(*get_tx_powers)(struct ieee802154_hw
> *hw, s32 *mbm,
> +					 u32 idx);
>  	int		(*set_lbt)(struct ieee802154_hw *hw, bool
> on); int		(*set_cca_mode)(struct ieee802154_hw *hw,
>  					const struct wpan_phy_cca
> *cca); diff --git a/net/ieee802154/rdev-ops.h
> b/net/ieee802154/rdev-ops.h index 7b5a9dd..8fc1afe 100644
> --- a/net/ieee802154/rdev-ops.h
> +++ b/net/ieee802154/rdev-ops.h
> @@ -75,6 +75,17 @@ rdev_set_cca_mode(struct
> cfg802154_registered_device *rdev, }
>  
>  static inline int
> +rdev_get_tx_powers(struct cfg802154_registered_device *rdev, s32
> *mbm, u32 idx) +{
> +	int ret;
> +
> +	trace_802154_rdev_get_tx_powers(&rdev->wpan_phy, idx);
> +	ret = rdev->ops->get_tx_powers(&rdev->wpan_phy, mbm, idx);
> +	trace_802154_rdev_return_int_mbm(&rdev->wpan_phy, ret, mbm);
> +	return ret;
> +}
> +
> +static inline int
>  rdev_set_pan_id(struct cfg802154_registered_device *rdev,
>  		struct wpan_dev *wpan_dev, __le16 pan_id)
>  {
> diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
> index 5ac25eb..3c54b5e 100644
> --- a/net/ieee802154/trace.h
> +++ b/net/ieee802154/trace.h
> @@ -108,6 +108,37 @@ TRACE_EVENT(802154_rdev_set_cca_mode,
>  		  WPAN_CCA_PR_ARG)
>  );
>  
> +TRACE_EVENT(802154_rdev_get_tx_powers,
> +	TP_PROTO(struct wpan_phy *wpan_phy, u32 idx),
> +	TP_ARGS(wpan_phy, idx),
> +	TP_STRUCT__entry(
> +		WPAN_PHY_ENTRY
> +		__field(u32, idx)
> +	),
> +	TP_fast_assign(
> +		WPAN_PHY_ASSIGN;
> +		__entry->idx = idx;
> +	),
> +	TP_printk(WPAN_PHY_PR_FMT ", idx: %d", WPAN_PHY_PR_ARG,
> __entry->idx) +);
> +
> +TRACE_EVENT(802154_rdev_return_int_mbm,
> +	TP_PROTO(struct wpan_phy *wpan_phy, int ret, s32 *mbm),
> +	TP_ARGS(wpan_phy, ret, mbm),
> +	TP_STRUCT__entry(
> +		WPAN_PHY_ENTRY
> +		__field(int, ret)
> +		__field(s32, mbm)
> +	),
> +	TP_fast_assign(
> +		WPAN_PHY_ASSIGN;
> +		__entry->ret = ret;
> +		__entry->mbm = *mbm;
> +	),
> +	TP_printk(WPAN_PHY_PR_FMT ", returned: %d, mbm: %d",
> WPAN_PHY_PR_ARG,
> +		  __entry->ret, __entry->mbm)
> +);
> +
>  DECLARE_EVENT_CLASS(802154_le16_template,
>  	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev
> *wpan_dev, __le16 le16arg),
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index d5290ea..4228069 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -106,6 +106,16 @@ ieee802154_set_cca_mode(struct wpan_phy
> *wpan_phy, }
>  
>  static int
> +ieee802154_get_tx_powers(struct wpan_phy *wpan_phy, s32 *mbm, u32
> idx) +{
> +	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
> +
> +	ASSERT_RTNL();
> +
> +	return drv_get_tx_powers(local, mbm, idx);
> +}
> +
> +static int
>  ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev
> *wpan_dev, __le16 pan_id)
>  {
> @@ -195,6 +205,7 @@ const struct cfg802154_ops mac802154_config_ops =
> { .del_virtual_intf = ieee802154_del_iface,
>  	.set_channel = ieee802154_set_channel,
>  	.set_cca_mode = ieee802154_set_cca_mode,
> +	.get_tx_powers = ieee802154_get_tx_powers,
>  	.set_pan_id = ieee802154_set_pan_id,
>  	.set_short_addr = ieee802154_set_short_addr,
>  	.set_backoff_exponent = ieee802154_set_backoff_exponent,
> diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
> index caecd5f..27a59dc 100644
> --- a/net/mac802154/driver-ops.h
> +++ b/net/mac802154/driver-ops.h
> @@ -70,6 +70,18 @@ static inline int drv_set_tx_power(struct
> ieee802154_local *local, s32 mbm) return
> local->ops->set_txpower(&local->hw, mbm); }
>  
> +static inline int
> +drv_get_tx_powers(struct ieee802154_local *local, s32 *mbm, u32 idx)
> +{
> +	might_sleep();
> +
> +	/* if not implemented indicate a empty list */
> +	if (!local->ops->get_tx_powers)
> +		return 1;
> +
> +	return local->ops->get_tx_powers(&local->hw, mbm, idx);
> +}
> +
>  static inline int drv_set_cca_mode(struct ieee802154_local *local,
>  				   const struct wpan_phy_cca *cca)
>  {

