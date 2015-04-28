Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32778 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965999AbbD1VX3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Apr 2015 17:23:29 -0400
Received: by wief7 with SMTP id f7so26458377wie.0
        for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2015 14:23:28 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-next 1/6] at86rf230: remove tabs after define
Date: Tue, 28 Apr 2015 23:22:29 +0200
Message-Id: <1430256154-1813-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430256154-1813-1-git-send-email-alex.aring@gmail.com>
References: <1430256154-1813-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the at86rf230 driver to use a space instead a tab
after define.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 304 ++++++++++++++++++-------------------
 1 file changed, 152 insertions(+), 152 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 684488a..9a41deb 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -100,158 +100,158 @@ struct at86rf230_local {
 	struct at86rf230_state_change tx;
 };
 
-#define	RG_TRX_STATUS	(0x01)
-#define	SR_TRX_STATUS		0x01, 0x1f, 0
-#define	SR_RESERVED_01_3	0x01, 0x20, 5
-#define	SR_CCA_STATUS		0x01, 0x40, 6
-#define	SR_CCA_DONE		0x01, 0x80, 7
-#define	RG_TRX_STATE	(0x02)
-#define	SR_TRX_CMD		0x02, 0x1f, 0
-#define	SR_TRAC_STATUS		0x02, 0xe0, 5
-#define	RG_TRX_CTRL_0	(0x03)
-#define	SR_CLKM_CTRL		0x03, 0x07, 0
-#define	SR_CLKM_SHA_SEL		0x03, 0x08, 3
-#define	SR_PAD_IO_CLKM		0x03, 0x30, 4
-#define	SR_PAD_IO		0x03, 0xc0, 6
-#define	RG_TRX_CTRL_1	(0x04)
-#define	SR_IRQ_POLARITY		0x04, 0x01, 0
-#define	SR_IRQ_MASK_MODE	0x04, 0x02, 1
-#define	SR_SPI_CMD_MODE		0x04, 0x0c, 2
-#define	SR_RX_BL_CTRL		0x04, 0x10, 4
-#define	SR_TX_AUTO_CRC_ON	0x04, 0x20, 5
-#define	SR_IRQ_2_EXT_EN		0x04, 0x40, 6
-#define	SR_PA_EXT_EN		0x04, 0x80, 7
-#define	RG_PHY_TX_PWR	(0x05)
-#define	SR_TX_PWR		0x05, 0x0f, 0
-#define	SR_PA_LT		0x05, 0x30, 4
-#define	SR_PA_BUF_LT		0x05, 0xc0, 6
-#define	RG_PHY_RSSI	(0x06)
-#define	SR_RSSI			0x06, 0x1f, 0
-#define	SR_RND_VALUE		0x06, 0x60, 5
-#define	SR_RX_CRC_VALID		0x06, 0x80, 7
-#define	RG_PHY_ED_LEVEL	(0x07)
-#define	SR_ED_LEVEL		0x07, 0xff, 0
-#define	RG_PHY_CC_CCA	(0x08)
-#define	SR_CHANNEL		0x08, 0x1f, 0
-#define	SR_CCA_MODE		0x08, 0x60, 5
-#define	SR_CCA_REQUEST		0x08, 0x80, 7
-#define	RG_CCA_THRES	(0x09)
-#define	SR_CCA_ED_THRES		0x09, 0x0f, 0
-#define	SR_RESERVED_09_1	0x09, 0xf0, 4
-#define	RG_RX_CTRL	(0x0a)
-#define	SR_PDT_THRES		0x0a, 0x0f, 0
-#define	SR_RESERVED_0a_1	0x0a, 0xf0, 4
-#define	RG_SFD_VALUE	(0x0b)
-#define	SR_SFD_VALUE		0x0b, 0xff, 0
-#define	RG_TRX_CTRL_2	(0x0c)
-#define	SR_OQPSK_DATA_RATE	0x0c, 0x03, 0
-#define	SR_SUB_MODE		0x0c, 0x04, 2
-#define	SR_BPSK_QPSK		0x0c, 0x08, 3
-#define	SR_OQPSK_SUB1_RC_EN	0x0c, 0x10, 4
-#define	SR_RESERVED_0c_5	0x0c, 0x60, 5
-#define	SR_RX_SAFE_MODE		0x0c, 0x80, 7
-#define	RG_ANT_DIV	(0x0d)
-#define	SR_ANT_CTRL		0x0d, 0x03, 0
-#define	SR_ANT_EXT_SW_EN	0x0d, 0x04, 2
-#define	SR_ANT_DIV_EN		0x0d, 0x08, 3
-#define	SR_RESERVED_0d_2	0x0d, 0x70, 4
-#define	SR_ANT_SEL		0x0d, 0x80, 7
-#define	RG_IRQ_MASK	(0x0e)
-#define	SR_IRQ_MASK		0x0e, 0xff, 0
-#define	RG_IRQ_STATUS	(0x0f)
-#define	SR_IRQ_0_PLL_LOCK	0x0f, 0x01, 0
-#define	SR_IRQ_1_PLL_UNLOCK	0x0f, 0x02, 1
-#define	SR_IRQ_2_RX_START	0x0f, 0x04, 2
-#define	SR_IRQ_3_TRX_END	0x0f, 0x08, 3
-#define	SR_IRQ_4_CCA_ED_DONE	0x0f, 0x10, 4
-#define	SR_IRQ_5_AMI		0x0f, 0x20, 5
-#define	SR_IRQ_6_TRX_UR		0x0f, 0x40, 6
-#define	SR_IRQ_7_BAT_LOW	0x0f, 0x80, 7
-#define	RG_VREG_CTRL	(0x10)
-#define	SR_RESERVED_10_6	0x10, 0x03, 0
-#define	SR_DVDD_OK		0x10, 0x04, 2
-#define	SR_DVREG_EXT		0x10, 0x08, 3
-#define	SR_RESERVED_10_3	0x10, 0x30, 4
-#define	SR_AVDD_OK		0x10, 0x40, 6
-#define	SR_AVREG_EXT		0x10, 0x80, 7
-#define	RG_BATMON	(0x11)
-#define	SR_BATMON_VTH		0x11, 0x0f, 0
-#define	SR_BATMON_HR		0x11, 0x10, 4
-#define	SR_BATMON_OK		0x11, 0x20, 5
-#define	SR_RESERVED_11_1	0x11, 0xc0, 6
-#define	RG_XOSC_CTRL	(0x12)
-#define	SR_XTAL_TRIM		0x12, 0x0f, 0
-#define	SR_XTAL_MODE		0x12, 0xf0, 4
-#define	RG_RX_SYN	(0x15)
-#define	SR_RX_PDT_LEVEL		0x15, 0x0f, 0
-#define	SR_RESERVED_15_2	0x15, 0x70, 4
-#define	SR_RX_PDT_DIS		0x15, 0x80, 7
-#define	RG_XAH_CTRL_1	(0x17)
-#define	SR_RESERVED_17_8	0x17, 0x01, 0
-#define	SR_AACK_PROM_MODE	0x17, 0x02, 1
-#define	SR_AACK_ACK_TIME	0x17, 0x04, 2
-#define	SR_RESERVED_17_5	0x17, 0x08, 3
-#define	SR_AACK_UPLD_RES_FT	0x17, 0x10, 4
-#define	SR_AACK_FLTR_RES_FT	0x17, 0x20, 5
-#define	SR_CSMA_LBT_MODE	0x17, 0x40, 6
-#define	SR_RESERVED_17_1	0x17, 0x80, 7
-#define	RG_FTN_CTRL	(0x18)
-#define	SR_RESERVED_18_2	0x18, 0x7f, 0
-#define	SR_FTN_START		0x18, 0x80, 7
-#define	RG_PLL_CF	(0x1a)
-#define	SR_RESERVED_1a_2	0x1a, 0x7f, 0
-#define	SR_PLL_CF_START		0x1a, 0x80, 7
-#define	RG_PLL_DCU	(0x1b)
-#define	SR_RESERVED_1b_3	0x1b, 0x3f, 0
-#define	SR_RESERVED_1b_2	0x1b, 0x40, 6
-#define	SR_PLL_DCU_START	0x1b, 0x80, 7
-#define	RG_PART_NUM	(0x1c)
-#define	SR_PART_NUM		0x1c, 0xff, 0
-#define	RG_VERSION_NUM	(0x1d)
-#define	SR_VERSION_NUM		0x1d, 0xff, 0
-#define	RG_MAN_ID_0	(0x1e)
-#define	SR_MAN_ID_0		0x1e, 0xff, 0
-#define	RG_MAN_ID_1	(0x1f)
-#define	SR_MAN_ID_1		0x1f, 0xff, 0
-#define	RG_SHORT_ADDR_0	(0x20)
-#define	SR_SHORT_ADDR_0		0x20, 0xff, 0
-#define	RG_SHORT_ADDR_1	(0x21)
-#define	SR_SHORT_ADDR_1		0x21, 0xff, 0
-#define	RG_PAN_ID_0	(0x22)
-#define	SR_PAN_ID_0		0x22, 0xff, 0
-#define	RG_PAN_ID_1	(0x23)
-#define	SR_PAN_ID_1		0x23, 0xff, 0
-#define	RG_IEEE_ADDR_0	(0x24)
-#define	SR_IEEE_ADDR_0		0x24, 0xff, 0
-#define	RG_IEEE_ADDR_1	(0x25)
-#define	SR_IEEE_ADDR_1		0x25, 0xff, 0
-#define	RG_IEEE_ADDR_2	(0x26)
-#define	SR_IEEE_ADDR_2		0x26, 0xff, 0
-#define	RG_IEEE_ADDR_3	(0x27)
-#define	SR_IEEE_ADDR_3		0x27, 0xff, 0
-#define	RG_IEEE_ADDR_4	(0x28)
-#define	SR_IEEE_ADDR_4		0x28, 0xff, 0
-#define	RG_IEEE_ADDR_5	(0x29)
-#define	SR_IEEE_ADDR_5		0x29, 0xff, 0
-#define	RG_IEEE_ADDR_6	(0x2a)
-#define	SR_IEEE_ADDR_6		0x2a, 0xff, 0
-#define	RG_IEEE_ADDR_7	(0x2b)
-#define	SR_IEEE_ADDR_7		0x2b, 0xff, 0
-#define	RG_XAH_CTRL_0	(0x2c)
-#define	SR_SLOTTED_OPERATION	0x2c, 0x01, 0
-#define	SR_MAX_CSMA_RETRIES	0x2c, 0x0e, 1
-#define	SR_MAX_FRAME_RETRIES	0x2c, 0xf0, 4
-#define	RG_CSMA_SEED_0	(0x2d)
-#define	SR_CSMA_SEED_0		0x2d, 0xff, 0
-#define	RG_CSMA_SEED_1	(0x2e)
-#define	SR_CSMA_SEED_1		0x2e, 0x07, 0
-#define	SR_AACK_I_AM_COORD	0x2e, 0x08, 3
-#define	SR_AACK_DIS_ACK		0x2e, 0x10, 4
-#define	SR_AACK_SET_PD		0x2e, 0x20, 5
-#define	SR_AACK_FVN_MODE	0x2e, 0xc0, 6
-#define	RG_CSMA_BE	(0x2f)
-#define	SR_MIN_BE		0x2f, 0x0f, 0
-#define	SR_MAX_BE		0x2f, 0xf0, 4
+#define RG_TRX_STATUS	(0x01)
+#define SR_TRX_STATUS		0x01, 0x1f, 0
+#define SR_RESERVED_01_3	0x01, 0x20, 5
+#define SR_CCA_STATUS		0x01, 0x40, 6
+#define SR_CCA_DONE		0x01, 0x80, 7
+#define RG_TRX_STATE	(0x02)
+#define SR_TRX_CMD		0x02, 0x1f, 0
+#define SR_TRAC_STATUS		0x02, 0xe0, 5
+#define RG_TRX_CTRL_0	(0x03)
+#define SR_CLKM_CTRL		0x03, 0x07, 0
+#define SR_CLKM_SHA_SEL		0x03, 0x08, 3
+#define SR_PAD_IO_CLKM		0x03, 0x30, 4
+#define SR_PAD_IO		0x03, 0xc0, 6
+#define RG_TRX_CTRL_1	(0x04)
+#define SR_IRQ_POLARITY		0x04, 0x01, 0
+#define SR_IRQ_MASK_MODE	0x04, 0x02, 1
+#define SR_SPI_CMD_MODE		0x04, 0x0c, 2
+#define SR_RX_BL_CTRL		0x04, 0x10, 4
+#define SR_TX_AUTO_CRC_ON	0x04, 0x20, 5
+#define SR_IRQ_2_EXT_EN		0x04, 0x40, 6
+#define SR_PA_EXT_EN		0x04, 0x80, 7
+#define RG_PHY_TX_PWR	(0x05)
+#define SR_TX_PWR		0x05, 0x0f, 0
+#define SR_PA_LT		0x05, 0x30, 4
+#define SR_PA_BUF_LT		0x05, 0xc0, 6
+#define RG_PHY_RSSI	(0x06)
+#define SR_RSSI			0x06, 0x1f, 0
+#define SR_RND_VALUE		0x06, 0x60, 5
+#define SR_RX_CRC_VALID		0x06, 0x80, 7
+#define RG_PHY_ED_LEVEL	(0x07)
+#define SR_ED_LEVEL		0x07, 0xff, 0
+#define RG_PHY_CC_CCA	(0x08)
+#define SR_CHANNEL		0x08, 0x1f, 0
+#define SR_CCA_MODE		0x08, 0x60, 5
+#define SR_CCA_REQUEST		0x08, 0x80, 7
+#define RG_CCA_THRES	(0x09)
+#define SR_CCA_ED_THRES		0x09, 0x0f, 0
+#define SR_RESERVED_09_1	0x09, 0xf0, 4
+#define RG_RX_CTRL	(0x0a)
+#define SR_PDT_THRES		0x0a, 0x0f, 0
+#define SR_RESERVED_0a_1	0x0a, 0xf0, 4
+#define RG_SFD_VALUE	(0x0b)
+#define SR_SFD_VALUE		0x0b, 0xff, 0
+#define RG_TRX_CTRL_2	(0x0c)
+#define SR_OQPSK_DATA_RATE	0x0c, 0x03, 0
+#define SR_SUB_MODE		0x0c, 0x04, 2
+#define SR_BPSK_QPSK		0x0c, 0x08, 3
+#define SR_OQPSK_SUB1_RC_EN	0x0c, 0x10, 4
+#define SR_RESERVED_0c_5	0x0c, 0x60, 5
+#define SR_RX_SAFE_MODE		0x0c, 0x80, 7
+#define RG_ANT_DIV	(0x0d)
+#define SR_ANT_CTRL		0x0d, 0x03, 0
+#define SR_ANT_EXT_SW_EN	0x0d, 0x04, 2
+#define SR_ANT_DIV_EN		0x0d, 0x08, 3
+#define SR_RESERVED_0d_2	0x0d, 0x70, 4
+#define SR_ANT_SEL		0x0d, 0x80, 7
+#define RG_IRQ_MASK	(0x0e)
+#define SR_IRQ_MASK		0x0e, 0xff, 0
+#define RG_IRQ_STATUS	(0x0f)
+#define SR_IRQ_0_PLL_LOCK	0x0f, 0x01, 0
+#define SR_IRQ_1_PLL_UNLOCK	0x0f, 0x02, 1
+#define SR_IRQ_2_RX_START	0x0f, 0x04, 2
+#define SR_IRQ_3_TRX_END	0x0f, 0x08, 3
+#define SR_IRQ_4_CCA_ED_DONE	0x0f, 0x10, 4
+#define SR_IRQ_5_AMI		0x0f, 0x20, 5
+#define SR_IRQ_6_TRX_UR		0x0f, 0x40, 6
+#define SR_IRQ_7_BAT_LOW	0x0f, 0x80, 7
+#define RG_VREG_CTRL	(0x10)
+#define SR_RESERVED_10_6	0x10, 0x03, 0
+#define SR_DVDD_OK		0x10, 0x04, 2
+#define SR_DVREG_EXT		0x10, 0x08, 3
+#define SR_RESERVED_10_3	0x10, 0x30, 4
+#define SR_AVDD_OK		0x10, 0x40, 6
+#define SR_AVREG_EXT		0x10, 0x80, 7
+#define RG_BATMON	(0x11)
+#define SR_BATMON_VTH		0x11, 0x0f, 0
+#define SR_BATMON_HR		0x11, 0x10, 4
+#define SR_BATMON_OK		0x11, 0x20, 5
+#define SR_RESERVED_11_1	0x11, 0xc0, 6
+#define RG_XOSC_CTRL	(0x12)
+#define SR_XTAL_TRIM		0x12, 0x0f, 0
+#define SR_XTAL_MODE		0x12, 0xf0, 4
+#define RG_RX_SYN	(0x15)
+#define SR_RX_PDT_LEVEL		0x15, 0x0f, 0
+#define SR_RESERVED_15_2	0x15, 0x70, 4
+#define SR_RX_PDT_DIS		0x15, 0x80, 7
+#define RG_XAH_CTRL_1	(0x17)
+#define SR_RESERVED_17_8	0x17, 0x01, 0
+#define SR_AACK_PROM_MODE	0x17, 0x02, 1
+#define SR_AACK_ACK_TIME	0x17, 0x04, 2
+#define SR_RESERVED_17_5	0x17, 0x08, 3
+#define SR_AACK_UPLD_RES_FT	0x17, 0x10, 4
+#define SR_AACK_FLTR_RES_FT	0x17, 0x20, 5
+#define SR_CSMA_LBT_MODE	0x17, 0x40, 6
+#define SR_RESERVED_17_1	0x17, 0x80, 7
+#define RG_FTN_CTRL	(0x18)
+#define SR_RESERVED_18_2	0x18, 0x7f, 0
+#define SR_FTN_START		0x18, 0x80, 7
+#define RG_PLL_CF	(0x1a)
+#define SR_RESERVED_1a_2	0x1a, 0x7f, 0
+#define SR_PLL_CF_START		0x1a, 0x80, 7
+#define RG_PLL_DCU	(0x1b)
+#define SR_RESERVED_1b_3	0x1b, 0x3f, 0
+#define SR_RESERVED_1b_2	0x1b, 0x40, 6
+#define SR_PLL_DCU_START	0x1b, 0x80, 7
+#define RG_PART_NUM	(0x1c)
+#define SR_PART_NUM		0x1c, 0xff, 0
+#define RG_VERSION_NUM	(0x1d)
+#define SR_VERSION_NUM		0x1d, 0xff, 0
+#define RG_MAN_ID_0	(0x1e)
+#define SR_MAN_ID_0		0x1e, 0xff, 0
+#define RG_MAN_ID_1	(0x1f)
+#define SR_MAN_ID_1		0x1f, 0xff, 0
+#define RG_SHORT_ADDR_0	(0x20)
+#define SR_SHORT_ADDR_0		0x20, 0xff, 0
+#define RG_SHORT_ADDR_1	(0x21)
+#define SR_SHORT_ADDR_1		0x21, 0xff, 0
+#define RG_PAN_ID_0	(0x22)
+#define SR_PAN_ID_0		0x22, 0xff, 0
+#define RG_PAN_ID_1	(0x23)
+#define SR_PAN_ID_1		0x23, 0xff, 0
+#define RG_IEEE_ADDR_0	(0x24)
+#define SR_IEEE_ADDR_0		0x24, 0xff, 0
+#define RG_IEEE_ADDR_1	(0x25)
+#define SR_IEEE_ADDR_1		0x25, 0xff, 0
+#define RG_IEEE_ADDR_2	(0x26)
+#define SR_IEEE_ADDR_2		0x26, 0xff, 0
+#define RG_IEEE_ADDR_3	(0x27)
+#define SR_IEEE_ADDR_3		0x27, 0xff, 0
+#define RG_IEEE_ADDR_4	(0x28)
+#define SR_IEEE_ADDR_4		0x28, 0xff, 0
+#define RG_IEEE_ADDR_5	(0x29)
+#define SR_IEEE_ADDR_5		0x29, 0xff, 0
+#define RG_IEEE_ADDR_6	(0x2a)
+#define SR_IEEE_ADDR_6		0x2a, 0xff, 0
+#define RG_IEEE_ADDR_7	(0x2b)
+#define SR_IEEE_ADDR_7		0x2b, 0xff, 0
+#define RG_XAH_CTRL_0	(0x2c)
+#define SR_SLOTTED_OPERATION	0x2c, 0x01, 0
+#define SR_MAX_CSMA_RETRIES	0x2c, 0x0e, 1
+#define SR_MAX_FRAME_RETRIES	0x2c, 0xf0, 4
+#define RG_CSMA_SEED_0	(0x2d)
+#define SR_CSMA_SEED_0		0x2d, 0xff, 0
+#define RG_CSMA_SEED_1	(0x2e)
+#define SR_CSMA_SEED_1		0x2e, 0x07, 0
+#define SR_AACK_I_AM_COORD	0x2e, 0x08, 3
+#define SR_AACK_DIS_ACK		0x2e, 0x10, 4
+#define SR_AACK_SET_PD		0x2e, 0x20, 5
+#define SR_AACK_FVN_MODE	0x2e, 0xc0, 6
+#define RG_CSMA_BE	(0x2f)
+#define SR_MIN_BE		0x2f, 0x0f, 0
+#define SR_MAX_BE		0x2f, 0xf0, 4
 
 #define CMD_REG		0x80
 #define CMD_REG_MASK	0x3f
-- 
2.3.6

