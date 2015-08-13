Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32824 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbbHMMXU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:20 -0400
Received: by wijp15 with SMTP id p15so256368623wij.0
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 00/21] mrf24j40: async rx/tx handling and new features
Date: Thu, 13 Aug 2015 14:22:27 +0200
Message-Id: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains some cleanups, devicetree support, rx/tx async
handling, threaded irq to hardirq, csma params settings, cca mode settings,
cca energy detection levels, tx power settings and promiscuous mode settings.

Also I add regmap support, the lowlevel spi calls are only used in hotpaths
for handling receive/transmit and irq handling. There are also some many
magic numbers, maybe we can introduce some register bits defines.

First I will send this as RFC to get some respone if the patches looks fine
and acceptable for mainline.

- Alex

Alexander Aring (21):
  mrf24j40: cleanup define identation
  mrf24j40: use ieee802154_alloc_hw for private data
  mrf24j40: calling ieee802154_register_hw at last
  mrf24j40: remove spi settings overwrite
  mrf24j40: add device-tree support
  mrf24j40: add default channel setting
  mrf24j40: add random extended addr generation
  mrf24j40: add more register defines
  mrf24j40: add regmap support
  mrf24j40: use regmap for register access
  mrf24j40: change to frame delivery with crc
  ieee802154: add helpers for frame control checks
  mrf24j40: rework tx handling to async tx handling
  mrf24j40: rework rx handling to async rx handling
  mrf24j40: async interrupt handling
  mrf24j40: add csma params support
  mrf24j40: add cca mode support
  mrf24j40: add cca ed level support
  mrf24j40: add tx power support
  mrf24j40: add promiscuous mode support
  mrf24j40: change irq trigger type behaviour

 .../bindings/net/ieee802154/mrf24j40.txt           |   20 +
 MAINTAINERS                                        |    1 +
 drivers/net/ieee802154/Kconfig                     |    1 +
 drivers/net/ieee802154/mrf24j40.c                  | 1342 +++++++++++++-------
 include/linux/ieee802154.h                         |   29 +
 5 files changed, 969 insertions(+), 424 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mrf24j40.txt

-- 
2.5.0

