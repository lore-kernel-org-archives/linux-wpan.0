Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36753 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbcLFPsH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Dec 2016 10:48:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so22236884wma.3
        for <linux-wpan@vger.kernel.org>; Tue, 06 Dec 2016 07:48:07 -0800 (PST)
From: harrymorris12@gmail.com
Subject: [PATCH v6 0/3] ieee802154: Add support for Cascoda CA8210
Date: Tue,  6 Dec 2016 15:47:37 +0000
Message-Id: <20161206154740.2992-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

This patchset adds a new device driver, documentation and build support for
Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
http://www.cascoda.com/products/ca-821x/

v6:
Kernel style conformance changes
Additional documentation
More meaningful register structs/macros
Removal of old TODOs
Removal of unnecessary macros
Check for safe removal of test interface

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
 drivers/net/ieee802154/Kconfig                     |   21 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/ca8210.c                    | 3719 ++++++++++++++++++++
 6 files changed, 3779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
 create mode 100644 drivers/net/ieee802154/ca8210.c

--
2.9.3.windows.1
