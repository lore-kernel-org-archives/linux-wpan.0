Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35093 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbEFLnV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:43:21 -0400
Received: by wgyo15 with SMTP id o15so8446456wgy.2
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:43:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 2/2] info: add support for phy capability dump
Date: Wed,  6 May 2015 13:43:07 +0200
Message-Id: <1430912587-17824-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912587-17824-1-git-send-email-alex.aring@gmail.com>
References: <1430912587-17824-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for dumping phy capabilities by running iwpan list,
which printout something like:

capabilities:
        iftypes: node,monitor
        channels:
                page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
        tx_powers: 3,2.8,2.3,1.8,1.3,0.7,0,-1,-2,-3,-4,-5,-7,-9,-12,-17
        cca_ed_levels: -91,-89,-87,-85,-83,-81,-79,-77,-75,-73,-71,-69,-67,-65,-63,-61
        cca_modes: 1,2,3
        cca_opts: 0(cca_mode: 3),1(cca_mode: 3)
        min_be: 0,1,2,3,4,5,6,7,8
        max_be: 3,4,5,6,7,8
        csma_backoffs: 0,1,2,3,4,5
        frame_retries: -1,0,1,2,3,4,5,6,7
        lbt: false

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c     | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/iwpan.h    |   2 +
 src/nl802154.h |  79 ++++++++++++++++++++++++++
 3 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/src/info.c b/src/info.c
index c52d304..c749866 100644
--- a/src/info.c
+++ b/src/info.c
@@ -12,11 +12,22 @@
 #include "nl_extras.h"
 #include "iwpan.h"
 
+static void print_minmax_handler(int min, int max)
+{
+	int i;
+
+	for (i = min; i <= max; i++)
+		printf("%d,", i);
+
+	/* TODO */
+	printf("\b \n");
+}
+
 static int print_phy_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
-	int rem_page, i;
+	int rem_page, i, ret;
 	int64_t phy_id = -1;
 	bool print_name = true;
 	struct nlattr *nl_page;
@@ -33,6 +44,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	if (print_name && tb_msg[NL802154_ATTR_WPAN_PHY_NAME])
 		printf("wpan_phy %s\n", nla_get_string(tb_msg[NL802154_ATTR_WPAN_PHY_NAME]));
 
