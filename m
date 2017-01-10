Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35524 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756674AbdAJPmt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Jan 2017 10:42:49 -0500
Received: by mail-wj0-f195.google.com with SMTP id ey1so8852639wjd.2
        for <linux-wpan@vger.kernel.org>; Tue, 10 Jan 2017 07:42:49 -0800 (PST)
From: Harry Morris <harrymorris12@gmail.com>
Subject: [PATCH v7 0/3] ieee802154: Add support for Cascoda CA8210
Date: Tue, 10 Jan 2017 15:41:19 +0000
Message-Id: <20170110154122.6724-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

This patchset adds a new device driver, documentation and build support for
Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
http://www.cascoda.com/products/ca-821x/

v7:
Remove use of cs_change property, always transmit full length buffers
Implement fully async spi transfers
Combine spi transmission and reception into one function
Use completion objects when waiting for events
Rework a lot of locking
Remove deprecated xmit_sync
Remove use of workqueue for IRQ handling

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
 drivers/net/ieee802154/ca8210.c                    | 3273 ++++++++++++++++++++
 6 files changed, 3333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
 create mode 100644 drivers/net/ieee802154/ca8210.c

--
2.9.3.windows.1
