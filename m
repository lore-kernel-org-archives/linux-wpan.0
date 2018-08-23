Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36639 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeHWUuN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Aug 2018 16:50:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so3119918pfo.3
        for <linux-wpan@vger.kernel.org>; Thu, 23 Aug 2018 10:19:32 -0700 (PDT)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 3/3 net] lorawan: List LORAWAN in menuconfig
Date: Fri, 24 Aug 2018 01:15:43 +0800
Message-Id: <cd021897a590ee57605a497b23e7ea9341889aef.1535039998.git.starnight@g.ncu.edu.tw>
In-Reply-To: <cover.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "contact@snootlab.com" <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>

List LORAWAN in menuconfig and enable it to be built.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 net/Kconfig  | 1 +
 net/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 053b36998c18..499c931ba0fa 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -224,6 +224,7 @@ source "net/6lowpan/Kconfig"
 source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/lora/Kconfig"
+source "net/maclorawan/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
 source "net/dns_resolver/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index e80b84313851..5341d0e23586 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
 obj-$(CONFIG_IEEE802154)	+= ieee802154/
 obj-$(CONFIG_MAC802154)		+= mac802154/
 obj-$(CONFIG_LORA)		+= lora/
+obj-$(CONFIG_LORAWAN)		+= maclorawan/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
-- 
2.18.0
