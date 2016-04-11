Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38547 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753865AbcDKJEa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:30 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 11/11] 6lowpan: move mac802154 header
Date: Mon, 11 Apr 2016 11:04:24 +0200
Message-Id: <1460365464-12435-12-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

In case of link-layer specific handling for 802.15.4 we need to cast to
802.15.4 sepcific structures. Simple add this header when include the
6lowpan header.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h | 3 +++
 net/6lowpan/iphc.c    | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 04b877c..da84cf9 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -58,6 +58,9 @@
 #include <net/ipv6.h>
 #include <net/net_namespace.h>
 
+/* special link-layer handling */
+#include <net/mac802154.h>
+
 #define EUI64_ADDR_LEN		8
 
 #define LOWPAN_NHC_MAX_ID_LEN	1
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index dff1591..8501dd5 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -53,9 +53,6 @@
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
 
-/* special link-layer handling */
-#include <net/mac802154.h>
-
 #include "6lowpan_i.h"
 #include "nhc.h"
 
-- 
2.8.0

