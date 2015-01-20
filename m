Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62215 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbbATKgO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 05:36:14 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so21926861wiv.0
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 02:36:12 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/2] treewide: shorten commands
Date: Tue, 20 Jan 2015 11:35:39 +0100
Message-Id: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch shorten all commands. I had the idea to make a similarity
from PIB/MIB values according the 802.15.4 names convention but this is
bad for fast shell hacking. Mainly I remove the underscore and some
additional information which are not necessary like "_addr" in
"short_addr" and "extended_addr" and such things.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c      | 10 +++++-----
 src/interface.c | 20 ++++++++++----------
 src/mac.c       | 10 +++++-----
 src/phy.c       |  6 +++---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/src/info.c b/src/info.c
index 83f2e3e..6ce4715 100644
--- a/src/info.c
+++ b/src/info.c
@@ -31,7 +31,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 		phy_id = nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]);
 	}
 	if (print_name && tb_msg[NL802154_ATTR_WPAN_PHY_NAME])
-		printf("wpan_phy %s\n", nla_get_string(tb_msg[NL802154_ATTR_WPAN_PHY_NAME]));
+		printf("WPANphy %s\n", nla_get_string(tb_msg[NL802154_ATTR_WPAN_PHY_NAME]));
 
 	if (tb_msg[NL802154_ATTR_CHANNELS_SUPPORTED]) {
 		unsigned char page = 0;
@@ -56,14 +56,14 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	}
 
 	if (tb_msg[NL802154_ATTR_PAGE])
-		printf("current_page: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_PAGE]));
+		printf("page: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_PAGE]));
 
 	if (tb_msg[NL802154_ATTR_CHANNEL])
-		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
+		printf("channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
 
 	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
 		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
-		printf("cca_mode: %d", cca_mode);
+		printf("cca: %d", cca_mode);
 		if (cca_mode == NL802154_CCA_ENERGY_CARRIER) {
 			enum nl802154_cca_opts cca_opt;
 
@@ -83,7 +83,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	}
 
 	if (tb_msg[NL802154_ATTR_TX_POWER])
-		printf("tx_power: %d\n", nla_get_s8(tb_msg[NL802154_ATTR_TX_POWER]));
+		printf("txpower: %d\n", nla_get_s8(tb_msg[NL802154_ATTR_TX_POWER]));
 
 	return 0;
 }
diff --git a/src/interface.c b/src/interface.c
index 095753b..9e59f15 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -187,7 +187,7 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 		unsigned int thiswpan_phy = nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]);
 		indent = "\t";
 		if (*wpan_phy != thiswpan_phy)
-			printf("phy#%d\n", thiswpan_phy);
+			printf("WPANphy#%d\n", thiswpan_phy);
 		*wpan_phy = thiswpan_phy;
 	}
 
