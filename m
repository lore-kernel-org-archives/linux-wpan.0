Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51414 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbaHSJDQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 05:03:16 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth 1/5] mac802154: fixed potential skb leak with mac802154_parse_frame_start
Date: Tue, 19 Aug 2014 11:02:59 +0200
Message-Id: <1408438983-13892-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
References: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <martin.townsend@xsilon.com>, Alexander Aring <alex.aring@gmail.com>

From: Martin Townsend <martin.townsend@xsilon.com>

This patch fix a memory leak if received frame was not able to parse.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/wpan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index 3c3069f..4c13323 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -573,6 +573,7 @@ void mac802154_wpans_rx(struct mac802154_priv *priv, struct sk_buff *skb)
 	ret = mac802154_parse_frame_start(skb, &hdr);
 	if (ret) {
 		pr_debug("got invalid frame\n");
+		kfree_skb(skb);
 		return;
 	}
 
-- 
2.0.3

