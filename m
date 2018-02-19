Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:42296 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbeBSX7R (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 18:59:17 -0500
Received: by mail-pf0-f169.google.com with SMTP id t15so1950952pfh.9
        for <linux-wpan@vger.kernel.org>; Mon, 19 Feb 2018 15:59:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9bd4f9bc-e0be-a5e0-87ed-5245b5cf3642@osg.samsung.com>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
 <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com>
 <20180219163107.GB27116@work.Speedport_W_724V_09011603_05_013>
 <CAJuUDwu_TmCMZt7sQpQdip0J5DOe-nJT47G0V4K4kg3cffEfsw@mail.gmail.com> <9bd4f9bc-e0be-a5e0-87ed-5245b5cf3642@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Tue, 20 Feb 2018 00:59:15 +0100
Message-ID: <CAJuUDws623rbNS9pfnJERd7oQfvK8WY64rRxQ-aBDLzkqtFh=w@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hello

On 19 February 2018 at 23:37, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Hello.
>
>
> On 02/19/2018 10:40 PM, Xue Liu wrote:
>> Hello Stefan,
>>
>> Thanks for the second review.
>>
>> On 19 February 2018 at 17:31, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>>> Hello.
>>>
>>> On Mon, 2018-02-19 at 11:51, Xue Liu wrote:
>>>> This is a driver for the NXP MCR20A 802.15.4 transceiver.
>>>>
>>>> The MCR20AVHM transceiver (or MCR20A) is a low power, high-performance 2.4 GHz, IEEE 802.15.4 compliant transceiver.
>>> Please break the lines here around 72 chars so it can be sanely viewed
>>> in git log.
>>>
>> OK.
>>>> This driver implements a subset of ieee802154_ops. It has no support for CSMA due to lack of hardware support. It has currently no support for its proprietary feature: Dual PAN.
>>>
>>> Wow, I honetsly did not realise CSMA was not done in hardware on this chip.
>>> This can be a real problem in busy deplyoment scenarios.
>>>
>>> From the kernel stack perspective this make thes second timing critical item
>>> we migth need to have a softMAC solution for. first ACK handling and now CSMA.
>>>
>>> If anybody on this list has an interest in digging into the time constraints
>>> we have for this in 802.15.4 and find out if the current realtime infrastructure
>>> of the kernel offers us what we need for these constraints this would be very
>>> welcome! But I am drifting of the actual review of this driver. :-)
>>>
>>>
>> If I remember correctly. Many 802.15.4 chips except at86rf23x have no
>> full CSMA support. They have only CCA.
>> Is it possible to use hrtimer to control such time constrains ?
>
> That would be something to find out. I'm honestly not sure. Never really checked out what real time constraints are supported by now.
>
>>>> https://www.nxp.com/docs/en/reference-manual/MCR20RM.pdf
>>>>
>>>> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
>>>> ---
>>>>  drivers/net/ieee802154/Kconfig  |   11 +
>>>>  drivers/net/ieee802154/Makefile |    1 +
>>>>  drivers/net/ieee802154/mcr20a.c | 1460 +++++++++++++++++++++++++++++++++++++++
>>>>  drivers/net/ieee802154/mcr20a.h |  498 +++++++++++++
>>>>  4 files changed, 1970 insertions(+)
>>>>  create mode 100644 drivers/net/ieee802154/mcr20a.c
>>>>  create mode 100644 drivers/net/ieee802154/mcr20a.h
>>>>
>>>> diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
>>>> index 303ba41..8782f56 100644
>>>> --- a/drivers/net/ieee802154/Kconfig
>>>> +++ b/drivers/net/ieee802154/Kconfig
>>>> @@ -104,3 +104,14 @@ config IEEE802154_CA8210_DEBUGFS
>>>>         exposes a debugfs node for each CA8210 instance which allows
>>>>         direct use of the Cascoda API, exposing the 802.15.4 MAC
>>>>         management entities.
>>>> +
>>>> +config IEEE802154_MCR20A
>>>> +       tristate "MCR20A transceiver driver"
>>>> +       depends on IEEE802154_DRIVERS && MAC802154
>>>> +       depends on SPI
>>>> +     ---help---
>>>> +       Say Y here to enable the MCR20A SPI 802.15.4 wireless
>>>> +       controller.
>>>> +
>>>> +       This driver can also be built as a module. To do so, say M here.
>>>> +       the module will be called 'mcr20a'.
>>>> diff --git a/drivers/net/ieee802154/Makefile b/drivers/net/ieee802154/Makefile
>>>> index bea1de5..104744d 100644
>>>> --- a/drivers/net/ieee802154/Makefile
>>>> +++ b/drivers/net/ieee802154/Makefile
>>>> @@ -6,3 +6,4 @@ obj-$(CONFIG_IEEE802154_CC2520) += cc2520.o
>>>>  obj-$(CONFIG_IEEE802154_ATUSB) += atusb.o
>>>>  obj-$(CONFIG_IEEE802154_ADF7242) += adf7242.o
>>>>  obj-$(CONFIG_IEEE802154_CA8210) += ca8210.o
>>>> +obj-$(CONFIG_IEEE802154_MCR20A) += mcr20a.o
>>>> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
>>>> new file mode 100644
>>>> index 0000000..90712e9
>>>> --- /dev/null
>>>> +++ b/drivers/net/ieee802154/mcr20a.c
>>>> @@ -0,0 +1,1460 @@
>>>> +/*
>>>> + * Driver for NXP MCR20A 802.15.4 Wireless-PAN Networking controller
>>>> + *
>>>> + * Copyright (C) 2018 Xue Liu <liuxuenetmail@gmail.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2
>>>> + * as published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + */
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/gpio.h>
>>>> +#include <linux/spi/spi.h>
>>>> +#include <linux/workqueue.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/skbuff.h>
>>>> +#include <linux/of_gpio.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/ieee802154.h>
>>>> +#include <linux/debugfs.h>
>>>> +
>>>> +#include <net/mac802154.h>
>>>> +#include <net/cfg802154.h>
>>>> +
>>>> +#include <linux/device.h>
>>>> +
>>>> +#include "mcr20a.h"
>>>> +
>>>> +#define      SPI_COMMAND_BUFFER              3
>>>> +
>>>> +#define REGISTER_READ                        BIT(7)
>>>> +#define REGISTER_WRITE                       (0 << 7)
>>>> +#define REGISTER_ACCESS                      (0 << 6)
>>>> +#define PACKET_BUFF_BURST_ACCESS     BIT(6)
>>>> +#define PACKET_BUFF_BYTE_ACCESS              BIT(5)
>>>> +
>>>> +#define MCR20A_WRITE_REG(x)          (x)
>>>> +#define MCR20A_READ_REG(x)           (REGISTER_READ | (x))
>>>> +#define MCR20A_BURST_READ_PACKET_BUF (0xC0)
>>>> +#define MCR20A_BURST_WRITE_PACKET_BUF        (0x40)
>>>> +
>>>> +#define MCR20A_CMD_REG               0x80
>>>> +#define MCR20A_CMD_REG_MASK  0x3f
>>>> +#define MCR20A_CMD_WRITE     0x40
>>>> +#define MCR20A_CMD_FB                0x20
>>> Some of these indents look wrong in my mailer. Did you run this patch through
>>> the checkpatch script?
>>>
>> Yes. 0 erros and 0 warnings. But I will check it again.
>
> Fair enough. Maybe my mailer was just off in that case.
> I will run in through checkpatch anyway before I apply it to my tree.
>
>>>> +/* Number of Interrupt Request Status Register */
>>>> +#define MCR20A_IRQSTS_NUM 2 /* only IRQ_STS1 and IRQ_STS2 */
>>>> +
>>>> +/* MCR20A CCA Type */
>>>> +enum {
>>>> +     MCR20A_CCA_ED,    // energy detect - CCA bit not active,
>>>> +                       // not to be used for T and CCCA sequences
>>>> +     MCR20A_CCA_MODE1, // energy detect - CCA bit ACTIVE
>>>> +     MCR20A_CCA_MODE2, // 802.15.4 compliant signal detect - CCA bit ACTIVE
>>>> +     MCR20A_CCA_MODE3
>>>> +};
>>>> +
>>>> +enum {
>>>> +     MCR20A_XCVSEQ_IDLE      = 0x00,
>>>> +     MCR20A_XCVSEQ_RX        = 0x01,
>>>> +     MCR20A_XCVSEQ_TX        = 0x02,
>>>> +     MCR20A_XCVSEQ_CCA       = 0x03,
>>>> +     MCR20A_XCVSEQ_TR        = 0x04,
>>>> +     MCR20A_XCVSEQ_CCCA      = 0x05,
>>>> +};
>>>> +
>>>> +/* IEEE-802.15.4 defined constants (2.4 GHz logical channels) */
>>>> +#define      MCR20A_MIN_CHANNEL      (11)
>>>> +#define      MCR20A_MAX_CHANNEL      (26)
>>>> +#define      MCR20A_CHANNEL_SPACING  (5)
>>>> +
>>>> +/* MCR20A CCA Threshold constans */
>>>> +#define MCR20A_MIN_CCA_THRESHOLD (0x6EU)
>>>> +#define MCR20A_MAX_CCA_THRESHOLD (0x00U)
>>>> +
>>>> +/* version 0C */
>>>> +#define MCR20A_OVERWRITE_VERSION (0x0C)
>>>> +
>>>> +/* MCR20A PLL configurations */
>>>> +static const u8  PLL_INT[16] = {
>>>> +     /* 2405 */ 0x0B,        /* 2410 */ 0x0B,        /* 2415 */ 0x0B,
>>>> +     /* 2420 */ 0x0B,        /* 2425 */ 0x0B,        /* 2430 */ 0x0B,
>>>> +     /* 2435 */ 0x0C,        /* 2440 */ 0x0C,        /* 2445 */ 0x0C,
>>>> +     /* 2450 */ 0x0C,        /* 2455 */ 0x0C,        /* 2460 */ 0x0C,
>>>> +     /* 2465 */ 0x0D,        /* 2470 */ 0x0D,        /* 2475 */ 0x0D,
>>>> +     /* 2480 */ 0x0D
>>>> +};
>>>> +
>>>> +static const u8 PLL_FRAC[16] = {
>>>> +     /* 2405 */ 0x28,        /* 2410 */ 0x50,        /* 2415 */ 0x78,
>>>> +     /* 2420 */ 0xA0,        /* 2425 */ 0xC8,        /* 2430 */ 0xF0,
>>>> +     /* 2435 */ 0x18,        /* 2440 */ 0x40,        /* 2445 */ 0x68,
>>>> +     /* 2450 */ 0x90,        /* 2455 */ 0xB8,        /* 2460 */ 0xE0,
>>>> +     /* 2465 */ 0x08,        /* 2470 */ 0x30,        /* 2475 */ 0x58,
>>>> +     /* 2480 */ 0x80
>>>> +};
>>>> +
>>>> +static const struct reg_sequence mar20a_iar_overwrites[] = {
>>>> +     { IAR_MISC_PAD_CTRL,    0x02 },
>>>> +     { IAR_VCO_CTRL1,        0xB3 },
>>>> +     { IAR_VCO_CTRL2,        0x07 },
>>>> +     { IAR_PA_TUNING,        0x71 },
>>>> +     { IAR_CHF_IBUF,         0x2F },
>>>> +     { IAR_CHF_QBUF,         0x2F },
>>>> +     { IAR_CHF_IRIN,         0x24 },
>>>> +     { IAR_CHF_QRIN,         0x24 },
>>>> +     { IAR_CHF_IL,           0x24 },
>>>> +     { IAR_CHF_QL,           0x24 },
>>>> +     { IAR_CHF_CC1,          0x32 },
>>>> +     { IAR_CHF_CCL,          0x1D },
>>>> +     { IAR_CHF_CC2,          0x2D },
>>>> +     { IAR_CHF_IROUT,        0x24 },
>>>> +     { IAR_CHF_QROUT,        0x24 },
>>>> +     { IAR_PA_CAL,           0x28 },
>>>> +     { IAR_AGC_THR1,         0x55 },
>>>> +     { IAR_AGC_THR2,         0x2D },
>>>> +     { IAR_ATT_RSSI1,        0x5F },
>>>> +     { IAR_ATT_RSSI2,        0x8F },
>>>> +     { IAR_RSSI_OFFSET,      0x61 },
>>>> +     { IAR_CHF_PMA_GAIN,     0x03 },
>>>> +     { IAR_CCA1_THRESH,      0x50 },
>>>> +     { IAR_CORR_NVAL,        0x13 },
>>>> +     { IAR_ACKDELAY,         0x3D },
>>>> +};
>>>> +
>>>> +#define MCR20A_VALID_CHANNELS (0x07FFF800)
>>>> +
>>>> +struct mcr20a_platform_data {
>>>> +     int rst_gpio;
>>>> +};
>>>> +
>>>> +#define MCR20A_MAX_BUF               (127)
>>>> +
>>>> +#define printdev(X) (&X->spi->dev)
>>>> +
>>>> +/* regmap information for Direct Access Register (DAR) access */
>>>> +#define MCR20A_DAR_WRITE     0x01
>>>> +#define MCR20A_DAR_READ              0x00
>>>> +#define MCR20A_DAR_NUMREGS   0x3F
>>>> +
>>>> +/* regmap information for Indirect Access Register (IAR) access */
>>>> +#define MCR20A_IAR_ACCESS    0x80
>>>> +#define MCR20A_IAR_NUMREGS   0xBEFF
>>>> +
>>>> +/* Read/Write SPI Commands for DAR and IAR registers. */
>>>> +#define MCR20A_READSHORT(reg)        ((reg) << 1)
>>>> +#define MCR20A_WRITESHORT(reg)       ((reg) << 1 | 1)
>>>> +#define MCR20A_READLONG(reg) (1 << 15 | (reg) << 5)
>>>> +#define MCR20A_WRITELONG(reg)        (1 << 15 | (reg) << 5 | 1 << 4)
>>>> +
>>>> +/* Type definitions for link configuration of instantiable layers  */
>>>> +#define MCR20A_PHY_INDIRECT_QUEUE_SIZE (12)
>>>> +
>>>> +static bool
>>>> +mcr20a_dar_writeable(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     switch (reg) {
>>>> +     case DAR_IRQ_STS1:
>>>> +     case DAR_IRQ_STS2:
>>>> +     case DAR_IRQ_STS3:
>>>> +     case DAR_PHY_CTRL1:
>>>> +     case DAR_PHY_CTRL2:
>>>> +     case DAR_PHY_CTRL3:
>>>> +     case DAR_PHY_CTRL4:
>>>> +     case DAR_SRC_CTRL:
>>>> +     case DAR_SRC_ADDRS_SUM_LSB:
>>>> +     case DAR_SRC_ADDRS_SUM_MSB:
>>>> +     case DAR_T3CMP_LSB:
>>>> +     case DAR_T3CMP_MSB:
>>>> +     case DAR_T3CMP_USB:
>>>> +     case DAR_T2PRIMECMP_LSB:
>>>> +     case DAR_T2PRIMECMP_MSB:
>>>> +     case DAR_T1CMP_LSB:
>>>> +     case DAR_T1CMP_MSB:
>>>> +     case DAR_T1CMP_USB:
>>>> +     case DAR_T2CMP_LSB:
>>>> +     case DAR_T2CMP_MSB:
>>>> +     case DAR_T2CMP_USB:
>>>> +     case DAR_T4CMP_LSB:
>>>> +     case DAR_T4CMP_MSB:
>>>> +     case DAR_T4CMP_USB:
>>>> +     case DAR_PLL_INT0:
>>>> +     case DAR_PLL_FRAC0_LSB:
>>>> +     case DAR_PLL_FRAC0_MSB:
>>>> +     case DAR_PA_PWR:
>>>> +     /* no DAR_ACM */
>>>> +     case DAR_OVERWRITE_VER:
>>>> +     case DAR_CLK_OUT_CTRL:
>>>> +     case DAR_PWR_MODES:
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static bool
>>>> +mcr20a_dar_readable(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     bool rc;
>>>> +
>>>> +     /* all writeable are also readable */
>>>> +     rc = mcr20a_dar_writeable(dev, reg);
>>>> +     if (rc)
>>>> +             return rc;
>>>> +
>>>> +     /* readonly regs */
>>>> +     switch (reg) {
>>>> +     case DAR_RX_FRM_LEN:
>>>> +     case DAR_CCA1_ED_FNL:
>>>> +     case DAR_EVENT_TMR_LSB:
>>>> +     case DAR_EVENT_TMR_MSB:
>>>> +     case DAR_EVENT_TMR_USB:
>>>> +     case DAR_TIMESTAMP_LSB:
>>>> +     case DAR_TIMESTAMP_MSB:
>>>> +     case DAR_TIMESTAMP_USB:
>>>> +     case DAR_SEQ_STATE:
>>>> +     case DAR_LQI_VALUE:
>>>> +     case DAR_RSSI_CCA_CONT:
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static bool
>>>> +mcr20a_dar_volatile(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     /* can be changed during runtime */
>>>> +     switch (reg) {
>>>> +     case DAR_IRQ_STS1:
>>>> +     case DAR_IRQ_STS2:
>>>> +     case DAR_IRQ_STS3:
>>>> +     /* use them in spi_async and regmap so it's volatile */
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static bool
>>>> +mcr20a_dar_precious(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     /* don't clear irq line on read */
>>>> +     switch (reg) {
>>>> +     case DAR_IRQ_STS1:
>>>> +     case DAR_IRQ_STS2:
>>>> +     case DAR_IRQ_STS3:
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static const struct regmap_config mcr20a_dar_regmap = {
>>>> +     .name                   = "mcr20a_dar",
>>>> +     .reg_bits               = 8,
>>>> +     .val_bits               = 8,
>>>> +     .write_flag_mask        = REGISTER_ACCESS | REGISTER_WRITE,
>>>> +     .read_flag_mask         = REGISTER_ACCESS | REGISTER_READ,
>>>> +     .cache_type             = REGCACHE_RBTREE,
>>>> +     .writeable_reg          = mcr20a_dar_writeable,
>>>> +     .readable_reg           = mcr20a_dar_readable,
>>>> +     .volatile_reg           = mcr20a_dar_volatile,
>>>> +     .precious_reg           = mcr20a_dar_precious,
>>>> +     .fast_io                = true,
>>>> +     .can_multi_write        = true,
>>>> +};
>>>> +
>>>> +static bool
>>>> +mcr20a_iar_writeable(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     switch (reg) {
>>>> +     case IAR_XTAL_TRIM:
>>>> +     case IAR_PMC_LP_TRIM:
>>>> +     case IAR_MACPANID0_LSB:
>>>> +     case IAR_MACPANID0_MSB:
>>>> +     case IAR_MACSHORTADDRS0_LSB:
>>>> +     case IAR_MACSHORTADDRS0_MSB:
>>>> +     case IAR_MACLONGADDRS0_0:
>>>> +     case IAR_MACLONGADDRS0_8:
>>>> +     case IAR_MACLONGADDRS0_16:
>>>> +     case IAR_MACLONGADDRS0_24:
>>>> +     case IAR_MACLONGADDRS0_32:
>>>> +     case IAR_MACLONGADDRS0_40:
>>>> +     case IAR_MACLONGADDRS0_48:
>>>> +     case IAR_MACLONGADDRS0_56:
>>>> +     case IAR_RX_FRAME_FILTER:
>>>> +     case IAR_PLL_INT1:
>>>> +     case IAR_PLL_FRAC1_LSB:
>>>> +     case IAR_PLL_FRAC1_MSB:
>>>> +     case IAR_MACPANID1_LSB:
>>>> +     case IAR_MACPANID1_MSB:
>>>> +     case IAR_MACSHORTADDRS1_LSB:
>>>> +     case IAR_MACSHORTADDRS1_MSB:
>>>> +     case IAR_MACLONGADDRS1_0:
>>>> +     case IAR_MACLONGADDRS1_8:
>>>> +     case IAR_MACLONGADDRS1_16:
>>>> +     case IAR_MACLONGADDRS1_24:
>>>> +     case IAR_MACLONGADDRS1_32:
>>>> +     case IAR_MACLONGADDRS1_40:
>>>> +     case IAR_MACLONGADDRS1_48:
>>>> +     case IAR_MACLONGADDRS1_56:
>>>> +     case IAR_DUAL_PAN_CTRL:
>>>> +     case IAR_DUAL_PAN_DWELL:
>>>> +     case IAR_CCA1_THRESH:
>>>> +     case IAR_CCA1_ED_OFFSET_COMP:
>>>> +     case IAR_LQI_OFFSET_COMP:
>>>> +     case IAR_CCA_CTRL:
>>>> +     case IAR_CCA2_CORR_PEAKS:
>>>> +     case IAR_CCA2_CORR_THRESH:
>>>> +     case IAR_TMR_PRESCALE:
>>>> +     case IAR_ANT_PAD_CTRL:
>>>> +     case IAR_MISC_PAD_CTRL:
>>>> +     case IAR_BSM_CTRL:
>>>> +     case IAR_RNG:
>>>> +     case IAR_RX_WTR_MARK:
>>>> +     case IAR_SOFT_RESET:
>>>> +     case IAR_TXDELAY:
>>>> +     case IAR_ACKDELAY:
>>>> +     case IAR_CORR_NVAL:
>>>> +     case IAR_ANT_AGC_CTRL:
>>>> +     case IAR_AGC_THR1:
>>>> +     case IAR_AGC_THR2:
>>>> +     case IAR_PA_CAL:
>>>> +     case IAR_ATT_RSSI1:
>>>> +     case IAR_ATT_RSSI2:
>>>> +     case IAR_RSSI_OFFSET:
>>>> +     case IAR_XTAL_CTRL:
>>>> +     case IAR_CHF_PMA_GAIN:
>>>> +     case IAR_CHF_IBUF:
>>>> +     case IAR_CHF_QBUF:
>>>> +     case IAR_CHF_IRIN:
>>>> +     case IAR_CHF_QRIN:
>>>> +     case IAR_CHF_IL:
>>>> +     case IAR_CHF_QL:
>>>> +     case IAR_CHF_CC1:
>>>> +     case IAR_CHF_CCL:
>>>> +     case IAR_CHF_CC2:
>>>> +     case IAR_CHF_IROUT:
>>>> +     case IAR_CHF_QROUT:
>>>> +     case IAR_PA_TUNING:
>>>> +     case IAR_VCO_CTRL1:
>>>> +     case IAR_VCO_CTRL2:
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static bool
>>>> +mcr20a_iar_readable(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     bool rc;
>>>> +
>>>> +     /* all writeable are also readable */
>>>> +     rc = mcr20a_iar_writeable(dev, reg);
>>>> +     if (rc)
>>>> +             return rc;
>>>> +
>>>> +     /* readonly regs */
>>>> +     switch (reg) {
>>>> +     case IAR_PART_ID:
>>>> +     case IAR_DUAL_PAN_STS:
>>>> +     case IAR_RX_BYTE_COUNT:
>>>> +     case IAR_FILTERFAIL_CODE1:
>>>> +     case IAR_FILTERFAIL_CODE2:
>>>> +     case IAR_RSSI:
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static bool
>>>> +mcr20a_iar_volatile(struct device *dev, unsigned int reg)
>>>> +{
>>>> +/* can be changed during runtime */
>>>> +     switch (reg) {
>>>> +     case IAR_DUAL_PAN_STS:
>>>> +     case IAR_RX_BYTE_COUNT:
>>>> +     case IAR_FILTERFAIL_CODE1:
>>>> +     case IAR_FILTERFAIL_CODE2:
>>>> +     case IAR_RSSI:
>>>> +             return true;
>>>> +     default:
>>>> +             return false;
>>>> +     }
>>>> +}
>>>> +
>>>> +static const struct regmap_config mcr20a_iar_regmap = {
>>>> +     .name                   = "mcr20a_iar",
>>>> +     .reg_bits               = 16,
>>>> +     .val_bits               = 8,
>>>> +     .write_flag_mask        = REGISTER_ACCESS | REGISTER_WRITE | IAR_INDEX,
>>>> +     .read_flag_mask         = REGISTER_ACCESS | REGISTER_READ  | IAR_INDEX,
>>>> +     .cache_type             = REGCACHE_RBTREE,
>>>> +     .writeable_reg          = mcr20a_iar_writeable,
>>>> +     .readable_reg           = mcr20a_iar_readable,
>>>> +     .volatile_reg           = mcr20a_iar_volatile,
>>>> +     .fast_io                = true,
>>>> +};
>>>> +
>>>> +struct mcr20a_local {
>>>> +     struct spi_device *spi;
>>>> +
>>>> +     struct ieee802154_hw *hw;
>>>> +     struct mcr20a_platform_data *pdata;
>>>> +     struct regmap *regmap_dar;
>>>> +     struct regmap *regmap_iar;
>>>> +
>>>> +     u8 *buf;
>>>> +
>>>> +     bool is_tx;
>>>> +
>>>> +     /* for writing tx buffer */
>>>> +     struct spi_message tx_buf_msg;
>>>> +     u8 tx_header[1];
>>>> +     /* burst buffer write command */
>>>> +     struct spi_transfer tx_xfer_header;
>>>> +     u8 tx_len[1];
>>>> +     /* len of tx packet */
>>>> +     struct spi_transfer tx_xfer_len;
>>>> +     /* data of tx packet */
>>>> +     struct spi_transfer tx_xfer_buf;
>>>> +     struct sk_buff *tx_skb;
>>>> +
>>>> +     /* for read length rxfifo */
>>>> +     struct spi_message reg_msg;
>>>> +     u8 reg_cmd[1];
>>>> +     u8 reg_data[MCR20A_IRQSTS_NUM];
>>>> +     struct spi_transfer reg_xfer_cmd;
>>>> +     struct spi_transfer reg_xfer_data;
>>>> +
>>>> +     /* receive handling */
>>>> +     struct spi_message rx_buf_msg;
>>>> +     u8 rx_header[1];
>>>> +     struct spi_transfer rx_xfer_header;
>>>> +     u8 rx_lqi[1];
>>>> +     struct spi_transfer rx_xfer_lqi;
>>>> +     u8 rx_buf[MCR20A_MAX_BUF];
>>>> +     struct spi_transfer rx_xfer_buf;
>>>> +
>>>> +     /* isr handling for reading intstat */
>>>> +     struct spi_message irq_msg;
>>>> +     u8 irq_header[1];
>>>> +     u8 irq_data[MCR20A_IRQSTS_NUM];
>>>> +     struct spi_transfer irq_xfer_data;
>>>> +     struct spi_transfer irq_xfer_header;
>>>> +};
>>>> +
>>>> +static void
>>>> +mcr20a_write_tx_buf_complete(void *context)
>>>> +{
>>>> +     struct mcr20a_local *lp = context;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     lp->reg_msg.complete = NULL;
>>>> +     lp->reg_cmd[0]  = MCR20A_WRITE_REG(DAR_PHY_CTRL1);
>>>> +     lp->reg_data[0] = MCR20A_XCVSEQ_TX;
>>>> +     lp->reg_xfer_data.len = 1;
>>>> +
>>>> +     ret = spi_async(lp->spi, &lp->reg_msg);
>>>> +     if (ret)
>>>> +             dev_err(printdev(lp), "failed to set SEQ TX\n");
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     lp->tx_skb = skb;
>>>> +
>>>> +#ifdef DEBUG
>>>> +     print_hex_dump(KERN_INFO, "mcr20a write: ", DUMP_PREFIX_OFFSET, 16, 1,
>>>> +                    skb->data, skb->len, 0);
>>>> +#endif
>>>> +
>>>> +     lp->is_tx = 1;
>>>> +
>>>> +     lp->reg_msg.complete    = NULL;
>>>> +     lp->reg_cmd[0]          = MCR20A_WRITE_REG(DAR_PHY_CTRL1);
>>>> +     lp->reg_data[0]         = MCR20A_XCVSEQ_IDLE;
>>>> +     lp->reg_xfer_data.len   = 1;
>>>> +
>>>> +     return spi_async(lp->spi, &lp->reg_msg);
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_ed(struct ieee802154_hw *hw, u8 *level)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     unsigned int val = 0;
>>>> +     u8 energy_level;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     ret = regmap_read(lp->regmap_dar, DAR_PHY_CTRL1, &val);
>>>> +     if (0x0 == (val & DAR_PHY_CTRL1_XCVSEQ_MASK)) {
>>>> +             /* Change CCA Type to 00 -  Energy Detect */
>>>> +             ret = regmap_write(lp->regmap_dar, DAR_PHY_CTRL4, 0x0);
>>>> +             /* Perform ED */
>>>> +             ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                                      DAR_PHY_CTRL1_XCVSEQ_MASK,
>>>> +                                      MCR20A_XCVSEQ_CCA);
>>>> +             val = 0;
>>>> +             while ((DAR_IRQSTS1_CCAIRQ & val) != DAR_IRQSTS1_CCAIRQ)
>>>> +                     ret = regmap_read(lp->regmap_dar, DAR_IRQ_STS1, &val);
>>>> +             /* the energy level scaled in 0x00 - 0xFF */
>>>> +             ret = regmap_read(lp->regmap_dar, DAR_CCA1_ED_FNL, &val);
>>>> +             energy_level = (u8)val;
>>>> +
>>>> +             if (energy_level >= 90) {
>>>> +             /* ED value is below minimum. Return 0x00. */
>>>> +                     energy_level = 0x00;
>>>> +             } else if (energy_level <= 26) {
>>>> +             /* ED value is above maximum. Return 0xFF. */
>>>> +                     energy_level = 0xFF;
>>>> +             } else {
>>>> +             /* Energy level (-90 dBm to -26 dBm ) varies form 0 to 64 */
>>>> +                     energy_level = (90 - energy_level);
>>>> +                     energy_level <<= 2;
>>>> +             }
>>>> +
>>>> +             *level = energy_level;
>>>> +     } else {
>>>> +             /* switch to IDLE at first */
>>>> +             regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                                DAR_PHY_CTRL1_XCVSEQ_MASK,
>>>> +                                MCR20A_XCVSEQ_IDLE);
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "mcr20a_set_channell(): %d\n", channel);
>>> Nitpick. Typo in channel here. Might as well use __func__ :)
>>>
>> Correct.
>
> Are you going to sent a new version with this one fixed?
>
>>>> +     /* freqency = ((PLL_INT+64) + (PLL_FRAC/65536)) * 32 MHz */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_PLL_INT0, PLL_INT[channel - 11]);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_PLL_FRAC0_LSB, 0x00);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_PLL_FRAC0_MSB,
>>>> +                        PLL_FRAC[channel - 11]);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_start(struct ieee802154_hw *hw)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* No slotted operation */
>>>> +     dev_dbg(printdev(lp), "no slotted operation\n");
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                              DAR_PHY_CTRL1_SLOTTED, 0x0);
>>>> +
>>>> +     /* enable irq */
>>>> +     enable_irq(lp->spi->irq);
>>>> +
>>>> +     /* Unmask SEQ interrupt */
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
>>>> +                              DAR_PHY_CTRL2_SEQMSK, 0x0);
>>>> +
>>>> +     /* Start the RX sequence */
>>>> +     dev_dbg(printdev(lp), "start the RX sequence\n");
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                              DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_stop(struct ieee802154_hw *hw)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* stop all running sequence */
>>>> +     regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                        DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_IDLE);
>>>> +
>>>> +     /* disable irq */
>>>> +     disable_irq(lp->spi->irq);
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_set_hw_addr_filt(struct ieee802154_hw *hw,
>>>> +                     struct ieee802154_hw_addr_filt *filt,
>>>> +                     unsigned long changed)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
>>>> +             u16 addr = le16_to_cpu(filt->short_addr);
>>>> +
>>>> +             regmap_write(lp->regmap_iar, IAR_MACSHORTADDRS0_LSB, addr);
>>>> +             regmap_write(lp->regmap_iar, IAR_MACSHORTADDRS0_MSB, addr >> 8);
>>>> +     }
>>>> +
>>>> +     if (changed & IEEE802154_AFILT_PANID_CHANGED) {
>>>> +             u16 pan = le16_to_cpu(filt->pan_id);
>>>> +
>>>> +             regmap_write(lp->regmap_iar, IAR_MACPANID0_LSB, pan);
>>>> +             regmap_write(lp->regmap_iar, IAR_MACPANID0_MSB, pan >> 8);
>>>> +     }
>>>> +
>>>> +     if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
>>>> +             u8 addr[8], i;
>>>> +
>>>> +             memcpy(addr, &filt->ieee_addr, 8);
>>>> +             for (i = 0; i < 8; i++)
>>>> +                     regmap_write(lp->regmap_iar,
>>>> +                                  IAR_MACLONGADDRS0_0 + i, addr[i]);
>>>> +     }
>>>> +
>>>> +     if (changed & IEEE802154_AFILT_PANC_CHANGED) {
>>>> +             if (filt->pan_coord) {
>>>> +                     regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL4,
>>>> +                                        DAR_PHY_CTRL4_PANCORDNTR0, 0x10);
>>>> +             } else {
>>>> +                     regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL4,
>>>> +                                        DAR_PHY_CTRL4_PANCORDNTR0, 0x00);
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +/* -30 dBm to 10 dBm */
>>>> +#define MCR20A_MAX_TX_POWERS 0x14
>>>> +static const s32 mcr20a_powers[MCR20A_MAX_TX_POWERS + 1] = {
>>>> +     -3000, -2800, -2600, -2400, -2200, -2000, -1800, -1600, -1400,
>>>> +     -1200, -1000, -800, -600, -400, -200, 0, 200, 400, 600, 800, 1000
>>>> +};
>>>> +
>>>> +static int
>>>> +mcr20a_set_txpower(struct ieee802154_hw *hw, s32 mbm)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     u32 i;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s(%d)\n", __func__, mbm);
>>>> +
>>>> +     for (i = 0; i < lp->hw->phy->supported.tx_powers_size; i++) {
>>>> +             if (lp->hw->phy->supported.tx_powers[i] == mbm)
>>>> +                     return regmap_write(lp->regmap_dar, DAR_PA_PWR,
>>>> +                                         ((i + 8) & 0x1F));
>>>> +     }
>>>> +
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +#define MCR20A_MAX_ED_LEVELS MCR20A_MIN_CCA_THRESHOLD
>>>> +static s32 mcr20a_ed_levels[MCR20A_MAX_ED_LEVELS + 1];
>>>> +
>>>> +static int
>>>> +mcr20a_set_cca_mode(struct ieee802154_hw *hw,
>>>> +                 const struct wpan_phy_cca *cca)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     unsigned int cca_mode = 0xff;
>>>> +     bool cca_mode_and = false;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* mapping 802.15.4 to driver spec */
>>>> +     switch (cca->mode) {
>>>> +     case NL802154_CCA_ENERGY:
>>>> +             cca_mode = MCR20A_CCA_MODE1;
>>>> +             break;
>>>> +     case NL802154_CCA_CARRIER:
>>>> +             cca_mode = MCR20A_CCA_MODE2;
>>>> +             break;
>>>> +     case NL802154_CCA_ENERGY_CARRIER:
>>>> +             switch (cca->opt) {
>>>> +             case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
>>>> +                     cca_mode = MCR20A_CCA_MODE3;
>>>> +                     cca_mode_and = true;
>>>> +                     break;
>>>> +             case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
>>>> +                     cca_mode = MCR20A_CCA_MODE3;
>>>> +                     cca_mode_and = false;
>>>> +                     break;
>>>> +             default:
>>>> +                     return -EINVAL;
>>>> +             }
>>>> +             break;
>>>> +     default:
>>>> +             return -EINVAL;
>>>> +     }
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL4,
>>>> +                              DAR_PHY_CTRL4_CCATYPE_MASK,
>>>> +                              cca_mode << DAR_PHY_CTRL4_CCATYPE_SHIFT);
>>>> +     if (ret < 0)
>>>> +             return ret;
>>>> +
>>>> +     if (cca_mode == MCR20A_CCA_MODE3) {
>>>> +             if (cca_mode_and) {
>>>> +                     ret = regmap_update_bits(lp->regmap_iar, IAR_CCA_CTRL,
>>>> +                                              IAR_CCA_CTRL_CCA3_AND_NOT_OR,
>>>> +                                              0x08);
>>>> +             } else {
>>>> +                     ret = regmap_update_bits(lp->regmap_iar,
>>>> +                                              IAR_CCA_CTRL,
>>>> +                                              IAR_CCA_CTRL_CCA3_AND_NOT_OR,
>>>> +                                              0x00);
>>>> +             }
>>>> +             if (ret < 0)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     u32 i;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     for (i = 0; i < hw->phy->supported.cca_ed_levels_size; i++) {
>>>> +             if (hw->phy->supported.cca_ed_levels[i] == mbm)
>>>> +                     return regmap_write(lp->regmap_iar, IAR_CCA1_THRESH, i);
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
>>>> +{
>>>> +     struct mcr20a_local *lp = hw->priv;
>>>> +     int ret;
>>>> +     u8 rx_frame_filter_reg = 0x0;
>>>> +     u8 val;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s(%d)\n", __func__, on);
>>>> +
>>>> +     if (on) {
>>>> +             /* All frame types accepted*/
>>>> +             val |= DAR_PHY_CTRL4_PROMISCUOUS;
>>>> +             rx_frame_filter_reg &= ~(IAR_RX_FRAME_FLT_FRM_VER);
>>>> +             rx_frame_filter_reg |= (IAR_RX_FRAME_FLT_ACK_FT |
>>>> +                               IAR_RX_FRAME_FLT_NS_FT);
>>>> +
>>>> +             ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL4,
>>>> +                                      DAR_PHY_CTRL4_PROMISCUOUS,
>>>> +                                      DAR_PHY_CTRL4_PROMISCUOUS);
>>>> +             if (ret < 0)
>>>> +                     return ret;
>>>> +
>>>> +             ret = regmap_write(lp->regmap_iar, IAR_RX_FRAME_FILTER,
>>>> +                                rx_frame_filter_reg);
>>>> +             if (ret < 0)
>>>> +                     return ret;
>>>> +     } else {
>>>> +             ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL4,
>>>> +                                      DAR_PHY_CTRL4_PROMISCUOUS, 0x0);
>>>> +             if (ret < 0)
>>>> +                     return ret;
>>>> +
>>>> +             ret = regmap_write(lp->regmap_iar, IAR_RX_FRAME_FILTER,
>>>> +                                IAR_RX_FRAME_FLT_FRM_VER |
>>>> +                                IAR_RX_FRAME_FLT_BEACON_FT |
>>>> +                                IAR_RX_FRAME_FLT_DATA_FT |
>>>> +                                IAR_RX_FRAME_FLT_CMD_FT);
>>>> +             if (ret < 0)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct ieee802154_ops mcr20a_hw_ops = {
>>>> +     .owner                  = THIS_MODULE,
>>>> +     .xmit_async             = mcr20a_xmit,
>>>> +     .ed                     = mcr20a_ed,
>>>> +     .set_channel            = mcr20a_set_channel,
>>>> +     .start                  = mcr20a_start,
>>>> +     .stop                   = mcr20a_stop,
>>>> +     .set_hw_addr_filt       = mcr20a_set_hw_addr_filt,
>>>> +     .set_txpower            = mcr20a_set_txpower,
>>>> +     .set_cca_mode           = mcr20a_set_cca_mode,
>>>> +     .set_cca_ed_level       = mcr20a_set_cca_ed_level,
>>>> +     .set_promiscuous_mode   = mcr20a_set_promiscuous_mode,
>>>> +};
>>>> +
>>>> +static int
>>>> +mcr20a_request_rx(struct mcr20a_local *lp)
>>>> +{
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* Start the RX sequence */
>>>> +     regmap_update_bits_async(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                              DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_handle_rx_read_buf_complete(void *context)
>>>> +{
>>>> +     struct mcr20a_local *lp = context;
>>>> +     u8 len = lp->reg_data[0] & DAR_RX_FRAME_LENGTH_MASK;
>>>> +     struct sk_buff *skb;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     dev_dbg(printdev(lp), "RX is done\n");
>>>> +
>>>> +     if (!ieee802154_is_valid_psdu_len(len)) {
>>>> +             dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
>>>> +             len = IEEE802154_MTU;
>>>> +     }
>>>> +
>>>> +     len = len - 2;  /* get rid of frame check field */
>>>> +
>>>> +     skb = dev_alloc_skb(len);
>>>> +     if (!skb)
>>>> +             return;
>>>> +
>>>> +     memcpy(skb_put(skb, len), lp->rx_buf, len);
>>>> +     ieee802154_rx_irqsafe(lp->hw, skb, lp->rx_lqi[0]);
>>>> +
>>>> +#ifdef DEBUG
>>>> +     print_hex_dump(KERN_INFO, "mcr20a rx: ", DUMP_PREFIX_OFFSET, 16, 1,
>>>> +                    lp->rx_buf, len, 0);
>>>> +     pr_info("mcr20a rx: lqi: %02hhx\n", lp->rx_lqi[0]);
>>>> +#endif
>>> Here, as well as in the corresponding TX hex_dump call I wonder how to better
>>> make use of it. Recompiling the driver to get the dump is not really nice.
>>> Having a way to have this enabled during runtime might be better. And across
>>> all drivers. Just thinking out loud here. Not saying you need to be he one
>>> implementing it. What do you think?
>>>
>>>
>> using module parameters may a solution.
>
> This would be an option but I was thinking more about towards a tracepoints like approach where we can dynamically enable or disable the
> hexdump or other debug functionality. Loading and unloading the module to change this is a bit cumbersome. This code might not even be a
> module at all but compiled in.
>
> I need to check what the kernel infra offers here and how other subsystems use it.
>
Do you mean "dynamic debug"
https://www.kernel.org/doc/html/v4.11/admin-guide/dynamic-debug-howto.html
?
I saw there is all a version for print_hex_dump.

>>>> +     /* start RX sequence */
>>>> +     mcr20a_request_rx(lp);
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_handle_rx_read_len_complete(void *context)
>>>> +{
>>>> +     struct mcr20a_local *lp = context;
>>>> +     u8 len;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* get the length of received frame */
>>>> +     len = lp->reg_data[0] & DAR_RX_FRAME_LENGTH_MASK;
>>>> +     dev_dbg(printdev(lp), "frame len : %d\n", len);
>>>> +
>>>> +     /* prepare to read the rx buf */
>>>> +     lp->rx_buf_msg.complete = mcr20a_handle_rx_read_buf_complete;
>>>> +     lp->rx_header[0] = MCR20A_BURST_READ_PACKET_BUF;
>>>> +     lp->rx_xfer_buf.len = len;
>>>> +
>>>> +     ret = spi_async(lp->spi, &lp->rx_buf_msg);
>>>> +     if (ret)
>>>> +             dev_err(printdev(lp), "failed to read rx buffer length\n");
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_handle_rx(struct mcr20a_local *lp)
>>>> +{
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +     lp->reg_msg.complete = mcr20a_handle_rx_read_len_complete;
>>>> +     lp->reg_cmd[0] = MCR20A_READ_REG(DAR_RX_FRM_LEN);
>>>> +     lp->reg_xfer_data.len   = 1;
>>>> +
>>>> +     return spi_async(lp->spi, &lp->reg_msg);
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_handle_tx_complete(struct mcr20a_local *lp)
>>>> +{
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     ieee802154_xmit_complete(lp->hw, lp->tx_skb, false);
>>>> +
>>>> +     return mcr20a_request_rx(lp);
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_handle_tx(struct mcr20a_local *lp)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* write tx buffer */
>>>> +     lp->tx_header[0]        = MCR20A_BURST_WRITE_PACKET_BUF;
>>>> +     /* add 2 bytes of FCS */
>>>> +     lp->tx_len[0]           = lp->tx_skb->len + 2;
>>>> +     lp->tx_xfer_buf.tx_buf  = lp->tx_skb->data;
>>>> +     /* add 1 byte psduLength */
>>>> +     lp->tx_xfer_buf.len     = lp->tx_skb->len + 1;
>>>> +
>>>> +     ret = spi_async(lp->spi, &lp->tx_buf_msg);
>>>> +     if (ret) {
>>>> +             dev_err(printdev(lp), "SPI write Failed for TX buf\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_irq_clean_complete(void *context)
>>>> +{
>>>> +     struct mcr20a_local *lp = context;
>>>> +     u8 seq_state = lp->irq_data[DAR_IRQ_STS1] & DAR_PHY_CTRL1_XCVSEQ_MASK;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     enable_irq(lp->spi->irq);
>>>> +
>>>> +     dev_dbg(printdev(lp), "IRQ STA1 (%02x) STA2 (%02x)\n",
>>>> +             lp->irq_data[DAR_IRQ_STS1], lp->irq_data[DAR_IRQ_STS2]);
>>>> +
>>>> +     switch (seq_state) {
>>>> +     /* TX IRQ, RX IRQ and SEQ IRQ */
>>>> +     case (0x03):
>>>> +             if (lp->is_tx) {
>>>> +                     lp->is_tx = 0;
>>>> +                     dev_dbg(printdev(lp), "TX is done. No ACK\n");
>>>> +                     mcr20a_handle_tx_complete(lp);
>>>> +             }
>>>> +             break;
>>>> +     case (0x05):
>>>> +                     /* rx is starting */
>>>> +                     dev_dbg(printdev(lp), "RX is starting\n");
>>>> +                     mcr20a_handle_rx(lp);
>>>> +             break;
>>>> +     case (0x07):
>>>> +             if (lp->is_tx) {
>>>> +                     /* tx is done */
>>>> +                     lp->is_tx = 0;
>>>> +                     dev_dbg(printdev(lp), "TX is done. Get ACK\n");
>>>> +                     mcr20a_handle_tx_complete(lp);
>>>> +             } else {
>>>> +                     /* rx is starting */
>>>> +                     dev_dbg(printdev(lp), "RX is starting\n");
>>>> +                     mcr20a_handle_rx(lp);
>>>> +             }
>>>> +             break;
>>>> +     case (0x01):
>>>> +             if (lp->is_tx) {
>>>> +                     dev_dbg(printdev(lp), "TX is starting\n");
>>>> +                     mcr20a_handle_tx(lp);
>>>> +             } else {
>>>> +                     dev_dbg(printdev(lp), "MCR20A is stop\n");
>>>> +             }
>>>> +             break;
>>>> +     }
>>>> +}
>>>> +
>>>> +static void mcr20a_irq_status_complete(void *context)
>>>> +{
>>>> +     int ret;
>>>> +     struct mcr20a_local *lp = context;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +     regmap_update_bits_async(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                              DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_IDLE);
>>>> +
>>>> +     lp->reg_msg.complete = mcr20a_irq_clean_complete;
>>>> +     lp->reg_cmd[0] = MCR20A_WRITE_REG(DAR_IRQ_STS1);
>>>> +     memcpy(lp->reg_data, lp->irq_data, MCR20A_IRQSTS_NUM);
>>>> +     lp->reg_xfer_data.len = MCR20A_IRQSTS_NUM;
>>>> +
>>>> +     ret = spi_async(lp->spi, &lp->reg_msg);
>>>> +
>>>> +     if (ret)
>>>> +             dev_err(printdev(lp), "failed to clean irq status\n");
>>>> +}
>>>> +
>>>> +static irqreturn_t mcr20a_irq_isr(int irq, void *data)
>>>> +{
>>>> +     struct mcr20a_local *lp = data;
>>>> +     int ret;
>>>> +
>>>> +     disable_irq_nosync(irq);
>>>> +
>>>> +     lp->irq_header[0] = MCR20A_READ_REG(DAR_IRQ_STS1);
>>>> +     /* read IRQSTSx */
>>>> +     ret = spi_async(lp->spi, &lp->irq_msg);
>>>> +     if (ret) {
>>>> +             enable_irq(irq);
>>>> +             return IRQ_NONE;
>>>> +     }
>>>> +
>>>> +     return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int mcr20a_get_platform_data(struct spi_device *spi,
>>>> +                                 struct mcr20a_platform_data *pdata)
>>>> +{
>>>> +     int ret = 0;
>>>> +
>>>> +     if (!spi->dev.of_node)
>>>> +             return -EINVAL;
>>>> +
>>>> +     pdata->rst_gpio = of_get_named_gpio(spi->dev.of_node, "rst_b-gpio", 0);
>>>> +     dev_dbg(&spi->dev, "rst_b-gpio: %d\n", pdata->rst_gpio);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static void mcr20a_hw_setup(struct mcr20a_local *lp)
>>>> +{
>>>> +     u8 i;
>>>> +     struct ieee802154_hw *hw = lp->hw;
>>>> +     struct wpan_phy *phy = lp->hw->phy;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     phy->symbol_duration = 16;
>>>> +     phy->lifs_period = 40;
>>>> +     phy->sifs_period = 12;
>>>> +
>>>> +     hw->flags = IEEE802154_HW_TX_OMIT_CKSUM |
>>>> +                     IEEE802154_HW_AFILT |
>>>> +                     IEEE802154_HW_PROMISCUOUS;
>>>> +
>>>> +     phy->flags = WPAN_PHY_FLAG_TXPOWER |
>>>> +             WPAN_PHY_FLAG_CCA_ED_LEVEL |
>>>> +             WPAN_PHY_FLAG_CCA_MODE;
>>>> +
>>>> +     phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
>>>> +             BIT(NL802154_CCA_CARRIER) | BIT(NL802154_CCA_ENERGY_CARRIER);
>>>> +     phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
>>>> +             BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
>>>> +
>>>> +     /* initiating cca_ed_levels */
>>>> +     for (i = MCR20A_MAX_CCA_THRESHOLD; i < MCR20A_MIN_CCA_THRESHOLD + 1;
>>>> +           ++i) {
>>>> +             mcr20a_ed_levels[i] =  -i * 100;
>>>> +     }
>>>> +
>>>> +     phy->supported.cca_ed_levels = mcr20a_ed_levels;
>>>> +     phy->supported.cca_ed_levels_size = ARRAY_SIZE(mcr20a_ed_levels);
>>>> +
>>>> +     phy->cca.mode = NL802154_CCA_ENERGY;
>>>> +
>>>> +     phy->supported.channels[0] = MCR20A_VALID_CHANNELS;
>>>> +     phy->current_page = 0;
>>>> +     /* MCR20A default reset value */
>>>> +     phy->current_channel = 20;
>>>> +     phy->symbol_duration = 16;
>>>> +     phy->supported.tx_powers = mcr20a_powers;
>>>> +     phy->supported.tx_powers_size = ARRAY_SIZE(mcr20a_powers);
>>>> +     phy->cca_ed_level = phy->supported.cca_ed_levels[75];
>>>> +     phy->transmit_power = phy->supported.tx_powers[0x0F];
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_setup_tx_spi_messages(struct mcr20a_local *lp)
>>>> +{
>>>> +     spi_message_init(&lp->tx_buf_msg);
>>>> +     lp->tx_buf_msg.context = lp;
>>>> +     lp->tx_buf_msg.complete = mcr20a_write_tx_buf_complete;
>>>> +
>>>> +     lp->tx_xfer_header.len = 1;
>>>> +     lp->tx_xfer_header.tx_buf = lp->tx_header;
>>>> +
>>>> +     lp->tx_xfer_len.len = 1;
>>>> +     lp->tx_xfer_len.tx_buf = lp->tx_len;
>>>> +
>>>> +     spi_message_add_tail(&lp->tx_xfer_header, &lp->tx_buf_msg);
>>>> +     spi_message_add_tail(&lp->tx_xfer_len, &lp->tx_buf_msg);
>>>> +     spi_message_add_tail(&lp->tx_xfer_buf, &lp->tx_buf_msg);
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_setup_rx_spi_messages(struct mcr20a_local *lp)
>>>> +{
>>>> +     spi_message_init(&lp->reg_msg);
>>>> +     lp->reg_msg.context = lp;
>>>> +
>>>> +     lp->reg_xfer_cmd.len = 1;
>>>> +     lp->reg_xfer_cmd.tx_buf = lp->reg_cmd;
>>>> +     lp->reg_xfer_cmd.rx_buf = lp->reg_cmd;
>>>> +
>>>> +     lp->reg_xfer_data.rx_buf = lp->reg_data;
>>>> +     lp->reg_xfer_data.tx_buf = lp->reg_data;
>>>> +
>>>> +     spi_message_add_tail(&lp->reg_xfer_cmd, &lp->reg_msg);
>>>> +     spi_message_add_tail(&lp->reg_xfer_data, &lp->reg_msg);
>>>> +
>>>> +     spi_message_init(&lp->rx_buf_msg);
>>>> +     lp->rx_buf_msg.context = lp;
>>>> +     lp->rx_buf_msg.complete = mcr20a_handle_rx_read_buf_complete;
>>>> +     lp->rx_xfer_header.len = 1;
>>>> +     lp->rx_xfer_header.tx_buf = lp->rx_header;
>>>> +     lp->rx_xfer_header.rx_buf = lp->rx_header;
>>>> +
>>>> +     lp->rx_xfer_buf.rx_buf = lp->rx_buf;
>>>> +
>>>> +     lp->rx_xfer_lqi.len = 1;
>>>> +     lp->rx_xfer_lqi.rx_buf = lp->rx_lqi;
>>>> +
>>>> +     spi_message_add_tail(&lp->rx_xfer_header, &lp->rx_buf_msg);
>>>> +     spi_message_add_tail(&lp->rx_xfer_buf, &lp->rx_buf_msg);
>>>> +     spi_message_add_tail(&lp->rx_xfer_lqi, &lp->rx_buf_msg);
>>>> +}
>>>> +
>>>> +static void
>>>> +mcr20a_setup_irq_spi_messages(struct mcr20a_local *lp)
>>>> +{
>>>> +     spi_message_init(&lp->irq_msg);
>>>> +     lp->irq_msg.context             = lp;
>>>> +     lp->irq_msg.complete    = mcr20a_irq_status_complete;
>>>> +     lp->irq_xfer_header.len = 1;
>>>> +     lp->irq_xfer_header.tx_buf = lp->irq_header;
>>>> +     lp->irq_xfer_header.rx_buf = lp->irq_header;
>>>> +
>>>> +     lp->irq_xfer_data.len   = MCR20A_IRQSTS_NUM;
>>>> +     lp->irq_xfer_data.rx_buf = lp->irq_data;
>>>> +
>>>> +     spi_message_add_tail(&lp->irq_xfer_header, &lp->irq_msg);
>>>> +     spi_message_add_tail(&lp->irq_xfer_data, &lp->irq_msg);
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_phy_init(struct mcr20a_local *lp)
>>>> +{
>>>> +     u8 index;
>>>> +     unsigned int phy_reg = 0;
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(printdev(lp), "%s\n", __func__);
>>>> +
>>>> +     /* Disable Tristate on COCO MISO for SPI reads */
>>>> +     ret = regmap_write(lp->regmap_iar, IAR_MISC_PAD_CTRL, 0x02);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* Clear all PP IRQ bits in IRQSTS1 to avoid unexpected interrupts
>>>> +      * immediately after init
>>>> +      */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_IRQ_STS1, 0xEF);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* Clear all PP IRQ bits in IRQSTS2 */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_IRQ_STS2,
>>>> +                        DAR_IRQSTS2_ASM_IRQ | DAR_IRQSTS2_PB_ERR_IRQ |
>>>> +                        DAR_IRQSTS2_WAKE_IRQ);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* Disable all timer interrupts */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_IRQ_STS3, 0xFF);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /*  PHY_CTRL1 : default HW settings + AUTOACK enabled */
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>>>> +                              DAR_PHY_CTRL1_AUTOACK, DAR_PHY_CTRL1_AUTOACK);
>>>> +
>>>> +     /*  PHY_CTRL2 : disable all interrupts */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_PHY_CTRL2, 0xFF);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* PHY_CTRL3 : disable all timers and remaining interrupts */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_PHY_CTRL3,
>>>> +                        DAR_PHY_CTRL3_ASM_MSK | DAR_PHY_CTRL3_PB_ERR_MSK |
>>>> +                        DAR_PHY_CTRL3_WAKE_MSK);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* SRC_CTRL : enable Acknowledge Frame Pending and
>>>> +      * Source Address Matching Enable
>>>> +      */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_SRC_CTRL,
>>>> +                        DAR_SRC_CTRL_ACK_FRM_PND |
>>>> +                        (DAR_SRC_CTRL_INDEX << DAR_SRC_CTRL_INDEX_SHIFT));
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /*  RX_FRAME_FILTER */
>>>> +     /*  FRM_VER[1:0] = b11. Accept FrameVersion 0 and 1 packets */
>>>> +     ret = regmap_write(lp->regmap_iar, IAR_RX_FRAME_FILTER,
>>>> +                        IAR_RX_FRAME_FLT_FRM_VER |
>>>> +                        IAR_RX_FRAME_FLT_BEACON_FT |
>>>> +                        IAR_RX_FRAME_FLT_DATA_FT |
>>>> +                        IAR_RX_FRAME_FLT_CMD_FT);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     dev_info(printdev(lp), "overwrites version: 0x%02x\n",
>>>> +              MCR20A_OVERWRITE_VERSION);
>>>> +
>>>> +     /* Overwrites direct registers  */
>>>> +     ret = regmap_write(lp->regmap_dar, DAR_OVERWRITE_VER,
>>>> +                        MCR20A_OVERWRITE_VERSION);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* Overwrites indirect registers  */
>>>> +     ret = regmap_multi_reg_write(lp->regmap_iar, mar20a_iar_overwrites,
>>>> +                                  ARRAY_SIZE(mar20a_iar_overwrites));
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* Clear HW indirect queue */
>>>> +     dev_dbg(printdev(lp), "clear HW indirect queue\n");
>>>> +     for (index = 0; index < MCR20A_PHY_INDIRECT_QUEUE_SIZE; index++) {
>>>> +             phy_reg = (u8)(((index & DAR_SRC_CTRL_INDEX) <<
>>>> +                            DAR_SRC_CTRL_INDEX_SHIFT)
>>>> +                           | (DAR_SRC_CTRL_SRCADDR_EN)
>>>> +                           | (DAR_SRC_CTRL_INDEX_DISABLE));
>>>> +             ret = regmap_write(lp->regmap_dar, DAR_SRC_CTRL, phy_reg);
>>>> +             if (ret)
>>>> +                     goto err_ret;
>>>> +             phy_reg = 0;
>>>> +     }
>>>> +
>>>> +     /* Assign HW Indirect hash table to PAN0 */
>>>> +     ret = regmap_read(lp->regmap_iar, IAR_DUAL_PAN_CTRL, &phy_reg);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* Clear current lvl */
>>>> +     phy_reg &= ~IAR_DUAL_PAN_CTRL_DUAL_PAN_SAM_LVL_MSK;
>>>> +
>>>> +     /* Set new lvl */
>>>> +     phy_reg |= MCR20A_PHY_INDIRECT_QUEUE_SIZE <<
>>>> +             IAR_DUAL_PAN_CTRL_DUAL_PAN_SAM_LVL_SHIFT;
>>>> +     ret = regmap_write(lp->regmap_iar, IAR_DUAL_PAN_CTRL, phy_reg);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* set CCA threshold to -75 dBm */
>>>> +     ret = regmap_write(lp->regmap_iar, IAR_CCA1_THRESH, 0x4B);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* set prescaller to obtain 1 symbol (16us) timebase */
>>>> +     ret = regmap_write(lp->regmap_iar, IAR_TMR_PRESCALE, 0x05);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* enable autodoze mode. */
>>>> +     dev_dbg(printdev(lp), "enable autodoze mode\n");
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_PWR_MODES,
>>>> +                              DAR_PWR_MODES_AUTODOZE,
>>>> +                              DAR_PWR_MODES_AUTODOZE);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     /* disable clk_out */
>>>> +     dev_dbg(printdev(lp), "disable clk_out\n");
>>>> +     ret = regmap_update_bits(lp->regmap_dar, DAR_CLK_OUT_CTRL,
>>>> +                              DAR_CLK_OUT_CTRL_EN, 0x0);
>>>> +     if (ret)
>>>> +             goto err_ret;
>>>> +
>>>> +     return 0;
>>>> +
>>>> +err_ret:
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int
>>>> +mcr20a_probe(struct spi_device *spi)
>>>> +{
>>>> +     struct ieee802154_hw *hw;
>>>> +     struct mcr20a_local *lp;
>>>> +     struct mcr20a_platform_data *pdata;
>>>> +     int irq_type;
>>>> +     int ret = -ENOMEM;
>>>> +
>>>> +     dev_dbg(&spi->dev, "%s\n", __func__);
>>>> +
>>>> +     if (!spi->irq) {
>>>> +             dev_err(&spi->dev, "no IRQ specified\n");
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
>>>> +     if (!pdata)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     /* set mcr20a platform data */
>>>> +     ret = mcr20a_get_platform_data(spi, pdata);
>>>> +     if (ret < 0) {
>>>> +             dev_crit(&spi->dev, "mcr20a_get_platform_data failed.\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     /* init reset gpio */
>>>> +     if (gpio_is_valid(pdata->rst_gpio)) {
>>>> +             ret = devm_gpio_request_one(&spi->dev, pdata->rst_gpio,
>>>> +                                         GPIOF_OUT_INIT_HIGH, "reset");
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     /* reset mcr20a */
>>>> +     if (gpio_is_valid(pdata->rst_gpio)) {
>>>> +             usleep_range(10, 20);
>>>> +             gpio_set_value_cansleep(pdata->rst_gpio, 0);
>>>> +             usleep_range(10, 20);
>>>> +             gpio_set_value_cansleep(pdata->rst_gpio, 1);
>>>> +             usleep_range(120, 240);
>>>> +     }
>>>> +
>>>> +     /* allocate ieee802154_hw and private data */
>>>> +     hw = ieee802154_alloc_hw(sizeof(*lp), &mcr20a_hw_ops);
>>>> +     if (!hw) {
>>>> +             dev_crit(&spi->dev, "ieee802154_alloc_hw failed\n");
>>>> +             return -ENOMEM;
>>>> +     }
>>>> +
>>>> +     /* init mcr20a local data */
>>>> +     lp = hw->priv;
>>>> +     lp->hw = hw;
>>>> +     lp->spi = spi;
>>>> +     lp->spi->dev.platform_data = pdata;
>>>> +     lp->pdata = pdata;
>>>> +
>>>> +     /* init ieee802154_hw */
>>>> +     hw->parent = &spi->dev;
>>>> +     ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
>>>> +
>>>> +     /* init buf */
>>>> +     lp->buf = devm_kzalloc(&spi->dev, SPI_COMMAND_BUFFER, GFP_KERNEL);
>>>> +
>>>> +     if (!lp->buf)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     mcr20a_setup_tx_spi_messages(lp);
>>>> +     mcr20a_setup_rx_spi_messages(lp);
>>>> +     mcr20a_setup_irq_spi_messages(lp);
>>>> +
>>>> +     /* setup regmap */
>>>> +     lp->regmap_dar = devm_regmap_init_spi(spi, &mcr20a_dar_regmap);
>>>> +     if (IS_ERR(lp->regmap_dar)) {
>>>> +             ret = PTR_ERR(lp->regmap_dar);
>>>> +             dev_err(&spi->dev, "Failed to allocate dar map: %d\n",
>>>> +                     ret);
>>>> +             goto free_dev;
>>>> +     }
>>>> +
>>>> +     lp->regmap_iar = devm_regmap_init_spi(spi, &mcr20a_iar_regmap);
>>>> +     if (IS_ERR(lp->regmap_iar)) {
>>>> +             ret = PTR_ERR(lp->regmap_iar);
>>>> +             dev_err(&spi->dev, "Failed to allocate iar map: %d\n", ret);
>>>> +             goto free_dev;
>>>> +     }
>>>> +
>>>> +     mcr20a_hw_setup(lp);
>>>> +
>>>> +     spi_set_drvdata(spi, lp);
>>>> +
>>>> +     ret = mcr20a_phy_init(lp);
>>>> +     if (ret < 0) {
>>>> +             dev_crit(&spi->dev, "mcr20a_phy_init failed\n");
>>>> +             goto free_dev;
>>>> +     }
>>>> +
>>>> +     irq_type = irq_get_trigger_type(spi->irq);
>>>> +     if (!irq_type)
>>>> +             irq_type = IRQF_TRIGGER_FALLING;
>>>> +
>>>> +     ret = devm_request_irq(&spi->dev, spi->irq, mcr20a_irq_isr,
>>>> +                            irq_type, dev_name(&spi->dev), lp);
>>>> +     if (ret) {
>>>> +             dev_err(&spi->dev, "could not request_irq for mcr20a\n");
>>>> +             ret = -ENODEV;
>>>> +             goto free_dev;
>>>> +     }
>>>> +
>>>> +     /* disable_irq by default and wait for starting hardware */
>>>> +     disable_irq(spi->irq);
>>>> +
>>>> +     ret = ieee802154_register_hw(hw);
>>>> +     if (ret) {
>>>> +             dev_crit(&spi->dev, "ieee802154_register_hw failed\n");
>>>> +             goto free_dev;
>>>> +     }
>>>> +
>>>> +     return ret;
>>>> +
>>>> +free_dev:
>>>> +     ieee802154_free_hw(lp->hw);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int mcr20a_remove(struct spi_device *spi)
>>>> +{
>>>> +     struct mcr20a_local *lp = spi_get_drvdata(spi);
>>>> +
>>>> +     dev_dbg(&spi->dev, "%s\n", __func__);
>>>> +
>>>> +     ieee802154_unregister_hw(lp->hw);
>>>> +     ieee802154_free_hw(lp->hw);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id mcr20a_of_match[] = {
>>>> +     { .compatible = "nxp,mcr20a", },
>>>> +     { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, mcr20a_of_match);
>>>> +
>>>> +static const struct spi_device_id mcr20a_device_id[] = {
>>>> +     { .name = "mcr20a", },
>>>> +     { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(spi, mcr20a_device_id);
>>>> +
>>>> +static struct spi_driver mcr20a_driver = {
>>>> +     .id_table = mcr20a_device_id,
>>>> +     .driver = {
>>>> +             .of_match_table = of_match_ptr(mcr20a_of_match),
>>>> +             .name   = "mcr20a",
>>>> +     },
>>>> +     .probe      = mcr20a_probe,
>>>> +     .remove     = mcr20a_remove,
>>>> +};
>>>> +
>>>> +module_spi_driver(mcr20a_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("MCR20A Transceiver Driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> +MODULE_AUTHOR("Xue Liu <liuxuenetmail@gmail>");
>>>> diff --git a/drivers/net/ieee802154/mcr20a.h b/drivers/net/ieee802154/mcr20a.h
>>>> new file mode 100644
>>>> index 0000000..6da4fd0
>>>> --- /dev/null
>>>> +++ b/drivers/net/ieee802154/mcr20a.h
>>>> @@ -0,0 +1,498 @@
>>>> +/*
>>>> + * Driver for NXP MCR20A 802.15.4 Wireless-PAN Networking controller
>>>> + *
>>>> + * Copyright (C) 2018 Xue Liu <liuxuenetmail@gmail.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2
>>>> + * as published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + */
>>>> +#ifndef _MCR20A_H
>>>> +#define _MCR20A_H
>>>> +
>>>> +/* Direct Accress Register */
>>>> +#define DAR_IRQ_STS1         0x00
>>>> +#define DAR_IRQ_STS2         0x01
>>>> +#define DAR_IRQ_STS3         0x02
>>>> +#define DAR_PHY_CTRL1                0x03
>>>> +#define DAR_PHY_CTRL2                0x04
>>>> +#define DAR_PHY_CTRL3                0x05
>>>> +#define DAR_RX_FRM_LEN               0x06
>>>> +#define DAR_PHY_CTRL4                0x07
>>>> +#define DAR_SRC_CTRL         0x08
>>>> +#define DAR_SRC_ADDRS_SUM_LSB        0x09
>>>> +#define DAR_SRC_ADDRS_SUM_MSB        0x0A
>>>> +#define DAR_CCA1_ED_FNL              0x0B
>>>> +#define DAR_EVENT_TMR_LSB    0x0C
>>>> +#define DAR_EVENT_TMR_MSB    0x0D
>>>> +#define DAR_EVENT_TMR_USB    0x0E
>>>> +#define DAR_TIMESTAMP_LSB    0x0F
>>>> +#define DAR_TIMESTAMP_MSB    0x10
>>>> +#define DAR_TIMESTAMP_USB    0x11
>>>> +#define DAR_T3CMP_LSB                0x12
>>>> +#define DAR_T3CMP_MSB                0x13
>>>> +#define DAR_T3CMP_USB                0x14
>>>> +#define DAR_T2PRIMECMP_LSB   0x15
>>>> +#define DAR_T2PRIMECMP_MSB   0x16
>>>> +#define DAR_T1CMP_LSB                0x17
>>>> +#define DAR_T1CMP_MSB                0x18
>>>> +#define DAR_T1CMP_USB                0x19
>>>> +#define DAR_T2CMP_LSB                0x1A
>>>> +#define DAR_T2CMP_MSB                0x1B
>>>> +#define DAR_T2CMP_USB                0x1C
>>>> +#define DAR_T4CMP_LSB                0x1D
>>>> +#define DAR_T4CMP_MSB                0x1E
>>>> +#define DAR_T4CMP_USB                0x1F
>>>> +#define DAR_PLL_INT0         0x20
>>>> +#define DAR_PLL_FRAC0_LSB    0x21
>>>> +#define DAR_PLL_FRAC0_MSB    0x22
>>>> +#define DAR_PA_PWR           0x23
>>>> +#define DAR_SEQ_STATE                0x24
>>>> +#define DAR_LQI_VALUE                0x25
>>>> +#define DAR_RSSI_CCA_CONT    0x26
>>>> +/*------------------            0x27 */
>>>> +#define DAR_ASM_CTRL1                0x28
>>>> +#define DAR_ASM_CTRL2                0x29
>>>> +#define DAR_ASM_DATA_0               0x2A
>>>> +#define DAR_ASM_DATA_1               0x2B
>>>> +#define DAR_ASM_DATA_2               0x2C
>>>> +#define DAR_ASM_DATA_3               0x2D
>>>> +#define DAR_ASM_DATA_4               0x2E
>>>> +#define DAR_ASM_DATA_5               0x2F
>>>> +#define DAR_ASM_DATA_6               0x30
>>>> +#define DAR_ASM_DATA_7               0x31
>>>> +#define DAR_ASM_DATA_8               0x32
>>>> +#define DAR_ASM_DATA_9               0x33
>>>> +#define DAR_ASM_DATA_A               0x34
>>>> +#define DAR_ASM_DATA_B               0x35
>>>> +#define DAR_ASM_DATA_C               0x36
>>>> +#define DAR_ASM_DATA_D               0x37
>>>> +#define DAR_ASM_DATA_E               0x38
>>>> +#define DAR_ASM_DATA_F               0x39
>>>> +/*-----------------------       0x3A */
>>>> +#define DAR_OVERWRITE_VER    0x3B
>>>> +#define DAR_CLK_OUT_CTRL     0x3C
>>>> +#define DAR_PWR_MODES                0x3D
>>>> +#define IAR_INDEX            0x3E
>>>> +#define IAR_DATA             0x3F
>>>> +
>>>> +/* Indirect Resgister Memory */
>>>> +#define IAR_PART_ID          0x00
>>>> +#define IAR_XTAL_TRIM                0x01
>>>> +#define IAR_PMC_LP_TRIM              0x02
>>>> +#define IAR_MACPANID0_LSB    0x03
>>>> +#define IAR_MACPANID0_MSB    0x04
>>>> +#define IAR_MACSHORTADDRS0_LSB       0x05
>>>> +#define IAR_MACSHORTADDRS0_MSB       0x06
>>>> +#define IAR_MACLONGADDRS0_0  0x07
>>>> +#define IAR_MACLONGADDRS0_8  0x08
>>>> +#define IAR_MACLONGADDRS0_16 0x09
>>>> +#define IAR_MACLONGADDRS0_24 0x0A
>>>> +#define IAR_MACLONGADDRS0_32 0x0B
>>>> +#define IAR_MACLONGADDRS0_40 0x0C
>>>> +#define IAR_MACLONGADDRS0_48 0x0D
>>>> +#define IAR_MACLONGADDRS0_56 0x0E
>>>> +#define IAR_RX_FRAME_FILTER  0x0F
>>>> +#define IAR_PLL_INT1         0x10
>>>> +#define IAR_PLL_FRAC1_LSB    0x11
>>>> +#define IAR_PLL_FRAC1_MSB    0x12
>>>> +#define IAR_MACPANID1_LSB    0x13
>>>> +#define IAR_MACPANID1_MSB    0x14
>>>> +#define IAR_MACSHORTADDRS1_LSB       0x15
>>>> +#define IAR_MACSHORTADDRS1_MSB       0x16
>>>> +#define IAR_MACLONGADDRS1_0  0x17
>>>> +#define IAR_MACLONGADDRS1_8  0x18
>>>> +#define IAR_MACLONGADDRS1_16 0x19
>>>> +#define IAR_MACLONGADDRS1_24 0x1A
>>>> +#define IAR_MACLONGADDRS1_32 0x1B
>>>> +#define IAR_MACLONGADDRS1_40 0x1C
>>>> +#define IAR_MACLONGADDRS1_48 0x1D
>>>> +#define IAR_MACLONGADDRS1_56 0x1E
>>>> +#define IAR_DUAL_PAN_CTRL    0x1F
>>>> +#define IAR_DUAL_PAN_DWELL   0x20
>>>> +#define IAR_DUAL_PAN_STS     0x21
>>>> +#define IAR_CCA1_THRESH              0x22
>>>> +#define IAR_CCA1_ED_OFFSET_COMP      0x23
>>>> +#define IAR_LQI_OFFSET_COMP  0x24
>>>> +#define IAR_CCA_CTRL         0x25
>>>> +#define IAR_CCA2_CORR_PEAKS  0x26
>>>> +#define IAR_CCA2_CORR_THRESH 0x27
>>>> +#define IAR_TMR_PRESCALE     0x28
>>>> +/*--------------------          0x29 */
>>>> +#define IAR_GPIO_DATA                0x2A
>>>> +#define IAR_GPIO_DIR         0x2B
>>>> +#define IAR_GPIO_PUL_EN              0x2C
>>>> +#define IAR_GPIO_PUL_SEL     0x2D
>>>> +#define IAR_GPIO_DS          0x2E
>>>> +/*------------------            0x2F */
>>>> +#define IAR_ANT_PAD_CTRL     0x30
>>>> +#define IAR_MISC_PAD_CTRL    0x31
>>>> +#define IAR_BSM_CTRL         0x32
>>>> +/*-------------------           0x33 */
>>>> +#define IAR_RNG                      0x34
>>>> +#define IAR_RX_BYTE_COUNT    0x35
>>>> +#define IAR_RX_WTR_MARK              0x36
>>>> +#define IAR_SOFT_RESET               0x37
>>>> +#define IAR_TXDELAY          0x38
>>>> +#define IAR_ACKDELAY         0x39
>>>> +#define IAR_SEQ_MGR_CTRL     0x3A
>>>> +#define IAR_SEQ_MGR_STS              0x3B
>>>> +#define IAR_SEQ_T_STS                0x3C
>>>> +#define IAR_ABORT_STS                0x3D
>>>> +#define IAR_CCCA_BUSY_CNT    0x3E
>>>> +#define IAR_SRC_ADDR_CHECKSUM1       0x3F
>>>> +#define IAR_SRC_ADDR_CHECKSUM2       0x40
>>>> +#define IAR_SRC_TBL_VALID1   0x41
>>>> +#define IAR_SRC_TBL_VALID2   0x42
>>>> +#define IAR_FILTERFAIL_CODE1 0x43
>>>> +#define IAR_FILTERFAIL_CODE2 0x44
>>>> +#define IAR_SLOT_PRELOAD     0x45
>>>> +/*--------------------          0x46 */
>>>> +#define IAR_CORR_VT          0x47
>>>> +#define IAR_SYNC_CTRL                0x48
>>>> +#define IAR_PN_LSB_0         0x49
>>>> +#define IAR_PN_LSB_1         0x4A
>>>> +#define IAR_PN_MSB_0         0x4B
>>>> +#define IAR_PN_MSB_1         0x4C
>>>> +#define IAR_CORR_NVAL                0x4D
>>>> +#define IAR_TX_MODE_CTRL     0x4E
>>>> +#define IAR_SNF_THR          0x4F
>>>> +#define IAR_FAD_THR          0x50
>>>> +#define IAR_ANT_AGC_CTRL     0x51
>>>> +#define IAR_AGC_THR1         0x52
>>>> +#define IAR_AGC_THR2         0x53
>>>> +#define IAR_AGC_HYS          0x54
>>>> +#define IAR_AFC                      0x55
>>>> +/*-------------------           0x56 */
>>>> +/*-------------------           0x57 */
>>>> +#define IAR_PHY_STS          0x58
>>>> +#define IAR_RX_MAX_CORR              0x59
>>>> +#define IAR_RX_MAX_PREAMBLE  0x5A
>>>> +#define IAR_RSSI             0x5B
>>>> +/*-------------------           0x5C */
>>>> +/*-------------------           0x5D */
>>>> +#define IAR_PLL_DIG_CTRL     0x5E
>>>> +#define IAR_VCO_CAL          0x5F
>>>> +#define IAR_VCO_BEST_DIFF    0x60
>>>> +#define IAR_VCO_BIAS         0x61
>>>> +#define IAR_KMOD_CTRL                0x62
>>>> +#define IAR_KMOD_CAL         0x63
>>>> +#define IAR_PA_CAL           0x64
>>>> +#define IAR_PA_PWRCAL                0x65
>>>> +#define IAR_ATT_RSSI1                0x66
>>>> +#define IAR_ATT_RSSI2                0x67
>>>> +#define IAR_RSSI_OFFSET              0x68
>>>> +#define IAR_RSSI_SLOPE               0x69
>>>> +#define IAR_RSSI_CAL1                0x6A
>>>> +#define IAR_RSSI_CAL2                0x6B
>>>> +/*-------------------           0x6C */
>>>> +/*-------------------           0x6D */
>>>> +#define IAR_XTAL_CTRL                0x6E
>>>> +#define IAR_XTAL_COMP_MIN    0x6F
>>>> +#define IAR_XTAL_COMP_MAX    0x70
>>>> +#define IAR_XTAL_GM          0x71
>>>> +/*-------------------           0x72 */
>>>> +/*-------------------           0x73 */
>>>> +#define IAR_LNA_TUNE         0x74
>>>> +#define IAR_LNA_AGCGAIN              0x75
>>>> +/*-------------------           0x76 */
>>>> +/*-------------------           0x77 */
>>>> +#define IAR_CHF_PMA_GAIN     0x78
>>>> +#define IAR_CHF_IBUF         0x79
>>>> +#define IAR_CHF_QBUF         0x7A
>>>> +#define IAR_CHF_IRIN         0x7B
>>>> +#define IAR_CHF_QRIN         0x7C
>>>> +#define IAR_CHF_IL           0x7D
>>>> +#define IAR_CHF_QL           0x7E
>>>> +#define IAR_CHF_CC1          0x7F
>>>> +#define IAR_CHF_CCL          0x80
>>>> +#define IAR_CHF_CC2          0x81
>>>> +#define IAR_CHF_IROUT                0x82
>>>> +#define IAR_CHF_QROUT                0x83
>>>> +/*-------------------           0x84 */
>>>> +/*-------------------           0x85 */
>>>> +#define IAR_RSSI_CTRL                0x86
>>>> +/*-------------------           0x87 */
>>>> +/*-------------------           0x88 */
>>>> +#define IAR_PA_BIAS          0x89
>>>> +#define IAR_PA_TUNING                0x8A
>>>> +/*-------------------           0x8B */
>>>> +/*-------------------           0x8C */
>>>> +#define IAR_PMC_HP_TRIM              0x8D
>>>> +#define IAR_VREGA_TRIM               0x8E
>>>> +/*-------------------           0x8F */
>>>> +/*-------------------           0x90 */
>>>> +#define IAR_VCO_CTRL1                0x91
>>>> +#define IAR_VCO_CTRL2                0x92
>>>> +/*-------------------           0x93 */
>>>> +/*-------------------           0x94 */
>>>> +#define IAR_ANA_SPARE_OUT1   0x95
>>>> +#define IAR_ANA_SPARE_OUT2   0x96
>>>> +#define IAR_ANA_SPARE_IN     0x97
>>>> +#define IAR_MISCELLANEOUS    0x98
>>>> +/*-------------------           0x99 */
>>>> +#define IAR_SEQ_MGR_OVRD0    0x9A
>>>> +#define IAR_SEQ_MGR_OVRD1    0x9B
>>>> +#define IAR_SEQ_MGR_OVRD2    0x9C
>>>> +#define IAR_SEQ_MGR_OVRD3    0x9D
>>>> +#define IAR_SEQ_MGR_OVRD4    0x9E
>>>> +#define IAR_SEQ_MGR_OVRD5    0x9F
>>>> +#define IAR_SEQ_MGR_OVRD6    0xA0
>>>> +#define IAR_SEQ_MGR_OVRD7    0xA1
>>>> +/*-------------------           0xA2 */
>>>> +#define IAR_TESTMODE_CTRL    0xA3
>>>> +#define IAR_DTM_CTRL1                0xA4
>>>> +#define IAR_DTM_CTRL2                0xA5
>>>> +#define IAR_ATM_CTRL1                0xA6
>>>> +#define IAR_ATM_CTRL2                0xA7
>>>> +#define IAR_ATM_CTRL3                0xA8
>>>> +/*-------------------           0xA9 */
>>>> +#define IAR_LIM_FE_TEST_CTRL 0xAA
>>>> +#define IAR_CHF_TEST_CTRL    0xAB
>>>> +#define IAR_VCO_TEST_CTRL    0xAC
>>>> +#define IAR_PLL_TEST_CTRL    0xAD
>>>> +#define IAR_PA_TEST_CTRL     0xAE
>>>> +#define IAR_PMC_TEST_CTRL    0xAF
>>>> +#define IAR_SCAN_DTM_PROTECT_1       0xFE
>>>> +#define IAR_SCAN_DTM_PROTECT_0       0xFF
>>>> +
>>>> +/* IRQSTS1 bits */
>>>> +#define DAR_IRQSTS1_RX_FRM_PEND              BIT(7)
>>>> +#define DAR_IRQSTS1_PLL_UNLOCK_IRQ   BIT(6)
>>>> +#define DAR_IRQSTS1_FILTERFAIL_IRQ   BIT(5)
>>>> +#define DAR_IRQSTS1_RXWTRMRKIRQ              BIT(4)
>>>> +#define DAR_IRQSTS1_CCAIRQ           BIT(3)
>>>> +#define DAR_IRQSTS1_RXIRQ            BIT(2)
>>>> +#define DAR_IRQSTS1_TXIRQ            BIT(1)
>>>> +#define DAR_IRQSTS1_SEQIRQ           BIT(0)
>>>> +
>>>> +/* IRQSTS2 bits */
>>>> +#define DAR_IRQSTS2_CRCVALID         BIT(7)
>>>> +#define DAR_IRQSTS2_CCA                      BIT(6)
>>>> +#define DAR_IRQSTS2_SRCADDR          BIT(5)
>>>> +#define DAR_IRQSTS2_PI                       BIT(4)
>>>> +#define DAR_IRQSTS2_TMRSTATUS                BIT(3)
>>>> +#define DAR_IRQSTS2_ASM_IRQ          BIT(2)
>>>> +#define DAR_IRQSTS2_PB_ERR_IRQ               BIT(1)
>>>> +#define DAR_IRQSTS2_WAKE_IRQ         BIT(0)
>>>> +
>>>> +/* IRQSTS3 bits */
>>>> +#define DAR_IRQSTS3_TMR4MSK          BIT(7)
>>>> +#define DAR_IRQSTS3_TMR3MSK          BIT(6)
>>>> +#define DAR_IRQSTS3_TMR2MSK          BIT(5)
>>>> +#define DAR_IRQSTS3_TMR1MSK          BIT(4)
>>>> +#define DAR_IRQSTS3_TMR4IRQ          BIT(3)
>>>> +#define DAR_IRQSTS3_TMR3IRQ          BIT(2)
>>>> +#define DAR_IRQSTS3_TMR2IRQ          BIT(1)
>>>> +#define DAR_IRQSTS3_TMR1IRQ          BIT(0)
>>>> +
>>>> +/* PHY_CTRL1 bits */
>>>> +#define DAR_PHY_CTRL1_TMRTRIGEN              BIT(7)
>>>> +#define DAR_PHY_CTRL1_SLOTTED                BIT(6)
>>>> +#define DAR_PHY_CTRL1_CCABFRTX               BIT(5)
>>>> +#define DAR_PHY_CTRL1_CCABFRTX_SHIFT 5
>>>> +#define DAR_PHY_CTRL1_RXACKRQD               BIT(4)
>>>> +#define DAR_PHY_CTRL1_AUTOACK                BIT(3)
>>>> +#define DAR_PHY_CTRL1_XCVSEQ_MASK    0x07
>>>> +
>>>> +/* PHY_CTRL2 bits */
>>>> +#define DAR_PHY_CTRL2_CRC_MSK                BIT(7)
>>>> +#define DAR_PHY_CTRL2_PLL_UNLOCK_MSK BIT(6)
>>>> +#define DAR_PHY_CTRL2_FILTERFAIL_MSK BIT(5)
>>>> +#define DAR_PHY_CTRL2_RX_WMRK_MSK    BIT(4)
>>>> +#define DAR_PHY_CTRL2_CCAMSK         BIT(3)
>>>> +#define DAR_PHY_CTRL2_RXMSK          BIT(2)
>>>> +#define DAR_PHY_CTRL2_TXMSK          BIT(1)
>>>> +#define DAR_PHY_CTRL2_SEQMSK         BIT(0)
>>>> +
>>>> +/* PHY_CTRL3 bits */
>>>> +#define DAR_PHY_CTRL3_TMR4CMP_EN     BIT(7)
>>>> +#define DAR_PHY_CTRL3_TMR3CMP_EN     BIT(6)
>>>> +#define DAR_PHY_CTRL3_TMR2CMP_EN     BIT(5)
>>>> +#define DAR_PHY_CTRL3_TMR1CMP_EN     BIT(4)
>>>> +#define DAR_PHY_CTRL3_ASM_MSK                BIT(2)
>>>> +#define DAR_PHY_CTRL3_PB_ERR_MSK     BIT(1)
>>>> +#define DAR_PHY_CTRL3_WAKE_MSK               BIT(0)
>>>> +
>>>> +/* RX_FRM_LEN bits */
>>>> +#define DAR_RX_FRAME_LENGTH_MASK     (0x7F)
>>>> +
>>>> +/* PHY_CTRL4 bits */
>>>> +#define DAR_PHY_CTRL4_TRCV_MSK               BIT(7)
>>>> +#define DAR_PHY_CTRL4_TC3TMOUT               BIT(6)
>>>> +#define DAR_PHY_CTRL4_PANCORDNTR0    BIT(5)
>>>> +#define DAR_PHY_CTRL4_CCATYPE                (3)
>>>> +#define DAR_PHY_CTRL4_CCATYPE_SHIFT  (3)
>>>> +#define DAR_PHY_CTRL4_CCATYPE_MASK   (0x18)
>>>> +#define DAR_PHY_CTRL4_TMRLOAD                BIT(2)
>>>> +#define DAR_PHY_CTRL4_PROMISCUOUS    BIT(1)
>>>> +#define DAR_PHY_CTRL4_TC2PRIME_EN    BIT(0)
>>>> +
>>>> +/* SRC_CTRL bits */
>>>> +#define DAR_SRC_CTRL_INDEX           (0x0F)
>>>> +#define DAR_SRC_CTRL_INDEX_SHIFT     (4)
>>>> +#define DAR_SRC_CTRL_ACK_FRM_PND     BIT(3)
>>>> +#define DAR_SRC_CTRL_SRCADDR_EN              BIT(2)
>>>> +#define DAR_SRC_CTRL_INDEX_EN                BIT(1)
>>>> +#define DAR_SRC_CTRL_INDEX_DISABLE   BIT(0)
>>>> +
>>>> +/* DAR_ASM_CTRL1 bits */
>>>> +#define DAR_ASM_CTRL1_CLEAR          BIT(7)
>>>> +#define DAR_ASM_CTRL1_START          BIT(6)
>>>> +#define DAR_ASM_CTRL1_SELFTST                BIT(5)
>>>> +#define DAR_ASM_CTRL1_CTR            BIT(4)
>>>> +#define DAR_ASM_CTRL1_CBC            BIT(3)
>>>> +#define DAR_ASM_CTRL1_AES            BIT(2)
>>>> +#define DAR_ASM_CTRL1_LOAD_MAC               BIT(1)
>>>> +
>>>> +/* DAR_ASM_CTRL2 bits */
>>>> +#define DAR_ASM_CTRL2_DATA_REG_TYPE_SEL              (7)
>>>> +#define DAR_ASM_CTRL2_DATA_REG_TYPE_SEL_SHIFT        (5)
>>>> +#define DAR_ASM_CTRL2_TSTPAS                 BIT(1)
>>>> +
>>>> +/* DAR_CLK_OUT_CTRL bits */
>>>> +#define DAR_CLK_OUT_CTRL_EXTEND              BIT(7)
>>>> +#define DAR_CLK_OUT_CTRL_HIZ         BIT(6)
>>>> +#define DAR_CLK_OUT_CTRL_SR          BIT(5)
>>>> +#define DAR_CLK_OUT_CTRL_DS          BIT(4)
>>>> +#define DAR_CLK_OUT_CTRL_EN          BIT(3)
>>>> +#define DAR_CLK_OUT_CTRL_DIV         (7)
>>>> +
>>>> +/* DAR_PWR_MODES bits */
>>>> +#define DAR_PWR_MODES_XTAL_READY     BIT(5)
>>>> +#define DAR_PWR_MODES_XTALEN         BIT(4)
>>>> +#define DAR_PWR_MODES_ASM_CLK_EN     BIT(3)
>>>> +#define DAR_PWR_MODES_AUTODOZE               BIT(1)
>>>> +#define DAR_PWR_MODES_PMC_MODE               BIT(0)
>>>> +
>>>> +/* RX_FRAME_FILTER bits */
>>>> +#define IAR_RX_FRAME_FLT_FRM_VER             (0xC0)
>>>> +#define IAR_RX_FRAME_FLT_FRM_VER_SHIFT               (6)
>>>> +#define IAR_RX_FRAME_FLT_ACTIVE_PROMISCUOUS  BIT(5)
>>>> +#define IAR_RX_FRAME_FLT_NS_FT                       BIT(4)
>>>> +#define IAR_RX_FRAME_FLT_CMD_FT                      BIT(3)
>>>> +#define IAR_RX_FRAME_FLT_ACK_FT                      BIT(2)
>>>> +#define IAR_RX_FRAME_FLT_DATA_FT             BIT(1)
>>>> +#define IAR_RX_FRAME_FLT_BEACON_FT           BIT(0)
>>>> +
>>>> +/* DUAL_PAN_CTRL bits */
>>>> +#define IAR_DUAL_PAN_CTRL_DUAL_PAN_SAM_LVL_MSK       (0xF0)
>>>> +#define IAR_DUAL_PAN_CTRL_DUAL_PAN_SAM_LVL_SHIFT     (4)
>>>> +#define IAR_DUAL_PAN_CTRL_CURRENT_NETWORK    BIT(3)
>>>> +#define IAR_DUAL_PAN_CTRL_PANCORDNTR1                BIT(2)
>>>> +#define IAR_DUAL_PAN_CTRL_DUAL_PAN_AUTO              BIT(1)
>>>> +#define IAR_DUAL_PAN_CTRL_ACTIVE_NETWORK     BIT(0)
>>>> +
>>>> +/* DUAL_PAN_STS bits */
>>>> +#define IAR_DUAL_PAN_STS_RECD_ON_PAN1                BIT(7)
>>>> +#define IAR_DUAL_PAN_STS_RECD_ON_PAN0                BIT(6)
>>>> +#define IAR_DUAL_PAN_STS_DUAL_PAN_REMAIN     (0x3F)
>>>> +
>>>> +/* CCA_CTRL bits */
>>>> +#define IAR_CCA_CTRL_AGC_FRZ_EN                      BIT(6)
>>>> +#define IAR_CCA_CTRL_CONT_RSSI_EN            BIT(5)
>>>> +#define IAR_CCA_CTRL_LQI_RSSI_NOT_CORR       BIT(4)
>>>> +#define IAR_CCA_CTRL_CCA3_AND_NOT_OR BIT(3)
>>>> +#define IAR_CCA_CTRL_POWER_COMP_EN_LQI       BIT(2)
>>>> +#define IAR_CCA_CTRL_POWER_COMP_EN_ED        BIT(1)
>>>> +#define IAR_CCA_CTRL_POWER_COMP_EN_CCA1      BIT(0)
>>>> +
>>>> +/* ANT_PAD_CTRL bits */
>>>> +#define IAR_ANT_PAD_CTRL_ANTX_POL    (0x0F)
>>>> +#define IAR_ANT_PAD_CTRL_ANTX_POL_SHIFT      (4)
>>>> +#define IAR_ANT_PAD_CTRL_ANTX_CTRLMODE       BIT(3)
>>>> +#define IAR_ANT_PAD_CTRL_ANTX_HZ     BIT(2)
>>>> +#define IAR_ANT_PAD_CTRL_ANTX_EN     (3)
>>>> +
>>>> +/* MISC_PAD_CTRL bits */
>>>> +#define IAR_MISC_PAD_CTRL_MISO_HIZ_EN        BIT(3)
>>>> +#define IAR_MISC_PAD_CTRL_IRQ_B_OD   BIT(2)
>>>> +#define IAR_MISC_PAD_CTRL_NON_GPIO_DS        BIT(1)
>>>> +#define IAR_MISC_PAD_CTRL_ANTX_CURR  (1)
>>>> +
>>>> +/* ANT_AGC_CTRL bits */
>>>> +#define IAR_ANT_AGC_CTRL_FAD_EN_SHIFT        (0)
>>>> +#define IAR_ANT_AGC_CTRL_FAD_EN_MASK (1)
>>>> +#define IAR_ANT_AGC_CTRL_ANTX_SHIFT  (1)
>>>> +#define IAR_ANT_AGC_CTRL_ANTX_MASK   BIT(AR_ANT_AGC_CTRL_ANTX_SHIFT)
>>>> +
>>>> +/* BSM_CTRL bits */
>>>> +#define BSM_CTRL_BSM_EN              (1)
>>>> +
>>>> +/* SOFT_RESET bits */
>>>> +#define IAR_SOFT_RESET_SOG_RST               BIT(7)
>>>> +#define IAR_SOFT_RESET_REGS_RST              BIT(4)
>>>> +#define IAR_SOFT_RESET_PLL_RST               BIT(3)
>>>> +#define IAR_SOFT_RESET_TX_RST                BIT(2)
>>>> +#define IAR_SOFT_RESET_RX_RST                BIT(1)
>>>> +#define IAR_SOFT_RESET_SEQ_MGR_RST   BIT(0)
>>>> +
>>>> +/* SEQ_MGR_CTRL bits */
>>>> +#define IAR_SEQ_MGR_CTRL_SEQ_STATE_CTRL              (3)
>>>> +#define IAR_SEQ_MGR_CTRL_SEQ_STATE_CTRL_SHIFT        (6)
>>>> +#define IAR_SEQ_MGR_CTRL_NO_RX_RECYCLE               BIT(5)
>>>> +#define IAR_SEQ_MGR_CTRL_LATCH_PREAMBLE              BIT(4)
>>>> +#define IAR_SEQ_MGR_CTRL_EVENT_TMR_DO_NOT_LATCH      BIT(3)
>>>> +#define IAR_SEQ_MGR_CTRL_CLR_NEW_SEQ_INHIBIT BIT(2)
>>>> +#define IAR_SEQ_MGR_CTRL_PSM_LOCK_DIS                BIT(1)
>>>> +#define IAR_SEQ_MGR_CTRL_PLL_ABORT_OVRD              BIT(0)
>>>> +
>>>> +/* SEQ_MGR_STS bits */
>>>> +#define IAR_SEQ_MGR_STS_TMR2_SEQ_TRIG_ARMED  BIT(7)
>>>> +#define IAR_SEQ_MGR_STS_RX_MODE                      BIT(6)
>>>> +#define IAR_SEQ_MGR_STS_RX_TIMEOUT_PENDING   BIT(5)
>>>> +#define IAR_SEQ_MGR_STS_NEW_SEQ_INHIBIT              BIT(4)
>>>> +#define IAR_SEQ_MGR_STS_SEQ_IDLE             BIT(3)
>>>> +#define IAR_SEQ_MGR_STS_XCVSEQ_ACTUAL                (7)
>>>> +
>>>> +/* ABORT_STS bits */
>>>> +#define IAR_ABORT_STS_PLL_ABORTED    BIT(2)
>>>> +#define IAR_ABORT_STS_TC3_ABORTED    BIT(1)
>>>> +#define IAR_ABORT_STS_SW_ABORTED     BIT(0)
>>>> +
>>>> +/* IAR_FILTERFAIL_CODE2 bits */
>>>> +#define IAR_FILTERFAIL_CODE2_PAN_SEL BIT(7)
>>>> +#define IAR_FILTERFAIL_CODE2_9_8     (3)
>>>> +
>>>> +/* PHY_STS bits */
>>>> +#define IAR_PHY_STS_PLL_UNLOCK               BIT(7)
>>>> +#define IAR_PHY_STS_PLL_LOCK_ERR     BIT(6)
>>>> +#define IAR_PHY_STS_PLL_LOCK         BIT(5)
>>>> +#define IAR_PHY_STS_CRCVALID         BIT(3)
>>>> +#define IAR_PHY_STS_FILTERFAIL_FLAG_SEL      BIT(2)
>>>> +#define IAR_PHY_STS_SFD_DET          BIT(1)
>>>> +#define IAR_PHY_STS_PREAMBLE_DET     BIT(0)
>>>> +
>>>> +/* TESTMODE_CTRL bits */
>>>> +#define IAR_TEST_MODE_CTRL_HOT_ANT           BIT(4)
>>>> +#define IAR_TEST_MODE_CTRL_IDEAL_RSSI_EN     BIT(3)
>>>> +#define IAR_TEST_MODE_CTRL_IDEAL_PFC_EN              BIT(2)
>>>> +#define IAR_TEST_MODE_CTRL_CONTINUOUS_EN     BIT(1)
>>>> +#define IAR_TEST_MODE_CTRL_FPGA_EN           BIT(0)
>>>> +
>>>> +/* DTM_CTRL1 bits */
>>>> +#define IAR_DTM_CTRL1_ATM_LOCKED     BIT(7)
>>>> +#define IAR_DTM_CTRL1_DTM_EN         BIT(6)
>>>> +#define IAR_DTM_CTRL1_PAGE5          BIT(5)
>>>> +#define IAR_DTM_CTRL1_PAGE4          BIT(4)
>>>> +#define IAR_DTM_CTRL1_PAGE3          BIT(3)
>>>> +#define IAR_DTM_CTRL1_PAGE2          BIT(2)
>>>> +#define IAR_DTM_CTRL1_PAGE1          BIT(1)
>>>> +#define IAR_DTM_CTRL1_PAGE0          BIT(0)
>>>> +
>>>> +/* TX_MODE_CTRL */
>>>> +#define IAR_TX_MODE_CTRL_TX_INV              BIT(4)
>>>> +#define IAR_TX_MODE_CTRL_BT_EN               BIT(3)
>>>> +#define IAR_TX_MODE_CTRL_DTS2                BIT(2)
>>>> +#define IAR_TX_MODE_CTRL_DTS1                BIT(1)
>>>> +#define IAR_TX_MODE_CTRL_DTS0                BIT(0)
>>>> +
>>>> +#define TX_MODE_CTRL_DTS_MASK        (7)
>>>> +
>>>> +#endif /* _MCR20A_H */
>>> The rest looks fine.
>>>
>>> regards
>>> Stefan Schmidt
>
> With the small nitpick from above fixed I would go ahead and apply this patchset tomorrow.
>
> Let me know if you will send a new version or if I should amend the small change myself.
>
> regards
> Stefan Schmidt
