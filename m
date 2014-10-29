Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50748 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbaJ2KsY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 06:48:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx10so2911670pab.40
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 03:48:24 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next v3] MAINTAINERS: add cc2520 driver maintainer
Date: Wed, 29 Oct 2014 16:15:22 +0530
Message-Id: <1414579522-10568-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch adds maintainer for cc2520 radio driver

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15867a6..7ec37a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2302,6 +2302,14 @@ F:	security/capability.c
 F:	security/commoncap.c
 F:	kernel/capability.c
 
+CC2520 IEEE-802.15.4 RADIO DRIVER
+M:	Varka Bhadram <varkabhadram@gmail.com>
+L:	linux-wpan@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ieee802154/cc2520.c
+F:	include/linux/spi/cc2520.h
+F:	Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
+
 CELL BROADBAND ENGINE ARCHITECTURE
 M:	Arnd Bergmann <arnd@arndb.de>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
1.7.9.5

