Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45892 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937AbaIDJd0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 05:33:26 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so703649wiv.7
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 02:33:25 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 3/6] phy: add support for setting cca_mode
Date: Thu,  4 Sep 2014 11:32:51 +0200
Message-Id: <1409823174-22491-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
References: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl802154.h |  3 +++
 src/phy.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/src/nl802154.h b/src/nl802154.h
index 1af09ac..762fc38 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -44,6 +44,7 @@ enum nl802154_commands {
 	NL802154_CMD_SET_PAN_ID,
 
 	NL802154_CMD_SET_TX_POWER,
+	NL802154_CMD_SET_CCA_MODE,
 
 	/* add new commands above here */
 
@@ -75,6 +76,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_TX_POWER,
 
+	NL802154_ATTR_CCA_MODE,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
diff --git a/src/phy.c b/src/phy.c
index 95e8f3b..7f9411c 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -93,3 +93,30 @@ nla_put_failure:
 }
 COMMAND(set, tx_power, "<dBm>",
 	NL802154_CMD_SET_TX_POWER, 0, CIB_PHY, handle_tx_power_set, NULL);
+
+static int handle_cca_mode_set(struct nl802154_state *state,
+			       struct nl_cb *cb,
+			       struct nl_msg *msg,
+			       int argc, char **argv,
+			       enum id_input id)
+{
+	unsigned long cca_mode;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* CCA_MODE */
+	cca_mode = strtoul(argv[0], &end, 10);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_CCA_MODE, cca_mode);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, cca_mode, "<mode>",
+	NL802154_CMD_SET_CCA_MODE, 0, CIB_PHY, handle_cca_mode_set, NULL);
-- 
2.1.0

