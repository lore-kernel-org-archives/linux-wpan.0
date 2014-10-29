Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:50523 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465AbaJ2Ifg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 04:35:36 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so2693085pab.36
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 01:35:35 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next v2] MAINTAINERS: add cc2520 driver maintainer
Date: Wed, 29 Oct 2014 14:02:33 +0530
Message-Id: <1414571553-9567-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch adds maintainer for cc2520 radio driver.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15867a6..43dc166 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4698,6 +4698,14 @@ F:	include/net/cfg802154.h
 F:	include/net/ieee802154_netdev.h
 F:	Documentation/networking/ieee802154.txt
 
+CC2520 IEEE-802.15.4 RADIO DRIVER
+M:	Varka Bhadram <varkabhadram@gmail.com>
+L:	linux-wpan@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ieee802154/cc2520.c
+F:	include/linux/spi/cc2520.h
+F:	Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
+
 IGUANAWORKS USB IR TRANSCEIVER
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
1.7.9.5

