Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33048 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbFCLW2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 07:22:28 -0400
Received: by padj3 with SMTP id j3so5294049pad.0
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 04:22:27 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-tools] nl802154: export supported commands
Date: Wed,  3 Jun 2015 16:51:54 +0530
Message-Id: <1433330514-18494-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

This patch list the supported commands by the radios.
Output format is like this.
...
Supported commands:
	* new_interface
	* del_interface
	* set_channel
	* set_pan_id
	* set_short_addr
	* set_tx_power

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 src/info.c     |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/nl802154.h |    2 ++
 2 files changed, 44 insertions(+)

diff --git a/src/info.c b/src/info.c
index cd6b2b7..d14a987 100644
--- a/src/info.c
+++ b/src/info.c
@@ -146,6 +146,39 @@ static void print_freq_handler(int channel_page, int channel)
 	}
 }
 
+static const char *commands[NL802154_CMD_MAX + 1] = {
+	[NL802154_CMD_UNSPEC] = "unspec",
+	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
+	[NL802154_CMD_SET_WPAN_PHY] = "set_wpan_phy",
+	[NL802154_CMD_NEW_WPAN_PHY] = "new_wpan_phy",
+	[NL802154_CMD_DEL_WPAN_PHY] = "del_wpan_phy",
+	[NL802154_CMD_GET_INTERFACE] = "get_interface",
+	[NL802154_CMD_SET_INTERFACE] = "set_interface",
+	[NL802154_CMD_NEW_INTERFACE] = "new_interface",
+	[NL802154_CMD_DEL_INTERFACE] = "del_interface",
+	[NL802154_CMD_SET_CHANNEL] = "set_channel",
+	[NL802154_CMD_SET_PAN_ID] = "set_pan_id",
+	[NL802154_CMD_SET_SHORT_ADDR] = "set_short_addr",
+	[NL802154_CMD_SET_TX_POWER] = "set_tx_power",
+	[NL802154_CMD_SET_CCA_MODE] = "set_cca_mode",
+	[NL802154_CMD_SET_CCA_ED_LEVEL] = "set_cca_ed_level",
+	[NL802154_CMD_SET_MAX_FRAME_RETRIES] = "set_max_frame_retries",
+	[NL802154_CMD_SET_BACKOFF_EXPONENT] = "set_backoff_exponent",
+	[NL802154_CMD_SET_MAX_CSMA_BACKOFFS] = "set_max_csma_backoffs",
+	[NL802154_CMD_SET_LBT_MODE] = "set_lbt_mode",
+};
+
+static char cmdbuf[100];
+
+const char *command_name(enum nl802154_commands cmd)
+{
+	if (cmd <= NL802154_CMD_MAX && commands[cmd])
+		return commands[cmd];
+
+	sprintf(cmdbuf, "Unknown command (%d)", cmd);
+	return cmdbuf;
+}
+
 static int print_phy_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
@@ -397,6 +430,15 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 		}
 	}
 
+	if (tb_msg[NL802154_ATTR_SUPPORTED_COMMANDS]) {
+		struct nlattr *nl_cmd;
+		int rem_cmd;
+
+		printf("Supported commands:\n");
+		nla_for_each_nested(nl_cmd, tb_msg[NL802154_ATTR_SUPPORTED_COMMANDS], rem_cmd)
+			printf("\t* %s\n", command_name(nla_get_u32(nl_cmd)));
+	}
+
 	return 0;
 }
 
diff --git a/src/nl802154.h b/src/nl802154.h
index 0badebd..6fc231e 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -102,6 +102,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_WPAN_PHY_CAPS,
 
+	NL802154_ATTR_SUPPORTED_COMMANDS,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
-- 
1.7.9.5

