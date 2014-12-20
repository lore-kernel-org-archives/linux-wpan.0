Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61280 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaLTOFb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Dec 2014 09:05:31 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so3497067wgg.0
        for <linux-wpan@vger.kernel.org>; Sat, 20 Dec 2014 06:05:30 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/5] ieee802154: create 6lowpan sub-directory
Date: Sat, 20 Dec 2014 15:04:59 +0100
Message-Id: <1419084300-29069-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
References: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch creates an 6lowpan sub-directory inside ieee802154.
Additional we move all ieee802154 6lowpan relevant files into
this sub-directory instead of placeing the 6lowpan related files
inside ieee802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c | 0
 net/ieee802154/6lowpan/Makefile             | 3 +++
 net/ieee802154/{ => 6lowpan}/reassembly.c   | 0
 net/ieee802154/{ => 6lowpan}/reassembly.h   | 0
 net/ieee802154/Makefile                     | 3 +--
 5 files changed, 4 insertions(+), 2 deletions(-)
 rename net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c (100%)
 create mode 100644 net/ieee802154/6lowpan/Makefile
 rename net/ieee802154/{ => 6lowpan}/reassembly.c (100%)
 rename net/ieee802154/{ => 6lowpan}/reassembly.h (100%)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan/6lowpan_rtnl.c
similarity index 100%
rename from net/ieee802154/6lowpan_rtnl.c
rename to net/ieee802154/6lowpan/6lowpan_rtnl.c
diff --git a/net/ieee802154/6lowpan/Makefile b/net/ieee802154/6lowpan/Makefile
new file mode 100644
index 0000000..936959b
--- /dev/null
+++ b/net/ieee802154/6lowpan/Makefile
@@ -0,0 +1,3 @@
+obj-y += ieee802154_6lowpan.o
+
+ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
similarity index 100%
rename from net/ieee802154/reassembly.c
rename to net/ieee802154/6lowpan/reassembly.c
diff --git a/net/ieee802154/reassembly.h b/net/ieee802154/6lowpan/reassembly.h
similarity index 100%
rename from net/ieee802154/reassembly.h
rename to net/ieee802154/6lowpan/reassembly.h
diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 9f88d1b..5af3d7e 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -1,7 +1,6 @@
 obj-$(CONFIG_IEEE802154) += ieee802154.o af802154/
-obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
+obj-$(CONFIG_IEEE802154_6LOWPAN) += 6lowpan/
 
-ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
 
-- 
2.2.0

