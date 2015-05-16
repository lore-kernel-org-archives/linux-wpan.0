Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34133 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbbEPP1N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:13 -0400
Received: by wguv19 with SMTP id v19so82883809wgu.1
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 12/13] fakelb: add support for async xmit handling
Date: Sat, 16 May 2015 17:26:16 +0200
Message-Id: <1431789977-31393-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch will add async xmit support for the fakelb driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 0deecc6..51b6043 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -87,6 +87,7 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	}
 	read_unlock_bh(&fakelb_ifup_phys_lock);
 
+	ieee802154_xmit_complete(hw, skb, false);
 	return 0;
 }
 
@@ -112,7 +113,7 @@ fakelb_hw_stop(struct ieee802154_hw *hw) {
 
 static const struct ieee802154_ops fakelb_ops = {
 	.owner = THIS_MODULE,
-	.xmit_sync = fakelb_hw_xmit,
+	.xmit_async = fakelb_hw_xmit,
 	.ed = fakelb_hw_ed,
 	.set_channel = fakelb_hw_channel,
 	.start = fakelb_hw_start,
-- 
2.3.7

