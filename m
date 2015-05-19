Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35816 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbbESLwQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 07:52:16 -0400
Received: by wicmx19 with SMTP id mx19so113985257wic.0
        for <linux-wpan@vger.kernel.org>; Tue, 19 May 2015 04:52:14 -0700 (PDT)
Date: Tue, 19 May 2015 13:52:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 21/34] ieee802154: add support for atusb
 transceiver
Message-ID: <20150519115158.GA976@omega>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
 <1431891910-32231-22-git-send-email-alex.aring@gmail.com>
 <555B1531.3060500@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <555B1531.3060500@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, marcel@holtmann.org, Werner Almesberger <werner@almesberger.net>, Richard Sharpe <realrichardsharpe@gmail.com>

On Tue, May 19, 2015 at 12:49:21PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 17/05/15 21:44, Alexander Aring wrote:
> >This patch adds support for the atusb transceiver.
> >
> >The current driver supports basic functionality only. Possible further
> >tasks would be to sync functionality with the at86rf230 driver, because
> >the atusb use internally an at86rf231 transceiver. Some of these
> >features need a firmware update like AACK and ARET handling.
> 
> We should really have a firmware release now that runs with the mainline
> driver. For new features we can then check the fw version in the driver and
> enable/disable accordingly.
> 

Yep, the current fw code in ben-wpan repository is working. For myself I
just change the RX_ON to RX_AACK_ON so the atusb works also in ARET
enabled networks.

