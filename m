Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35783 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbbFFPbO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:14 -0400
Received: by wgme6 with SMTP id e6so75003922wgm.2
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 7/8] mac802154: add missing structure comments
Date: Sat,  6 Jun 2015 17:30:52 +0200
Message-Id: <1433604653-9585-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch add missing comments to internal mac802154 structures.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index d8e9e6f..095c9d0 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -55,18 +55,40 @@ enum ieee802154_hw_addr_filt_flags {
 	IEEE802154_AFILT_PANC_CHANGED		= BIT(4),
 };
 
+/**
+ * struct ieee802154_hw_addr_filt - hardware address filtering settings
+ *
+ * @pan_id: pan_id which should be set to the hardware address filter.
+ *
+ * @short_addr: short_addr which should be set to the hardware address filter.
+ *
+ * @ieee_addr: extended address which should be set to the hardware address
+ *	filter.
+ *
+ * @pan_coord: boolean if hardware filtering should be operate as coordinator.
+ */
 struct ieee802154_hw_addr_filt {
-	__le16	pan_id;		/* Each independent PAN selects a unique
-				 * identifier. This PAN id allows communication
-				 * between devices within a network using short
-				 * addresses and enables transmissions between
-				 * devices across independent networks.
-				 */
+	__le16	pan_id;
 	__le16	short_addr;
 	__le64	ieee_addr;
 	u8	pan_coord;
 };
 
+/**
+ * struct ieee802154_hw - ieee802154 hardware
+ *
+ * @extra_tx_headroom: headroom to reserve in each transmit skb for use by the
+ *	driver (e.g. for transmit headers.)
+ *
+ * @flags: hardware flags, see &enum ieee802154_hw_flags
+ *
+ * @parent: parent device of the hardware.
+ *
+ * @priv: pointer to private area that was allocated for driver use along with
+ *	this structure.
+ *
+ * @phy: This points to the &struct wpan_phy allocated for this 802.15.4 PHY.
+ */
 struct ieee802154_hw {
 	/* filled by the driver */
 	int	extra_tx_headroom;
-- 
2.4.1

