Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:41977 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbD0LuX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Apr 2015 07:50:23 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t3RBoK4V026964
	for <linux-wpan@vger.kernel.org>; Mon, 27 Apr 2015 13:50:20 +0200
Date: Mon, 27 Apr 2015 13:50:19 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [RFC bluetooth-next 10/15] ieee802154: add support for get cca
 ed levels
Message-ID: <20150427135019.7795da22@zoidberg>
In-Reply-To: <1429807674-24849-11-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
	<1429807674-24849-11-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, 23 Apr 2015 18:47:49 +0200
Alexander Aring <alex.aring@gmail.com> wrote:

> This patch adds support for get cca energy detection levels. The
> driver needs to implement a driver ops callback which can iterate
> over each transmit power level index. This callback can return zero
> for successful iteration, 1 for ending the iteration, 2 for continue
> the iteration which an index increment and values below 0 zero if
> failed.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/net/cfg802154.h    |  2 ++
>  include/net/mac802154.h    |  9 +++++++++
>  net/ieee802154/rdev-ops.h  | 12 ++++++++++++
>  net/ieee802154/trace.h     | 31 +++++++++++++++++++++++++++++++
>  net/mac802154/cfg.c        | 11 +++++++++++
>  net/mac802154/driver-ops.h | 12 ++++++++++++
>  6 files changed, 77 insertions(+)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 89995dd..7d44dcc 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -43,6 +43,8 @@ struct cfg802154_ops {
>  	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
>  				const struct wpan_phy_cca *cca);
>  	int	(*get_tx_powers)(struct wpan_phy *wpan_phy, s8
> *dbm, u32 idx);
> +	int	(*get_cca_ed_levels)(struct wpan_phy *wpan_phy,
> s32 *dbm,
> +				     u32 idx);

mBm instead of dBm would be better here, too.

