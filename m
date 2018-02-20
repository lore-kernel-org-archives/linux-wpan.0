Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41090 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBTL4H (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Feb 2018 06:56:07 -0500
Received: by mail-wr0-f193.google.com with SMTP id f14so9136206wre.8
        for <linux-wpan@vger.kernel.org>; Tue, 20 Feb 2018 03:56:06 -0800 (PST)
Received: from xue-ThinkPad-T470s.kelle.grp (p578b164d.dip0.t-ipconnect.de. [87.139.22.77])
        by smtp.gmail.com with ESMTPSA id f16sm20222897edj.68.2018.02.20.03.56.04
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Feb 2018 03:56:05 -0800 (PST)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCHv3 0/3] ieee802154: Add support for NXP MCR20A
Date: Tue, 20 Feb 2018 12:55:55 +0100
Message-Id: <1519127758-2084-1-git-send-email-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This patchset adds a new device driver, documentation and build support for
NXP's MCR20A IEEE 802.15.4 radio transceiver:
https://www.nxp.com/products/wireless-connectivity/thread/2.4-ghz-802.15.4-wireless-transceiver:MCR20A

v3:
- fix typo
- use print_hex_dump_debug()

Xue Liu (3):
  ieee802154: Add device tree documentation for MCR20A
  ieee802154: Add entry in MAINTAINTERS for MCR20a driver
  This is a driver for the NXP MCR20A 802.15.4 transceiver.

 .../devicetree/bindings/net/ieee802154/mcr20a.txt  |   23 +
 MAINTAINERS                                        |    9 +
 drivers/net/ieee802154/Kconfig                     |   11 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/mcr20a.c                    | 1413 ++++++++++++++++++++
 drivers/net/ieee802154/mcr20a.h                    |  498 +++++++
 6 files changed, 1955 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
 create mode 100644 drivers/net/ieee802154/mcr20a.c
 create mode 100644 drivers/net/ieee802154/mcr20a.h

-- 
2.7.4

