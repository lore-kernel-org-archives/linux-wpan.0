Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46361 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706AbaIDIEP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 04:04:15 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so561033wib.9
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 01:04:14 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 6/6] phy: add support for cca mode 3 and/or handling
Date: Thu,  4 Sep 2014 10:03:54 +0200
Message-Id: <1409817834-14660-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
References: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl802154.h |  1 +
 src/phy.c      | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index 963feda..904bebb 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -83,6 +83,7 @@ enum nl802154_attrs {
 	NL802154_ATTR_TX_POWER,
 
 	NL802154_ATTR_CCA_MODE,
+	NL802154_ATTR_CCA_MODE3_AND,
 
 	NL802154_ATTR_MAX_FRAME_RETRIES,
 
diff --git a/src/phy.c b/src/phy.c
index cfdf056..1698cc2 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -100,7 +100,7 @@ static int handle_cca_mode_set(struct nl802154_state *state,
 			       int argc, char **argv,
 			       enum id_input id)
 {
-	unsigned long cca_mode;
+	unsigned long cca_mode, cca_mode3_and;
 	char *end;
 
 	if (argc < 1)
@@ -111,6 +111,18 @@ static int handle_cca_mode_set(struct nl802154_state *state,
 	if (*end != '\0')
 		return 1;
 
+	if (cca_mode == 3) {
+		if (argc < 2)
+			return 1;
+
+		/* CCA_MODE */
+		cca_mode3_and = strtoul(argv[1], &end, 10);
+		if (*end != '\0')
+			return 1;
+
+		NLA_PUT_U8(msg, NL802154_ATTR_CCA_MODE3_AND, cca_mode3_and);
+	}
+
 	NLA_PUT_U8(msg, NL802154_ATTR_CCA_MODE, cca_mode);
 
 	return 0;
@@ -118,5 +130,5 @@ static int handle_cca_mode_set(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, cca_mode, "<mode>",
+COMMAND(set, cca_mode, "<mode|3 <1|0>>",
 	NL802154_CMD_SET_CCA_MODE, 0, CIB_PHY, handle_cca_mode_set, NULL);
-- 
2.1.0

