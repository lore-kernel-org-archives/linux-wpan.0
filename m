Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33391 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbbI1SAE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 28 Sep 2015 14:00:04 -0400
Received: by wiclk2 with SMTP id lk2so117018219wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 28 Sep 2015 11:00:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: check on len instead mac_len
Date: Mon, 28 Sep 2015 19:59:48 +0200
Message-Id: <1443463188-6881-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch change the length check to len instead of mac_len for
checking if the frame control field is available to dereference.
We need to change it because I saw issues with af_packet raw sockets
and the mrf24j40 which calls this functionality. The raw socket
functionality doesn't set the mac_len but resets the skb_mac_header to
skb->data which is still correct. The issue occur at mrf24j40 only,
because the driver need to evaluate the fc fields.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 2c47850..5718765 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -248,7 +248,7 @@ struct ieee802154_ops {
 static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 {
 	/* return some invalid fc on failure */
-	if (unlikely(skb->mac_len < 2)) {
+	if (unlikely(skb->len < 2)) {
 		WARN_ON(1);
 		return cpu_to_le16(0);
 	}
-- 
2.5.3