+	/* TODO remove this handling it's deprecated */
 	if (tb_msg[NL802154_ATTR_CHANNELS_SUPPORTED]) {
 		unsigned char page = 0;
 		unsigned long channel;
@@ -85,6 +97,168 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	if (tb_msg[NL802154_ATTR_TX_POWER])
 		printf("tx_power: %.2g\n", MBM_TO_DBM(nla_get_s32(tb_msg[NL802154_ATTR_TX_POWER])));
 
+	if (tb_msg[NL802154_ATTR_WPAN_PHY_CAPS]) {
+		struct nlattr *tb_caps[NL802154_CAP_ATTR_MAX + 1];
+		/* TODO fix netlink lib that we can use NLA_S32 here
+		 * see function  validate_nla line if (pt->type > NLA_TYPE_MAX) */
+		static struct nla_policy caps_policy[NL802154_CAP_ATTR_MAX + 1] = {
+			[NL802154_CAP_ATTR_CHANNELS] = { .type = NLA_NESTED },
+			[NL802154_CAP_ATTR_TX_POWERS] = { .type = NLA_NESTED },
+			[NL802154_CAP_ATTR_CCA_ED_LEVELS] = { .type = NLA_NESTED },
+			[NL802154_CAP_ATTR_CCA_MODES] = { .type = NLA_NESTED },
+			[NL802154_CAP_ATTR_CCA_OPTS] = { .type = NLA_NESTED },
+			[NL802154_CAP_ATTR_MIN_MINBE] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MAX_MINBE] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MIN_MAXBE] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MAX_MAXBE] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MIN_FRAME_RETRIES] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_MAX_FRAME_RETRIES] = { .type = NLA_U8 },
+			[NL802154_CAP_ATTR_IFTYPES] = { .type = NLA_NESTED },
+			[NL802154_CAP_ATTR_LBT] = { .type = NLA_U32 },
+		};
+
+		printf("capabilities:\n");
+
+		ret = nla_parse_nested(tb_caps, NL802154_CAP_ATTR_MAX,
+				       tb_msg[NL802154_ATTR_WPAN_PHY_CAPS],
+				       caps_policy);
+		if (ret) {
+			printf("failed to parse caps\n");
+			return -EIO;
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_IFTYPES]) {
+			struct nlattr *nl_iftypes;
+			int rem_iftypes;
+			printf("\tiftypes: ");
+			nla_for_each_nested(nl_iftypes,
+					    tb_caps[NL802154_CAP_ATTR_IFTYPES],
+					    rem_iftypes)
+				printf("%s,", iftype_name(nla_type(nl_iftypes)));
+			/* TODO */
+			printf("\b \n");
+		}
+
+		if (tb_msg[NL802154_CAP_ATTR_CHANNELS]) {
+			int rem_pages;
+			struct nlattr *nl_pages;
+			printf("\tchannels:\n");
+			nla_for_each_nested(nl_pages, tb_caps[NL802154_CAP_ATTR_CHANNELS],
+					    rem_pages) {
+				int rem_channels;
+				struct nlattr *nl_channels;
+				printf("\t\tpage %d: ", nla_type(nl_pages));
+				nla_for_each_nested(nl_channels, nl_pages, rem_channels)
+					printf("%d,", nla_type(nl_channels));
+				/*  TODO hack use sprintf here */
+				printf("\b \b\n");
+			}
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_TX_POWERS]) {
+			int rem_pwrs;
+			struct nlattr *nl_pwrs;
+
+			printf("\ttx_powers: ");
+			nla_for_each_nested(nl_pwrs, tb_caps[NL802154_CAP_ATTR_TX_POWERS], rem_pwrs)
+				printf("%.2g,", MBM_TO_DBM(nla_get_s32(nl_pwrs)));
+			/* TODO */
+			printf("\b \n");
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_CCA_ED_LEVELS]) {
+			int rem_levels;
+			struct nlattr *nl_levels;
+
+			printf("\tcca_ed_levels: ");
+			nla_for_each_nested(nl_levels, tb_caps[NL802154_CAP_ATTR_CCA_ED_LEVELS], rem_levels)
+				printf("%.2g,", MBM_TO_DBM(nla_get_s32(nl_levels)));
+			/* TODO */
+			printf("\b \n");
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_CCA_MODES]) {
+			struct nlattr *nl_cca_modes;
+			int rem_cca_modes;
+			printf("\tcca_modes: ");
+			nla_for_each_nested(nl_cca_modes,
+					    tb_caps[NL802154_CAP_ATTR_CCA_MODES],
+					    rem_cca_modes)
+				printf("%d,", nla_type(nl_cca_modes));
+			/* TODO */
+			printf("\b \n");
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
+			struct nlattr *nl_cca_opts;
+			int rem_cca_opts;
+
+			printf("\tcca_opts: ");
+			nla_for_each_nested(nl_cca_opts,
+					    tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
+					    rem_cca_opts) {
+				printf("%d", nla_type(nl_cca_opts));
+				switch (nla_type(nl_cca_opts)) {
+				case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+				case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+					printf("(cca_mode: 3),");
+					break;
+				default:
+					printf("unkown\n");
+					break;
+				}
+			}
+			/* TODO */
+			printf("\b \n");
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_MIN_MINBE] &&
+		    tb_caps[NL802154_CAP_ATTR_MAX_MINBE] &&
+		    tb_caps[NL802154_CAP_ATTR_MIN_MAXBE] &&
+		    tb_caps[NL802154_CAP_ATTR_MAX_MAXBE]) {
+			printf("\tmin_be: ");
+			print_minmax_handler(nla_get_u8(tb_caps[NL802154_CAP_ATTR_MIN_MINBE]),
+					     nla_get_u8(tb_caps[NL802154_CAP_ATTR_MAX_MINBE]));
+			printf("\tmax_be: ");
+			print_minmax_handler(nla_get_u8(tb_caps[NL802154_CAP_ATTR_MIN_MAXBE]),
+					     nla_get_u8(tb_caps[NL802154_CAP_ATTR_MAX_MAXBE]));
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS] &&
+		    tb_caps[NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS]) {
+			printf("\tcsma_backoffs: ");
+			print_minmax_handler(nla_get_u8(tb_caps[NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS]),
+					     nla_get_u8(tb_caps[NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS]));
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_MIN_FRAME_RETRIES] &&
+		    tb_caps[NL802154_CAP_ATTR_MAX_FRAME_RETRIES]) {
+			printf("\tframe_retries: ");
+			print_minmax_handler(nla_get_s8(tb_caps[NL802154_CAP_ATTR_MIN_FRAME_RETRIES]),
+					     nla_get_s8(tb_caps[NL802154_CAP_ATTR_MAX_FRAME_RETRIES]));
+		}
+
+		if (tb_caps[NL802154_CAP_ATTR_LBT]) {
+			printf("\tlbt: ");
+			switch (nla_get_u32(tb_caps[NL802154_CAP_ATTR_LBT])) {
+			case NL802154_SUPPORTED_BOOL_FALSE:
+				printf("false\n");
+				break;
+			case NL802154_SUPPORTED_BOOL_TRUE:
+				printf("true\n");
+				break;
+			case NL802154_SUPPORTED_BOOL_BOTH:
+				printf("false,true\n");
+				break;
+			default:
+				printf("unkown\n");
+				break;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/src/iwpan.h b/src/iwpan.h
index 2c309fc..48c4f03 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -118,4 +118,6 @@ int handle_cmd(struct nl802154_state *state, enum id_input idby,
 DECLARE_SECTION(set);
 DECLARE_SECTION(get);
 
+const char *iftype_name(enum nl802154_iftype iftype);
+
 #endif /* __IWPAN_H */
diff --git a/src/nl802154.h b/src/nl802154.h
index f8b5bc9..0badebd 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
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
@@ -162,4 +219,26 @@ enum nl802154_cca_opts {
 	NL802154_CCA_OPT_ATTR_MAX = __NL802154_CCA_OPT_ATTR_AFTER_LAST - 1
 };
 
+/**
+ * enum nl802154_supported_bool_states - bool states for bool capability entry
+ *
+ * @NL802154_SUPPORTED_BOOL_FALSE: indicates to set false
+ * @NL802154_SUPPORTED_BOOL_TRUE: indicates to set true
+ * @__NL802154_SUPPORTED_BOOL_INVALD: reserved
+ * @NL802154_SUPPORTED_BOOL_BOTH: indicates to set true and false
+ * @__NL802154_SUPPORTED_BOOL_AFTER_LAST: Internal
+ * @NL802154_SUPPORTED_BOOL_MAX: highest value for bool states
+ */
+enum nl802154_supported_bool_states {
+	NL802154_SUPPORTED_BOOL_FALSE,
+	NL802154_SUPPORTED_BOOL_TRUE,
+	/* to handle them in a mask */
+	__NL802154_SUPPORTED_BOOL_INVALD,
+	NL802154_SUPPORTED_BOOL_BOTH,
+
+	/* keep last */
+	__NL802154_SUPPORTED_BOOL_AFTER_LAST,
+	NL802154_SUPPORTED_BOOL_MAX = __NL802154_SUPPORTED_BOOL_AFTER_LAST - 1
+};
+
 #endif /* __NL802154_H */
-- 
2.3.7

