Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:33056 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbAHKaU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Jan 2015 05:30:20 -0500
Received: by mail-we0-f169.google.com with SMTP id m14so1668677wev.0
        for <linux-wpan@vger.kernel.org>; Thu, 08 Jan 2015 02:30:18 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: 6lowpan: fix Makefile entry
Date: Thu,  8 Jan 2015 11:30:10 +0100
Message-Id: <1420713010-16105-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Since commit ea81ac2e7050798109356150ea16e71622a5c329 ("ieee802154:
create 6lowpan sub-directory") we have a subdirectory for the ieee802154
6lowpan implementation. This commit also moves the Kconfig entry inside
of net/ieee802154/6lowpan/ and forgot to rename the Makefile entry from
obj-$(CONFIG_IEEE802154_6LOWPAN) to obj-y and handle the
obj-$(CONFIG_IEEE802154_6LOWPAN) inside the created 6lowpan directory.
This will occur that the ieee802154_6lowpan can't be build.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/Makefile | 2 +-
 net/ieee802154/Makefile         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/Makefile b/net/ieee802154/6lowpan/Makefile
index 2f1b75a..6bfb270 100644
--- a/net/ieee802154/6lowpan/Makefile
+++ b/net/ieee802154/6lowpan/Makefile
@@ -1,3 +1,3 @@
-obj-y += ieee802154_6lowpan.o
+obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := core.o rx.o reassembly.o tx.o
diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 3653397..05dab29 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_IEEE802154) += ieee802154.o
 obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
-obj-$(CONFIG_IEEE802154_6LOWPAN) += 6lowpan/
+obj-y += 6lowpan/
 
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
-- 
2.2.1

