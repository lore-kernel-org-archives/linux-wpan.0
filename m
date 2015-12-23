Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33439 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985AbbLWWMi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Dec 2015 17:12:38 -0500
Received: by mail-wm0-f48.google.com with SMTP id p187so160100974wmp.0
        for <linux-wpan@vger.kernel.org>; Wed, 23 Dec 2015 14:12:38 -0800 (PST)
Date: Wed, 23 Dec 2015 23:12:28 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 1/1] ieee802154: cc2520: Check CRC & add promiscuous
Message-ID: <20151223221226.GA3932@omega>
References: <1450858678-59333-1-git-send-email-bradjc5@gmail.com>
 <1450858678-59333-2-git-send-email-bradjc5@gmail.com>
 <20151223095542.GB2075@omega>
 <CADEbMG3ogcs2Ep2N2paSU5uwfQqsULBwHHFG-U7czsRR=BOgjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADEbMG3ogcs2Ep2N2paSU5uwfQqsULBwHHFG-U7czsRR=BOgjA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Wed, Dec 23, 2015 at 04:27:12PM -0500, Brad Campbell wrote:
> On Wed, Dec 23, 2015 at 4:55 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> > On Wed, Dec 23, 2015 at 03:17:58AM -0500, Brad Campbell wrote:
> >> This patch adds checking the "CRC_OK" bit at the end of packets coming
> >> from the CC2520 radio. It also adds support for putting the radio in
> >> promiscuous mode (in which packets are not dropped if the CRC fails).
> >> In order to provide monitors information about CRC pass/fail, the CRC is
> >> recreated in the driver and appended to the packet before being passed
> >> to higher layers. If the CRC failed, a dummy CRC is appended.
> >>
> >
> > Why append a dummy CRC? There is a CRC and leave it there.
> >
> > There could be one reason to do this:
> >
> > There is no CRC appended when CRC failed.
> >
> > Is this true? I don't know how the CC2520 is working and why it should
> > do this.
> >
> 
> When the AUTOCRC bit is set, upon packet reception the CC2520 does
> not return the two FCS bytes, instead it replaces them with 1 byte
> of RSSI, 1 bit of CRC_OK and 7 bits of correlation value. So, in order to
> comply with the ieee802154_rx() interface, the driver could do one of:
> 
> 1. Turn off AUTOCRC, which would require linux to calculate the CRC for
> TX packets, but the CC2520 would give us the CRC bytes which would
> then be passed up.
> 
> 2. Leave AUTOCRC on and calculate the CRC in software at the driver
> level so that if the CRC failed a bad CRC could get appended. (This
> is what the patch currently does).
> 
> 3. Leave AUTOCRC on, set IEEE802154_HW_RX_OMIT_CKSUM and
> let ieee802154_rx() calculate the CRC. This is bad because the monitor
> layer will always see a correct CRC, even if it did in fact fail. (This is
> how the driver works currently).
> 

Okay, then you have one of these transceiver which doesn't offer the CRC
for upper layers. I would not turn AUTOCRC off for tx handling then.

btw: this is exacly the TODO in IEEE802154_HW_RX_OMIT_CKSUM, there
should be some way that userspace programms can see "the frame is
without CRC", it makes no sense to give that to userspace. But we
doesn't support that right now. (I know wireless monitors can to that
somehow) :-)

Then wireshark will disable frames without CRC. The own caculated is for
workaround this handling that you don't see stupid things in wireshark.

> I think the best thing to do is to actually change the ieee802154_rx()
> interface to allow 15.4 drivers to pass in a boolean if the CRC passed
> and get rid of IEEE802154_HW_RX_DROP_BAD_CKSUM. Then
> ieee802154_rx() can recreate CRCs and/or drop packets as needed,
> and the 15.4 drivers wouldn't need to do "if (promiscuous_mode)"
> checks. Drivers would be able to pass in the actual received CRC
> values instead of this flag if appropriate, of course.
> 

mmhhh, what about such handling:

if going into promiscuous mode (turn off all filtering), then additional
you change the AUTOCRC = 0 (if promiscuous_mode) and = 1 (if not
promiscuous_mode):

Then on TX:

if (promiscuous_mode)
	/* append own calculated CRC, rarely case */
else
	/* nothing */

set the  IEEE802154_HW_TX_OMIT_CKSUM

Then on RX:

if (promiscuous_mode)
	/* do nothing, do 0xff lqi's if there are not available */
else
	/* grab RSSI, LQI, check crc bit(because transceiver don't do
	 * that). Don't remove the last two bytes, it will dropped anyway
	 * because non-promiscuous interfaces will drop the crc at first
	 * step of receiving. Random data of 2 bytes is okay, I think
	 * we will never change that and if so then the CC2520 needs other
	 * workarounds to deal with mac802154 */

don't set IEEE802154_HW_RX_OMIT_CKSUM.

This will set the CRC for monitor receiving and do some crc filtering which
is in your case transceiver specific and should be handled in-driver.


A note about monitor transmit:

There was some discussion about it, it's currently possible but if it
really makes sense is another question. This is very unlikely _except_
you want put some weird data into the network which comes from a node
which doesn't exist. But this _may_ be a use-case for monitors.
Also I didn't test xmit with monitors, put maybe you want try that with
AF_PACKET and RAW sockets on wpan interfaces. :-)

