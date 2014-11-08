Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37722 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaKHRBC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Nov 2014 12:01:02 -0500
Received: by mail-wi0-f171.google.com with SMTP id r20so7089665wiv.4
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 09:01:00 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 4/5] phy: do page and channel setting into one cmd
Date: Sat,  8 Nov 2014 18:00:49 +0100
Message-Id: <1415466050-2630-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
References: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch puts the page and channel setting in one cmd. These
parameters depends on each other and should be set in one cmd.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/phy.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/src/phy.c b/src/phy.c
index e57ad6a..8379786 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -13,33 +13,6 @@
 #include "nl802154.h"
 #include "iwpan.h"
 
-static int handle_page_set(struct nl802154_state *state,
-			   struct nl_cb *cb,
-			   struct nl_msg *msg,
-			   int argc, char **argv,
-			   enum id_input id)
-{
-	unsigned long page;
-	char *end;
-
-	if (argc < 1)
-		return 1;
-
-	/* PAGE */
-	page = strtoul(argv[0], &end, 10);
-	if (*end != '\0')
-		return 1;
-
-	NLA_PUT_U8(msg, NL802154_ATTR_PAGE, page);
-
-	return 0;
-
-nla_put_failure:
-	return -ENOBUFS;
-}
-COMMAND(set, page, "<page>",
-	NL802154_CMD_SET_PAGE, 0, CIB_PHY, handle_page_set, NULL);
-
 static int handle_channel_set(struct nl802154_state *state,
 			      struct nl_cb *cb,
 			      struct nl_msg *msg,
@@ -47,16 +20,23 @@ static int handle_channel_set(struct nl802154_state *state,
 			      enum id_input id)
 {
 	unsigned long channel;
+	unsigned long page;
 	char *end;
 
-	if (argc < 1)
+	if (argc < 2)
+		return 1;
+
+	/* PAGE */
+	page = strtoul(argv[0], &end, 10);
+	if (*end != '\0')
 		return 1;
 
 	/* CHANNEL */
-	channel = strtoul(argv[0], &end, 10);
+	channel = strtoul(argv[1], &end, 10);
 	if (*end != '\0')
 		return 1;
 
+	NLA_PUT_U8(msg, NL802154_ATTR_PAGE, page);
 	NLA_PUT_U8(msg, NL802154_ATTR_CHANNEL, channel);
 
 	return 0;
@@ -64,7 +44,7 @@ static int handle_channel_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, channel, "<channel>",
+COMMAND(set, channel, "<page> <channel>",
 	NL802154_CMD_SET_CHANNEL, 0, CIB_PHY, handle_channel_set, NULL);
 
 static int handle_tx_power_set(struct nl802154_state *state,
-- 
2.1.3

