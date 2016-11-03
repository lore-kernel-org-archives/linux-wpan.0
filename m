Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35664 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756863AbcKCPyB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Nov 2016 11:54:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id 68so8712716wmz.2
        for <linux-wpan@vger.kernel.org>; Thu, 03 Nov 2016 08:54:00 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH v3 0/3] ieee802154: Add support for Cascoda CA8210
Date: Thu,  3 Nov 2016 15:50:57 +0000
Message-Id: <20161103155100.8400-1-h.morris@cascoda.com>
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