> Werner, is this something you would do? Making a release of the firmware? Or
> should Alexander or myself look into this?
> 
> >I did small changes to this driver to work with xmit_async callback and
> >setting of a random extended perm address.
> 
> Thanks!
> 
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >Cc: Werner Almesberger <werner@almesberger.net>
> >Cc: Stefan Schmidt <s.schmidt@samsung.com>
> >Cc: Richard Sharpe <realrichardsharpe@gmail.com>
> >---
> >  drivers/net/ieee802154/Kconfig     |  10 +
> >  drivers/net/ieee802154/Makefile    |   1 +
> >  drivers/net/ieee802154/at86rf230.c | 199 +----------
> >  drivers/net/ieee802154/at86rf230.h | 220 ++++++++++++
> >  drivers/net/ieee802154/atusb.c     | 692
> >+++++++++++++++++++++++++++++++++++++
> >  drivers/net/ieee802154/atusb.h     |  84 +++++
> >  6 files changed, 1009 insertions(+), 197 deletions(-)
> >  create mode 100644 drivers/net/ieee802154/at86rf230.h
> >  create mode 100644 drivers/net/ieee802154/atusb.c
> >  create mode 100644 drivers/net/ieee802154/atusb.h
> >
> >diff --git a/drivers/net/ieee802154/Kconfig
> >b/drivers/net/ieee802154/Kconfig
> >index 1a3c3e5..1dd5ab8 100644
> >--- a/drivers/net/ieee802154/Kconfig
> >+++ b/drivers/net/ieee802154/Kconfig
> >@@ -53,3 +53,13 @@ config IEEE802154_CC2520
> >
> >  	  This driver can also be built as a module. To do so, say M here.
> >  	  the module will be called 'cc2520'.
> >+
> >+config IEEE802154_ATUSB
> >+	tristate "ATUSB transceiver driver"
> >+	depends on IEEE802154_DRIVERS && MAC802154 && USB
> >+	---help---
> >+	  Say Y here to enable the ATUSB IEEE 802.15.4 wireless
> >+	  controller.
> >+
> >+	  This driver can also be built as a module. To do so say M here.
> >+	  The module will be called 'atusb'.
> >diff --git a/drivers/net/ieee802154/Makefile
> >b/drivers/net/ieee802154/Makefile
> >index d77fa4d..cf1d2a6 100644
> >--- a/drivers/net/ieee802154/Makefile
> >+++ b/drivers/net/ieee802154/Makefile
> >@@ -2,3 +2,4 @@ obj-$(CONFIG_IEEE802154_FAKELB) += fakelb.o
> >  obj-$(CONFIG_IEEE802154_AT86RF230) += at86rf230.o
> >  obj-$(CONFIG_IEEE802154_MRF24J40) += mrf24j40.o
> >  obj-$(CONFIG_IEEE802154_CC2520) += cc2520.o
> >+obj-$(CONFIG_IEEE802154_ATUSB) += atusb.o
> >diff --git a/drivers/net/ieee802154/at86rf230.c
> >b/drivers/net/ieee802154/at86rf230.c
> >index 8d5ed6e..d417ceb 100644
> >--- a/drivers/net/ieee802154/at86rf230.c
> >+++ b/drivers/net/ieee802154/at86rf230.c
> >@@ -35,6 +35,8 @@
> >  #include <net/mac802154.h>
> >  #include <net/cfg802154.h>
> >
> >+#include "at86rf230.h"
> >+
> >  struct at86rf230_local;
> >  /* at86rf2xx chip depend data.
> >   * All timings are in us.
> >@@ -102,203 +104,6 @@ struct at86rf230_local {
> >  	struct at86rf230_state_change tx;
> >  };
> >
> >-#define RG_TRX_STATUS	(0x01)
> >-#define SR_TRX_STATUS		0x01, 0x1f, 0
> >-#define SR_RESERVED_01_3	0x01, 0x20, 5
> >-#define SR_CCA_STATUS		0x01, 0x40, 6
> >-#define SR_CCA_DONE		0x01, 0x80, 7
> >-#define RG_TRX_STATE	(0x02)
> >-#define SR_TRX_CMD		0x02, 0x1f, 0
> >-#define SR_TRAC_STATUS		0x02, 0xe0, 5
> >-#define RG_TRX_CTRL_0	(0x03)
> >-#define SR_CLKM_CTRL		0x03, 0x07, 0
> >-#define SR_CLKM_SHA_SEL		0x03, 0x08, 3
> >-#define SR_PAD_IO_CLKM		0x03, 0x30, 4
> >-#define SR_PAD_IO		0x03, 0xc0, 6
> >-#define RG_TRX_CTRL_1	(0x04)
> >-#define SR_IRQ_POLARITY		0x04, 0x01, 0
> >-#define SR_IRQ_MASK_MODE	0x04, 0x02, 1
> >-#define SR_SPI_CMD_MODE		0x04, 0x0c, 2
> >-#define SR_RX_BL_CTRL		0x04, 0x10, 4
> >-#define SR_TX_AUTO_CRC_ON	0x04, 0x20, 5
> >-#define SR_IRQ_2_EXT_EN		0x04, 0x40, 6
> >-#define SR_PA_EXT_EN		0x04, 0x80, 7
> >-#define RG_PHY_TX_PWR	(0x05)
> >-#define SR_TX_PWR_23X		0x05, 0x0f, 0
> >-#define SR_PA_LT_230		0x05, 0x30, 4
> >-#define SR_PA_BUF_LT_230	0x05, 0xc0, 6
> >-#define SR_TX_PWR_212		0x05, 0x1f, 0
> >-#define SR_GC_PA_212		0x05, 0x60, 5
> >-#define SR_PA_BOOST_LT_212	0x05, 0x80, 7
> >-#define RG_PHY_RSSI	(0x06)
> >-#define SR_RSSI			0x06, 0x1f, 0
> >-#define SR_RND_VALUE		0x06, 0x60, 5
> >-#define SR_RX_CRC_VALID		0x06, 0x80, 7
> >-#define RG_PHY_ED_LEVEL	(0x07)
> >-#define SR_ED_LEVEL		0x07, 0xff, 0
> >-#define RG_PHY_CC_CCA	(0x08)
> >-#define SR_CHANNEL		0x08, 0x1f, 0
> >-#define SR_CCA_MODE		0x08, 0x60, 5
> >-#define SR_CCA_REQUEST		0x08, 0x80, 7
> >-#define RG_CCA_THRES	(0x09)
> >-#define SR_CCA_ED_THRES		0x09, 0x0f, 0
> >-#define SR_RESERVED_09_1	0x09, 0xf0, 4
> >-#define RG_RX_CTRL	(0x0a)
> >-#define SR_PDT_THRES		0x0a, 0x0f, 0
> >-#define SR_RESERVED_0a_1	0x0a, 0xf0, 4
> >-#define RG_SFD_VALUE	(0x0b)
> >-#define SR_SFD_VALUE		0x0b, 0xff, 0
> >-#define RG_TRX_CTRL_2	(0x0c)
> >-#define SR_OQPSK_DATA_RATE	0x0c, 0x03, 0
> >-#define SR_SUB_MODE		0x0c, 0x04, 2
> >-#define SR_BPSK_QPSK		0x0c, 0x08, 3
> >-#define SR_OQPSK_SUB1_RC_EN	0x0c, 0x10, 4
> >-#define SR_RESERVED_0c_5	0x0c, 0x60, 5
> >-#define SR_RX_SAFE_MODE		0x0c, 0x80, 7
> >-#define RG_ANT_DIV	(0x0d)
> >-#define SR_ANT_CTRL		0x0d, 0x03, 0
> >-#define SR_ANT_EXT_SW_EN	0x0d, 0x04, 2
> >-#define SR_ANT_DIV_EN		0x0d, 0x08, 3
> >-#define SR_RESERVED_0d_2	0x0d, 0x70, 4
> >-#define SR_ANT_SEL		0x0d, 0x80, 7
> >-#define RG_IRQ_MASK	(0x0e)
> >-#define SR_IRQ_MASK		0x0e, 0xff, 0
> >-#define RG_IRQ_STATUS	(0x0f)
> >-#define SR_IRQ_0_PLL_LOCK	0x0f, 0x01, 0
> >-#define SR_IRQ_1_PLL_UNLOCK	0x0f, 0x02, 1
> >-#define SR_IRQ_2_RX_START	0x0f, 0x04, 2
> >-#define SR_IRQ_3_TRX_END	0x0f, 0x08, 3
> >-#define SR_IRQ_4_CCA_ED_DONE	0x0f, 0x10, 4
> >-#define SR_IRQ_5_AMI		0x0f, 0x20, 5
> >-#define SR_IRQ_6_TRX_UR		0x0f, 0x40, 6
> >-#define SR_IRQ_7_BAT_LOW	0x0f, 0x80, 7
> >-#define RG_VREG_CTRL	(0x10)
> >-#define SR_RESERVED_10_6	0x10, 0x03, 0
> >-#define SR_DVDD_OK		0x10, 0x04, 2
> >-#define SR_DVREG_EXT		0x10, 0x08, 3
> >-#define SR_RESERVED_10_3	0x10, 0x30, 4
> >-#define SR_AVDD_OK		0x10, 0x40, 6
> >-#define SR_AVREG_EXT		0x10, 0x80, 7
> >-#define RG_BATMON	(0x11)
> >-#define SR_BATMON_VTH		0x11, 0x0f, 0
> >-#define SR_BATMON_HR		0x11, 0x10, 4
> >-#define SR_BATMON_OK		0x11, 0x20, 5
> >-#define SR_RESERVED_11_1	0x11, 0xc0, 6
> >-#define RG_XOSC_CTRL	(0x12)
> >-#define SR_XTAL_TRIM		0x12, 0x0f, 0
> >-#define SR_XTAL_MODE		0x12, 0xf0, 4
> >-#define RG_RX_SYN	(0x15)
> >-#define SR_RX_PDT_LEVEL		0x15, 0x0f, 0
> >-#define SR_RESERVED_15_2	0x15, 0x70, 4
> >-#define SR_RX_PDT_DIS		0x15, 0x80, 7
> >-#define RG_XAH_CTRL_1	(0x17)
> >-#define SR_RESERVED_17_8	0x17, 0x01, 0
> >-#define SR_AACK_PROM_MODE	0x17, 0x02, 1
> >-#define SR_AACK_ACK_TIME	0x17, 0x04, 2
> >-#define SR_RESERVED_17_5	0x17, 0x08, 3
> >-#define SR_AACK_UPLD_RES_FT	0x17, 0x10, 4
> >-#define SR_AACK_FLTR_RES_FT	0x17, 0x20, 5
> >-#define SR_CSMA_LBT_MODE	0x17, 0x40, 6
> >-#define SR_RESERVED_17_1	0x17, 0x80, 7
> >-#define RG_FTN_CTRL	(0x18)
> >-#define SR_RESERVED_18_2	0x18, 0x7f, 0
> >-#define SR_FTN_START		0x18, 0x80, 7
> >-#define RG_PLL_CF	(0x1a)
> >-#define SR_RESERVED_1a_2	0x1a, 0x7f, 0
> >-#define SR_PLL_CF_START		0x1a, 0x80, 7
> >-#define RG_PLL_DCU	(0x1b)
> >-#define SR_RESERVED_1b_3	0x1b, 0x3f, 0
> >-#define SR_RESERVED_1b_2	0x1b, 0x40, 6
> >-#define SR_PLL_DCU_START	0x1b, 0x80, 7
> >-#define RG_PART_NUM	(0x1c)
> >-#define SR_PART_NUM		0x1c, 0xff, 0
> >-#define RG_VERSION_NUM	(0x1d)
> >-#define SR_VERSION_NUM		0x1d, 0xff, 0
> >-#define RG_MAN_ID_0	(0x1e)
> >-#define SR_MAN_ID_0		0x1e, 0xff, 0
> >-#define RG_MAN_ID_1	(0x1f)
> >-#define SR_MAN_ID_1		0x1f, 0xff, 0
> >-#define RG_SHORT_ADDR_0	(0x20)
> >-#define SR_SHORT_ADDR_0		0x20, 0xff, 0
> >-#define RG_SHORT_ADDR_1	(0x21)
> >-#define SR_SHORT_ADDR_1		0x21, 0xff, 0
> >-#define RG_PAN_ID_0	(0x22)
> >-#define SR_PAN_ID_0		0x22, 0xff, 0
> >-#define RG_PAN_ID_1	(0x23)
> >-#define SR_PAN_ID_1		0x23, 0xff, 0
> >-#define RG_IEEE_ADDR_0	(0x24)
> >-#define SR_IEEE_ADDR_0		0x24, 0xff, 0
> >-#define RG_IEEE_ADDR_1	(0x25)
> >-#define SR_IEEE_ADDR_1		0x25, 0xff, 0
> >-#define RG_IEEE_ADDR_2	(0x26)
> >-#define SR_IEEE_ADDR_2		0x26, 0xff, 0
> >-#define RG_IEEE_ADDR_3	(0x27)
> >-#define SR_IEEE_ADDR_3		0x27, 0xff, 0
> >-#define RG_IEEE_ADDR_4	(0x28)
> >-#define SR_IEEE_ADDR_4		0x28, 0xff, 0
> >-#define RG_IEEE_ADDR_5	(0x29)
> >-#define SR_IEEE_ADDR_5		0x29, 0xff, 0
> >-#define RG_IEEE_ADDR_6	(0x2a)
> >-#define SR_IEEE_ADDR_6		0x2a, 0xff, 0
> >-#define RG_IEEE_ADDR_7	(0x2b)
> >-#define SR_IEEE_ADDR_7		0x2b, 0xff, 0
> >-#define RG_XAH_CTRL_0	(0x2c)
> >-#define SR_SLOTTED_OPERATION	0x2c, 0x01, 0
> >-#define SR_MAX_CSMA_RETRIES	0x2c, 0x0e, 1
> >-#define SR_MAX_FRAME_RETRIES	0x2c, 0xf0, 4
> >-#define RG_CSMA_SEED_0	(0x2d)
> >-#define SR_CSMA_SEED_0		0x2d, 0xff, 0
> >-#define RG_CSMA_SEED_1	(0x2e)
> >-#define SR_CSMA_SEED_1		0x2e, 0x07, 0
> >-#define SR_AACK_I_AM_COORD	0x2e, 0x08, 3
> >-#define SR_AACK_DIS_ACK		0x2e, 0x10, 4
> >-#define SR_AACK_SET_PD		0x2e, 0x20, 5
> >-#define SR_AACK_FVN_MODE	0x2e, 0xc0, 6
> >-#define RG_CSMA_BE	(0x2f)
> >-#define SR_MIN_BE		0x2f, 0x0f, 0
> >-#define SR_MAX_BE		0x2f, 0xf0, 4
> >-
> >-#define CMD_REG		0x80
> >-#define CMD_REG_MASK	0x3f
> >-#define CMD_WRITE	0x40
> >-#define CMD_FB		0x20
> >-
> >-#define IRQ_BAT_LOW	(1 << 7)
> >-#define IRQ_TRX_UR	(1 << 6)
> >-#define IRQ_AMI		(1 << 5)
> >-#define IRQ_CCA_ED	(1 << 4)
> >-#define IRQ_TRX_END	(1 << 3)
> >-#define IRQ_RX_START	(1 << 2)
> >-#define IRQ_PLL_UNL	(1 << 1)
> >-#define IRQ_PLL_LOCK	(1 << 0)
> >-
> >-#define IRQ_ACTIVE_HIGH	0
> >-#define IRQ_ACTIVE_LOW	1
> >-
> >-#define STATE_P_ON		0x00	/* BUSY */
> >-#define STATE_BUSY_RX		0x01
> >-#define STATE_BUSY_TX		0x02
> >-#define STATE_FORCE_TRX_OFF	0x03
> >-#define STATE_FORCE_TX_ON	0x04	/* IDLE */
> >-/* 0x05 */				/* INVALID_PARAMETER */
> >-#define STATE_RX_ON		0x06
> >-/* 0x07 */				/* SUCCESS */
> >-#define STATE_TRX_OFF		0x08
> >-#define STATE_TX_ON		0x09
> >-/* 0x0a - 0x0e */			/* 0x0a - UNSUPPORTED_ATTRIBUTE */
> >-#define STATE_SLEEP		0x0F
> >-#define STATE_PREP_DEEP_SLEEP	0x10
> >-#define STATE_BUSY_RX_AACK	0x11
> >-#define STATE_BUSY_TX_ARET	0x12
> >-#define STATE_RX_AACK_ON	0x16
> >-#define STATE_TX_ARET_ON	0x19
> >-#define STATE_RX_ON_NOCLK	0x1C
> >-#define STATE_RX_AACK_ON_NOCLK	0x1D
> >-#define STATE_BUSY_RX_AACK_NOCLK 0x1E
> >-#define STATE_TRANSITION_IN_PROGRESS 0x1F
> >-
> >-#define TRX_STATE_MASK		(0x1F)
> >-
> >  #define AT86RF2XX_NUMREGS 0x3F
> >
> >  static void
> >diff --git a/drivers/net/ieee802154/at86rf230.h
> >b/drivers/net/ieee802154/at86rf230.h
> >new file mode 100644
> >index 0000000..1e6d1cc
> >--- /dev/null
> >+++ b/drivers/net/ieee802154/at86rf230.h
> >@@ -0,0 +1,220 @@
> >+/*
> >+ * AT86RF230/RF231 driver
> >+ *
> >+ * Copyright (C) 2009-2012 Siemens AG
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License version 2
> >+ * as published by the Free Software Foundation.
> >+ *
> >+ * This program is distributed in the hope that it will be useful,
> >+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ * GNU General Public License for more details.
> >+ *
> >+ * Written by:
> >+ * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >+ * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
> >+ */
> >+
> >+#ifndef _AT86RF230_H
> >+#define _AT86RF230_H
> >+
> >+#define RG_TRX_STATUS	(0x01)
> >+#define SR_TRX_STATUS		0x01, 0x1f, 0
> >+#define SR_RESERVED_01_3	0x01, 0x20, 5
> >+#define SR_CCA_STATUS		0x01, 0x40, 6
> >+#define SR_CCA_DONE		0x01, 0x80, 7
> >+#define RG_TRX_STATE	(0x02)
> >+#define SR_TRX_CMD		0x02, 0x1f, 0
> >+#define SR_TRAC_STATUS		0x02, 0xe0, 5
> >+#define RG_TRX_CTRL_0	(0x03)
> >+#define SR_CLKM_CTRL		0x03, 0x07, 0
> >+#define SR_CLKM_SHA_SEL		0x03, 0x08, 3
> >+#define SR_PAD_IO_CLKM		0x03, 0x30, 4
> >+#define SR_PAD_IO		0x03, 0xc0, 6
> >+#define RG_TRX_CTRL_1	(0x04)
> >+#define SR_IRQ_POLARITY		0x04, 0x01, 0
> >+#define SR_IRQ_MASK_MODE	0x04, 0x02, 1
> >+#define SR_SPI_CMD_MODE		0x04, 0x0c, 2
> >+#define SR_RX_BL_CTRL		0x04, 0x10, 4
> >+#define SR_TX_AUTO_CRC_ON	0x04, 0x20, 5
> >+#define SR_IRQ_2_EXT_EN		0x04, 0x40, 6
> >+#define SR_PA_EXT_EN		0x04, 0x80, 7
> >+#define RG_PHY_TX_PWR	(0x05)
> >+#define SR_TX_PWR_23X		0x05, 0x0f, 0
> >+#define SR_PA_LT_230		0x05, 0x30, 4
> >+#define SR_PA_BUF_LT_230	0x05, 0xc0, 6
> >+#define SR_TX_PWR_212		0x05, 0x1f, 0
> >+#define SR_GC_PA_212		0x05, 0x60, 5
> >+#define SR_PA_BOOST_LT_212	0x05, 0x80, 7
> >+#define RG_PHY_RSSI	(0x06)
> >+#define SR_RSSI			0x06, 0x1f, 0
> >+#define SR_RND_VALUE		0x06, 0x60, 5
> >+#define SR_RX_CRC_VALID		0x06, 0x80, 7
> >+#define RG_PHY_ED_LEVEL	(0x07)
> >+#define SR_ED_LEVEL		0x07, 0xff, 0
> >+#define RG_PHY_CC_CCA	(0x08)
> >+#define SR_CHANNEL		0x08, 0x1f, 0
> >+#define SR_CCA_MODE		0x08, 0x60, 5
> >+#define SR_CCA_REQUEST		0x08, 0x80, 7
> >+#define RG_CCA_THRES	(0x09)
> >+#define SR_CCA_ED_THRES		0x09, 0x0f, 0
> >+#define SR_RESERVED_09_1	0x09, 0xf0, 4
> >+#define RG_RX_CTRL	(0x0a)
> >+#define SR_PDT_THRES		0x0a, 0x0f, 0
> >+#define SR_RESERVED_0a_1	0x0a, 0xf0, 4
> >+#define RG_SFD_VALUE	(0x0b)
> >+#define SR_SFD_VALUE		0x0b, 0xff, 0
> >+#define RG_TRX_CTRL_2	(0x0c)
> >+#define SR_OQPSK_DATA_RATE	0x0c, 0x03, 0
> >+#define SR_SUB_MODE		0x0c, 0x04, 2
> >+#define SR_BPSK_QPSK		0x0c, 0x08, 3
> >+#define SR_OQPSK_SUB1_RC_EN	0x0c, 0x10, 4
> >+#define SR_RESERVED_0c_5	0x0c, 0x60, 5
> >+#define SR_RX_SAFE_MODE		0x0c, 0x80, 7
> >+#define RG_ANT_DIV	(0x0d)
> >+#define SR_ANT_CTRL		0x0d, 0x03, 0
> >+#define SR_ANT_EXT_SW_EN	0x0d, 0x04, 2
> >+#define SR_ANT_DIV_EN		0x0d, 0x08, 3
> >+#define SR_RESERVED_0d_2	0x0d, 0x70, 4
> >+#define SR_ANT_SEL		0x0d, 0x80, 7
> >+#define RG_IRQ_MASK	(0x0e)
> >+#define SR_IRQ_MASK		0x0e, 0xff, 0
> >+#define RG_IRQ_STATUS	(0x0f)
> >+#define SR_IRQ_0_PLL_LOCK	0x0f, 0x01, 0
> >+#define SR_IRQ_1_PLL_UNLOCK	0x0f, 0x02, 1
> >+#define SR_IRQ_2_RX_START	0x0f, 0x04, 2
> >+#define SR_IRQ_3_TRX_END	0x0f, 0x08, 3
> >+#define SR_IRQ_4_CCA_ED_DONE	0x0f, 0x10, 4
> >+#define SR_IRQ_5_AMI		0x0f, 0x20, 5
> >+#define SR_IRQ_6_TRX_UR		0x0f, 0x40, 6
> >+#define SR_IRQ_7_BAT_LOW	0x0f, 0x80, 7
> >+#define RG_VREG_CTRL	(0x10)
> >+#define SR_RESERVED_10_6	0x10, 0x03, 0
> >+#define SR_DVDD_OK		0x10, 0x04, 2
> >+#define SR_DVREG_EXT		0x10, 0x08, 3
> >+#define SR_RESERVED_10_3	0x10, 0x30, 4
> >+#define SR_AVDD_OK		0x10, 0x40, 6
> >+#define SR_AVREG_EXT		0x10, 0x80, 7
> >+#define RG_BATMON	(0x11)
> >+#define SR_BATMON_VTH		0x11, 0x0f, 0
> >+#define SR_BATMON_HR		0x11, 0x10, 4
> >+#define SR_BATMON_OK		0x11, 0x20, 5
> >+#define SR_RESERVED_11_1	0x11, 0xc0, 6
> >+#define RG_XOSC_CTRL	(0x12)
> >+#define SR_XTAL_TRIM		0x12, 0x0f, 0
> >+#define SR_XTAL_MODE		0x12, 0xf0, 4
> >+#define RG_RX_SYN	(0x15)
> >+#define SR_RX_PDT_LEVEL		0x15, 0x0f, 0
> >+#define SR_RESERVED_15_2	0x15, 0x70, 4
> >+#define SR_RX_PDT_DIS		0x15, 0x80, 7
> >+#define RG_XAH_CTRL_1	(0x17)
> >+#define SR_RESERVED_17_8	0x17, 0x01, 0
> >+#define SR_AACK_PROM_MODE	0x17, 0x02, 1
> >+#define SR_AACK_ACK_TIME	0x17, 0x04, 2
> >+#define SR_RESERVED_17_5	0x17, 0x08, 3
> >+#define SR_AACK_UPLD_RES_FT	0x17, 0x10, 4
> >+#define SR_AACK_FLTR_RES_FT	0x17, 0x20, 5
> >+#define SR_CSMA_LBT_MODE	0x17, 0x40, 6
> >+#define SR_RESERVED_17_1	0x17, 0x80, 7
> >+#define RG_FTN_CTRL	(0x18)
> >+#define SR_RESERVED_18_2	0x18, 0x7f, 0
> >+#define SR_FTN_START		0x18, 0x80, 7
> >+#define RG_PLL_CF	(0x1a)
> >+#define SR_RESERVED_1a_2	0x1a, 0x7f, 0
> >+#define SR_PLL_CF_START		0x1a, 0x80, 7
> >+#define RG_PLL_DCU	(0x1b)
> >+#define SR_RESERVED_1b_3	0x1b, 0x3f, 0
> >+#define SR_RESERVED_1b_2	0x1b, 0x40, 6
> >+#define SR_PLL_DCU_START	0x1b, 0x80, 7
> >+#define RG_PART_NUM	(0x1c)
> >+#define SR_PART_NUM		0x1c, 0xff, 0
> >+#define RG_VERSION_NUM	(0x1d)
> >+#define SR_VERSION_NUM		0x1d, 0xff, 0
> >+#define RG_MAN_ID_0	(0x1e)
> >+#define SR_MAN_ID_0		0x1e, 0xff, 0
> >+#define RG_MAN_ID_1	(0x1f)
> >+#define SR_MAN_ID_1		0x1f, 0xff, 0
> >+#define RG_SHORT_ADDR_0	(0x20)
> >+#define SR_SHORT_ADDR_0		0x20, 0xff, 0
> >+#define RG_SHORT_ADDR_1	(0x21)
> >+#define SR_SHORT_ADDR_1		0x21, 0xff, 0
> >+#define RG_PAN_ID_0	(0x22)
> >+#define SR_PAN_ID_0		0x22, 0xff, 0
> >+#define RG_PAN_ID_1	(0x23)
> >+#define SR_PAN_ID_1		0x23, 0xff, 0
> >+#define RG_IEEE_ADDR_0	(0x24)
> >+#define SR_IEEE_ADDR_0		0x24, 0xff, 0
> >+#define RG_IEEE_ADDR_1	(0x25)
> >+#define SR_IEEE_ADDR_1		0x25, 0xff, 0
> >+#define RG_IEEE_ADDR_2	(0x26)
> >+#define SR_IEEE_ADDR_2		0x26, 0xff, 0
> >+#define RG_IEEE_ADDR_3	(0x27)
> >+#define SR_IEEE_ADDR_3		0x27, 0xff, 0
> >+#define RG_IEEE_ADDR_4	(0x28)
> >+#define SR_IEEE_ADDR_4		0x28, 0xff, 0
> >+#define RG_IEEE_ADDR_5	(0x29)
> >+#define SR_IEEE_ADDR_5		0x29, 0xff, 0
> >+#define RG_IEEE_ADDR_6	(0x2a)
> >+#define SR_IEEE_ADDR_6		0x2a, 0xff, 0
> >+#define RG_IEEE_ADDR_7	(0x2b)
> >+#define SR_IEEE_ADDR_7		0x2b, 0xff, 0
> >+#define RG_XAH_CTRL_0	(0x2c)
> >+#define SR_SLOTTED_OPERATION	0x2c, 0x01, 0
> >+#define SR_MAX_CSMA_RETRIES	0x2c, 0x0e, 1
> >+#define SR_MAX_FRAME_RETRIES	0x2c, 0xf0, 4
> >+#define RG_CSMA_SEED_0	(0x2d)
> >+#define SR_CSMA_SEED_0		0x2d, 0xff, 0
> >+#define RG_CSMA_SEED_1	(0x2e)
> >+#define SR_CSMA_SEED_1		0x2e, 0x07, 0
> >+#define SR_AACK_I_AM_COORD	0x2e, 0x08, 3
> >+#define SR_AACK_DIS_ACK		0x2e, 0x10, 4
> >+#define SR_AACK_SET_PD		0x2e, 0x20, 5
> >+#define SR_AACK_FVN_MODE	0x2e, 0xc0, 6
> >+#define RG_CSMA_BE	(0x2f)
> >+#define SR_MIN_BE		0x2f, 0x0f, 0
> >+#define SR_MAX_BE		0x2f, 0xf0, 4
> >+
> >+#define CMD_REG		0x80
> >+#define CMD_REG_MASK	0x3f
> >+#define CMD_WRITE	0x40
> >+#define CMD_FB		0x20
> >+
> >+#define IRQ_BAT_LOW	BIT(7)
> >+#define IRQ_TRX_UR	BIT(6)
> >+#define IRQ_AMI		BIT(5)
> >+#define IRQ_CCA_ED	BIT(4)
> >+#define IRQ_TRX_END	BIT(3)
> >+#define IRQ_RX_START	BIT(2)
> >+#define IRQ_PLL_UNL	BIT(1)
> >+#define IRQ_PLL_LOCK	BIT(0)
> >+
> >+#define IRQ_ACTIVE_HIGH	0
> >+#define IRQ_ACTIVE_LOW	1
> >+
> >+#define STATE_P_ON		0x00	/* BUSY */
> >+#define STATE_BUSY_RX		0x01
> >+#define STATE_BUSY_TX		0x02
> >+#define STATE_FORCE_TRX_OFF	0x03
> >+#define STATE_FORCE_TX_ON	0x04	/* IDLE */
> >+/* 0x05 */				/* INVALID_PARAMETER */
> >+#define STATE_RX_ON		0x06
> >+/* 0x07 */				/* SUCCESS */
> >+#define STATE_TRX_OFF		0x08
> >+#define STATE_TX_ON		0x09
> >+/* 0x0a - 0x0e */			/* 0x0a - UNSUPPORTED_ATTRIBUTE */
> >+#define STATE_SLEEP		0x0F
> >+#define STATE_PREP_DEEP_SLEEP	0x10
> >+#define STATE_BUSY_RX_AACK	0x11
> >+#define STATE_BUSY_TX_ARET	0x12
> >+#define STATE_RX_AACK_ON	0x16
> >+#define STATE_TX_ARET_ON	0x19
> >+#define STATE_RX_ON_NOCLK	0x1C
> >+#define STATE_RX_AACK_ON_NOCLK	0x1D
> >+#define STATE_BUSY_RX_AACK_NOCLK 0x1E
> >+#define STATE_TRANSITION_IN_PROGRESS 0x1F
> >+
> >+#define TRX_STATE_MASK		(0x1F)
> >+
> >+#endif /* !_AT86RF230_H */
> 
> I think I updated some of these defines at some point. Will go through my
> changes and see if I have any updates for this. Nothing imprtant for the
> current functionality so this can go in as is and the other patch follow up
> later. Mostly updated to some former reserved areas iirc.
> 

