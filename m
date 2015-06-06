Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38781 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbFFPbH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:07 -0400
Received: by wibdq8 with SMTP id dq8so44791526wib.1
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/8] mac802154: cleanup address filtering flags
Date: Sat,  6 Jun 2015 17:30:47 +0200
Message-Id: <1433604653-9585-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the address filtering flags to enums and setting the
flag values with the BIT macro. Additional this patch changes the
commenting style for matching usual kernel style.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 80a9e60..845e4f8 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -31,18 +31,29 @@
  */
 #define MAC802154_FRAME_HARD_HEADER_LEN		(2 + 1 + 20 + 14)
 
-/* The following flags are used to indicate changed address settings from
+/**
+ * enum ieee802154_hw_addr_filt_flags - hardware address filtering flags
+ *
+ * The following flags are used to indicate changed address settings from
  * the stack to the hardware.
+ *
+ * @IEEE802154_AFILT_SADDR_CHANGED: Indicates that the short address will be
+ *	change.
+ *
+ * @IEEE802154_AFILT_IEEEADDR_CHANGED: Indicates that the extended address
+ *	will be change.
+ *
+ * @IEEE802154_AFILT_PANID_CHANGED: Indicates that the pan id will be change.
+ *
+ * @IEEE802154_AFILT_PANC_CHANGED: Indicates that the address filter will
+ *	do frame address filtering as a pan coordinator.
  */
-
-/* indicates that the Short Address changed */
-#define IEEE802154_AFILT_SADDR_CHANGED		0x00000001
-/* indicates that the IEEE Address changed */
-#define IEEE802154_AFILT_IEEEADDR_CHANGED	0x00000002
-/* indicates that the PAN ID changed */
-#define IEEE802154_AFILT_PANID_CHANGED		0x00000004
-/* indicates that PAN Coordinator status changed */
-#define IEEE802154_AFILT_PANC_CHANGED		0x00000008
+enum ieee802154_hw_addr_filt_flags {
+	IEEE802154_AFILT_SADDR_CHANGED		= BIT(1),
+	IEEE802154_AFILT_IEEEADDR_CHANGED	= BIT(2),
+	IEEE802154_AFILT_PANID_CHANGED		= BIT(3),
+	IEEE802154_AFILT_PANC_CHANGED		= BIT(4),
+};
 
 struct ieee802154_hw_addr_filt {
 	__le16	pan_id;		/* Each independent PAN selects a unique
-- 
2.4.1

