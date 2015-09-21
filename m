Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:48900 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbIUSwG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 14:52:06 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 00/22] mrf24j40: async rx/tx handling and new features
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 21 Sep 2015 20:51:59 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <771AB6B3-8F00-4D58-BCA4-A40D91D97131@holtmann.org>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com

Hi Alex,

> this patch series contains some cleanups, devicetree support, rx/tx async
> handling, threaded irq to hardirq, csma params settings, cca mode settings,
> cca energy detection levels, tx power settings and promiscuous mode settings.
> 
> Also I add regmap support, the lowlevel spi calls are only used in hotpaths
> for handling receive/transmit and irq handling. There are also some many
> magic numbers, maybe we can introduce some register bits defines.
> 
> - Alex
> 
> changes since PATCH:
> 
> - add warning for edge triggered irq's
> - add patch to replace magic numbers, except hw_init which is specified by
>   datasheet instruction
> - remove WARN_ON for max_be
> - fix cca mode setting s/OR/AND
> - add warning for spi freq is above maximum
> - let txpower also working for mrf24j40 chips by default
> - re-add DEBUG things for rssi and lqi value
> - add several reviewed-by's
> - use for cca_ed_thres register regmap_write instead update bits with full
>   0xff mask
> 
> Alexander Aring (22):
>  mrf24j40: cleanup define identation
>  mrf24j40: use ieee802154_alloc_hw for private data
>  mrf24j40: calling ieee802154_register_hw at last
>  mrf24j40: remove spi settings overwrite
>  mrf24j40: add device-tree support
>  mrf24j40: add default channel setting
>  mrf24j40: add random extended addr generation
>  mrf24j40: add more register defines
>  mrf24j40: add regmap support
>  mrf24j40: use regmap for register access
>  mrf24j40: change to frame delivery with crc
>  ieee802154: add helpers for frame control checks
>  mrf24j40: rework tx handling to async tx handling
>  mrf24j40: rework rx handling to async rx handling
>  mrf24j40: async interrupt handling
>  mrf24j40: add csma params support
>  mrf24j40: add cca mode support
>  mrf24j40: add cca ed level support
>  mrf24j40: add tx power support
>  mrf24j40: add promiscuous mode support
>  mrf24j40: change irq trigger type behaviour
>  mrf24j40: replace magic numbers
> 
> .../bindings/net/ieee802154/mrf24j40.txt           |   20 +
> MAINTAINERS                                        |    1 +
> drivers/net/ieee802154/Kconfig                     |    1 +
> drivers/net/ieee802154/mrf24j40.c                  | 1424 ++++++++++++++------
> include/linux/ieee802154.h                         |   12 +
> 5 files changed, 1031 insertions(+), 427 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mrf24j40.txt

all 22 patches has been applied to bluetooth-next tree.

Regards

Marcel

