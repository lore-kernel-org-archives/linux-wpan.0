Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33864 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaKETwS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:18 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so13498902wid.8
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:17 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/18] ieee802154: add IEEE802154_EXTENDED_ADDR_LEN
Date: Wed,  5 Nov 2014 20:51:21 +0100
Message-Id: <1415217089-24919-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new define for getting the length of an extended
address.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 4c03286..a907fe5 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -29,6 +29,8 @@
 #define IEEE802154_MTU			127
 #define IEEE802154_MIN_PSDU_LEN		5
 
+#define IEEE802154_EXTENDED_ADDR_LEN	8
+
 #define IEEE802154_FC_TYPE_BEACON	0x0	/* Frame is beacon */
 #define	IEEE802154_FC_TYPE_DATA		0x1	/* Frame is data */
 #define IEEE802154_FC_TYPE_ACK		0x2	/* Frame is acknowledgment */
-- 
2.1.3

