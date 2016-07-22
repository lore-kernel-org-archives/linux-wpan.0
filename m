Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbcGVRSX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 Jul 2016 13:18:23 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH 2/3] mac802154: use rate limited warnings for malformed frames
Date: Fri, 22 Jul 2016 13:18:15 -0400
Message-Id: <1469207896-26481-2-git-send-email-arozansk@redhat.com>
In-Reply-To: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
References: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Aristeu Rozanski <arozansk@redhat.com>

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
---
 net/mac802154/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index d388bf2..11dac04 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -111,8 +111,8 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		return ieee802154_deliver_skb(skb);
 
 	default:
-		pr_warn("ieee802154: bad frame received (type = %d)\n",
-			mac_cb(skb)->type);
+		pr_warn_ratelimited("ieee802154: bad frame received "
+				    "(type = %d)\n", mac_cb(skb)->type);
 		sdata->dev->stats.rx_frame_errors++;
 		goto fail;
 	}
-- 
1.8.3.1

