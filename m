Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbcGYPqs (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 11:46:48 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH v2 1/2] mac802154: don't warn on unsupported frames
Date: Mon, 25 Jul 2016 11:46:40 -0400
Message-Id: <1469461601-656-1-git-send-email-arozansk@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Aristeu Rozanski <arozansk@redhat.com>

Just because we don't support certain types of frames yet doesn't mean
we have to flood the message log with warnings about "invalid" frames.

v2: get rid of stats update, some of them were wrong, others might change in
    the future

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
---
 net/mac802154/rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 446e130..b978da0 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -101,6 +101,11 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 	sdata->dev->stats.rx_bytes += skb->len;
 
 	switch (mac_cb(skb)->type) {
+	case IEEE802154_FC_TYPE_BEACON:
+	case IEEE802154_FC_TYPE_ACK:
+	case IEEE802154_FC_TYPE_MAC_CMD:
+		goto fail;
+
 	case IEEE802154_FC_TYPE_DATA:
 		return ieee802154_deliver_skb(skb);
 	default:
-- 
1.8.3.1

