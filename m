Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54900 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667AbcGYMPD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 08:15:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 2/4] mac802154: keep Makefile sync with mac80211
Date: Mon, 25 Jul 2016 14:14:48 +0200
Message-Id: <20160725121450.4093-3-aar@pengutronix.de>
In-Reply-To: <20160725121450.4093-1-aar@pengutronix.de>
References: <20160725121450.4093-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/mac802154/Makefile | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 17a51e8..9f7347a 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,6 +1,17 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
-mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   iface.o llsec.o util.o cfg.o trace.o
+
+# mac802154 objects
+mac802154-objs := \
+	main.o \
+	rx.o \
+	tx.o \
+	mac_cmd.o \
+	mib.o \
+	iface.o \
+	llsec.o \
+	util.o \
+	cfg.o \
+	trace.o
 
 CFLAGS_trace.o := -I$(src)
 
-- 
2.9.0

