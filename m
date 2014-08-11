Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:51762 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbaHKLac (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 07:30:32 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 13:25:08 +0200
Message-Id: <1407756310-26592-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH 2/4] mac802154: common error path
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkab@cdac.in>

By introducing label fail, making the common error path for
mac802154_llsec_decrypt() and packet type default case.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/wpan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index 3c3069f..ce17570 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -472,8 +472,7 @@ mac802154_subif_frame(struct mac802154_sub_if_data *sdata, struct sk_buff *skb,
 	rc = mac802154_llsec_decrypt(&sdata->sec, skb);
 	if (rc) {
 		pr_debug("decryption failed: %i\n", rc);
-		kfree_skb(skb);
-		return NET_RX_DROP;
+		goto fail;
 	}
 
 	sdata->dev->stats.rx_packets++;
@@ -485,9 +484,12 @@ mac802154_subif_frame(struct mac802154_sub_if_data *sdata, struct sk_buff *skb,
 	default:
 		pr_warn("ieee802154: bad frame received (type = %d)\n",
 			mac_cb(skb)->type);
-		kfree_skb(skb);
-		return NET_RX_DROP;
+		goto fail;
 	}
+
+fail:
+	kfree_skb(skb);
+	return NET_RX_DROP;
 }
 
 static void mac802154_print_addr(const char *name,
-- 
2.0.3

