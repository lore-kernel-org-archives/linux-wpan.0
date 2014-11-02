Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38566 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbaKBDT0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:26 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so3997201wiv.13
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:25 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/16] mac802154: iface: add validation for extended address
Date: Sun,  2 Nov 2014 04:18:46 +0100
Message-Id: <1414898327-20759-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch use the validation function to check if an extended address
is valid or not while set the extended address.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index eaad665..ceedf3e 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -112,13 +112,17 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct sockaddr *addr = p;
+	__le64 extended_addr;
 
 	if (netif_running(dev))
 		return -EBUSY;
 
-	/* FIXME: validate addr */
+	extended_addr = ieee802154_netdev_to_extended_addr(addr->sa_data);
+	if (!ieee802154_is_valid_extended_addr(extended_addr))
+		return -EINVAL;
+
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
-	sdata->extended_addr = ieee802154_netdev_to_extended_addr(dev->dev_addr);
+	sdata->extended_addr = extended_addr;
 
 	return mac802154_wpan_update_llsec(dev);
 }
-- 
2.1.3

