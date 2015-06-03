Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32973 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbFCDwW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 23:52:22 -0400
Received: by padj3 with SMTP id j3so81324522pad.0
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 20:52:22 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] cfg802154: fix rdev-ops naming convension and format specifiers
Date: Wed,  3 Jun 2015 09:21:47 +0530
Message-Id: <1433303507-10061-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch make to use the same naming convention that mac802154
tracing follows and fixes the format specifier for extended addr.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/ieee802154/trace.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 73eb760..9b5f0eb 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -56,7 +56,7 @@ TRACE_EVENT(802154_rdev_add_virtual_intf,
 		__entry->type = type;
 		__entry->extended_addr = extended_addr;
 	),
-	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, ea %llx",
+	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, extended addr: 0x%llx",
 		  WPAN_PHY_PR_ARG, __get_str(vir_intf_name), __entry->type,
 		  __le64_to_cpu(__entry->extended_addr))
 );
@@ -104,7 +104,7 @@ TRACE_EVENT(802154_rdev_set_tx_power,
 		WPAN_PHY_ASSIGN;
 		__entry->power = power;
 	),
-	TP_printk(WPAN_PHY_PR_FMT ", power: %d", WPAN_PHY_PR_ARG,
+	TP_printk(WPAN_PHY_PR_FMT ", mbm: %d", WPAN_PHY_PR_ARG,
 		  __entry->power)
 );
 
@@ -134,7 +134,7 @@ TRACE_EVENT(802154_rdev_set_cca_ed_level,
 		WPAN_PHY_ASSIGN;
 		__entry->ed_level = ed_level;
 	),
-	TP_printk(WPAN_PHY_PR_FMT ", ed_level: %d", WPAN_PHY_PR_ARG,
+	TP_printk(WPAN_PHY_PR_FMT ", ed level: %d", WPAN_PHY_PR_ARG,
 		  __entry->ed_level)
 );
 
@@ -167,7 +167,7 @@ DEFINE_EVENT_PRINT(802154_le16_template, 802154_rdev_set_short_addr,
 	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		 __le16 le16arg),
 	TP_ARGS(wpan_phy, wpan_dev, le16arg),
-	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", sa: 0x%04x",
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", short addr: 0x%04x",
 		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG,
 		  __le16_to_cpu(__entry->le16arg))
 );
@@ -190,7 +190,7 @@ TRACE_EVENT(802154_rdev_set_backoff_exponent,
 	),
 
 	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
-		  ", min be: %d, max_be: %d", WPAN_PHY_PR_ARG,
+		  ", min be: %d, max be: %d", WPAN_PHY_PR_ARG,
 		  WPAN_DEV_PR_ARG, __entry->min_be, __entry->max_be)
 );
 
-- 
1.7.9.5

