Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57669 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbADQLL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Jan 2015 11:11:11 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so26320648wgh.1
        for <linux-wpan@vger.kernel.org>; Sun, 04 Jan 2015 08:11:10 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/5] ieee802154: create 6lowpan sub-directory
Date: Sun,  4 Jan 2015 17:10:53 +0100
Message-Id: <1420387857-32029-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
References: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch creates an 6lowpan sub-directory inside ieee802154.
Additional we move all ieee802154 6lowpan relevant files into
this sub-directory instead of placing the 6lowpan related files
inside ieee802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c | 0
 net/ieee802154/6lowpan/Kconfig              | 5 +++++
 net/ieee802154/6lowpan/Makefile             | 3 +++
 net/ieee802154/{ => 6lowpan}/reassembly.c   | 0
 net/ieee802154/{ => 6lowpan}/reassembly.h   | 0
 net/ieee802154/Kconfig                      | 6 +-----
 net/ieee802154/Makefile                     | 3 +--
 7 files changed, 10 insertions(+), 7 deletions(-)
 rename net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c (100%)
 create mode 100644 net/ieee802154/6lowpan/Kconfig
 create mode 100644 net/ieee802154/6lowpan/Makefile
 rename net/ieee802154/{ => 6lowpan}/reassembly.c (100%)
 rename net/ieee802154/{ => 6lowpan}/reassembly.h (100%)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan/6lowpan_rtnl.c
similarity index 100%
rename from net/ieee802154/6lowpan_rtnl.c
rename to net/ieee802154/6lowpan/6lowpan_rtnl.c
diff --git a/net/ieee802154/6lowpan/Kconfig b/net/ieee802154/6lowpan/Kconfig
new file mode 100644
index 0000000..d24f985
--- /dev/null
+++ b/net/ieee802154/6lowpan/Kconfig
@@ -0,0 +1,5 @@
+config IEEE802154_6LOWPAN
+	tristate "6lowpan support over IEEE 802.15.4"
+	depends on 6LOWPAN
+	---help---
+	  IPv6 compression over IEEE 802.15.4.
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
diff --git a/net/ieee802154/Kconfig b/net/ieee802154/Kconfig
index 9ea0af4..1370d5b 100644
--- a/net/ieee802154/Kconfig
+++ b/net/ieee802154/Kconfig
@@ -20,10 +20,6 @@ config IEEE802154_SOCKET
 	  for 802.15.4 dataframes. Also RAW socket interface to build MAC
 	  header from userspace.
 
-config IEEE802154_6LOWPAN
-	tristate "6lowpan support over IEEE 802.15.4"
-	depends on 6LOWPAN
-	---help---
-	  IPv6 compression over IEEE 802.15.4.
+source "net/ieee802154/6lowpan/Kconfig"
 
 endif
diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 88bde78..3653397 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -1,8 +1,7 @@
 obj-$(CONFIG_IEEE802154) += ieee802154.o
 obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
-obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
+obj-$(CONFIG_IEEE802154_6LOWPAN) += 6lowpan/
 
-ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
 ieee802154_socket-y := socket.o
-- 
2.2.1

