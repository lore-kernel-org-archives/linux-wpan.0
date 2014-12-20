Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54101 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaLTOF2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Dec 2014 09:05:28 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so4413936wiv.6
        for <linux-wpan@vger.kernel.org>; Sat, 20 Dec 2014 06:05:27 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/5] ieee802154: create af802154 sub-directory
Date: Sat, 20 Dec 2014 15:04:56 +0100
Message-Id: <1419084300-29069-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
References: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch creates an af802154 sub-directory inside ieee802154.
Additional we move all af802154 relevant files into this sub-directory
instead of placeing the address family files inside ieee802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile                       | 3 +--
 net/ieee802154/af802154/Makefile              | 3 +++
 net/ieee802154/{ => af802154}/af802154.h      | 0
 net/ieee802154/{ => af802154}/af_ieee802154.c | 0
 net/ieee802154/{ => af802154}/dgram.c         | 0
 net/ieee802154/{ => af802154}/raw.c           | 0
 6 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 net/ieee802154/af802154/Makefile
 rename net/ieee802154/{ => af802154}/af802154.h (100%)
 rename net/ieee802154/{ => af802154}/af_ieee802154.c (100%)
 rename net/ieee802154/{ => af802154}/dgram.c (100%)
 rename net/ieee802154/{ => af802154}/raw.c (100%)

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 9f6970f..9f88d1b 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -1,9 +1,8 @@
-obj-$(CONFIG_IEEE802154) += ieee802154.o af_802154.o
+obj-$(CONFIG_IEEE802154) += ieee802154.o af802154/
 obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
-af_802154-y := af_ieee802154.o raw.o dgram.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/ieee802154/af802154/Makefile b/net/ieee802154/af802154/Makefile
new file mode 100644
index 0000000..f039520
--- /dev/null
+++ b/net/ieee802154/af802154/Makefile
@@ -0,0 +1,3 @@
+obj-y += af_802154.o
+
+af_802154-y := af_ieee802154.o raw.o dgram.o
diff --git a/net/ieee802154/af802154.h b/net/ieee802154/af802154/af802154.h
similarity index 100%
rename from net/ieee802154/af802154.h
rename to net/ieee802154/af802154/af802154.h
diff --git a/net/ieee802154/af_ieee802154.c b/net/ieee802154/af802154/af_ieee802154.c
similarity index 100%
rename from net/ieee802154/af_ieee802154.c
rename to net/ieee802154/af802154/af_ieee802154.c
diff --git a/net/ieee802154/dgram.c b/net/ieee802154/af802154/dgram.c
similarity index 100%
rename from net/ieee802154/dgram.c
rename to net/ieee802154/af802154/dgram.c
diff --git a/net/ieee802154/raw.c b/net/ieee802154/af802154/raw.c
similarity index 100%
rename from net/ieee802154/raw.c
rename to net/ieee802154/af802154/raw.c
-- 
2.2.0

