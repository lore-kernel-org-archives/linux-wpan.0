Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:63366 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaKBDTR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:17 -0400
Received: by mail-wg0-f51.google.com with SMTP id l18so8822771wgh.38
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/16] ieee802154: add helper wpan_phy_to_rdev function
Date: Sun,  2 Nov 2014 04:18:37 +0100
Message-Id: <1414898327-20759-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce a function to get the cfg802154_registered_device
from a wpan_phy.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index 26752ca..1bc1725 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -12,6 +12,14 @@ struct cfg802154_registered_device {
 	struct wpan_phy wpan_phy __aligned(NETDEV_ALIGN);
 };
 
+static inline struct cfg802154_registered_device *
+wpan_phy_to_rdev(struct wpan_phy *wpan_phy)
+{
+	BUG_ON(!wpan_phy);
+	return container_of(wpan_phy, struct cfg802154_registered_device,
+			    wpan_phy);
+}
+
 /* free object */
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev);
 
-- 
2.1.3