ok. That's good I just take the current defines from at86rf230 driver (I
did also some small changes there). Then we have fixed version for both
drivers.

> >diff --git a/drivers/net/ieee802154/atusb.c
> >b/drivers/net/ieee802154/atusb.c
> >new file mode 100644
> >index 0000000..ea1259e
> >--- /dev/null
> >+++ b/drivers/net/ieee802154/atusb.c
> >@@ -0,0 +1,692 @@
> >+/*
> >+ * atusb.c - Driver for the ATUSB IEEE 802.15.4 dongle
> >+ *
> >+ * Written 2013 by Werner Almesberger <werner@almesberger.net>
> >+ *
> >+ * This program is free software; you can redistribute it and/or
> >+ * modify it under the terms of the GNU General Public License as
> >+ * published by the Free Software Foundation, version 2
> >+ *
> >+ * Based on at86rf230.c and spi_atusb.c.
> >+ * at86rf230.c is
> >+ * Copyright (C) 2009 Siemens AG
> >+ * Written by: Dmitry Eremin-Solenikov <dmitry.baryshkov@siemens.com>
> >+ *
> >+ * spi_atusb.c is
> >+ * Copyright (c) 2011 Richard Sharpe <realrichardsharpe@gmail.com>
> >+ * Copyright (c) 2011 Stefan Schmidt <stefan@datenfreihafen.org>
> >+ * Copyright (c) 2011 Werner Almesberger <werner@almesberger.net>
> >+ *
> >+ * USB initialization is
> >+ * Copyright (c) 2013 Alexander Aring <alex.aring@gmail.com>
> >+ */
> >+
> >+#include <linux/kernel.h>
> >+#include <linux/slab.h>
> >+#include <linux/module.h>
> >+#include <linux/jiffies.h>
> >+#include <linux/usb.h>
> >+#include <linux/skbuff.h>
> >+
> >+#include <net/cfg802154.h>
> >+#include <net/mac802154.h>
> >+
> >+#include "at86rf230.h"
> >+#include "atusb.h"
> >+
> >+#define ATUSB_JEDEC_ATMEL	0x1f	/* JEDEC manufacturer ID */
> >+
> >+#define ATUSB_NUM_RX_URBS	4	/* allow for a bit of local
> >latency */
> >+#define ATUSB_ALLOC_DELAY_MS	100	/* delay after failed allocation
> >*/
> >+#define ATUSB_TX_TIMEOUT_MS	200	/* on the air timeout */
> >+
> >+struct atusb {
> >+	struct ieee802154_hw *hw;
> >+	struct usb_device *usb_dev;
> >+	int shutdown;			/* non-zero if shutting down */
> >+	int err;			/* set by first error */
> >+
> >+	/* RX variables */
> >+	struct delayed_work work;	/* memory allocations */
> >+	struct usb_anchor idle_urbs;	/* URBs waiting to be submitted */
> >+	struct usb_anchor rx_urbs;	/* URBs waiting for reception */
> >+
> >+	/* TX variables */
> >+	struct usb_ctrlrequest tx_dr;
> >+	struct urb *tx_urb;
> >+	struct sk_buff *tx_skb;
> >+	uint8_t tx_ack_seq;		/* current TX ACK sequence number
> >*/
> >+};
> >+
> >+/* at86rf230.h defines values as <reg, mask, shift> tuples. We use the
> >more
> >+ * traditional style of having registers and or-able values. SR_REG
> >extracts
> >+ * the register number. SR_VALUE uses the shift to prepare a value
> >accordingly.
> >+ */
> >+
> >+#define __SR_REG(reg, mask, shift)	(reg)
> >+#define SR_REG(sr)			__SR_REG(sr)
> >+
> >+#define __SR_VALUE(reg, mask, shift, val)	((val) << (shift))
> >+#define SR_VALUE(sr, val)			__SR_VALUE(sr, (val))
> >+
> >+/* ----- USB commands without data
> >----------------------------------------- */
> >+
> >+/* To reduce the number of error checks in the code, we record the first
> >error
> >+ * in atusb->err and reject all subsequent requests until the error is
> >cleared.
> >+ */
> >+
> >+static int atusb_control_msg(struct atusb *atusb, unsigned int pipe,
> >+			     __u8 request, __u8 requesttype,
> >+			     __u16 value, __u16 index,
> >+			     void *data, __u16 size, int timeout)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	int ret;
> >+
> >+	if (atusb->err)
> >+		return atusb->err;
> >+
> >+	ret = usb_control_msg(usb_dev, pipe, request, requesttype,
> >+			      value, index, data, size, timeout);
> >+	if (ret < 0) {
> >+		atusb->err = ret;
> >+		dev_err(&usb_dev->dev,
> >+			"atusb_control_msg: req 0x%02x val 0x%x idx 0x%x,
> >error %d\n",
> >+			request, value, index, ret);
> >+	}
> >+	return ret;
> >+}
> >+
> >+static int atusb_command(struct atusb *atusb, uint8_t cmd, uint8_t arg)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_command: cmd = 0x%x\n", cmd);
> >+	return atusb_control_msg(atusb, usb_sndctrlpipe(usb_dev, 0),
> >+				 cmd, ATUSB_REQ_TO_DEV, arg, 0, NULL, 0,
> >1000);
> >+}
> >+
> >+static int atusb_write_reg(struct atusb *atusb, uint8_t reg, uint8_t
> >value)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_write_reg: 0x%02x <- 0x%02x\n",
> >+		reg, value);
> >+	return atusb_control_msg(atusb, usb_sndctrlpipe(usb_dev, 0),
> >+				 ATUSB_REG_WRITE, ATUSB_REQ_TO_DEV,
> >+				 value, reg, NULL, 0, 1000);
> >+}
> >+
> >+static int atusb_read_reg(struct atusb *atusb, uint8_t reg)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	int ret;
> >+	uint8_t value;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb: reg = 0x%x\n", reg);
> >+	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
> >+				ATUSB_REG_READ, ATUSB_REQ_FROM_DEV,
> >+				0, reg, &value, 1, 1000);
> >+	return ret >= 0 ? value : ret;
> >+}
> >+
> >+static int atusb_get_and_clear_error(struct atusb *atusb)
> >+{
> >+	int err = atusb->err;
> >+
> >+	atusb->err = 0;
> >+	return err;
> >+}
> >+
> >+/* ----- skb allocation
> >---------------------------------------------------- */
> 
> I was never a fan of these markers but Werner likes them. Keep them in does
> not do any harm.
> 

