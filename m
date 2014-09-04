Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:49117 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547AbaIDIEM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 04:04:12 -0400
Received: by mail-wi0-f181.google.com with SMTP id e4so567780wiv.14
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 01:04:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/6] phy: add support for tx power pib attribute
Date: Thu,  4 Sep 2014 10:03:50 +0200
Message-Id: <1409817834-14660-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
References: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl802154.h |  4 ++++
 src/phy.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/src/nl802154.h b/src/nl802154.h
index 51d08b0..1af09ac 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -43,6 +43,8 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_PAN_ID,
 
+	NL802154_CMD_SET_TX_POWER,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -71,6 +73,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_PAN_ID,
 
+	NL802154_ATTR_TX_POWER,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
diff --git a/src/phy.c b/src/phy.c
index 33365dd..811fc35 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -9,6 +9,7 @@
 #include <netlink/msg.h>
 #include <netlink/attr.h>
 
+#include "nl_updates.h"
 #include "nl802154.h"
 #include "iwpan.h"
 
@@ -65,3 +66,30 @@ nla_put_failure:
 }
 COMMAND(set, channel, "<channel>",
 	NL802154_CMD_SET_CHANNEL, 0, CIB_PHY, handle_channel_set, NULL);
+
+static int handle_tx_power_set(struct nl802154_state *state,
+			       struct nl_cb *cb,
+			       struct nl_msg *msg,
+			       int argc, char **argv,
+			       enum id_input id)
+{
+	long dbm;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* TX_POWER */
+	dbm = strtol(argv[0], &end, 10);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_S8(msg, NL802154_ATTR_TX_POWER, dbm);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, tx_power, "<dBm>",
+	NL802154_CMD_SET_TX_POWER, 0, CIB_PHY, handle_tx_power_set, NULL);
-- 
2.1.0

