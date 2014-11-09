Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48657 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaKIHhi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:38 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so6510646wgh.1
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:36 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/15] mac820154: don't set monitor dev_addr
Date: Sun,  9 Nov 2014 08:36:56 +0100
Message-Id: <1415518619-4370-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the setting of dev_addr on a monitor device. This
address should be zero. A monitor should only sniff and send raw frames
out. The address should be never used by upper layers and receiving
frame parsing.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 4630ceb..d635f36 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -416,12 +416,14 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	/* for compatibility, actual default is 3 */
 	wpan_dev->frame_retries = -1;
 
-	ieee802154_be64_to_le64(&wpan_dev->extended_addr, sdata->dev->dev_addr);
 	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
 	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
 	switch (type) {
 	case IEEE802154_DEV_WPAN:
+		ieee802154_be64_to_le64(&wpan_dev->extended_addr,
+					sdata->dev->dev_addr);
+
 		sdata->dev->header_ops = &mac802154_header_ops;
 		sdata->dev->destructor = mac802154_wpan_free;
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
-- 
2.1.3

