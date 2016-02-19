Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57104 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756148AbcBSI7Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 19 Feb 2016 03:59:16 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 2/5] mac802154: fix mac header length check
Date: Fri, 19 Feb 2016 09:59:11 +0100
Message-Id: <1455872354-26032-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
References: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

I got report about that sometimes the WARN_ON occurs there which should
never happen. I came to the conclusion that the mac header is there but
inside the headroom of skb. The skb->len information doesn't contain the
information about the headroom length and skb->len is lesser than two.

We check now if the skb_mac_header pointer is set and the room between
mac header pointer and tail pointer.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/mac802154.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index da574bb..2e3cdd20 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -247,8 +247,9 @@ struct ieee802154_ops {
  */
 static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 {
-	/* return some invalid fc on failure */
-	if (unlikely(skb->len < 2)) {
+	/* check if we can fc at skb_mac_header of sk buffer */
+	if (unlikely(!skb_mac_header_was_set(skb) ||
+		     (skb_tail_pointer(skb) - skb_mac_header(skb)) < 2)) {
 		WARN_ON(1);
 		return cpu_to_le16(0);
 	}
-- 
2.7.1

