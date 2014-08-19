Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:57945 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbaHSRD7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 13:03:59 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth 3/5] ieee802154: mac802154: handle the reserved dest mode by dropping the packet
Date: Tue, 19 Aug 2014 19:03:30 +0200
Message-Id: <1408467812-30483-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
References: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <martin.townsend@xsilon.com>, Alexander Aring <alex.aring@gmail.com>

From: Martin Townsend <martin.townsend@xsilon.com>

If received frame contains the reserved destination address mode. The
frame should be dropped and free the skb.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/wpan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index 4c13323..5478388 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -462,7 +462,10 @@ mac802154_subif_frame(struct mac802154_sub_if_data *sdata, struct sk_buff *skb,
 			skb->pkt_type = PACKET_OTHERHOST;
 		break;
 	default:
-		break;
+		spin_unlock_bh(&sdata->mib_lock);
+		pr_debug("invalid dest mode\n");
+		kfree_skb(skb);
+		return NET_RX_DROP;
 	}
 
 	spin_unlock_bh(&sdata->mib_lock);
-- 
2.0.4

