Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from msr12.hinet.net ([168.95.4.112]:37953 "EHLO msr12.hinet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbdHFTVL (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 6 Aug 2017 15:21:11 -0400
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH] doc: linux-wpan: Change the old function names to the lastest function names
Date: Mon,  7 Aug 2017 00:28:29 +0800
Message-Id: <20170806162829.2540-1-starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>

The function declaration in the lastest include/net/mac802154.h has been
changed since v3.19.

ieee802154_alloc_device => ieee802154_alloc_hw
ieee802154_free_device => ieee802154_free_hw
ieee802154_register_device => ieee802154_register_hw
ieee802154_unregister_device => ieee802154_unregister_hw

However, the description in the Device drivers API section of
Documentation/networking/ieee802154.txt is still in the state of
v3.18.63.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 Documentation/networking/ieee802154.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
index 22bbc7225f8..ca1697a2273 100644
--- a/Documentation/networking/ieee802154.txt
+++ b/Documentation/networking/ieee802154.txt
@@ -96,17 +96,17 @@ Device drivers API
 ==================
 
 The include/net/mac802154.h defines following functions:
- - struct ieee802154_dev *ieee802154_alloc_device
-   (size_t priv_size, struct ieee802154_ops *ops):
-   allocation of IEEE 802.15.4 compatible device
+ - struct ieee802154_hw *
+   ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops):
+   allocation of IEEE 802.15.4 compatible hardware device
 
- - void ieee802154_free_device(struct ieee802154_dev *dev):
-   freeing allocated device
+ - void ieee802154_free_hw(struct ieee802154_hw *hw):
+   freeing allocated hardware device
 
- - int ieee802154_register_device(struct ieee802154_dev *dev):
-   register PHY in the system
+ - int ieee802154_register_hw(struct ieee802154_hw *hw):
+   register PHY which is the allocated hardware device, in the system
 
- - void ieee802154_unregister_device(struct ieee802154_dev *dev):
+ - void ieee802154_unregister_hw(struct ieee802154_hw *hw):
    freeing registered PHY
 
 Moreover IEEE 802.15.4 device operations structure should be filled.
-- 
2.13.3

