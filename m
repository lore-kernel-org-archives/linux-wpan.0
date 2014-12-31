Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:49246 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaLaSji (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:39:38 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so4570948wgg.12
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:39:37 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/6] ieee802154: socket: change module name
Date: Wed, 31 Dec 2014 19:39:09 +0100
Message-Id: <1420051153-8673-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the module name of af_802154 to ieee802154_socket.
Just for keeping the name convention according to the 6LoWPAN module
ieee802154_6lowpan.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 53612d1..19b2bec 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -1,10 +1,10 @@
 obj-$(CONFIG_IEEE802154) += ieee802154.o
-obj-$(CONFIG_IEEE802154_SOCKET) += af_802154.o
+obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
 obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o sysfs.o nl802154.o
-af_802154-y := af_ieee802154.o raw.o dgram.o
+ieee802154_socket-y := af_ieee802154.o raw.o dgram.o
 
 ccflags-y += -D__CHECK_ENDIAN__
-- 
2.2.0

