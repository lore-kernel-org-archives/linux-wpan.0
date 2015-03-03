Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:39490 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbbCCW1z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Mar 2015 17:27:55 -0500
Received: by wesx3 with SMTP id x3so42778145wes.6
        for <linux-wpan@vger.kernel.org>; Tue, 03 Mar 2015 14:27:54 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] ieee802154: add IEEE802154_MAX_SIFS_FRAME_SIZE
Date: Tue,  3 Mar 2015 23:27:34 +0100
Message-Id: <1425421655-21420-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425421655-21420-1-git-send-email-alex.aring@gmail.com>
References: <1425421655-21420-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a define for the max sifs frame size value according
802.15.4.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 1 +
 net/mac802154/util.c       | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 40b0ab9..f26682e 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -39,6 +39,7 @@
 
 #define IEEE802154_LIFS_PERIOD		40
 #define IEEE802154_SIFS_PERIOD		12
+#define IEEE802154_MAX_SIFS_FRAME_SIZE	18
 
 #define IEEE802154_MAX_CHANNEL		26
 #define IEEE802154_MAX_PAGE		31
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 04e13d9..dad966c 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -72,9 +72,9 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 		 * part of skb->len.
 		 */
 		if (hw->flags & IEEE802154_HW_TX_OMIT_CKSUM)
-			max_sifs_size = 16;
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE - 2;
 		else
-			max_sifs_size = 18;
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE;
 
 		if (skb->len > max_sifs_size)
 			hrtimer_start(&local->ifs_timer,
-- 
2.3.0

