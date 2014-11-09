Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33663 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaKIHhc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:32 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so6632732wgg.18
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:30 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/15] ieee802154: sysfs add wpan_phy index and name
Date: Sun,  9 Nov 2014 08:36:51 +0100
Message-Id: <1415518619-4370-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds new sysfs entries for wpan_phy index and name. This
needed for the new 802.15.4 userspace tool.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index 8819998..1613b9c 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -27,6 +27,27 @@ dev_to_rdev(struct device *dev)
 			    wpan_phy.dev);
 }
 
+#define SHOW_FMT(name, fmt, member)					\
+static ssize_t name ## _show(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     char *buf)					\
+{									\
+	return sprintf(buf, fmt "\n", dev_to_rdev(dev)->member);	\
+}									\
+static DEVICE_ATTR_RO(name)
+
+SHOW_FMT(index, "%d", wpan_phy_idx);
+
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct wpan_phy *wpan_phy = &dev_to_rdev(dev)->wpan_phy;
+
+	return sprintf(buf, "%s\n", dev_name(&wpan_phy->dev));
+}
+static DEVICE_ATTR_RO(name);
+
 #define MASTER_SHOW_COMPLEX(name, format_string, args...)		\
 static ssize_t name ## _show(struct device *dev,			\
 			    struct device_attribute *attr, char *buf)	\
@@ -78,6 +99,9 @@ static void wpan_phy_release(struct device *dev)
 }
 
 static struct attribute *pmib_attrs[] = {
+	&dev_attr_index.attr,
+	&dev_attr_name.attr,
+	/* below will be removed soon */
 	&dev_attr_current_channel.attr,
 	&dev_attr_current_page.attr,
 	&dev_attr_channels_supported.attr,
-- 
2.1.3

