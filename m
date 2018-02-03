Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54888 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbeBCUvZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Feb 2018 15:51:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so19125132wmi.4
        for <linux-wpan@vger.kernel.org>; Sat, 03 Feb 2018 12:51:24 -0800 (PST)
Received: from xue-ThinkPad-T470s.fritz.box (ipservice-092-218-175-186.092.218.pools.vodafone-ip.de. [92.218.175.186])
        by smtp.gmail.com with ESMTPSA id w17sm4503584eda.96.2018.02.03.12.51.22
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Feb 2018 12:51:22 -0800 (PST)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCH 2/3] ieee802154: Add entry in MAINTAINTERS for MCR20a driver
Date: Sat,  3 Feb 2018 21:51:13 +0100
Message-Id: <1517691074-20306-3-git-send-email-liuxuenetmail@gmail.com>
In-Reply-To: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
References: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e262e23..275e389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8555,6 +8555,14 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4531.c
 
+MCR20A IEEE-802.15.4 RADIO DRIVER
+M:	Xue Liu <liuxuenetmail@gmail.com>
+L:	linux-wpan@vger.kernel.org
+W:	https://github.com/xueliu/mcr20a-linux
+S:	Maintained
+F:	drivers/net/ieee802154/mcr20a.c
+F:	Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
+
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.7.4

