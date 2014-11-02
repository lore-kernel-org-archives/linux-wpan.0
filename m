Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:50096 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaKBUn1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:27 -0500
Received: by mail-wi0-f173.google.com with SMTP id n3so4975552wiv.6
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:26 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/6] ieee802154: sysfs: add missing include
Date: Sun,  2 Nov 2014 21:43:04 +0100
Message-Id: <1414960986-7051-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Running make C=2 occurs in warnings:

symbol 'wpan_phy_class' was not declared. Should it be static?
symbol 'wpan_phy_sysfs_init' was not declared. Should it be static?
symbol 'wpan_phy_sysfs_exit' wasnot declared. Should it be static?

This patch adds a missing include "sysfs.h" to solve these warnings.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/ieee802154/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index c6e0380..8819998 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -18,6 +18,7 @@
 #include <net/cfg802154.h>
 
 #include "core.h"
+#include "sysfs.h"
 
 static inline struct cfg802154_registered_device *
 dev_to_rdev(struct device *dev)
-- 
2.1.3

