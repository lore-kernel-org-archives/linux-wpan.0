Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34321 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbFAEec (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 00:34:32 -0400
Received: by payr10 with SMTP id r10so17815983pay.1
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 21:34:31 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154: trace: fix name for tx power value
Date: Mon,  1 Jun 2015 10:03:56 +0530
Message-Id: <1433133238-16056-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1433133238-16056-1-git-send-email-varkab@cdac.in>
References: <1433133238-16056-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/ieee802154/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 73eb760..b4295fd 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -104,7 +104,7 @@ TRACE_EVENT(802154_rdev_set_tx_power,
 		WPAN_PHY_ASSIGN;
 		__entry->power = power;
 	),
-	TP_printk(WPAN_PHY_PR_FMT ", power: %d", WPAN_PHY_PR_ARG,
+	TP_printk(WPAN_PHY_PR_FMT ", mbm: %d", WPAN_PHY_PR_ARG,
 		  __entry->power)
 );
 
-- 
1.7.9.5