send patches. The driver isn't perfect but it's good to have them
mainline that we all can contribute now the work for this driver.

> >+
> >+#define MAX_PSDU	127
> >+#define MAX_RX_XFER	(1 + MAX_PSDU + 2 + 1)	/* PHR+PSDU+CRC+LQI */
> >+
> >+#define SKB_ATUSB(skb)	(*(struct atusb **)(skb)->cb)
> >+
> >+static void atusb_in(struct urb *urb);
> >+
> >+static int atusb_submit_rx_urb(struct atusb *atusb, struct urb *urb)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	struct sk_buff *skb = urb->context;
> >+	int ret;
> >+
> >+	if (!skb) {
> >+		skb = alloc_skb(MAX_RX_XFER, GFP_KERNEL);
> >+		if (!skb) {
> >+			dev_warn_ratelimited(&usb_dev->dev,
> >+					     "atusb_in: can't allocate
> >skb\n");
> >+			return -ENOMEM;
> >+		}
> >+		skb_put(skb, MAX_RX_XFER);
> >+		SKB_ATUSB(skb) = atusb;
> >+	}
> >+
> >+	usb_fill_bulk_urb(urb, usb_dev, usb_rcvbulkpipe(usb_dev, 1),
> >+			  skb->data, MAX_RX_XFER, atusb_in, skb);
> >+	usb_anchor_urb(urb, &atusb->rx_urbs);
> >+
> >+	ret = usb_submit_urb(urb, GFP_KERNEL);
> >+	if (ret) {
> >+		usb_unanchor_urb(urb);
> >+		kfree_skb(skb);
> >+		urb->context = NULL;
> >+	}
> >+	return ret;
> >+}
> >+
> >+static void atusb_work_urbs(struct work_struct *work)
> >+{
> >+	struct atusb *atusb =
> >+	    container_of(to_delayed_work(work), struct atusb, work);
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	struct urb *urb;
> >+	int ret;
> >+
> >+	if (atusb->shutdown)
> >+		return;
> >+
> >+	do {
> >+		urb = usb_get_from_anchor(&atusb->idle_urbs);
> >+		if (!urb)
> >+			return;
> >+		ret = atusb_submit_rx_urb(atusb, urb);
> >+	} while (!ret);
> >+
> >+	usb_anchor_urb(urb, &atusb->idle_urbs);
> >+	dev_warn_ratelimited(&usb_dev->dev,
> >+			     "atusb_in: can't allocate/submit URB (%d)\n",
> >ret);
> >+	schedule_delayed_work(&atusb->work,
> >+			      msecs_to_jiffies(ATUSB_ALLOC_DELAY_MS) + 1);
> >+}
> >+
> >+/* ----- Asynchronous USB
> >-------------------------------------------------- */
> >+
> >+static void atusb_tx_done(struct atusb *atusb, uint8_t seq)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	uint8_t expect = atusb->tx_ack_seq;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_tx_done (0x%02x/0x%02x)\n", seq,
> >expect);
> >+	if (seq == expect) {
> >+		/* TODO check for ifs handling in firmware */
> >+		ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> >+	} else {
> >+		/* TODO I experience this case when atusb has a tx
> >complete
> >+		 * irq before probing, we should fix the firmware it's an
> >+		 * unlikely case now that seq == expect is then true, but
> >can
> >+		 * happen and fail with a tx_skb = NULL;
> >+		 */
> 
> 
> Ah, so that comes with the xmit_async change. Looks like a good candidate
> for what I mentioned at the top about haveing a fw release now (0.1) and
> once we fixed the bug in the fw and released a fixed version we can check
> for it here and act according to the fw version. That is the only sane way
> to handle various fw versions I fear without upsetting our users with
> forcing new fw versions for new drivers on them.
> 

If somebody runs an old firmware on newer atusb driver then probing
fails with a message to update the firmware version, or should we
support all backwards supporting with all firmware versions?

> Only alternative I see is to ship compatible versions with linux-firmware to
> match the kernel version.
> 

This is what Marcel also told to me that we should doing that in this way.
The linux-firmware should also accept firmwares for persitent storage,
or is there some way to run dfu inside kernelspace to update the atusb
on the fly? I don't know if something like this exists.

> >+		ieee802154_wake_queue(atusb->hw);
> >+		if (atusb->tx_skb)
> >+			dev_kfree_skb_irq(atusb->tx_skb);
> >+	}
> >+}
> >+
> >+static void atusb_in_good(struct urb *urb)
> >+{
> >+	struct usb_device *usb_dev = urb->dev;
> >+	struct sk_buff *skb = urb->context;
> >+	struct atusb *atusb = SKB_ATUSB(skb);
> >+	uint8_t len, lqi;
> >+
> >+	if (!urb->actual_length) {
> >+		dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
> >+		return;
> >+	}
> >+
> >+	len = *skb->data;
> >+
> >+	if (urb->actual_length == 1) {
> >+		atusb_tx_done(atusb, len);
> >+		return;
> >+	}
> >+
> >+	if (len + 1 > urb->actual_length - 1) {
> >+		dev_dbg(&usb_dev->dev, "atusb_in: frame len %d+1 > URB
> >%u-1\n",
> >+			len, urb->actual_length);
> >+		return;
> >+	}
> >+
> >+	if (!ieee802154_is_valid_psdu_len(len)) {
> >+		dev_dbg(&usb_dev->dev, "atusb_in: frame corrupted\n");
> >+		return;
> >+	}
> >+
> >+	lqi = skb->data[len + 1];
> >+	dev_dbg(&usb_dev->dev, "atusb_in: rx len %d lqi 0x%02x\n", len,
> >lqi);
> >+	skb_pull(skb, 1);	/* remove PHR */
> >+	skb_trim(skb, len);	/* get payload only */
> 
> Hmm, the code I used here still has this:
> skb_trim(skb, len); /* remove CRC */
> 
> Do we now longer need this? Did you change the driver capabilities to match
> this?
> 

I splitted some times ago a hw flag IEEE802154_HW_OMIT_CKSUM. Which was
always that on transmit we have no FCS and while receive we have no
FCS.

But if you run as monitor you usually want to receive the CRC which was
on the air, not an own calculated one which is always correct even when
the frame was corrupted.

To handle backwards compatibility we have now:

#define IEEE802154_HW_OMIT_CKSUM        (IEEE802154_HW_TX_OMIT_CKSUM | \
					 IEEE802154_HW_RX_OMIT_CKSUM)

