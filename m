Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:39259 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbaKHRBA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Nov 2014 12:01:00 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so7096501wiw.15
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 09:00:59 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 3/5] mac: do backoff_exponent into one cmd
Date: Sat,  8 Nov 2014 18:00:48 +0100
Message-Id: <1415466050-2630-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
References: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch do the backoff exponent setting in one netlink cmd. These
parameters depends on each other and should be set in one cmd.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/mac.c | 54 +++++++++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/src/mac.c b/src/mac.c
index a6c456f..3f2dfc8 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -95,23 +95,30 @@ COMMAND(set, max_frame_retries, "<retries>",
 	NL802154_CMD_SET_MAX_FRAME_RETRIES, 0, CIB_NETDEV,
 	handle_max_frame_retries_set, NULL);
 
-static int handle_max_be(struct nl802154_state *state,
-			 struct nl_cb *cb,
-			 struct nl_msg *msg,
-			 int argc, char **argv,
-			 enum id_input id)
+static int handle_backoff_exponent(struct nl802154_state *state,
+				   struct nl_cb *cb,
+				   struct nl_msg *msg,
+				   int argc, char **argv,
+				   enum id_input id)
 {
 	unsigned long max_be;
+	unsigned long min_be;
 	char *end;
 
-	if (argc < 1)
+	if (argc < 2)
+		return 1;
+
+	/* MIN_BE */
+	min_be = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
 		return 1;
 
 	/* MAX_BE */
-	max_be = strtoul(argv[0], &end, 0);
+	max_be = strtoul(argv[1], &end, 0);
 	if (*end != '\0')
 		return 1;
 
+	NLA_PUT_U8(msg, NL802154_ATTR_MIN_BE, min_be);
 	NLA_PUT_U8(msg, NL802154_ATTR_MAX_BE, max_be);
 
 	return 0;
@@ -119,9 +126,9 @@ static int handle_max_be(struct nl802154_state *state,
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, max_be, "<max_be>",
-	NL802154_CMD_SET_MAX_BE, 0, CIB_NETDEV,
-	handle_max_be, NULL);
+COMMAND(set, backoff_exponents, "<min_be> <max_be>",
+	NL802154_CMD_SET_BACKOFF_EXPONENT, 0, CIB_NETDEV,
+	handle_backoff_exponent, NULL);
 
 static int handle_max_csma_backoffs(struct nl802154_state *state,
 				    struct nl_cb *cb,
@@ -151,33 +158,6 @@ COMMAND(set, max_csma_backoffs, "<backoffs>",
 	NL802154_CMD_SET_MAX_CSMA_BACKOFFS, 0, CIB_NETDEV,
 	handle_max_csma_backoffs, NULL);
 
-static int handle_min_be(struct nl802154_state *state,
-			 struct nl_cb *cb,
-			 struct nl_msg *msg,
-			 int argc, char **argv,
-			 enum id_input id)
-{
-	unsigned long min_be;
-	char *end;
-
-	if (argc < 1)
-		return 1;
-
-	/* MIN_BE */
-	min_be = strtoul(argv[0], &end, 0);
-	if (*end != '\0')
-		return 1;
-
-	NLA_PUT_U8(msg, NL802154_ATTR_MIN_BE, min_be);
-
-	return 0;
-
-nla_put_failure:
-	return -ENOBUFS;
-}
-COMMAND(set, min_be, "<min_be>",
-	NL802154_CMD_SET_MIN_BE, 0, CIB_NETDEV,
-	handle_min_be, NULL);
 
 static int handle_lbt_mode(struct nl802154_state *state,
 			   struct nl_cb *cb,
-- 
2.1.3

