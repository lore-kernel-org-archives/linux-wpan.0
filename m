Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:64660 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaKBUn2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:28 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so9801661wgh.14
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:27 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/6] mac802154: cfg: add missing include
Date: Sun,  2 Nov 2014 21:43:05 +0100
Message-Id: <1414960986-7051-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Running make C=2 occurs warning:

symbol 'mac802154_config_ops' was not declared. Should it be static?

This patch adds a missing include in cfg.c to solve this warning.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/mac802154/cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 75a5d25..0c69b44 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -16,6 +16,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "cfg.h"
 
 static struct net_device *
 ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
-- 
2.1.3

