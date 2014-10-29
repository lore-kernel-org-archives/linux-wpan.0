Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:60260 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbaJ2Ufv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:51 -0400
Received: by mail-wi0-f173.google.com with SMTP id n3so2788580wiv.0
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:50 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/17] mac802154: remove tab after define
Date: Wed, 29 Oct 2014 21:34:29 +0100
Message-Id: <1414614884-20243-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes tabs after define in hardware flags declarations.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 85a4efc..fe14957 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -74,22 +74,22 @@ struct ieee802154_hw {
  */
 
 /* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
-#define	IEEE802154_HW_OMIT_CKSUM	0x00000001
+#define IEEE802154_HW_OMIT_CKSUM	0x00000001
 /* Indicates that receiver will autorespond with ACK frames. */
-#define	IEEE802154_HW_AACK		0x00000002
+#define IEEE802154_HW_AACK		0x00000002
 /* Indicates that transceiver will support transmit power setting. */
-#define	IEEE802154_HW_TXPOWER		0x00000004
+#define IEEE802154_HW_TXPOWER		0x00000004
 /* Indicates that transceiver will support listen before transmit. */
-#define	IEEE802154_HW_LBT		0x00000008
+#define IEEE802154_HW_LBT		0x00000008
 /* Indicates that transceiver will support cca mode setting. */
-#define	IEEE802154_HW_CCA_MODE		0x00000010
+#define IEEE802154_HW_CCA_MODE		0x00000010
 /* Indicates that transceiver will support cca ed level setting. */
-#define	IEEE802154_HW_CCA_ED_LEVEL	0x00000020
+#define IEEE802154_HW_CCA_ED_LEVEL	0x00000020
 /* Indicates that transceiver will support csma (max_be, min_be, csma retries)
  * settings. */
-#define	IEEE802154_HW_CSMA_PARAMS	0x00000040
+#define IEEE802154_HW_CSMA_PARAMS	0x00000040
 /* Indicates that transceiver will support ARET frame retries setting. */
-#define	IEEE802154_HW_FRAME_RETRIES	0x00000080
+#define IEEE802154_HW_FRAME_RETRIES	0x00000080
 
 /* This groups the most common CSMA support fields into one. */
 #define IEEE802154_HW_CSMA		(IEEE802154_HW_CCA_MODE | \
-- 
2.1.2

