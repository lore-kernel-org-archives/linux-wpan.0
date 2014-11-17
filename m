Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:47598 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaKQHVg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:36 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so2582735wgh.16
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/13] ieee802154: rename and move WPAN_NUM_ defines
Date: Mon, 17 Nov 2014 08:20:54 +0100
Message-Id: <1416208855-8623-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the 802.15.4 constraints WPAN_NUM_ defines into
"net/ieee802154.h" which should contain all necessary 802.15.4 related
information. Also rename these defines to a common name which is
IEEE802154_MAX_CHANNEL and IEEE802154_MAX_PAGE.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h |  3 +++
 include/net/cfg802154.h    | 11 ++---------
 net/ieee802154/nl802154.c  |  4 ++--
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 5a40c04..6e82d88 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -39,6 +39,9 @@
 #define IEEE802154_LIFS_PERIOD		40
 #define IEEE802154_SIFS_PERIOD		12
 
+#define IEEE802154_MAX_CHANNEL		26
+#define IEEE802154_MAX_PAGE		31
+
 #define IEEE802154_FC_TYPE_BEACON	0x0	/* Frame is beacon */
 #define	IEEE802154_FC_TYPE_DATA		0x1	/* Frame is data */
 #define IEEE802154_FC_TYPE_ACK		0x2	/* Frame is acknowledgment */
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 507ac9d..228f1f7 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -17,20 +17,13 @@
 #ifndef __NET_CFG802154_H
 #define __NET_CFG802154_H
 
+#include <linux/ieee802154.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
 #include <linux/bug.h>
 
 #include <net/nl802154.h>
 
-/* According to the IEEE 802.15.4 stadard the upper most significant bits of
- * the 32-bit channel bitmaps shall be used as an integer value to specify 32
- * possible channel pages. The lower 27 bits of the channel bit map shall be
- * used as a bit mask to specify channel numbers within a channel page.
- */
-#define WPAN_NUM_CHANNELS	27
-#define WPAN_NUM_PAGES		32
-
 struct wpan_phy;
 
 struct cfg802154_ops {
@@ -81,7 +74,7 @@ struct wpan_phy {
 	 */
 	u8 current_channel;
 	u8 current_page;
-	u32 channels_supported[32];
+	u32 channels_supported[IEEE802154_MAX_PAGE + 1];
 	s8 transmit_power;
 	u8 cca_mode;
 
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 6b9bc93..b82b016 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -245,7 +245,7 @@ nl802154_send_wpan_phy_channels(struct cfg802154_registered_device *rdev,
 	if (!nl_page)
 		return -ENOBUFS;
 
-	for (page = 0; page < WPAN_NUM_PAGES; page++) {
+	for (page = 0; page <= IEEE802154_MAX_PAGE; page++) {
 		if (nla_put_u32(msg, NL802154_ATTR_SUPPORTED_CHANNEL,
 				rdev->wpan_phy.channels_supported[page]))
 			return -ENOBUFS;
@@ -616,7 +616,7 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
 
 	/* check 802.15.4 constraints */
-	if (page >= WPAN_NUM_PAGES || channel >= WPAN_NUM_CHANNELS)
+	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL)
 		return -EINVAL;
 
 	return rdev_set_channel(rdev, page, channel);
-- 
2.1.3

