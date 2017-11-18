Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from msr14.hinet.net ([168.95.4.114]:38923 "EHLO msr14.hinet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424359AbdKRR2M (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 18 Nov 2017 12:28:12 -0500
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH] doc: linux-wpan: Fulfill the description of missed 802.15.4 APIs
Date: Sat, 18 Nov 2017 23:55:01 +0800
Message-Id: <20171118155501.14148-1-starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Jonathan Corbet <corbet@lwn.net>, linux-wpan@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>

There are more functions and operations which must be used or implemented
in each IEEE 802.15.4 device driver, but are not mentioned in the Device
drivers API section of Documentation/networking/ieee802154.txt.  Therefore,
I want to fulfill the missed part into the documentation with this patch.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 Documentation/networking/ieee802154.txt | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
index 057e9fdbfac9..e74d8e1da0e2 100644
--- a/Documentation/networking/ieee802154.txt
+++ b/Documentation/networking/ieee802154.txt
@@ -97,6 +97,46 @@ The include/net/mac802154.h defines following functions:
  - void ieee802154_unregister_hw(struct ieee802154_hw *hw):
    freeing registered PHY
 
+ - void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
+                              u8 lqi):
+   telling 802.15.4 module there is a new received frame in the skb with
+   the RF Link Quality Indicator (LQI) from the hardware device
+
+ - void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
+                                 bool ifs_handling):
+   telling 802.15.4 module the frame in the skb is or going to be
+   transmitted through the hardware device
+
+The device driver must implement the following callbacks in the IEEE 802.15.4
+operations structure at least:
+struct ieee802154_ops {
+	...
+	int	(*start)(struct ieee802154_hw *hw);
+	void	(*stop)(struct ieee802154_hw *hw);
+	...
+	int	(*xmit_async)(struct ieee802154_hw *hw, struct sk_buff *skb);
+	int	(*ed)(struct ieee802154_hw *hw, u8 *level);
+	int	(*set_channel)(struct ieee802154_hw *hw, u8 page, u8 channel);
+	...
+};
+
+ - int start(struct ieee802154_hw *hw):
+   handler that 802.15.4 module calls for the hardware device initialization.
+
+ - void stop(struct ieee802154_hw *hw):
+   handler that 802.15.4 module calls for the hardware device cleanup.
+
+ - int xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb):
+   handler that 802.15.4 module calls for each frame in the skb going to be
+   transmitted through the hardware device.
+
+ - int ed(struct ieee802154_hw *hw, u8 *level):
+   handler that 802.15.4 module calls for Energy Detection from the hardware
+   device.
+
+ - int set_channel(struct ieee802154_hw *hw, u8 page, u8 channel):
+   set radio for listening on specific channel of the hardware device.
+
 Moreover IEEE 802.15.4 device operations structure should be filled.
 
 Fake drivers
-- 
2.15.0

