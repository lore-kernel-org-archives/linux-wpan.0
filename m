Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63240 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaLTOFc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Dec 2014 09:05:32 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so4268660wid.17
        for <linux-wpan@vger.kernel.org>; Sat, 20 Dec 2014 06:05:31 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/5] ieee802154: 6lowpan: rename internal header
Date: Sat, 20 Dec 2014 15:05:00 +0100
Message-Id: <1419084300-29069-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
References: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the internal header for af802154. This naming
convention is like ieee802154_i.h in mac802154 and avoids naming
confusing with the global af802154 header. Furthermore this header
contains more ieee802154 specific definitions.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/{reassembly.h => 6lowpan_i.h} | 6 +++---
 net/ieee802154/6lowpan/6lowpan_rtnl.c                | 2 +-
 net/ieee802154/6lowpan/reassembly.c                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename net/ieee802154/6lowpan/{reassembly.h => 6lowpan_i.h} (85%)

diff --git a/net/ieee802154/6lowpan/reassembly.h b/net/ieee802154/6lowpan/6lowpan_i.h
similarity index 85%
rename from net/ieee802154/6lowpan/reassembly.h
rename to net/ieee802154/6lowpan/6lowpan_i.h
index 836b16f..edbe803 100644
--- a/net/ieee802154/6lowpan/reassembly.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -1,5 +1,5 @@
-#ifndef __IEEE802154_6LOWPAN_REASSEMBLY_H__
-#define __IEEE802154_6LOWPAN_REASSEMBLY_H__
+#ifndef __IEEE802154_6LOWPAN_I_H__
+#define __IEEE802154_6LOWPAN_I_H__
 
 #include <net/inet_frag.h>
 
@@ -38,4 +38,4 @@ int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
 void lowpan_net_frag_exit(void);
 int lowpan_net_frag_init(void);
 
-#endif /* __IEEE802154_6LOWPAN_REASSEMBLY_H__ */
+#endif /* __IEEE802154_6LOWPAN_I_H__ */
diff --git a/net/ieee802154/6lowpan/6lowpan_rtnl.c b/net/ieee802154/6lowpan/6lowpan_rtnl.c
index 27eaa65..1918c43 100644
--- a/net/ieee802154/6lowpan/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan/6lowpan_rtnl.c
@@ -55,7 +55,7 @@
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
 
-#include "reassembly.h"
+#include "6lowpan_i.h"
 
 static LIST_HEAD(lowpan_devices);
 static int lowpan_open_count;
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 9d980ed..f46e4d1 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -28,7 +28,7 @@
 #include <net/ipv6.h>
 #include <net/inet_frag.h>
 
-#include "reassembly.h"
+#include "6lowpan_i.h"
 
 static const char lowpan_frags_cache_name[] = "lowpan-frags";
 
-- 
2.2.0

