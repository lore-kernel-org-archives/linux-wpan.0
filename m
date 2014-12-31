Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34451 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbaLaSjm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:39:42 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so25935117wiv.1
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:39:41 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/6] ieee802154: rename af_ieee802154.c to socket.c
Date: Wed, 31 Dec 2014 19:39:12 +0100
Message-Id: <1420051153-8673-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the "af_ieee802154.c" to "socket.c". This is just a
cleanup to have a short name for it which describes the implementationm
stuff more human understandable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile                      | 2 +-
 net/ieee802154/{af_ieee802154.c => socket.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/ieee802154/{af_ieee802154.c => socket.c} (100%)

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index e6ddfcd..88bde78 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
-ieee802154_socket-y := af_ieee802154.o
+ieee802154_socket-y := socket.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/ieee802154/af_ieee802154.c b/net/ieee802154/socket.c
similarity index 100%
rename from net/ieee802154/af_ieee802154.c
rename to net/ieee802154/socket.c
-- 
2.2.0

