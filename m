Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34700 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbcGVRSX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 Jul 2016 13:18:23 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH 1/3] mac802154: don't warn on unsupported frames
Date: Fri, 22 Jul 2016 13:18:14 -0400
Message-Id: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Aristeu Rozanski <arozansk@redhat.com>

Just because we don't support certain types of frames yet doesn't mean
we have to flood the message log with warnings about "invalid" frames.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
---
 net/mac802154/rx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 446e130..d388bf2 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -82,6 +82,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		break;
 	default:
 		pr_debug("invalid dest mode\n");
+		sdata->dev->stats.rx_frame_errors++;
 		goto fail;
 	}
 
@@ -97,15 +98,22 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		goto fail;
 	}
 
-	sdata->dev->stats.rx_packets++;
-	sdata->dev->stats.rx_bytes += skb->len;
-
 	switch (mac_cb(skb)->type) {
+	case IEEE802154_FC_TYPE_BEACON:
+	case IEEE802154_FC_TYPE_ACK:
+	case IEEE802154_FC_TYPE_MAC_CMD:
+		sdata->dev->stats.rx_dropped++;
+		goto fail;
+
 	case IEEE802154_FC_TYPE_DATA:
+		sdata->dev->stats.rx_bytes += skb->len;
+		sdata->dev->stats.rx_packets++;
 		return ieee802154_deliver_skb(skb);
+
 	default:
 		pr_warn("ieee802154: bad frame received (type = %d)\n",
 			mac_cb(skb)->type);
+		sdata->dev->stats.rx_frame_errors++;
 		goto fail;
 	}
 
-- 
1.8.3.1

