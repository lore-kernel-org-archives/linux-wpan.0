Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56569 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919AbaJ2UgF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:05 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so5660221wiv.3
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/17] mac802154: rx: add rx stats incrementation
Date: Wed, 29 Oct 2014 21:34:40 +0100
Message-Id: <1414614884-20243-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds rx stats incrementation when the monitor interface
recevied a frame.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 7669cdb..6ba2769 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -241,6 +241,9 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		skb2->dev = sdata->dev;
 
 		ieee802154_deliver_skb(skb2);
+
+		sdata->dev->stats.rx_packets++;
+		sdata->dev->stats.rx_bytes += skb->len;
 	}
 }
 
-- 
2.1.2