I changed the flag in atusb to have only IEEE802154_HW_TX_OMIT_CKSUM. We
deliver now the CRC to the next layer. This will remove the crc then
again before frame parsing, but when we support promisucous mode then
this handling will be more correct and the monitor will receive the CRC
which was on the air.

We still need to have:

skb_trim(skb, len);     /* get payload only */

because we need cut the last byte which is the lqi value, maybe this
handling can improved and we can drop this line.


btw: all drivers should be updated to not use IEEE802154_HW_OMIT_CKSUM
and cut the CRC while receiving.

> >+	ieee802154_rx_irqsafe(atusb->hw, skb, lqi);
> >+	urb->context = NULL;	/* skb is gone */
> >+}
> >+
> >+static void atusb_in(struct urb *urb)
> >+{
> >+	struct usb_device *usb_dev = urb->dev;
> >+	struct sk_buff *skb = urb->context;
> >+	struct atusb *atusb = SKB_ATUSB(skb);
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_in: status %d len %d\n",
> >+		urb->status, urb->actual_length);
> >+	if (urb->status) {
> >+		if (urb->status == -ENOENT) { /* being killed */
> >+			kfree_skb(skb);
> >+			urb->context = NULL;
> >+			return;
> >+		}
> >+		dev_dbg(&usb_dev->dev, "atusb_in: URB error %d\n",
> >urb->status);
> >+	} else {
> >+		atusb_in_good(urb);
> >+	}
> >+
> >+	usb_anchor_urb(urb, &atusb->idle_urbs);
> >+	if (!atusb->shutdown)
> >+		schedule_delayed_work(&atusb->work, 0);
> >+}
> >+
> >+/* ----- URB allocation/deallocation
> >--------------------------------------- */
> >+
> >+static void atusb_free_urbs(struct atusb *atusb)
> >+{
> >+	struct urb *urb;
> >+
> >+	while (1) {
> >+		urb = usb_get_from_anchor(&atusb->idle_urbs);
> >+		if (!urb)
> >+			break;
> >+		if (urb->context)
> >+			kfree_skb(urb->context);
> >+		usb_free_urb(urb);
> >+	}
> >+}
> >+
> >+static int atusb_alloc_urbs(struct atusb *atusb, int n)
> >+{
> >+	struct urb *urb;
> >+
> >+	while (n) {
> >+		urb = usb_alloc_urb(0, GFP_KERNEL);
> >+		if (!urb) {
> >+			atusb_free_urbs(atusb);
> >+			return -ENOMEM;
> >+		}
> >+		usb_anchor_urb(urb, &atusb->idle_urbs);
> >+		n--;
> >+	}
> >+	return 0;
> >+}
> >+
> >+/* ----- IEEE 802.15.4 interface operations
> >-------------------------------- */
> >+
> >+static void atusb_xmit_complete(struct urb *urb)
> >+{
> >+	dev_dbg(&urb->dev->dev, "atusb_xmit urb completed");
> >+}
> >+
> >+static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
> >+{
> >+	struct atusb *atusb = hw->priv;
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	int ret;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_xmit (%d)\n", skb->len);
> >+	atusb->tx_skb = skb;
> >+	atusb->tx_ack_seq++;
> >+	atusb->tx_dr.wIndex = cpu_to_le16(atusb->tx_ack_seq);
> >+	atusb->tx_dr.wLength = cpu_to_le16(skb->len);
> >+
> >+	usb_fill_control_urb(atusb->tx_urb, usb_dev,
> >+			     usb_sndctrlpipe(usb_dev, 0),
> >+			     (unsigned char *)&atusb->tx_dr, skb->data,
> >+			     skb->len, atusb_xmit_complete, NULL);
> >+	ret = usb_submit_urb(atusb->tx_urb, GFP_ATOMIC);
> >+	dev_dbg(&usb_dev->dev, "atusb_xmit done (%d)\n", ret);
> >+	return ret;
> >+}
> >+
> >+static int atusb_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> >+{
> >+	struct atusb *atusb = hw->priv;
> >+	int ret;
> >+
> >+	/* This implicitly sets the CCA (Clear Channel Assessment) mode to
> >0,
> >+	 * "Mode 3a, Carrier sense OR energy above threshold".
> >+	 * We should probably make this configurable. @@@
> >+	 */
> >+	ret = atusb_write_reg(atusb, RG_PHY_CC_CCA, channel);
> >+	if (ret < 0)
> >+		return ret;
> >+	msleep(1);	/* @@@ ugly synchronization */
> 
> The hw->phy->current_channel = channel; is no longer needed here? Does the
> stack handle this part now?
> 

yes. See [0].

> >+	return 0;
> >+}
> >+
> >+static int atusb_ed(struct ieee802154_hw *hw, u8 *level)
> >+{
> >+	/* @@@ not used by the stack yet */
> >+	*level = 0;
> >+	return 0;
> >+}
> >+
> >+static int atusb_set_hw_addr_filt(struct ieee802154_hw *hw,
> >+				  struct ieee802154_hw_addr_filt *filt,
> >+				  unsigned long changed)
> >+{
> >+	struct atusb *atusb = hw->priv;
> >+	struct device *dev = &atusb->usb_dev->dev;
> >+	uint8_t reg;
> >+
> >+	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
> >+		u16 addr = le16_to_cpu(filt->short_addr);
> >+
> >+		dev_vdbg(dev, "atusb_set_hw_addr_filt called for
> >saddr\n");
> >+		atusb_write_reg(atusb, RG_SHORT_ADDR_0, addr);
> >+		atusb_write_reg(atusb, RG_SHORT_ADDR_1, addr >> 8);
> >+	}
> >+
> >+	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
> >+		u16 pan = le16_to_cpu(filt->pan_id);
> >+
> >+		dev_vdbg(dev, "atusb_set_hw_addr_filt called for pan
> >id\n");
> >+		atusb_write_reg(atusb, RG_PAN_ID_0, pan);
> >+		atusb_write_reg(atusb, RG_PAN_ID_1, pan >> 8);
> >+	}
> >+
> >+	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
> >+		u8 i, addr[IEEE802154_EXTENDED_ADDR_LEN];
> >+
> >+		memcpy(addr, &filt->ieee_addr,
> >IEEE802154_EXTENDED_ADDR_LEN);
> >+		dev_vdbg(dev, "atusb_set_hw_addr_filt called for IEEE
> >addr\n");
> >+		for (i = 0; i < 8; i++)
> >+			atusb_write_reg(atusb, RG_IEEE_ADDR_0 + i,
> >addr[i]);
> >+	}
> >+
> >+	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
> >+		dev_vdbg(dev,
> >+			 "atusb_set_hw_addr_filt called for panc
> >change\n");
> >+		reg = atusb_read_reg(atusb, SR_REG(SR_AACK_I_AM_COORD));
> >+		if (filt->pan_coord)
> >+			reg |= SR_VALUE(SR_AACK_I_AM_COORD, 1);
> >+		else
> >+			reg &= ~SR_VALUE(SR_AACK_I_AM_COORD, 1);
> >+		atusb_write_reg(atusb, SR_REG(SR_AACK_I_AM_COORD), reg);
> >+	}
> >+
> >+	return atusb_get_and_clear_error(atusb);
> >+}
> >+
> >+static int atusb_start(struct ieee802154_hw *hw)
> >+{
> >+	struct atusb *atusb = hw->priv;
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	int ret;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_start\n");
> >+	schedule_delayed_work(&atusb->work, 0);
> >+	atusb_command(atusb, ATUSB_RX_MODE, 1);
> >+	ret = atusb_get_and_clear_error(atusb);
> >+	if (ret < 0)
> >+		usb_kill_anchored_urbs(&atusb->idle_urbs);
> >+	return ret;
> >+}
> >+
> >+static void atusb_stop(struct ieee802154_hw *hw)
> >+{
> >+	struct atusb *atusb = hw->priv;
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+
> >+	dev_dbg(&usb_dev->dev, "atusb_stop\n");
> >+	usb_kill_anchored_urbs(&atusb->idle_urbs);
> >+	atusb_command(atusb, ATUSB_RX_MODE, 0);
> >+	atusb_get_and_clear_error(atusb);
> >+}
> >+
> >+static struct ieee802154_ops atusb_ops = {
> >+	.owner			= THIS_MODULE,
> >+	.xmit_async		= atusb_xmit,
> >+	.ed			= atusb_ed,
> >+	.set_channel		= atusb_channel,
> >+	.start			= atusb_start,
> >+	.stop			= atusb_stop,
> >+	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
> >+};
> >+
> >+/* ----- Firmware and chip version information
> >----------------------------- */
> >+
> >+static int atusb_get_and_show_revision(struct atusb *atusb)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	unsigned char buffer[3];
> >+	int ret;
> >+
> >+	/* Get a couple of the ATMega Firmware values */
> >+	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
> >+				ATUSB_ID, ATUSB_REQ_FROM_DEV, 0, 0,
> >+				buffer, 3, 1000);
> >+	if (ret >= 0)
> >+		dev_info(&usb_dev->dev,
> >+			 "Firmware: major: %u, minor: %u, hardware type:
> >%u\n",
> >+			 buffer[0], buffer[1], buffer[2]);
> >+
> >+	return ret;
> >+}
> >+
> >+static int atusb_get_and_show_build(struct atusb *atusb)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	char build[ATUSB_BUILD_SIZE + 1];
> >+	int ret;
> >+
> >+	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
> >+				ATUSB_BUILD, ATUSB_REQ_FROM_DEV, 0, 0,
> >+				build, ATUSB_BUILD_SIZE, 1000);
> >+	if (ret >= 0) {
> >+		build[ret] = 0;
> >+		dev_info(&usb_dev->dev, "Firmware: build %s\n", build);
> >+	}
> >+
> >+	return ret;
> >+}
> >+
> >+static int atusb_get_and_show_chip(struct atusb *atusb)
> >+{
> >+	struct usb_device *usb_dev = atusb->usb_dev;
> >+	uint8_t man_id_0, man_id_1, part_num, version_num;
> >+
> >+	man_id_0 = atusb_read_reg(atusb, RG_MAN_ID_0);
> >+	man_id_1 = atusb_read_reg(atusb, RG_MAN_ID_1);
> >+	part_num = atusb_read_reg(atusb, RG_PART_NUM);
> >+	version_num = atusb_read_reg(atusb, RG_VERSION_NUM);
> >+
> >+	if (atusb->err)
> >+		return atusb->err;
> >+
> >+	if ((man_id_1 << 8 | man_id_0) != ATUSB_JEDEC_ATMEL) {
> >+		dev_err(&usb_dev->dev,
> >+			"non-Atmel transceiver xxxx%02x%02x\n",
> >+			man_id_1, man_id_0);
> >+		goto fail;
> >+	}
> >+	if (part_num != 3) {
> >+		dev_err(&usb_dev->dev,
> >+			"unexpected transceiver, part 0x%02x version
> >0x%02x\n",
> >+			part_num, version_num);
> >+		goto fail;
> >+	}
> >+
> >+	dev_info(&usb_dev->dev, "ATUSB: AT86RF231 version %d\n",
> >version_num);
> >+
> >+	return 0;
> >+
> >+fail:
> >+	atusb->err = -ENODEV;
> >+	return -ENODEV;
> >+}
> >+
> >+/* ----- Setup
> >------------------------------------------------------------- */
> >+
> >+static int atusb_probe(struct usb_interface *interface,
> >+		       const struct usb_device_id *id)
> >+{
> >+	struct usb_device *usb_dev = interface_to_usbdev(interface);
> >+	struct ieee802154_hw *hw;
> >+	struct atusb *atusb = NULL;
> >+	int ret = -ENOMEM;
> >+
> >+	hw = ieee802154_alloc_hw(sizeof(struct atusb), &atusb_ops);
> >+	if (!hw)
> >+		return -ENOMEM;
> >+
> >+	atusb = hw->priv;
> >+	atusb->hw = hw;
> >+	atusb->usb_dev = usb_get_dev(usb_dev);
> >+	usb_set_intfdata(interface, atusb);
> >+
> >+	atusb->shutdown = 0;
> >+	atusb->err = 0;
> >+	INIT_DELAYED_WORK(&atusb->work, atusb_work_urbs);
> >+	init_usb_anchor(&atusb->idle_urbs);
> >+	init_usb_anchor(&atusb->rx_urbs);
> >+
> >+	if (atusb_alloc_urbs(atusb, ATUSB_NUM_RX_URBS))
> >+		goto fail;
> >+
> >+	atusb->tx_dr.bRequestType = ATUSB_REQ_TO_DEV;
> >+	atusb->tx_dr.bRequest = ATUSB_TX;
> >+	atusb->tx_dr.wValue = cpu_to_le16(0);
> 
> What are these three lines for? ^^
> 

atusb->tx_dr is for async_xmit handling. These values are always the
same and I just setup this structure in probing time instead of setting
always the static value in async_xmit handling.

The async_xmit sets now only the tx_ack_seq which is a dynamic value and
skb->len.

> >+	atusb->tx_urb = usb_alloc_urb(0, GFP_ATOMIC);
> >+	if (!atusb->tx_urb)
> >+		goto fail;
> >+
> >+	hw->parent = &usb_dev->dev;
> >+	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
> >+
> >+	hw->phy->current_page = 0;
> >+	hw->phy->current_channel = 11;	/* reset default */
> >+	hw->phy->supported.channels[0] = 0x7FFF800;
> >+	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> >+
> >+	atusb_command(atusb, ATUSB_RF_RESET, 0);
> >+	atusb_get_and_show_chip(atusb);
> >+	atusb_get_and_show_revision(atusb);
> >+	atusb_get_and_show_build(atusb);
> >+	ret = atusb_get_and_clear_error(atusb);
> >+	if (ret) {
> >+		dev_err(&atusb->usb_dev->dev,
> >+			"%s: initialization failed, error = %d\n",
> >+			__func__, ret);
> >+		goto fail;
> >+	}
> >+
> >+	ret = ieee802154_register_hw(hw);
> >+	if (ret)
> >+		goto fail;
> >+
> >+	/* If we just powered on, we're now in P_ON and need to enter
> >TRX_OFF
> >+	 * explicitly. Any resets after that will send us straight to
> >TRX_OFF,
> >+	 * making the command below redundant.
> >+	 */
> >+	atusb_write_reg(atusb, RG_TRX_STATE, STATE_FORCE_TRX_OFF);
> >+	msleep(1);	/* reset => TRX_OFF, tTR13 = 37 us */
> >+
> >+#if 0
> >+	/* Calculating the maximum time available to empty the frame
> >buffer
> >+	 * on reception:
> >+	 *
> >+	 * According to [1], the inter-frame gap is
> >+	 * R * 20 * 16 us + 128 us
> >+	 * where R is a random number from 0 to 7. Furthermore, we have 20
> >bit
> >+	 * times (80 us at 250 kbps) of SHR of the next frame before the
> >+	 * transceiver begins storing data in the frame buffer.
> >+	 *
> >+	 * This yields a minimum time of 208 us between the last data of a
> >+	 * frame and the first data of the next frame. This time is
> >further
> >+	 * reduced by interrupt latency in the atusb firmware.
> >+	 *
> >+	 * atusb currently needs about 500 us to retrieve a maximum-sized
> >+	 * frame. We therefore have to allow reception of a new frame to
> >begin
> >+	 * while we retrieve the previous frame.
> >+	 *
> >+	 * [1] "JN-AN-1035 Calculating data rates in an IEEE
> >802.15.4-based
> >+	 *      network", Jennic 2006.
> >+	 *
> >http://www.jennic.com/download_file.php?supportFile=JN-AN-1035%20Calculati
> >ng%20802-15-4%20Data%20Rates-1v0.pdf
> >+	 */
> >+
> >+	atusb_write_reg(atusb,
> >+			SR_REG(SR_RX_SAFE_MODE), SR_VALUE(SR_RX_SAFE_MODE,
> >1));
> >+#endif
> >+	atusb_write_reg(atusb, RG_IRQ_MASK, 0xff);
> >+
> >+	ret = atusb_get_and_clear_error(atusb);
> >+	if (!ret)
> >+		return 0;
> >+
> >+	dev_err(&atusb->usb_dev->dev,
> >+		"%s: setup failed, error = %d\n",
> >+		__func__, ret);
> >+
> >+	ieee802154_unregister_hw(hw);
> >+fail:
> >+	atusb_free_urbs(atusb);
> >+	usb_kill_urb(atusb->tx_urb);
> >+	usb_free_urb(atusb->tx_urb);
> >+	usb_put_dev(usb_dev);
> >+	ieee802154_free_hw(hw);
> >+	return ret;
> >+}
> >+
> >+static void atusb_disconnect(struct usb_interface *interface)
> >+{
> >+	struct atusb *atusb = usb_get_intfdata(interface);
> >+
> >+	dev_dbg(&atusb->usb_dev->dev, "atusb_disconnect\n");
> >+
> >+	atusb->shutdown = 1;
> >+	cancel_delayed_work_sync(&atusb->work);
> >+
> >+	usb_kill_anchored_urbs(&atusb->rx_urbs);
> >+	atusb_free_urbs(atusb);
> >+	usb_kill_urb(atusb->tx_urb);
> >+	usb_free_urb(atusb->tx_urb);
> >+
> >+	ieee802154_unregister_hw(atusb->hw);
> >+
> >+	ieee802154_free_hw(atusb->hw);
> >+
> >+	usb_set_intfdata(interface, NULL);
> >+	usb_put_dev(atusb->usb_dev);
> >+
> >+	pr_debug("atusb_disconnect done\n");
> >+}
> >+
> >+/* The devices we work with */
> >+static const struct usb_device_id atusb_device_table[] = {
> >+	{
> >+		.match_flags		= USB_DEVICE_ID_MATCH_DEVICE |
> >+					  USB_DEVICE_ID_MATCH_INT_INFO,
> >+		.idVendor		= ATUSB_VENDOR_ID,
> >+		.idProduct		= ATUSB_PRODUCT_ID,
> >+		.bInterfaceClass	= USB_CLASS_VENDOR_SPEC
> >+	},
> >+	/* end with null element */
> >+	{}
> >+};
> >+MODULE_DEVICE_TABLE(usb, atusb_device_table);
> >+
> >+static struct usb_driver atusb_driver = {
> >+	.name		= "atusb",
> >+	.probe		= atusb_probe,
> >+	.disconnect	= atusb_disconnect,
> >+	.id_table	= atusb_device_table,
> >+};
> >+module_usb_driver(atusb_driver);
> >+
> >+MODULE_AUTHOR("Alexander Aring <alex.aring@gmail.com>");
> >+MODULE_AUTHOR("Richard Sharpe <realrichardsharpe@gmail.com>");
> >+MODULE_AUTHOR("Stefan Schmidt <stefan@datenfreihafen.org>");
> >+MODULE_AUTHOR("Werner Almesberger <werner@almesberger.net>");
> >+MODULE_DESCRIPTION("ATUSB IEEE 802.15.4 Driver");
> >+MODULE_LICENSE("GPL");
> >diff --git a/drivers/net/ieee802154/atusb.h
> >b/drivers/net/ieee802154/atusb.h
> >new file mode 100644
> >index 0000000..0690edc
> >--- /dev/null
> >+++ b/drivers/net/ieee802154/atusb.h
> >@@ -0,0 +1,84 @@
> >+/*
> >+ * atusb.h - Definitions shared between kernel and ATUSB firmware
> >+ *
> >+ * Written 2013 by Werner Almesberger <werner@almesberger.net>
> >+ *
> >+ * This program is free software; you can redistribute it and/or
> >+ * modify it under the terms of the GNU General Public License as
> >+ * published by the Free Software Foundation, version 2, or
> >+ * (at your option) any later version.
> >+ *
> >+ * This file should be identical for kernel and firmware.
> >+ * Kernel: drivers/net/ieee802154/atusb.h
> >+ * Firmware: ben-wpan/atusb/fw/include/atusb/atusb.h
> >+ */
> >+
> >+#ifndef _ATUSB_H
> >+#define _ATUSB_H
> >+
> >+#define ATUSB_VENDOR_ID	0x20b7	/* Qi Hardware*/
> >+#define ATUSB_PRODUCT_ID 0x1540	/* 802.15.4, device 0 */
> >+				/*     -- -         - */
> >+
> >+#define ATUSB_BUILD_SIZE 256	/* maximum build version/date message
> >length */
> >+
> >+/* Commands to our device. Make sure this is synced with the firmware */
> >+enum atusb_requests {
> >+	ATUSB_ID			= 0x00,	/* system status/control
> >grp */
> >+	ATUSB_BUILD,
> >+	ATUSB_RESET,
> >+	ATUSB_RF_RESET			= 0x10,	/* debug/test group */
> >+	ATUSB_POLL_INT,
> >+	ATUSB_TEST,			/* atusb-sil only */
> >+	ATUSB_TIMER,
> >+	ATUSB_GPIO,
> >+	ATUSB_SLP_TR,
> >+	ATUSB_GPIO_CLEANUP,
> >+	ATUSB_REG_WRITE			= 0x20,	/* transceiver group */
> >+	ATUSB_REG_READ,
> >+	ATUSB_BUF_WRITE,
> >+	ATUSB_BUF_READ,
> >+	ATUSB_SRAM_WRITE,
> >+	ATUSB_SRAM_READ,
> >+	ATUSB_SPI_WRITE			= 0x30,	/* SPI group */
> >+	ATUSB_SPI_READ1,
> >+	ATUSB_SPI_READ2,
> >+	ATUSB_SPI_WRITE2_SYNC,
> >+	ATUSB_RX_MODE			= 0x40, /* HardMAC group */
> >+	ATUSB_TX,
> >+};
> >+
> >+/* Direction	bRequest		wValue		wIndex	wLength
> >+ *
> >+ * ->host	ATUSB_ID		-		-	3
> >+ * ->host	ATUSB_BUILD		-		-	#bytes
> >+ * host->	ATUSB_RESET		-		-	0
> >+ *
> >+ * host->	ATUSB_RF_RESET		-		-	0
> >+ * ->host	ATUSB_POLL_INT		-		-	1
> >+ * host->	ATUSB_TEST		-		-	0
> >+ * ->host	ATUSB_TIMER		-		-	#bytes (6)
> >+ * ->host	ATUSB_GPIO		dir+data	mask+p#	3
> >+ * host->	ATUSB_SLP_TR		-		-	0
> >+ * host->	ATUSB_GPIO_CLEANUP	-		-	0
> >+ *
> >+ * host->	ATUSB_REG_WRITE		value		addr	0
> >+ * ->host	ATUSB_REG_READ		-		addr	1
> >+ * host->	ATUSB_BUF_WRITE		-		-	#bytes
> >+ * ->host	ATUSB_BUF_READ		-		-	#bytes
> >+ * host->	ATUSB_SRAM_WRITE	-		addr	#bytes
> >+ * ->host	ATUSB_SRAM_READ		-		addr	#bytes
> >+ *
> >+ * host->	ATUSB_SPI_WRITE		byte0		byte1	#bytes
> >+ * ->host	ATUSB_SPI_READ1		byte0		-	#bytes
> >+ * ->host	ATUSB_SPI_READ2		byte0		byte1	#bytes
> >+ * ->host	ATUSB_SPI_WRITE2_SYNC	byte0		byte1	0/1
> >+ *
> >+ * host->	ATUSB_RX_MODE		on		-	0
> >+ * host->	ATUSB_TX		flags		ack_seq	#bytes
> >+ */
> >+
> >+#define ATUSB_REQ_FROM_DEV	(USB_TYPE_VENDOR | USB_DIR_IN)
> >+#define ATUSB_REQ_TO_DEV	(USB_TYPE_VENDOR | USB_DIR_OUT)
> >+
> >+#endif /* !_ATUSB_H */
> >
> 
> Besides the mentioned things this looks fine. Will give it some testing
> later this week.
> 

ok.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac802154/cfg.c#L77
