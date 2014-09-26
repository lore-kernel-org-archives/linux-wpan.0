Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:46662 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbaIZIGW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 04:06:22 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so9251935wgh.12
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 01:06:21 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/3] mac: add support for setting lbt mode
Date: Fri, 26 Sep 2014 10:06:07 +0200
Message-Id: <1411718769-1986-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
References: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/mac.c      | 27 +++++++++++++++++++++++++++
 src/nl802154.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/src/mac.c b/src/mac.c
index 1d12a04..a6c456f 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -178,3 +178,30 @@ nla_put_failure:
 COMMAND(set, min_be, "<min_be>",
 	NL802154_CMD_SET_MIN_BE, 0, CIB_NETDEV,
 	handle_min_be, NULL);
+
+static int handle_lbt_mode(struct nl802154_state *state,
+			   struct nl_cb *cb,
+			   struct nl_msg *msg,
+			   int argc, char **argv,
+			   enum id_input id)
+{
+	unsigned long mode;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* LBT_MODE */
+	mode = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_LBT_MODE, mode);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, lbt, "<1|0>",
+	NL802154_CMD_SET_LBT_MODE, 0, CIB_NETDEV, handle_lbt_mode, NULL);
diff --git a/src/nl802154.h b/src/nl802154.h
index ce6ae2a..a30e9c0 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -54,6 +54,8 @@ enum nl802154_commands {
 	NL802154_CMD_SET_MAX_CSMA_BACKOFFS,
 	NL802154_CMD_SET_MIN_BE,
 
+	NL802154_CMD_SET_LBT_MODE,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -95,6 +97,8 @@ enum nl802154_attrs {
 	NL802154_ATTR_MAX_CSMA_BACKOFFS,
 	NL802154_ATTR_MIN_BE,
 
+	NL802154_ATTR_LBT_MODE,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
-- 
2.1.0

