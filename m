Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:42190 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbaKBDT1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:27 -0400
Received: by mail-wi0-f176.google.com with SMTP id h11so3992352wiw.9
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:26 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/16] ieee802154: 6lowpan: remove set of mac address
Date: Sun,  2 Nov 2014 04:18:47 +0100
Message-Id: <1414898327-20759-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Currently the ieee802154 6lowpan interface operates on wpan interfaces
only. Setting the wpan mac address over 6lowpan interface is complex and
maybe we can't never do this. This patch removes the set of mac address
handling in ieee802154 6lowpan interface for now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 519a654..659f7b2 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -206,19 +206,6 @@ drop:
 	return -EINVAL;
 }
 
-static int lowpan_set_address(struct net_device *dev, void *p)
-{
-	struct sockaddr *sa = p;
-
-	if (netif_running(dev))
-		return -EBUSY;
-
-	/* TODO: validate addr */
-	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
-
-	return 0;
-}
-
 static struct sk_buff*
 lowpan_alloc_frag(struct sk_buff *skb, int size,
 		  const struct ieee802154_hdr *master_hdr)
@@ -474,7 +461,6 @@ static int lowpan_dev_init(struct net_device *dev)
 static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_init		= lowpan_dev_init,
 	.ndo_start_xmit		= lowpan_xmit,
-	.ndo_set_mac_address	= lowpan_set_address,
 };
 
 static struct ieee802154_mlme_ops lowpan_mlme = {
-- 
2.1.3

