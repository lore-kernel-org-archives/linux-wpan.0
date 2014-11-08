Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36606 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaKHRA6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Nov 2014 12:00:58 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so7058104wib.17
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 09:00:57 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/5] phy: remove split dump feature
Date: Sat,  8 Nov 2014 18:00:46 +0100
Message-Id: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch removes the split dump feature. We don't use this right now
in kernelspace and was copy&pasted from iw tool.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/src/info.c b/src/info.c
index 6bbe3f0..50a7bba 100644
--- a/src/info.c
+++ b/src/info.c
@@ -79,8 +79,6 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	return 0;
 }
 
-static bool nl802154_has_split_wiphy = false;
-
 static int handle_info(struct nl802154_state *state,
 		       struct nl_cb *cb,
 		       struct nl_msg *msg,
@@ -88,13 +86,8 @@ static int handle_info(struct nl802154_state *state,
 		       enum id_input id)
 {
 	char *feat_args[] = { "features", "-q" };
-	int err;
 
-	err = handle_cmd(state, CIB_NONE, 2, feat_args);
-	if (!err && nl802154_has_split_wiphy) {
-		nla_put_flag(msg, NL802154_ATTR_SPLIT_WPAN_PHY_DUMP);
-		nlmsg_hdr(msg)->nlmsg_flags |= NLM_F_DUMP;
-	}
+	handle_cmd(state, CIB_NONE, 2, feat_args);
 
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_phy_handler, NULL);
 
-- 
2.1.3

