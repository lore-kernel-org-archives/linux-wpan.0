Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36874 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932477AbeBLDvO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 11 Feb 2018 22:51:14 -0500
Received: by mail-io0-f195.google.com with SMTP id f89so15848878ioj.4
        for <linux-wpan@vger.kernel.org>; Sun, 11 Feb 2018 19:51:13 -0800 (PST)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan-next] ieee802154: 6lowpan: set IFF_NO_QUEUE
Date: Sun, 11 Feb 2018 22:50:46 -0500
Message-Id: <20180212035046.11550-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch sets the IFF_NO_QUEUE for IEEE 802.15.4 6lowpan interfaces. As
commit 24dcbf662205 ("6lowpan: Don't set IFF_NO_QUEUE") removes it for
"reasons" from the bluetooth 6lowpan subsystem. In IEEE 802.15.4 the lower
interface deals with one qdisc for the real hardware, 6LoWPAN does the
protocol adaption only and no second queuing on top.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 net/ieee802154/6lowpan/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 974765b7d92a..e4f305320519 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -104,6 +104,7 @@ static void lowpan_setup(struct net_device *ldev)
 	/* We need an ipv6hdr as minimum len when calling xmit */
 	ldev->hard_header_len	= sizeof(struct ipv6hdr);
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
+	ldev->priv_flags	|= IFF_NO_QUEUE;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->header_ops	= &lowpan_header_ops;
-- 
2.11.0

