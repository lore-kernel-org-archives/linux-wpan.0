Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38174 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaKYEiz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Nov 2014 23:38:55 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so11221062pde.10
        for <linux-wpan@vger.kernel.org>; Mon, 24 Nov 2014 20:38:55 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: fix spelling mistakes
Date: Tue, 25 Nov 2014 10:04:57 +0530
Message-Id: <1416890097-3643-1-git-send-email-varkab@cdac.in>
In-Reply-To: <n>
References: <n>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/ieee802154/6lowpan_rtnl.c |    2 +-
 net/ieee802154/netlink.c      |    2 +-
 net/ieee802154/nl-mac.c       |    2 +-
 net/ieee802154/nl-phy.c       |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 290e14f..16f5e91 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -597,7 +597,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 
 	entry->ldev = dev;
 
-	/* Set the lowpan harware address to the wpan hardware address. */
+	/* Set the lowpan hardware address to the wpan hardware address. */
 	memcpy(dev->dev_addr, real_dev->dev_addr, IEEE802154_ADDR_LEN);
 
 	mutex_lock(&lowpan_dev_info(dev)->dev_list_mtx);
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 63ee7d6..6ad0da3 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -1,5 +1,5 @@
 /*
- * Netlink inteface for IEEE 802.15.4 stack
+ * Netlink interface for IEEE 802.15.4 stack
  *
  * Copyright 2007, 2008 Siemens AG
  *
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index fe77f0c..1f085ed 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -1,5 +1,5 @@
 /*
- * Netlink inteface for IEEE 802.15.4 stack
+ * Netlink interface for IEEE 802.15.4 stack
  *
  * Copyright 2007, 2008 Siemens AG
  *
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 80a946d..6246354 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -1,5 +1,5 @@
 /*
- * Netlink inteface for IEEE 802.15.4 stack
+ * Netlink interface for IEEE 802.15.4 stack
  *
  * Copyright 2007, 2008 Siemens AG
  *
-- 
1.7.9.5

