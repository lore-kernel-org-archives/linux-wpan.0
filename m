Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:43816 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbaIDJd2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 05:33:28 -0400
Received: by mail-wg0-f52.google.com with SMTP id m15so9760734wgh.23
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 02:33:26 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 5/6] mac: initial support for setting csma params
Date: Thu,  4 Sep 2014 11:32:53 +0200
Message-Id: <1409823174-22491-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
References: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/mac.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/nl802154.h |  8 ++++++
 2 files changed, 92 insertions(+)

diff --git a/src/mac.c b/src/mac.c
index d882f96..afaac2d 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -67,3 +67,87 @@ nla_put_failure:
 COMMAND(set, max_frame_retries, "<retries>",
 	NL802154_CMD_SET_MAX_FRAME_RETRIES, 0, CIB_NETDEV,
 	handle_max_frame_retries_set, NULL);
+
+static int handle_max_be(struct nl802154_state *state,
+			 struct nl_cb *cb,
+			 struct nl_msg *msg,
+			 int argc, char **argv,
+			 enum id_input id)
+{
+	unsigned long max_be;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* MAX_BE */
+	max_be = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_MAX_BE, max_be);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, max_be, "<max_be>",
+	NL802154_CMD_SET_MAX_BE, 0, CIB_NETDEV,
+	handle_max_be, NULL);
+
+static int handle_max_csma_backoffs(struct nl802154_state *state,
+				    struct nl_cb *cb,
+				    struct nl_msg *msg,
+				    int argc, char **argv,
+				    enum id_input id)
+{
+	unsigned long backoffs;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* BACKOFFS */
+	backoffs = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_MAX_CSMA_BACKOFFS, backoffs);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, max_csma_backoffs, "<backoffs>",
+	NL802154_CMD_SET_MAX_CSMA_BACKOFFS, 0, CIB_NETDEV,
+	handle_max_csma_backoffs, NULL);
+
+static int handle_min_be(struct nl802154_state *state,
+			 struct nl_cb *cb,
+			 struct nl_msg *msg,
+			 int argc, char **argv,
+			 enum id_input id)
+{
+	unsigned long min_be;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* MIN_BE */
+	min_be = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_MIN_BE, min_be);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, min_be, "<min_be>",
+	NL802154_CMD_SET_MIN_BE, 0, CIB_NETDEV,
+	handle_min_be, NULL);
diff --git a/src/nl802154.h b/src/nl802154.h
index a23c34f..963feda 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -48,6 +48,10 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_MAX_FRAME_RETRIES,
 
+	NL802154_CMD_SET_MAX_BE,
+	NL802154_CMD_SET_MAX_CSMA_BACKOFFS,
+	NL802154_CMD_SET_MIN_BE,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -82,6 +86,10 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_MAX_FRAME_RETRIES,
 
+	NL802154_ATTR_MAX_BE,
+	NL802154_ATTR_MAX_CSMA_BACKOFFS,
+	NL802154_ATTR_MIN_BE,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
-- 
2.1.0

