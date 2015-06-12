Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36853 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbbFLHYa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Jun 2015 03:24:30 -0400
Received: by wigg3 with SMTP id g3so8232656wig.1
        for <linux-wpan@vger.kernel.org>; Fri, 12 Jun 2015 00:24:29 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: fix flags BIT definitions order
Date: Fri, 12 Jun 2015 09:24:00 +0200
Message-Id: <1434093840-27138-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch fixes commits ("mac802154: cleanup ieee802154 hardware flags")
bcbfd2078d9b11277d9c9ce0c30ba73c750503c9 and ("mac802154: cleanup address
filtering flags") 6b70a43c7e0202cf285c864bc9f20f607c42e432 by starting
the flags definitions at BIT(0) which is same like the previous behaviour.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index de1cdde..f534a46 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -49,10 +49,10 @@
  *	do frame address filtering as a pan coordinator.
  */
 enum ieee802154_hw_addr_filt_flags {
-	IEEE802154_AFILT_SADDR_CHANGED		= BIT(1),
-	IEEE802154_AFILT_IEEEADDR_CHANGED	= BIT(2),
-	IEEE802154_AFILT_PANID_CHANGED		= BIT(3),
-	IEEE802154_AFILT_PANC_CHANGED		= BIT(4),
+	IEEE802154_AFILT_SADDR_CHANGED		= BIT(0),
+	IEEE802154_AFILT_IEEEADDR_CHANGED	= BIT(1),
+	IEEE802154_AFILT_PANID_CHANGED		= BIT(2),
+	IEEE802154_AFILT_PANC_CHANGED		= BIT(3),
 };
 
 /**
@@ -133,14 +133,14 @@ struct ieee802154_hw {
  *	frames with bad checksum.
  */
 enum ieee802154_hw_flags {
-	IEEE802154_HW_TX_OMIT_CKSUM	= BIT(1),
-	IEEE802154_HW_LBT		= BIT(2),
-	IEEE802154_HW_CSMA_PARAMS	= BIT(3),
-	IEEE802154_HW_FRAME_RETRIES	= BIT(4),
-	IEEE802154_HW_AFILT		= BIT(5),
-	IEEE802154_HW_PROMISCUOUS	= BIT(6),
-	IEEE802154_HW_RX_OMIT_CKSUM	= BIT(7),
-	IEEE802154_HW_RX_DROP_BAD_CKSUM	= BIT(8),
+	IEEE802154_HW_TX_OMIT_CKSUM	= BIT(0),
+	IEEE802154_HW_LBT		= BIT(1),
+	IEEE802154_HW_CSMA_PARAMS	= BIT(2),
+	IEEE802154_HW_FRAME_RETRIES	= BIT(3),
+	IEEE802154_HW_AFILT		= BIT(4),
+	IEEE802154_HW_PROMISCUOUS	= BIT(5),
+	IEEE802154_HW_RX_OMIT_CKSUM	= BIT(6),
+	IEEE802154_HW_RX_DROP_BAD_CKSUM	= BIT(7),
 };
 
 /* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
-- 
2.4.1

