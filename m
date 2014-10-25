Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42234 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaJYSjr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:39:47 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so3931052lbv.26
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:39:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 7/7] MAINTAINERS: add missing headers in 802.15.4
Date: Sat, 25 Oct 2014 09:25:05 +0200
Message-Id: <1414221905-19422-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414221905-19422-1-git-send-email-alex.aring@gmail.com>
References: <1414221905-19422-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a lot of include headers which are missing by the
current IEEE 802.15.4 subsystem.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43898b1..15867a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4689,6 +4689,13 @@ S:	Maintained
 F:	net/ieee802154/
 F:	net/mac802154/
 F:	drivers/net/ieee802154/
+F:	include/linux/nl802154.h
+F:	include/linux/ieee802154.h
+F:	include/net/nl802154.h
+F:	include/net/mac802154.h
+F:	include/net/af_ieee802154.h
+F:	include/net/cfg802154.h
+F:	include/net/ieee802154_netdev.h
 F:	Documentation/networking/ieee802154.txt
 
 IGUANAWORKS USB IR TRANSCEIVER
-- 
2.1.2

