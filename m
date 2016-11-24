Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36730 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965723AbcKXN7P (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Nov 2016 08:59:15 -0500
From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] net: ieee802154: drop duplicate header delay.h
Date: Thu, 24 Nov 2016 21:58:32 +0800
Message-Id: <f64943b9c1da12b6199ba745ba04cb477a05a5a3.1479991128.git.geliangtang@gmail.com>
In-Reply-To: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
References: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <aar@pengutronix.de>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Drop duplicate header delay.h from adf7242.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/net/ieee802154/adf7242.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 4ff4c7d..3e4c8b2 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -20,7 +20,6 @@
 #include <linux/skbuff.h>
 #include <linux/of.h>
 #include <linux/irq.h>
-#include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/bitops.h>
 #include <linux/ieee802154.h>
-- 
2.9.3

