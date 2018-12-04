Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44669 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeLDOPq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Dec 2018 09:15:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so8354749pls.11
        for <linux-wpan@vger.kernel.org>; Tue, 04 Dec 2018 06:15:46 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V4 6/6] net: lorawan: List LORAWAN in menuconfig
Date: Tue,  4 Dec 2018 22:13:43 +0800
Message-Id: <20181204141341.4353-7-starnight@g.ncu.edu.tw>
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
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
index cf2e651ee31d..03b3ff306778 100644
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
2.19.2