> 
> >
> >
> >> NOTE: This is an API breaking change for the CC2520 radio. The radio now
> >> defaults to frame filtering (checking that the destination and PANID in
> >> the incoming packet matches the local node). This matches the other
> >> 15.4 radios and is what a user would expect to be the default.
> >>
> >
> > Was the frame filtering stuff disabled before? Then this is no API
> > change, it's an improvement for CC2520.
> >
> > It would be an API change if the frame filtering of CC2520 is not
> > 802.15.4 compliant.
> >
> > Maybe it breaks API now but then this is a TODO/BUG in mac802154.
> >
> 
> Currently, the CC2520 driver does no frame filtering. The patch makes
> it 802.15.4 compliant.
> 

ok.

> >> Other changes:
> >>
> >> 1. Adds LQI calculation
> >> 2. Makes #defines for relevant bit fields in CC2520 registers
> >>
> >> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> >> ---
> >>  drivers/net/ieee802154/cc2520.c | 128 ++++++++++++++++++++++++++++++++++------
> >>  1 file changed, 111 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> >> index e65b605..3d66717 100644
> >> --- a/drivers/net/ieee802154/cc2520.c
> >> +++ b/drivers/net/ieee802154/cc2520.c
> >> @@ -21,6 +21,8 @@
> >>  #include <linux/skbuff.h>
> >>  #include <linux/of_gpio.h>
> >>  #include <linux/ieee802154.h>
> >> +#include <linux/crc-ccitt.h>
> >> +#include <asm/unaligned.h>
> >>
> >>  #include <net/mac802154.h>
> >>  #include <net/cfg802154.h>
> >> @@ -189,6 +191,18 @@
> >>  #define      CC2520_RXFIFOCNT                0x3E
> >>  #define      CC2520_TXFIFOCNT                0x3F
> >>
> >> +/* CC2520_FRMFILT0 */
> >> +#define FRMFILT0_FRAME_FILTER_EN     BIT(0)
> >> +#define FRMFILT0_PAN_COORDINATOR     BIT(1)
> >> +
> >> +/* CC2520_FRMCTRL0 */
> >> +#define FRMCTRL0_AUTOACK             BIT(5)
> >> +#define FRMCTRL0_AUTOCRC             BIT(6)
> >> +
> >> +/* CC2520_FRMCTRL1 */
> >> +#define FRMCTRL1_SET_RXENMASK_ON_TX  BIT(0)
> >> +#define FRMCTRL1_IGNORE_TX_UNDERF    BIT(1)
> >> +
> >>  /* Driver private information */
> >>  struct cc2520_private {
> >>       struct spi_device *spi;         /* SPI device structure */
> >> @@ -201,6 +215,7 @@ struct cc2520_private {
> >>       struct work_struct fifop_irqwork;/* Workqueue for FIFOP */
> >>       spinlock_t lock;                /* Lock for is_tx*/
> >>       struct completion tx_complete;  /* Work completion for Tx */
> >> +     bool promiscuous;               /* Flag for promiscuous mode */
> >>  };
> >>
> >>  /* Generic Functions */
> >> @@ -414,7 +429,7 @@ cc2520_write_txfifo(struct cc2520_private *priv, u8 *data, u8 len)
> >>  }
> >>
> >>  static int
> >> -cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len, u8 *lqi)
> >> +cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len)
> >>  {
> >>       int status;
> >>       struct spi_message msg;
> >> @@ -516,24 +531,67 @@ err_tx:
> >>  static int cc2520_rx(struct cc2520_private *priv)
> >>  {
> >>       u8 len = 0, lqi = 0, bytes = 1;
> >> +     bool crc_ok;
> >> +     u16 crc;
> >>       struct sk_buff *skb;
> >>
> >> -     cc2520_read_rxfifo(priv, &len, bytes, &lqi);
> >> +     /* Read single length byte from the radio. */
> >> +     cc2520_read_rxfifo(priv, &len, bytes);
> >>
> >> -     if (len < 2 || len > IEEE802154_MTU)
> >> -             return -EINVAL;
> >> +     if (!ieee802154_is_valid_psdu_len(len)) {
> >> +             /* Corrupted frame received, clear frame buffer by
> >> +              * reading entire buffer.
> >> +              */
> >> +             dev_dbg(&priv->spi->dev, "corrupted frame received\n");
> >> +             len = IEEE802154_MTU;
> >> +     }
> >>
> >>       skb = dev_alloc_skb(len);
> >>       if (!skb)
> >>               return -ENOMEM;
> >>
> >> -     if (cc2520_read_rxfifo(priv, skb_put(skb, len), len, &lqi)) {
> >> +     if (cc2520_read_rxfifo(priv, skb_put(skb, len), len)) {
> >>               dev_dbg(&priv->spi->dev, "frame reception failed\n");
> >>               kfree_skb(skb);
> >>               return -EINVAL;
> >>       }
> >>
> >> -     skb_trim(skb, skb->len - 2);
> >
> > This code told me before it was there: we cut off the CRC for delivery.
> >
> 
> The CC2520 does append two bytes, but not the CRC.
> 

but when AUTOCRC = 0, then a CRC is appended but no LQI/RSSI/CRC_OK(BIT7)?

- Alex
