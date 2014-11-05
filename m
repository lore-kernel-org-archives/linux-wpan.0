Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:57279 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaKETwW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:22 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so12408886wiv.4
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:21 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/18] mac802154: add support for perm_extended_addr
Date: Wed,  5 Nov 2014 20:51:25 +0100
Message-Id: <1415217089-24919-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adding support for a perm extended address. This is useful
when a device supports an eeprom with a programmed static extended address.
If a device doesn't support such eeprom or serial registers then the
driver should generate a random extended address.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h | 2 ++
 net/mac802154/iface.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 57333f1..9d99b96 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -57,6 +57,8 @@ struct wpan_phy {
 	u8 csma_retries;
 	s8 frame_retries;
 
+	__le64 perm_extended_addr;
+
 	bool lbt;
 	s32 cca_ed_level;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index a1aa09b..97e5bed 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -410,6 +410,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	/* for compatibility, actual default is 3 */
 	sdata->mac_params.frame_retries = -1;
 
+	ieee802154_be64_to_le64(&sdata->extended_addr, sdata->dev->dev_addr);
 	sdata->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
 	sdata->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
@@ -471,6 +472,9 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		goto err;
 	}
 
+	ieee802154_le64_to_be64(ndev->perm_addr,
+				&local->hw.phy->perm_extended_addr);
+	memcpy(ndev->dev_addr, ndev->perm_addr, IEEE802154_EXTENDED_ADDR_LEN);
 	/* TODO check this */
 	SET_NETDEV_DEV(ndev, &local->phy->dev);
 	sdata = netdev_priv(ndev);
-- 
2.1.3

