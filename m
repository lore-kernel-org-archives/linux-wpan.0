Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:42772 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759291AbbCDUUI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 15:20:08 -0500
Received: by wiwh11 with SMTP id h11so33456218wiw.1
        for <linux-wpan@vger.kernel.org>; Wed, 04 Mar 2015 12:20:07 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next] mac802154: correct max sifs size handling
Date: Wed,  4 Mar 2015 21:19:59 +0100
Message-Id: <1425500399-18438-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
References: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the max sifs size correction when the
IEEE802154_HW_TX_OMIT_CKSUM flag is set. With this flag the sk_buff
doesn't contain the CRC, because the transceiver will add the CRC
while transmit.

Also add some defines for the max sifs frame size value and frame check
sequence according to 802.15.4 standard.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h |  2 ++
 net/mac802154/util.c       | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index 5fc9790..150bf80 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -65,8 +65,19 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 {
 	if (ifs_handling) {
 		struct ieee802154_local *local = hw_to_local(hw);
+		u8 max_sifs_size;
 
-		if (skb->len > 18)
+		/* If transceiver sets CRC on his own we need to use lifs
+		 * threshold len above 16 otherwise 18, because it's not
+		 * part of skb->len.
+		 */
+		if (hw->flags & IEEE802154_HW_TX_OMIT_CKSUM)
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE -
+					IEEE802154_FCS_LEN;
+		else
+			max_sifs_size = IEEE802154_MAX_SIFS_FRAME_SIZE;
+
+		if (skb->len > max_sifs_size)
 			hrtimer_start(&local->ifs_timer,
 				      ktime_set(0, hw->phy->lifs_period * NSEC_PER_USEC),
 				      HRTIMER_MODE_REL);
-- 
2.3.0

