Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34720 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbbFELnd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 07:43:33 -0400
Received: by wgv5 with SMTP id 5so54767636wgv.1
        for <linux-wpan@vger.kernel.org>; Fri, 05 Jun 2015 04:43:32 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools] treewide: replace wireless with wpan
Date: Fri,  5 Jun 2015 13:43:25 +0200
Message-Id: <1433504605-5242-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch replaced several wireless string with wpan. This behaviour
was simpled copied from wireless iw tool and it hasn't been renamed to
wpan.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c      | 4 ++--
 src/interface.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/info.c b/src/info.c
index 2434bef..8afeeb7 100644
--- a/src/info.c
+++ b/src/info.c
@@ -459,7 +459,7 @@ static int handle_info(struct nl802154_state *state,
 }
 
 __COMMAND(NULL, info, "info", NULL, NL802154_CMD_GET_WPAN_PHY, 0, 0, CIB_PHY, handle_info,
-	  "Show capabilities for the specified wireless device.", NULL);
+	  "Show capabilities for the specified wpan device.", NULL);
 TOPLEVEL(list, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info,
-	 "List all wireless devices and their capabilities.");
+	 "List all wpan devices and their capabilities.");
 TOPLEVEL(phy, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info, NULL);
diff --git a/src/interface.c b/src/interface.c
index 647247b..c67077b 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -252,4 +252,4 @@ static int handle_dev_dump(struct nl802154_state *state,
 	return 0;
 }
 TOPLEVEL(dev, NULL, NL802154_CMD_GET_INTERFACE, NLM_F_DUMP, CIB_NONE, handle_dev_dump,
-	 "List all network interfaces for wireless hardware.");
+	 "List all network interfaces for wpan hardware.");
-- 
2.4.1

