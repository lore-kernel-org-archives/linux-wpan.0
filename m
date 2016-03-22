Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57343 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758908AbcCVNPo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:44 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 11/19] 6lowpan: move mac802154 header
Date: Tue, 22 Mar 2016 14:15:07 +0100
Message-Id: <1458652515-7862-12-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

In case of link-layer specific handling for 802.15.4 we need to cast to
802.15.4 sepcific structures. Simple add this header when include the
6lowpan header.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h | 3 +++
 net/6lowpan/iphc.c    | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 6c09d01..4e465c7 100644
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
index a3ea5f6..d167ce5bd1 100644
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
2.7.4

