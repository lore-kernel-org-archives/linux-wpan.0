Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36837 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbbEFLlY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:24 -0400
Received: by wgiu9 with SMTP id u9so8370274wgi.3
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 16/16] nl802154: add support for dump phy capabilities
Date: Wed,  6 May 2015 13:40:28 +0200
Message-Id: <1430912428-17284-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch add support to nl802154 to dump all phy capabilities which is
inside the wpan_phy_supported struct. Also we introduce a new method to
dumping supported channels. The new method will offer a easier interface
and has lesser netlink traffic.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/nl802154.h    |  57 +++++++++++++++++++++
 net/ieee802154/nl802154.c | 127 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 0552771..0badebd 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -100,6 +100,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_EXTENDED_ADDR,
 
+	NL802154_ATTR_WPAN_PHY_CAPS,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
@@ -120,6 +122,61 @@ enum nl802154_iftype {
 };
 
 /**
+ * enum nl802154_wpan_phy_capability_attr - wpan phy capability attributes
+ *
+ * @__NL802154_CAP_ATTR_INVALID: attribute number 0 is reserved
+ * @NL802154_CAP_ATTR_CHANNELS: a nested attribute for nl802154_channel_attr
+ * @NL802154_CAP_ATTR_TX_POWERS: a nested attribute for
+ *	nl802154_wpan_phy_tx_power
+ * @NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL: minimum value for cca_ed_level
+ * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maxmimum value for cca_ed_level
+ * @NL802154_CAP_ATTR_CCA_MODES: nl802154_cca_modes flags
+ * @NL802154_CAP_ATTR_CCA_OPTS: nl802154_cca_opts flags
+ * @NL802154_CAP_ATTR_MIN_MINBE: minimum of minbe value
+ * @NL802154_CAP_ATTR_MAX_MINBE: maximum of minbe value
+ * @NL802154_CAP_ATTR_MIN_MAXBE: minimum of maxbe value
+ * @NL802154_CAP_ATTR_MAX_MINBE: maximum of maxbe value
+ * @NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS: minimum of csma backoff value
+ * @NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS: maximum of csma backoffs value
+ * @NL802154_CAP_ATTR_MIN_FRAME_RETRIES: minimum of frame retries value
+ * @NL802154_CAP_ATTR_MAX_FRAME_RETRIES: maximum of frame retries value
+ * @NL802154_CAP_ATTR_IFTYPES: nl802154_iftype flags
+ * @NL802154_CAP_ATTR_LBT: nl802154_supported_bool_states flags
+ * @NL802154_CAP_ATTR_MAX: highest cap attribute currently defined
+ * @__NL802154_CAP_ATTR_AFTER_LAST: internal use
+ */
+enum nl802154_wpan_phy_capability_attr {
+	__NL802154_CAP_ATTR_INVALID,
+
+	NL802154_CAP_ATTR_IFTYPES,
+
+	NL802154_CAP_ATTR_CHANNELS,
+	NL802154_CAP_ATTR_TX_POWERS,
+
+	NL802154_CAP_ATTR_CCA_ED_LEVELS,
+	NL802154_CAP_ATTR_CCA_MODES,
+	NL802154_CAP_ATTR_CCA_OPTS,
+
+	NL802154_CAP_ATTR_MIN_MINBE,
+	NL802154_CAP_ATTR_MAX_MINBE,
+
+	NL802154_CAP_ATTR_MIN_MAXBE,
+	NL802154_CAP_ATTR_MAX_MAXBE,
+
+	NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS,
+	NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS,
+
+	NL802154_CAP_ATTR_MIN_FRAME_RETRIES,
+	NL802154_CAP_ATTR_MAX_FRAME_RETRIES,
+
+	NL802154_CAP_ATTR_LBT,
+
+	/* keep last */
+	__NL802154_CAP_ATTR_AFTER_LAST,
+	NL802154_CAP_ATTR_MAX = __NL802154_CAP_ATTR_AFTER_LAST - 1
+};
+
+/**
  * enum nl802154_cca_modes - cca modes
  *
  * @__NL802154_CCA_INVALID: cca mode number 0 is reserved
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 00b646d..568b514 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -225,6 +225,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 	[NL802154_ATTR_MAX_FRAME_RETRIES] = { .type = NLA_S8, },
 
 	[NL802154_ATTR_LBT_MODE] = { .type = NLA_U8, },
+
+	[NL802154_ATTR_WPAN_PHY_CAPS] = { .type = NLA_NESTED },
 };
 
 /* message building helper */
@@ -236,6 +238,28 @@ static inline void *nl802154hdr_put(struct sk_buff *skb, u32 portid, u32 seq,
 }
 
 static int
