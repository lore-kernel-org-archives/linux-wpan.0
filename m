Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35135 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbCZLqv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 07:46:51 -0400
Received: by wibbg6 with SMTP id bg6so60817449wib.0
        for <linux-wpan@vger.kernel.org>; Thu, 26 Mar 2015 04:46:49 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/3] mac802154: cleanup concurrent check
Date: Thu, 26 Mar 2015 12:46:28 +0100
Message-Id: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the checking of different mac phy depended values by
handling depended mac settings per hw support flag in one condition.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9b8e264..3f6a3fe 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -174,24 +174,16 @@ ieee802154_check_mac_settings(struct ieee802154_local *local,
 	}
 
 	if (local->hw.flags & IEEE802154_HW_AFILT) {
-		if (wpan_dev->pan_id != nwpan_dev->pan_id)
-			return -EBUSY;
-
-		if (wpan_dev->short_addr != nwpan_dev->short_addr)
-			return -EBUSY;
-
-		if (wpan_dev->extended_addr != nwpan_dev->extended_addr)
+		if (wpan_dev->pan_id != nwpan_dev->pan_id ||
+		    wpan_dev->short_addr != nwpan_dev->short_addr ||
+		    wpan_dev->extended_addr != nwpan_dev->extended_addr)
 			return -EBUSY;
 	}
 
 	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
-		if (wpan_dev->min_be != nwpan_dev->min_be)
-			return -EBUSY;
-
-		if (wpan_dev->max_be != nwpan_dev->max_be)
-			return -EBUSY;
-
-		if (wpan_dev->csma_retries != nwpan_dev->csma_retries)
+		if (wpan_dev->min_be != nwpan_dev->min_be ||
+		    wpan_dev->max_be != nwpan_dev->max_be ||
+		    wpan_dev->csma_retries != nwpan_dev->csma_retries)
 			return -EBUSY;
 	}
 
-- 
2.3.4

