Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:45621 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbbCBOKd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 09:10:33 -0500
Received: by wesp10 with SMTP id p10so31350168wes.12
        for <linux-wpan@vger.kernel.org>; Mon, 02 Mar 2015 06:10:31 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: remove deprecated sysfs entries
Date: Mon,  2 Mar 2015 15:10:05 +0100
Message-Id: <1425305405-30706-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
References: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

It's only necessary to offer the name and index, others value are
available over netlink.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/sysfs.c | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index dff55c2..133b428 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -48,49 +48,6 @@ static ssize_t name_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name);
 
-#define MASTER_SHOW_COMPLEX(name, format_string, args...)		\
-static ssize_t name ## _show(struct device *dev,			\
-			    struct device_attribute *attr, char *buf)	\
-{									\
-	struct wpan_phy *phy = container_of(dev, struct wpan_phy, dev);	\
-	int ret;							\
-									\
-	mutex_lock(&phy->pib_lock);					\
-	ret = snprintf(buf, PAGE_SIZE, format_string "\n", args);	\
-	mutex_unlock(&phy->pib_lock);					\
-	return ret;							\
-}									\
-static DEVICE_ATTR_RO(name)
-
-#define MASTER_SHOW(field, format_string)				\
-	MASTER_SHOW_COMPLEX(field, format_string, phy->field)
-
-MASTER_SHOW(current_channel, "%d");
-MASTER_SHOW(current_page, "%d");
-MASTER_SHOW(transmit_power, "%d +- 1 dB");
-MASTER_SHOW_COMPLEX(cca_mode, "%d", phy->cca.mode);
-
-static ssize_t channels_supported_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct wpan_phy *phy = container_of(dev, struct wpan_phy, dev);
-	int ret;
-	int i, len = 0;
-
-	mutex_lock(&phy->pib_lock);
-	for (i = 0; i < 32; i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len,
-			       "%#09x\n", phy->channels_supported[i]);
-		if (ret < 0)
-			break;
-		len += ret;
-	}
-	mutex_unlock(&phy->pib_lock);
-	return len;
-}
-static DEVICE_ATTR_RO(channels_supported);
-
 static void wpan_phy_release(struct device *dev)
 {
 	struct cfg802154_registered_device *rdev = dev_to_rdev(dev);
@@ -101,12 +58,6 @@ static void wpan_phy_release(struct device *dev)
 static struct attribute *pmib_attrs[] = {
 	&dev_attr_index.attr,
 	&dev_attr_name.attr,
-	/* below will be removed soon */
-	&dev_attr_current_channel.attr,
-	&dev_attr_current_page.attr,
-	&dev_attr_channels_supported.attr,
-	&dev_attr_transmit_power.attr,
-	&dev_attr_cca_mode.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(pmib);
-- 
2.3.0

