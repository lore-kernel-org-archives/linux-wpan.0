Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37655 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbaLTOF3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Dec 2014 09:05:29 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so4377319wiv.17
        for <linux-wpan@vger.kernel.org>; Sat, 20 Dec 2014 06:05:28 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/5] ieee802154: af802154: rename internal header
Date: Sat, 20 Dec 2014 15:04:57 +0100
Message-Id: <1419084300-29069-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
References: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the internal header for af802154. This naming
convention is like ieee802154_i.h in mac802154 and avoids naming
confusing with the global af802154 header.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/af802154/{af802154.h => af802154_i.h} | 6 +++---
 net/ieee802154/af802154/af_ieee802154.c              | 2 +-
 net/ieee802154/af802154/dgram.c                      | 2 +-
 net/ieee802154/af802154/raw.c                        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename net/ieee802154/af802154/{af802154.h => af802154_i.h} (93%)

diff --git a/net/ieee802154/af802154/af802154.h b/net/ieee802154/af802154/af802154_i.h
similarity index 93%
rename from net/ieee802154/af802154/af802154.h
rename to net/ieee802154/af802154/af802154_i.h
index 343b63e..e5c7bb5 100644
--- a/net/ieee802154/af802154/af802154.h
+++ b/net/ieee802154/af802154/af802154_i.h
@@ -17,8 +17,8 @@
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  */
 
-#ifndef AF802154_H
-#define AF802154_H
+#ifndef AF802154_I_H
+#define AF802154_I_H
 
 struct sk_buff;
 struct net_device;
@@ -30,4 +30,4 @@ int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb);
 struct net_device *ieee802154_get_dev(struct net *net,
 				      const struct ieee802154_addr *addr);
 
-#endif
+#endif /* AF802154_I_H */
diff --git a/net/ieee802154/af802154/af_ieee802154.c b/net/ieee802154/af802154/af_ieee802154.c
index d0a1282..41a7bcf 100644
--- a/net/ieee802154/af802154/af_ieee802154.c
+++ b/net/ieee802154/af802154/af_ieee802154.c
@@ -34,7 +34,7 @@
 #include <net/af_ieee802154.h>
 #include <net/ieee802154_netdev.h>
 
-#include "af802154.h"
+#include "af802154_i.h"
 
 /* Utility function for families */
 struct net_device*
diff --git a/net/ieee802154/af802154/dgram.c b/net/ieee802154/af802154/dgram.c
index d1930b7..3a8487b 100644
--- a/net/ieee802154/af802154/dgram.c
+++ b/net/ieee802154/af802154/dgram.c
@@ -30,7 +30,7 @@
 
 #include <asm/ioctls.h>
 
-#include "af802154.h"
+#include "af802154_i.h"
 
 static HLIST_HEAD(dgram_head);
 static DEFINE_RWLOCK(dgram_lock);
diff --git a/net/ieee802154/af802154/raw.c b/net/ieee802154/af802154/raw.c
index 1674b115..0315f76 100644
--- a/net/ieee802154/af802154/raw.c
+++ b/net/ieee802154/af802154/raw.c
@@ -26,7 +26,7 @@
 #include <net/af_ieee802154.h>
 #include <net/ieee802154_netdev.h>
 
-#include "af802154.h"
+#include "af802154_i.h"
 
 static HLIST_HEAD(raw_head);
 static DEFINE_RWLOCK(raw_lock);
-- 
2.2.0