>  	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
>  			      struct wpan_dev *wpan_dev, __le16
> pan_id); int	(*set_short_addr)(struct wpan_phy *wpan_phy,
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index c489946..009e64c 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -182,6 +182,13 @@ struct ieee802154_hw {
>   *	  returned for skipping dbm but increment idx value, this
> can be useful
>   *	  for register to dbm array mapping.
>   *
> + * get_cca_ed_levels
> + *	  Get cca ed levels in dBm for cca mode 3. Called when
> rtnl lock is
> + *	  held. Parameter idx descibes the index of cca ed levels
> which is
> + *	  supported. Returns either zero or negative errno. One
> should be
> + *	  returned to break the iteration of cca ed levels
> setting. Two should
> + *	  be returned for skipping dbm but increment idx value.
> + *
>   * set_lbt
>   *	  Enables or disables listen before talk on the device.
> Called with
>   *	  pib_lock held.
> @@ -224,6 +231,8 @@ struct ieee802154_ops {
>  	int		(*set_txpower)(struct ieee802154_hw *hw,
> s8 dbm); int		(*get_tx_powers)(struct ieee802154_hw
> *hw, s8 *dbm, u32 idx);
> +	int		(*get_cca_ed_levels)(struct ieee802154_hw
> *hw,
> +					     s32 *dbm, u32 idx);
>  	int		(*set_lbt)(struct ieee802154_hw *hw, bool
> on); int		(*set_cca_mode)(struct ieee802154_hw *hw,
>  					const struct wpan_phy_cca
> *cca); diff --git a/net/ieee802154/rdev-ops.h
> b/net/ieee802154/rdev-ops.h index d944a7a..5d2666f 100644
> --- a/net/ieee802154/rdev-ops.h
> +++ b/net/ieee802154/rdev-ops.h
> @@ -71,6 +71,18 @@ rdev_set_cca_mode(struct
> cfg802154_registered_device *rdev, }
>  
>  static inline int
> +rdev_get_cca_ed_levels(struct cfg802154_registered_device *rdev, s32
> *dbm,
> +		       u32 idx)
> +{
> +	int ret;
> +
> +	trace_802154_rdev_get_cca_ed_levels(&rdev->wpan_phy, idx);
> +	ret = rdev->ops->get_cca_ed_levels(&rdev->wpan_phy, dbm,
> idx);
> +	trace_802154_rdev_return_int_cca_ed_levels(&rdev->wpan_phy,
> ret, dbm);
> +	return ret;
> +}
> +
> +static inline int
>  rdev_get_tx_powers(struct cfg802154_registered_device *rdev, s8
> *dbm, u32 idx) {
>  	int ret;
> diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
> index 94ac3b9..c06b57f 100644
> --- a/net/ieee802154/trace.h
> +++ b/net/ieee802154/trace.h
> @@ -108,6 +108,37 @@ TRACE_EVENT(802154_rdev_set_cca_mode,
>  		  WPAN_CCA_PR_ARG)
>  );
>  
> +TRACE_EVENT(802154_rdev_get_cca_ed_levels,
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
> +TRACE_EVENT(802154_rdev_return_int_cca_ed_levels,
> +	TP_PROTO(struct wpan_phy *wpan_phy, int ret, s32 *dbm),
> +	TP_ARGS(wpan_phy, ret, dbm),
> +	TP_STRUCT__entry(
> +		WPAN_PHY_ENTRY
> +		__field(int, ret)
> +		__field(s32, dbm)
> +	),
> +	TP_fast_assign(
> +		WPAN_PHY_ASSIGN;
> +		__entry->ret = ret;
> +		__entry->dbm = *dbm;
> +	),
> +	TP_printk(WPAN_PHY_PR_FMT ", returned: %d, dbm: %d",
> WPAN_PHY_PR_ARG,
> +		  __entry->ret, __entry->dbm)
> +);
> +
>  TRACE_EVENT(802154_rdev_get_tx_powers,
>  	TP_PROTO(struct wpan_phy *wpan_phy, u32 idx),
>  	TP_ARGS(wpan_phy, idx),
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 2b80a77..e5234ab 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -103,6 +103,16 @@ ieee802154_set_cca_mode(struct wpan_phy
> *wpan_phy, }
>  
>  static int
> +ieee802154_get_cca_ed_levels(struct wpan_phy *wpan_phy, s32 *dbm,
> u32 idx) +{
> +	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
> +
> +	ASSERT_RTNL();
> +
> +	return drv_get_cca_ed_levels(local, dbm, idx);
> +}
> +
> +static int
>  ieee802154_get_tx_powers(struct wpan_phy *wpan_phy, s8 *dbm, u32 idx)
>  {
>  	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
> @@ -203,6 +213,7 @@ const struct cfg802154_ops mac802154_config_ops =
> { .set_channel = ieee802154_set_channel,
>  	.set_cca_mode = ieee802154_set_cca_mode,
>  	.get_tx_powers = ieee802154_get_tx_powers,
> +	.get_cca_ed_levels = ieee802154_get_cca_ed_levels,
>  	.set_pan_id = ieee802154_set_pan_id,
>  	.set_short_addr = ieee802154_set_short_addr,
>  	.set_backoff_exponent = ieee802154_set_backoff_exponent,
> diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
> index 08e2b09..323da5c 100644
> --- a/net/mac802154/driver-ops.h
> +++ b/net/mac802154/driver-ops.h
> @@ -120,6 +120,18 @@ drv_set_cca_ed_level(struct ieee802154_local
> *local, s32 ed_level) return local->ops->set_cca_ed_level(&local->hw,
> ed_level); }
>  
> +static inline int
> +drv_get_cca_ed_levels(struct ieee802154_local *local, s32 *dbm, u32
> idx) +{
> +	might_sleep();
> +
> +	/* if not implemented indicate a empty list */
> +	if (!local->ops->get_tx_powers)
> +		return 1;
> +
> +	return local->ops->get_cca_ed_levels(&local->hw, dbm, idx);
> +}
> +
>  static inline int drv_set_pan_id(struct ieee802154_local *local,
> __le16 pan_id) {
>  	struct ieee802154_hw_addr_filt filt;

