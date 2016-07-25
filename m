Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbcGYPqs (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 11:46:48 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH v2 2/2] mac802154: use rate limited warnings for malformed frames
Date: Mon, 25 Jul 2016 11:46:41 -0400
Message-Id: <1469461601-656-2-git-send-email-arozansk@redhat.com>
In-Reply-To: <1469461601-656-1-git-send-email-arozansk@redhat.com>
References: <1469461601-656-1-git-send-email-arozansk@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Aristeu Rozanski <arozansk@redhat.com>

v2: rediff on top of previous v2

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
---
 net/mac802154/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index b978da0..4dcf6e1 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -109,8 +109,8 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 	case IEEE802154_FC_TYPE_DATA:
 		return ieee802154_deliver_skb(skb);
 	default:
-		pr_warn("ieee802154: bad frame received (type = %d)\n",
-			mac_cb(skb)->type);
+		pr_warn_ratelimited("ieee802154: bad frame received "
+				    "(type = %d)\n", mac_cb(skb)->type);
 		goto fail;
 	}
 
-- 
1.8.3.1

