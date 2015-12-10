Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:36109 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753040AbbLJS0V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Dec 2015 13:26:21 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v4] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC IEEE802154
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449747519-11584-1-git-send-email-michael.hennerich@analog.com>
Date: Thu, 10 Dec 2015 08:26:14 -1000
Content-Transfer-Encoding: 8BIT
Message-Id: <EB15CE28-1C04-42D3-8E14-1B11B1D063C3@holtmann.org>
References: <1449747519-11584-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: michael.hennerich@analog.com
Cc: Alexander Aring <alex.aring@gmail.com>, stefan@datenfreihafen.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi Michael,

please use ieee802154/adf7242: ... as subject line.

> This driver has been sitting in the linux-zigbee[2] repository for a long
> time. We updated it from time to time and made it available via our
> github kernel repository. The Linux MAC802.15.4 support has improved a lot
> since then. Thanks to all! So it’s finally time to upstream this driver.
> 
> The ADF7242 requires an add-on firmware for the automatic IEEE 802.15.4
> operating modes. The firmware file is currently made available on the
> ADF7242 wiki page here [1]
> 
> [1] http://wiki.analog.com/resources/tools-software/linux-drivers/networking-mac802154/adf7242
> [2] http://sourceforge.net/p/linux-zigbee/kernel/ci/devel/tree/drivers/ieee802154/adf7242.c
> 
> Changes since v3:
> 	-Avoid race condition between xmit and the IRQ handler.
> 	 If we receive a packet while we prepare a transmission we
> 	 must not return to CMD_RX. Introduce atomic bitops flags,
> 	 and drop packets if necessary.
> 	-Refactor IRQ handling logic accordingly.
> 	-Disable CSMA_CA status reported for now.
> 	-For debug purposes adf7242_wait_status() pass line number to called function.
> 	-Use atomic bitops in start/stop.
> 	-Decrease xmit timeout to 250ms.
> 	-Fix error handling path in adf7242_rx().
> 	-Adf7242_isr() factor out debug code into separate function.
> 	-Avoid surplus ifdef DEBUG
> 
> Changes since v2:
> 	-Removed unused variable.
> 	-Removed dead code.
> 
> Changes since v1:
> 	-Add link to the product page/datasheet.
> 	-Add missing includes.
> 	-Use defines for magic PA bias values.
> 	-Unify wait_ready and wait_status functions.
> 	-Add RC_BUSY error handling using soft reset.
> 	 Requires some extra cached parameters.
> 	-Enable adf7242_verify_firmware() only during DEBUG.
> 	-Fixed some compiler warnings.
> 	-Removed sysfs status attribute.
> 	-Added debugfs status file.
> 	-Enable/Disable IRQ in start/stop.
> 	-Added missing MAINTAINER entry.
> 	-Added missing Kconfig help text.

Normally the change notes go after the --- line.

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> .../devicetree/bindings/net/ieee802154/adf7242.txt |   18 +
> MAINTAINERS                                        |    9 +
> drivers/net/ieee802154/Kconfig                     |   11 +
> drivers/net/ieee802154/Makefile                    |    1 +
> drivers/net/ieee802154/adf7242.c                   | 1282 ++++++++++++++++++++
> 5 files changed, 1321 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/ieee802154/adf7242.txt
> create mode 100644 drivers/net/ieee802154/adf7242.c

  CC      drivers/net/ieee802154/adf7242.o
drivers/net/ieee802154/adf7242.c: In function ‘adf7242_isr’:
drivers/net/ieee802154/adf7242.c:866:2: warning: ‘lqi’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  ieee802154_rx_irqsafe(lp->hw, skb, lqi);
  ^
drivers/net/ieee802154/adf7242.c:836:5: note: ‘lqi’ was declared here
  u8 lqi, len_u8, *data;
     ^

The patch is causing this compiler warning. Lets get this fixed since I do not want to introduce a warning.

Regards

Marcel

