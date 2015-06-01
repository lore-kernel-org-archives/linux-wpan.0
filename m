Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36674 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbFAEej (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 00:34:39 -0400
Received: by pacux9 with SMTP id ux9so60284740pac.3
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 21:34:38 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: trace: fix extended addr format specifier
Date: Mon,  1 Jun 2015 10:03:58 +0530
Message-Id: <1433133238-16056-4-git-send-email-varkab@cdac.in>
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
index 9b5eefc..dce6794 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -56,7 +56,7 @@ TRACE_EVENT(802154_rdev_add_virtual_intf,
 		__entry->type = type;
 		__entry->extended_addr = extended_addr;
 	),
-	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, extended addr: %llx",
+	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, extended addr: 0x%llx",
 		  WPAN_PHY_PR_ARG, __get_str(vir_intf_name), __entry->type,
 		  __le64_to_cpu(__entry->extended_addr))
 );
-- 
1.7.9.5

