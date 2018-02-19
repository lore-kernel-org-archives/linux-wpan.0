Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39584 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeBSKvZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 05:51:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id 191so7201801wmm.4
        for <linux-wpan@vger.kernel.org>; Mon, 19 Feb 2018 02:51:24 -0800 (PST)
Received: from xue-ThinkPad-T470s.kelle.grp (p578b164d.dip0.t-ipconnect.de. [87.139.22.77])
        by smtp.gmail.com with ESMTPSA id f19sm7210097edd.84.2018.02.19.02.51.22
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 02:51:23 -0800 (PST)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCHv2 2/3] ieee802154: Add entry in MAINTAINTERS for MCR20a driver
Date: Mon, 19 Feb 2018 11:51:10 +0100
Message-Id: <1519037471-17668-3-git-send-email-liuxuenetmail@gmail.com>
In-Reply-To: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e262e23..497efe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8555,6 +8555,15 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4531.c
 
+MCR20A IEEE-802.15.4 RADIO DRIVER
+M:	Xue Liu <liuxuenetmail@gmail.com>
+L:	linux-wpan@vger.kernel.org
+W:	https://github.com/xueliu/mcr20a-linux
+S:	Maintained
+F:	drivers/net/ieee802154/mcr20a.c
+F:	drivers/net/ieee802154/mcr20a.h
+F:	Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
+
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.7.4

