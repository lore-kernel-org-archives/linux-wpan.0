Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:37411 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbaIDJd0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 05:33:26 -0400
Received: by mail-wg0-f48.google.com with SMTP id n12so9825806wgh.7
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 02:33:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 4/6] mac: add support for setting max_frame_retries
Date: Thu,  4 Sep 2014 11:32:52 +0200
Message-Id: <1409823174-22491-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
References: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/mac.c      | 29 +++++++++++++++++++++++++++++
 src/nl802154.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/src/mac.c b/src/mac.c
index 5fa1111..d882f96 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -9,6 +9,7 @@
 #include <netlink/msg.h>
 #include <netlink/attr.h>
 
+#include "nl_extras.h"
 #include "nl802154.h"
 #include "iwpan.h"
 
@@ -38,3 +39,31 @@ nla_put_failure:
 }
 COMMAND(set, pan_id, "<pan_id>",
 	NL802154_CMD_SET_PAN_ID, 0, CIB_NETDEV, handle_pan_id_set, NULL);
+
+static int handle_max_frame_retries_set(struct nl802154_state *state,
+					struct nl_cb *cb,
+					struct nl_msg *msg,
+					int argc, char **argv,
+					enum id_input id)
+{
+	long retries;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* RETRIES */
+	retries = strtol(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_S8(msg, NL802154_ATTR_MAX_FRAME_RETRIES, retries);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, max_frame_retries, "<retries>",
+	NL802154_CMD_SET_MAX_FRAME_RETRIES, 0, CIB_NETDEV,
+	handle_max_frame_retries_set, NULL);
diff --git a/src/nl802154.h b/src/nl802154.h
index 762fc38..a23c34f 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -46,6 +46,8 @@ enum nl802154_commands {
 	NL802154_CMD_SET_TX_POWER,
 	NL802154_CMD_SET_CCA_MODE,
 
+	NL802154_CMD_SET_MAX_FRAME_RETRIES,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -78,6 +80,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_CCA_MODE,
 
+	NL802154_ATTR_MAX_FRAME_RETRIES,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
-- 
2.1.0

