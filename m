Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54729 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbeBSKvX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 05:51:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id z81so14275465wmb.4
        for <linux-wpan@vger.kernel.org>; Mon, 19 Feb 2018 02:51:22 -0800 (PST)
Received: from xue-ThinkPad-T470s.kelle.grp (p578b164d.dip0.t-ipconnect.de. [87.139.22.77])
        by smtp.gmail.com with ESMTPSA id f19sm7210097edd.84.2018.02.19.02.51.20
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 02:51:20 -0800 (PST)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCHv2 0/3] ieee802154: Add support for NXP MCR20A
Date: Mon, 19 Feb 2018 11:51:08 +0100
Message-Id: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
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
 MAINTAINERS                                        |    9 +
 drivers/net/ieee802154/Kconfig                     |   11 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/mcr20a.c                    | 1460 ++++++++++++++++++++
 drivers/net/ieee802154/mcr20a.h                    |  498 +++++++
 6 files changed, 2002 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
 create mode 100644 drivers/net/ieee802154/mcr20a.c
 create mode 100644 drivers/net/ieee802154/mcr20a.h

-- 
2.7.4

