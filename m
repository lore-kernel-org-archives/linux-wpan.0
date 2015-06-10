Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47426 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932613AbbFJKNw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 06:13:52 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id A5310140D6B
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 06:13:50 -0400 (EDT)
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH bluetooth-next] nl802154: fix misspelled enum comment
Date: Wed, 10 Jun 2015 12:13:38 +0200
Message-Id: <1433931218-24741-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---

Learnt this the hard way...next time I will do a proper search to also catch
the comments that are misspelled.

 include/net/nl802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index b796561188d6..b0ab530d28cd 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -187,7 +187,7 @@ enum nl802154_wpan_phy_capability_attr {
  * @NL802154_CCA_ENERGY_CARRIER: Carrier sense with energy above threshold
  * @NL802154_CCA_ALOHA: CCA shall always report an idle medium
  * @NL802154_CCA_UWB_SHR: UWB preamble sense based on the SHR of a frame
- * @NL802154_CCA_UWB_MULTIPEXED: UWB preamble sense based on the packet with
+ * @NL802154_CCA_UWB_MULTIPLEXED: UWB preamble sense based on the packet with
  *	the multiplexed preamble
  * @__NL802154_CCA_ATTR_AFTER_LAST: Internal
  * @NL802154_CCA_ATTR_MAX: Maximum CCA attribute number
-- 
2.1.4

