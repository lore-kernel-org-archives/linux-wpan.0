Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33114 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030231AbbDWQsd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:33 -0400
Received: by wgin8 with SMTP id n8so24785167wgi.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:32 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 03/15] ieee802154: move validation check out of softmac
Date: Thu, 23 Apr 2015 18:47:42 +0200
Message-Id: <1429807674-24849-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the value validation out of softmac layer. after
calling rdev-ops we need to be sure now that this value is accepted by
the transceiver/mac802154 or "possible" hardmac drivers.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 28 +++++++++++++++++++++++++++-
 net/mac802154/cfg.c       | 29 -----------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 9de427d..e19f218 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -625,7 +625,8 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
 
 	/* check 802.15.4 constraints */
-	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL)
+	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL ||
+	    !(rdev->wpan_phy.channels_supported[page] & BIT(channel)))
 		return -EINVAL;
 
 	return rdev_set_channel(rdev, page, channel);
@@ -674,6 +675,16 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 
 	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
 
+	/* TODO
+	 * I am not sure about to check here on broadcast pan_id.
+	 * Broadcast is a valid setting, comment from 802.15.4:
+	 * If this value is 0xffff, the device is not associated.
+	 *
+	 * This could useful to simple deassociate an device.
+	 */
+	if (pan_id == cpu_to_le16(IEEE802154_PAN_ID_BROADCAST))
+		return -EINVAL;
+
 	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
 }
 
@@ -695,6 +706,21 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 
 	short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
 
+	/* TODO
+	 * I am not sure about to check here on broadcast short_addr.
+	 * Broadcast is a valid setting, comment from 802.15.4:
+	 * A value of 0xfffe indicates that the device has
+	 * associated but has not been allocated an address. A
+	 * value of 0xffff indicates that the device does not
+	 * have a short address.
+	 *
+	 * I think we should allow to set these settings but
+	 * don't allow to allow socket communication with it.
+	 */
+	if (short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC) ||
+	    short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST))
+		return -EINVAL;
+
 	return rdev_set_short_addr(rdev, wpan_dev, short_addr);
 }
 
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 5d9f68c..e53aec9 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -70,10 +70,6 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 
 	ASSERT_RTNL();
 
-	/* check if phy support this setting */
-	if (!(wpan_phy->channels_supported[page] & BIT(channel)))
-		return -EINVAL;
-
 	ret = drv_set_channel(local, page, channel);
 	if (!ret) {
 		wpan_phy->current_page = page;
@@ -109,16 +105,6 @@ ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
-	/* TODO
-	 * I am not sure about to check here on broadcast pan_id.
-	 * Broadcast is a valid setting, comment from 802.15.4:
-	 * If this value is 0xffff, the device is not associated.
-	 *
-	 * This could useful to simple deassociate an device.
-	 */
-	if (pan_id == cpu_to_le16(IEEE802154_PAN_ID_BROADCAST))
-		return -EINVAL;
-
 	wpan_dev->pan_id = pan_id;
 	return 0;
 }
@@ -146,21 +132,6 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
-	/* TODO
-	 * I am not sure about to check here on broadcast short_addr.
-	 * Broadcast is a valid setting, comment from 802.15.4:
-	 * A value of 0xfffe indicates that the device has
-	 * associated but has not been allocated an address. A
-	 * value of 0xffff indicates that the device does not
-	 * have a short address.
-	 *
-	 * I think we should allow to set these settings but
-	 * don't allow to allow socket communication with it.
-	 */
-	if (short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC) ||
-	    short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST))
-		return -EINVAL;
-
 	wpan_dev->short_addr = short_addr;
 	return 0;
 }
-- 
2.3.6