+nl802154_put_flags(struct sk_buff *msg, int attr, u32 mask)
+{
+	struct nlattr *nl_flags = nla_nest_start(msg, attr);
+	int i;
+
+	if (!nl_flags)
+		return -ENOBUFS;
+
+	i = 0;
+	while (mask) {
+		if ((mask & 1) && nla_put_flag(msg, i))
+			return -ENOBUFS;
+
+		mask >>= 1;
+		i++;
+	}
+
+	nla_nest_end(msg, nl_flags);
+	return 0;
+}
+
+static int
 nl802154_send_wpan_phy_channels(struct cfg802154_registered_device *rdev,
 				struct sk_buff *msg)
 {
@@ -256,6 +280,102 @@ nl802154_send_wpan_phy_channels(struct cfg802154_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl802154_put_capabilities(struct sk_buff *msg,
+			  struct cfg802154_registered_device *rdev)
+{
+	const struct wpan_phy_supported *caps = &rdev->wpan_phy.supported;
+	struct nlattr *nl_tx_pwrs, *nl_caps, *nl_channels;
+	int idx;
+	s32 pwr;
+	int ret;
+
+	nl_caps = nla_nest_start(msg, NL802154_ATTR_WPAN_PHY_CAPS);
+	if (!nl_caps)
+		return -ENOBUFS;
+
+	nl_channels = nla_nest_start(msg, NL802154_CAP_ATTR_CHANNELS);
+	if (!nl_channels)
+		return -ENOBUFS;
+
+	for (idx = 0; idx <= IEEE802154_MAX_PAGE; idx++) {
+		if (caps->channels[idx]) {
+			if (nl802154_put_flags(msg, idx,
+					       caps->channels[idx]))
+				return -ENOBUFS;
+		}
+	}
+
+	nla_nest_end(msg, nl_channels);
+
+	/* cca_ed_levels only in mode 1 and 3 important, check if supported */
+	if (caps->cca_modes & (BIT(NL802154_CCA_ENERGY_CARRIER) |
+			       BIT(NL802154_CCA_ENERGY))) {
+		struct nlattr *nl_ed_lvls;
+		s32 ed;
+
+		nl_ed_lvls = nla_nest_start(msg,
+					    NL802154_CAP_ATTR_CCA_ED_LEVELS);
+			if (!nl_ed_lvls)
+				return -ENOBUFS;
+
+		idx = 0;
+		while (1) {
+			ret = rdev_get_cca_ed_levels(rdev, &ed, idx++);
+			if (ret < 0)
+				return ret;
+			else if (ret == 1)
+				break;
+
+			nla_put_s32(msg, idx, ed);
+		};
+
+		nla_nest_end(msg, nl_ed_lvls);
+	}
+
+	nl_tx_pwrs = nla_nest_start(msg, NL802154_CAP_ATTR_TX_POWERS);
+	if (!nl_tx_pwrs)
+		return -ENOBUFS;
+
+	idx = 0;
+	while (1) {
+		ret = rdev_get_tx_powers(rdev, &pwr, idx++);
+		if (ret < 0)
+			return ret;
+		else if (ret == 1)
+			break;
+
+		nla_put_s32(msg, idx, pwr);
+	};
+
+	nla_nest_end(msg, nl_tx_pwrs);
+
+	if (nl802154_put_flags(msg, NL802154_CAP_ATTR_CCA_MODES,
+			       caps->cca_modes) ||
+	    nl802154_put_flags(msg, NL802154_CAP_ATTR_CCA_OPTS,
+			       caps->cca_opts) ||
+	    nla_put_u8(msg, NL802154_CAP_ATTR_MIN_MINBE, caps->min_minbe) ||
+	    nla_put_u8(msg, NL802154_CAP_ATTR_MAX_MINBE, caps->max_minbe) ||
+	    nla_put_u8(msg, NL802154_CAP_ATTR_MIN_MAXBE, caps->min_maxbe) ||
+	    nla_put_u8(msg, NL802154_CAP_ATTR_MAX_MAXBE, caps->max_maxbe) ||
+	    nla_put_u8(msg, NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS,
+		       caps->min_csma_backoffs) ||
+	    nla_put_u8(msg, NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS,
+		       caps->max_csma_backoffs) ||
+	    nla_put_s8(msg, NL802154_CAP_ATTR_MIN_FRAME_RETRIES,
+		       caps->min_frame_retries) ||
+	    nla_put_s8(msg, NL802154_CAP_ATTR_MAX_FRAME_RETRIES,
+		       caps->max_frame_retries) ||
+	    nl802154_put_flags(msg, NL802154_CAP_ATTR_IFTYPES,
+			       caps->iftypes) ||
+	    nla_put_u32(msg, NL802154_CAP_ATTR_LBT, caps->lbt))
+		return -ENOBUFS;
+
+	nla_nest_end(msg, nl_caps);
+
+	return 0;
+}
+
 static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 				  enum nl802154_commands cmd,
 				  struct sk_buff *msg, u32 portid, u32 seq,
@@ -286,7 +406,9 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 		       rdev->wpan_phy.current_channel))
 		goto nla_put_failure;
 
-	/* supported channels array */
+	/* TODO remove this behaviour, we still keep support it for a while
+	 * so users can change the behaviour to the new one.
+	 */
 	if (nl802154_send_wpan_phy_channels(rdev, msg))
 		goto nla_put_failure;
 
@@ -305,6 +427,9 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 			rdev->wpan_phy.transmit_power))
 		goto nla_put_failure;
 
+	if (nl802154_put_capabilities(msg, rdev))
+		goto nla_put_failure;
+
 finish:
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
2.3.7

