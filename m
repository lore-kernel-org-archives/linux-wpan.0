Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35848 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaJYSpn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:45:43 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so3938683lbv.24
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:45:42 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 5/7] ieee802154: move wpan-class.c to core.c
Date: Sat, 25 Oct 2014 09:41:03 +0200
Message-Id: <1414222865-1692-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
References: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Like the wireless core.c file this file contains function for phy
allocation and freeing. Move this file to core.c to get similar
behaviour.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile                 | 2 +-
 net/ieee802154/{wpan-class.c => core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/ieee802154/{wpan-class.c => core.c} (100%)

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 3914b1e..e58c4cb 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_IEEE802154) += ieee802154.o af_802154.o
 obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
-ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o wpan-class.o \
+ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
                 header_ops.o
 af_802154-y := af_ieee802154.o raw.o dgram.o
 
diff --git a/net/ieee802154/wpan-class.c b/net/ieee802154/core.c
similarity index 100%
rename from net/ieee802154/wpan-class.c
rename to net/ieee802154/core.c
-- 
2.1.2

