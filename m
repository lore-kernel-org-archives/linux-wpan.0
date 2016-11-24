Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33235 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936424AbcKXJfY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Nov 2016 04:35:24 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so2843275wjc.0
        for <linux-wpan@vger.kernel.org>; Thu, 24 Nov 2016 01:35:23 -0800 (PST)
From: harrymorris12@gmail.com
Subject: [PATCH v5 0/3] ieee802154: Add support for Cascoda CA8210
Date: Thu, 24 Nov 2016 09:18:19 +0000
Message-Id: <20161124091822.3752-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

This patchset adds a new device driver, documentation and build support for
Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
http://www.cascoda.com/products/ca-821x/

v5:
+Cc: Marcel Holtmann

v4:
Added allowable tx_powers and cca_ed_levels
Changed power units to mbm (tx_power & cca_ed_level)

Harry Morris (3):
  ieee802154: Add CA8210 IEEE 802.15.4 device driver
  ieee802154: Add device tree documentation for CA8210
  ieee802154: Add entry in MAINTAINTERS for CA8210 driver

 .../devicetree/bindings/net/ieee802154/ca8210.txt  |   28 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/net/ieee802154/Kconfig                     |   18 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/ca8210.c                    | 3665 ++++++++++++++++++++
 6 files changed, 3722 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
 create mode 100644 drivers/net/ieee802154/ca8210.c

--
2.9.3.windows.1
