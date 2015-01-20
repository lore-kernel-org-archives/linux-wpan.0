Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:45790 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbATUDI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:03:08 -0500
Received: by mail-wi0-f170.google.com with SMTP id em10so8847754wid.1
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 12:03:07 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 2/2] info: remove unused features argument
Date: Tue, 20 Jan 2015 21:02:35 +0100
Message-Id: <1421784155-2670-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1421784155-2670-1-git-send-email-alex.aring@gmail.com>
References: <1421784155-2670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch removes an unused argument string for the phy information
call. This is copied from the original iw tool. If we need really such
argument then we can add this later again.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/info.c b/src/info.c
index 83f2e3e..e155470 100644
--- a/src/info.c
+++ b/src/info.c
@@ -94,10 +94,6 @@ static int handle_info(struct nl802154_state *state,
 		       int argc, char **argv,
 		       enum id_input id)
 {
-	char *feat_args[] = { "features", "-q" };
-
-	handle_cmd(state, CIB_NONE, 2, feat_args);
-
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_phy_handler, NULL);
 
 	return 0;
-- 
2.2.2

