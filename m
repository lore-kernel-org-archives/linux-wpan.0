Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33114 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaKETwZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:25 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so3084464wiv.8
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:24 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 17/18] mac802154: use IEEE802154_EXTENDED_ADDR_LEN
Date: Wed,  5 Nov 2014 20:51:28 +0100
Message-Id: <1415217089-24919-18-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the af_ieee802154 defines and use the
IEEE802154_EXTENDED_ADDR_LEN. We should do this everywhere in the
802.15.4 subsystem because af_ieee802154 should be normally an uapi
header.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 97e5bed..51abe05 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -24,7 +24,6 @@
 
 #include <net/rtnetlink.h>
 #include <linux/nl802154.h>
-#include <net/af_ieee802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/cfg802154.h>
@@ -384,8 +383,8 @@ static void mac802154_wpan_free(struct net_device *dev)
 
 static void ieee802154_if_setup(struct net_device *dev)
 {
-	dev->addr_len		= IEEE802154_ADDR_LEN;
-	memset(dev->broadcast, 0xff, IEEE802154_ADDR_LEN);
+	dev->addr_len		= IEEE802154_EXTENDED_ADDR_LEN;
+	memset(dev->broadcast, 0xff, IEEE802154_EXTENDED_ADDR_LEN);
 
 	dev->hard_header_len	= MAC802154_FRAME_HARD_HEADER_LEN;
 	dev->needed_tailroom	= 2 + 16; /* FCS + MIC */
-- 
2.1.3

