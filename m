Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50634 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbeBCUvW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Feb 2018 15:51:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id f71so19173061wmf.0
        for <linux-wpan@vger.kernel.org>; Sat, 03 Feb 2018 12:51:22 -0800 (PST)
Received: from xue-ThinkPad-T470s.fritz.box (ipservice-092-218-175-186.092.218.pools.vodafone-ip.de. [92.218.175.186])
        by smtp.gmail.com with ESMTPSA id w17sm4503584eda.96.2018.02.03.12.51.20
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Feb 2018 12:51:20 -0800 (PST)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCH 0/3] ieee802154: Add support for NXP MCR20A
Date: Sat,  3 Feb 2018 21:51:11 +0100
Message-Id: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This patchset adds a new device driver, documentation and build support for
NXP's MCR20A IEEE 802.15.4 radio transceiver:
https://www.nxp.com/products/wireless-connectivity/thread/2.4-ghz-802.15.4-wireless-transceiver:MCR20A

Xue Liu (3):
  ieee802154: Add device tree documentation for MCR20A
  ieee802154: Add entry in MAINTAINTERS for MCR20a driver
  ieee802154: Add MCR20A IEEE 802.15.4 device driver

 .../devicetree/bindings/net/ieee802154/mcr20a.txt  |   23 +
 MAINTAINERS                                        |    8 +
 drivers/net/ieee802154/Kconfig                     |   11 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/mcr20a.c                    | 1482 ++++++++++++++++++++
 drivers/net/ieee802154/mcr20a.h                    |  498 +++++++
 6 files changed, 2023 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
 create mode 100644 drivers/net/ieee802154/mcr20a.c
 create mode 100644 drivers/net/ieee802154/mcr20a.h

-- 
2.7.4

