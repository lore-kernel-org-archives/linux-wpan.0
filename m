Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:52065 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcK3ODh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 09:03:37 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 1/5] ieee802154: check device type
Date: Wed, 30 Nov 2016 15:03:21 +0100
Message-Id: <1480514605-30926-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
References: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, Lennert Buytenhek <buytenh@wantstofly.org>, Alexander Aring <alex.aring@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sergey Lapin <slapin@ossfans.org>, Stefan Schmidt <stefan@osg.samsung.com>

From: "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>

I've observed a NULL pointer dereference in ieee802154_del_iface() during
netlink fuzzing. It's the ->wpan_phy dereference here:

        phy = dev->ieee802154_ptr->wpan_phy;

My bet is that we're not checking that this is an IEEE802154 interface,
so let's do what ieee802154_nl_get_dev() is doing. (Maybe we should even
be calling this directly?)

Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Sergey Lapin <slapin@ossfans.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Acked-by: Alexander Aring <aar@pengutronix.de>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/ieee802154/nl-phy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 77d7301..dc2960b 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -286,9 +286,12 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 	if (name[nla_len(info->attrs[IEEE802154_ATTR_DEV_NAME]) - 1] != '\0')
 		return -EINVAL; /* name should be null-terminated */
 
+	rc = -ENODEV;
 	dev = dev_get_by_name(genl_info_net(info), name);
 	if (!dev)
-		return -ENODEV;
+		return rc;
+	if (dev->type != ARPHRD_IEEE802154)
+		goto out;
 
 	phy = dev->ieee802154_ptr->wpan_phy;
 	BUG_ON(!phy);
@@ -342,6 +345,7 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(msg);
 out_dev:
 	wpan_phy_put(phy);
+out:
 	if (dev)
 		dev_put(dev);
 
-- 
2.5.5

