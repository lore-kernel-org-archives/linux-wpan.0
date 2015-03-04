Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35510 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759220AbbCDLZI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 06:25:08 -0500
Received: by wivz2 with SMTP id z2so10507032wiv.0
        for <linux-wpan@vger.kernel.org>; Wed, 04 Mar 2015 03:25:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 2/2] ieee802154: replace magic numbers by standard defines
Date: Wed,  4 Mar 2015 12:24:50 +0100
Message-Id: <1425468290-24525-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425468290-24525-1-git-send-email-alex.aring@gmail.com>
References: <1425468290-24525-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a define for the max sifs frame size value and frame check
sequence according to 802.15.4 standard.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 2 ++
 net/mac802154/util.c       | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 40b0ab9..8872ca1 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -30,6 +30,7 @@
 #define IEEE802154_MTU			127
 #define IEEE802154_ACK_PSDU_LEN		5
 #define IEEE802154_MIN_PSDU_LEN		9
+#define IEEE802154_FCS_LEN		2
 
 #define IEEE802154_PAN_ID_BROADCAST	0xffff
 #define IEEE802154_ADDR_SHORT_BROADCAST	0xffff
@@ -39,6 +40,7 @@
 
 #define IEEE802154_LIFS_PERIOD		40
 #define IEEE802154_SIFS_PERIOD		12
+#define IEEE802154_MAX_SIFS_FRAME_SIZE	18
 
 #define IEEE802154_MAX_CHANNEL		26
 #define IEEE802154_MAX_PAGE		31
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 04e13d9..150bf80 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -72,9 +72,10 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 		 * part of skb->len.
 		 */
 		if (hw->flags & IEEE802154_HW_TX_OMIT_CKSUM)
-			max_sifs_size = 16;
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE -
+					IEEE802154_FCS_LEN;
 		else
-			max_sifs_size = 18;
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE;
 
 		if (skb->len > max_sifs_size)
 			hrtimer_start(&local->ifs_timer,
-- 
2.3.0

