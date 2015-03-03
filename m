Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:42404 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618AbbCCW15 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Mar 2015 17:27:57 -0500
Received: by wggz12 with SMTP id z12so5814904wgg.9
        for <linux-wpan@vger.kernel.org>; Tue, 03 Mar 2015 14:27:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: add IEEE802154_FCS_LEN
Date: Tue,  3 Mar 2015 23:27:35 +0100
Message-Id: <1425421655-21420-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425421655-21420-1-git-send-email-alex.aring@gmail.com>
References: <1425421655-21420-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a IEEE802154_FCS_LEN for the frame check sequence also
called CRC which is inside the MFR (MAC Footer).

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 1 +
 net/mac802154/util.c       | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index f26682e..8872ca1 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -30,6 +30,7 @@
 #define IEEE802154_MTU			127
 #define IEEE802154_ACK_PSDU_LEN		5
 #define IEEE802154_MIN_PSDU_LEN		9
+#define IEEE802154_FCS_LEN		2
 
 #define IEEE802154_PAN_ID_BROADCAST	0xffff
 #define IEEE802154_ADDR_SHORT_BROADCAST	0xffff
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index dad966c..150bf80 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -72,7 +72,8 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 		 * part of skb->len.
 		 */
 		if (hw->flags & IEEE802154_HW_TX_OMIT_CKSUM)
-			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE - 2;
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE -
+					IEEE802154_FCS_LEN;
 		else
 			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE;
 
-- 
2.3.0

