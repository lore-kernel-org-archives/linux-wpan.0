Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:41516 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaLTOFa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Dec 2014 09:05:30 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so3511984wgh.9
        for <linux-wpan@vger.kernel.org>; Sat, 20 Dec 2014 06:05:29 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/5] ieee802154: af802154: rename af_ieee802154 to core
Date: Sat, 20 Dec 2014 15:04:58 +0100
Message-Id: <1419084300-29069-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
References: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the af_ieee802154 file to core. This file contains
some core af802154 functionality which is used by raw and dgram socket
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/af802154/Makefile                    | 2 +-
 net/ieee802154/af802154/{af_ieee802154.c => core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/ieee802154/af802154/{af_ieee802154.c => core.c} (100%)

diff --git a/net/ieee802154/af802154/Makefile b/net/ieee802154/af802154/Makefile
index f039520..d37fd88 100644
--- a/net/ieee802154/af802154/Makefile
+++ b/net/ieee802154/af802154/Makefile
@@ -1,3 +1,3 @@
 obj-y += af_802154.o
 
-af_802154-y := af_ieee802154.o raw.o dgram.o
+af_802154-y := core.o raw.o dgram.o
diff --git a/net/ieee802154/af802154/af_ieee802154.c b/net/ieee802154/af802154/core.c
similarity index 100%
rename from net/ieee802154/af802154/af_ieee802154.c
rename to net/ieee802154/af802154/core.c
-- 
2.2.0