@@ -199,29 +199,29 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 	if (tb_msg[NL802154_ATTR_IFINDEX])
 		printf("%s\tifindex %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_IFINDEX]));
 	if (tb_msg[NL802154_ATTR_WPAN_DEV])
-		printf("%s\twpan_dev 0x%llx\n", indent,
+		printf("%s\tWPANdev 0x%llx\n", indent,
 		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
 	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
-		printf("%s\textended_addr 0x%016llx\n", indent,
+		printf("%s\textended 0x%016llx\n", indent,
 		       le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
 	if (tb_msg[NL802154_ATTR_SHORT_ADDR])
-		printf("%s\tshort_addr 0x%04x\n", indent,
+		printf("%s\tshort 0x%04x\n", indent,
 		       le16toh(nla_get_u16(tb_msg[NL802154_ATTR_SHORT_ADDR])));
 	if (tb_msg[NL802154_ATTR_PAN_ID])
-		printf("%s\tpan_id 0x%04x\n", indent,
+		printf("%s\tpan 0x%04x\n", indent,
 		       le16toh(nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID])));
 	if (tb_msg[NL802154_ATTR_IFTYPE])
 		printf("%s\ttype %s\n", indent, iftype_name(nla_get_u32(tb_msg[NL802154_ATTR_IFTYPE])));
 	if (!wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY])
-		printf("%s\twpan_phy %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
+		printf("%s\tWPANphy %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
 	if (tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES])
-		printf("%s\tmax_frame_retries %d\n", indent, nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
+		printf("%s\tframeretries %d\n", indent, nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
 	if (tb_msg[NL802154_ATTR_MIN_BE])
-		printf("%s\tmin_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MIN_BE]));
+		printf("%s\tminBE %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MIN_BE]));
 	if (tb_msg[NL802154_ATTR_MAX_BE])
-		printf("%s\tmax_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_BE]));
+		printf("%s\tmaxBE %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_BE]));
 	if (tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS])
-		printf("%s\tmax_csma_backoffs %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS]));
+		printf("%s\tcsmabackoffs %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS]));
 	if (tb_msg[NL802154_ATTR_LBT_MODE])
 		printf("%s\tlbt %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_LBT_MODE]));
 
diff --git a/src/mac.c b/src/mac.c
index 703d09f..79d088b 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -37,7 +37,7 @@ static int handle_pan_id_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, pan_id, "<pan_id>",
+COMMAND(set, pan, "<panid>",
 	NL802154_CMD_SET_PAN_ID, 0, CIB_NETDEV, handle_pan_id_set, NULL);
 
 static int handle_short_addr_set(struct nl802154_state *state,
@@ -64,7 +64,7 @@ static int handle_short_addr_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, short_addr, "<short_addr>",
+COMMAND(set, short, "<addr>",
 	NL802154_CMD_SET_SHORT_ADDR, 0, CIB_NETDEV, handle_short_addr_set, NULL);
 
 static int handle_max_frame_retries_set(struct nl802154_state *state,
@@ -91,7 +91,7 @@ static int handle_max_frame_retries_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, max_frame_retries, "<retries>",
+COMMAND(set, frameretries, "<retries>",
 	NL802154_CMD_SET_MAX_FRAME_RETRIES, 0, CIB_NETDEV,
 	handle_max_frame_retries_set, NULL);
 
@@ -126,7 +126,7 @@ static int handle_backoff_exponent(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, backoff_exponents, "<min_be> <max_be>",
+COMMAND(set, backoffexponents, "<minBE> <maxBE>",
 	NL802154_CMD_SET_BACKOFF_EXPONENT, 0, CIB_NETDEV,
 	handle_backoff_exponent, NULL);
 
@@ -154,7 +154,7 @@ static int handle_max_csma_backoffs(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, max_csma_backoffs, "<backoffs>",
+COMMAND(set, csmabackoffs, "<backoffs>",
 	NL802154_CMD_SET_MAX_CSMA_BACKOFFS, 0, CIB_NETDEV,
 	handle_max_csma_backoffs, NULL);
 
diff --git a/src/phy.c b/src/phy.c
index 2e25013..994841f 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -71,7 +71,7 @@ static int handle_tx_power_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, tx_power, "<dBm>",
+COMMAND(set, txpower, "<dBm>",
 	NL802154_CMD_SET_TX_POWER, 0, CIB_PHY, handle_tx_power_set, NULL);
 
 static int handle_cca_mode_set(struct nl802154_state *state,
@@ -112,7 +112,7 @@ static int handle_cca_mode_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, cca_mode, "<mode|3 <1|0>>",
+COMMAND(set, cca, "<mode|3 <1|0>>",
 	NL802154_CMD_SET_CCA_MODE, 0, CIB_PHY, handle_cca_mode_set, NULL);
 
 static int handle_cca_ed_level(struct nl802154_state *state,
@@ -139,5 +139,5 @@ static int handle_cca_ed_level(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, cca_ed_level, "<level>",
+COMMAND(set, edlevel, "<level>",
 	NL802154_CMD_SET_CCA_ED_LEVEL, 0, CIB_PHY, handle_cca_ed_level, NULL);
-- 
2.2.2

