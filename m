Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33184 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759231AbbCDLZF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 06:25:05 -0500
Received: by wghb13 with SMTP id b13so45929346wgh.0
        for <linux-wpan@vger.kernel.org>; Wed, 04 Mar 2015 03:25:04 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/2] mac802154: correct max sifs size handling
Date: Wed,  4 Mar 2015 12:24:49 +0100
Message-Id: <1425468290-24525-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425468290-24525-1-git-send-email-alex.aring@gmail.com>
References: <1425468290-24525-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the max sifs size correction when the
IEEE802154_HW_TX_OMIT_CKSUM flag is set. With this flag the sk_buff
doesn't contain the CRC, because the transceiver will add the CRC
while transmit.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/util.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 5fc9790..04e13d9 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -65,8 +65,18 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
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
+			max_sifs_size = 16;
+		else
+			max_sifs_size = 18;
+
+		if (skb->len > max_sifs_size)
 			hrtimer_start(&local->ifs_timer,
 				      ktime_set(0, hw->phy->lifs_period * NSEC_PER_USEC),
 				      HRTIMER_MODE_REL);
-- 
2.3.0

