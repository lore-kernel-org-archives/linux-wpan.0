Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbeKOCHa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 14 Nov 2018 21:07:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id y6-v6so425256plt.3
        for <linux-wpan@vger.kernel.org>; Wed, 14 Nov 2018 08:03:40 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V3 7/7] net: lorawan: List LORAWAN in menuconfig
Date: Thu, 15 Nov 2018 00:01:28 +0800
Message-Id: <20181114160126.4445-8-starnight@g.ncu.edu.tw>
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>, Jian-Hong Pan <starnight@g.ncu.edu.tw>

List LORAWAN and MACLORAWAN in menuconfig and make they can be built.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules

 net/Kconfig  | 2 ++
 net/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 053b36998c18..b12b8bed6abb 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -224,6 +224,8 @@ source "net/6lowpan/Kconfig"
 source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/lora/Kconfig"
+source "net/lorawan/Kconfig"
+source "net/maclorawan/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
 source "net/dns_resolver/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index e80b84313851..9d5515965a8f 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
 obj-$(CONFIG_IEEE802154)	+= ieee802154/
 obj-$(CONFIG_MAC802154)		+= mac802154/
 obj-$(CONFIG_LORA)		+= lora/
+obj-$(CONFIG_LORAWAN)		+= lorawan/
+obj-$(CONFIG_MACLORAWAN)	+= maclorawan/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
-- 
2.19.1
