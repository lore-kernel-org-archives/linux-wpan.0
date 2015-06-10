Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47530 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754175AbbFJMjZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 08:39:25 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 24415140D69
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 08:39:23 -0400 (EDT)
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH wpan-tools] nl802154: fix misspelled enum
Date: Wed, 10 Jun 2015 14:39:18 +0200
Message-Id: <1433939958-3168-1-git-send-email-christoffer@christofferholmstedt.se>
In-Reply-To: <20150610121712.GA6647@omega>
References: <20150610121712.GA6647@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This patch updates nl802154 enum to match the one in bluetooth-next tree from
commit d446278c408b ("nl802154: fix misspelled enum").

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 src/nl802154.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index 6fc231e60920..b0ab530d28cd 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -187,7 +187,7 @@ enum nl802154_wpan_phy_capability_attr {
  * @NL802154_CCA_ENERGY_CARRIER: Carrier sense with energy above threshold
  * @NL802154_CCA_ALOHA: CCA shall always report an idle medium
  * @NL802154_CCA_UWB_SHR: UWB preamble sense based on the SHR of a frame
- * @NL802154_CCA_UWB_MULTIPEXED: UWB preamble sense based on the packet with
+ * @NL802154_CCA_UWB_MULTIPLEXED: UWB preamble sense based on the packet with
  *	the multiplexed preamble
  * @__NL802154_CCA_ATTR_AFTER_LAST: Internal
  * @NL802154_CCA_ATTR_MAX: Maximum CCA attribute number
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

