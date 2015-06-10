Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47382 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932635AbbFJJED (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 05:04:03 -0400
From: christoffer@christofferholmstedt.se
Subject: [PATCH bluetooth-next] nl802154: fix misspelled enum
Date: Wed, 10 Jun 2015 11:03:59 +0200
Message-Id: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Christoffer Holmstedt <christoffer@christofferholmstedt.se>

From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 include/net/nl802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 6fc231e60920..b796561188d6 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -199,7 +199,7 @@ enum nl802154_cca_modes {
 	NL802154_CCA_ENERGY_CARRIER,
 	NL802154_CCA_ALOHA,
 	NL802154_CCA_UWB_SHR,
-	NL802154_CCA_UWB_MULTIPEXED,
+	NL802154_CCA_UWB_MULTIPLEXED,
 
 	/* keep last */
 	__NL802154_CCA_ATTR_AFTER_LAST,
-- 
2.1.4

