Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34299 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755269AbcKCPTp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Nov 2016 11:19:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id p190so8567981wmp.1
        for <linux-wpan@vger.kernel.org>; Thu, 03 Nov 2016 08:19:44 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH v2 0/3] ieee802154: Add support for Cascoda CA8210
Date: Thu,  3 Nov 2016 15:16:48 +0000
Message-Id: <20161103151651.7880-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

This patchset adds a new device driver, documentation and build support for
Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
http://www.cascoda.com/products/ca-821x/

Harry Morris (3):
  ieee802154: Add CA8210 IEEE 802.15.4 device driver
  ieee802154: Add device tree documentation for CA8210
  ieee802154: Add entry in MAINTAINTERS for CA8210 driver

 .../devicetree/bindings/net/ieee802154/ca8210.txt  |   28 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/net/ieee802154/Kconfig                     |   18 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/ca8210.c                    | 3648 ++++++++++++++++++++
 6 files changed, 3705 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
 create mode 100644 drivers/net/ieee802154/ca8210.c

--
2.9.3.windows.1
