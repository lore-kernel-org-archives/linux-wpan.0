Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33716 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbLUVsP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Dec 2015 16:48:15 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so85159610wmp.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Dec 2015 13:48:15 -0800 (PST)
Date: Mon, 21 Dec 2015 22:48:08 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 1/1] ieee802154-cc2520: Check CRC
Message-ID: <20151221214803.GA16943@omega>
References: <1450660533-38184-1-git-send-email-bradjc5@gmail.com>
 <1450660533-38184-2-git-send-email-bradjc5@gmail.com>
 <20151221115418.GA3345@omega>
 <20151221125736.GA8247@omega>
 <385C3987-300B-4E6F-A76A-85189A858790@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <385C3987-300B-4E6F-A76A-85189A858790@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Mon, Dec 21, 2015 at 03:53:14PM -0500, Brad Campbell wrote:
> 
> > On Dec 21, 2015, at 7:57 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> > 
> > On Mon, Dec 21, 2015 at 12:54:18PM +0100, Alexander Aring wrote:
> >> Hi,
> >> 
> >> On Sun, Dec 20, 2015 at 08:15:33PM -0500, Brad Campbell wrote:
> >>> Add checking the "CRC_OK" bit at the end of incoming packets to make
> >>> sure the cc2520 driver only passes up valid packets. Because the AUTOCRC
> >>> bit in the FRMCTRL0 register is set to 1 after init, the CC2520 handles
> >>> checking the CRC of incoming packets and sets the most significant bit
> >>> of the last byte of the incoming packet to 1 if the check passed. This
> >>> patch simply checks that bit.
> >>> 
> >>> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> >>> ---
> >>> drivers/net/ieee802154/cc2520.c | 11 +++++++++++
> >>> 1 file changed, 11 insertions(+)
> >>> 
> >>> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> >>> index e65b605..b54edbf 100644
> >>> --- a/drivers/net/ieee802154/cc2520.c
> >>> +++ b/drivers/net/ieee802154/cc2520.c
> >>> @@ -450,6 +450,17 @@ cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len, u8 *lqi)
> >>> 
> >>> 	mutex_unlock(&priv->buffer_mutex);
> >>> 
> >>> +	/* If we are reading the actual packet and not just the length byte,
> >>> +	 * check that the CRC is valid.
> >>> +	 */
> >>> +	if (len > 1) {
> >>> +		/* Most significant bit of the last byte of the data buffer
> >>> +		 * is a 1 bit CRC indicator. See section 20.3.4.
> >>> +		 */
> >>> +		if (data[len - 1] >> 7 == 0)
> >>> +			return -EINVAL;
> >>> +	}
> >>> +
> >> 
> >> Doing an access with "len" which I supposed it's the _transmitted_ len
> >> field of PHR, you need to verify the length field that it's not above
> >> 127 which is _phy_ mtu length.
> >> 
> >> The PHR doesn't reach the mac802154 layer, so we always do such
> >> filtering inside the driver layer.
> >> 
> >> Look for function "ieee802154_is_valid_psdu_len(len)", example [0].
> >> 
> >> In general "don't use the len PHR field if you don't check if it's
> >> valid". I also don't know what happens when mac802154 get's an skb above
> >> _phy_ mtu. We should filter on this _always_ inside driver-layer after
> >> receiving. The disadvantage is: monitor interfaces doesn't get such
> >> frames, but it's very rarely that a transceiver receive such bad frame.
> >> 
> >> 
> >> I would not bet on, that cc2520 does filter the length field. I had
> >> expierence in other transceiver and the most datasheets give not much
> >> information about such handling exactly.
> >> 
> >> Nevertheless such check doesn't count for performance, simple add such
> >> handling for drop the frame then. :-)
> >> 
> > 
> > I actually see, the at86rf230 driver don't drop the frame then. The
> > frame length is more "unknown" then we use the full phy mtu of 127 for
> > reading out the framebuffer. (For handling monitor interfaces).
> > 
> > In case for checking your crc valid bit here, maybe do this handling
> > then when the len field is valid only.
> > 
> > note:
> > Also IF the driver supports promiscuous mode (it's currently not
> > supported by cc2520) then you need to turn off this handling as well.
> > But so far this driver doesn't support promiscuous mode, ignore this
> > handling then.
> > Otherwise the driver will filter bad crc frames and monitor interfaces
> > are there to see such frames inside userspace with e.g. wireshark.
> > 
> > - Alex
> 
> The cc2520_rx function does the len check to make sure it’s reading

ah yes, but doesn't use mac802154 functions for that. :-)

> something from the radio that looks like a valid 15.4 frame. However,
> I will update my patch to make things more clear.
> 
> The point about promiscuous mode is interesting, however. Do packets
> bound for something like wireshark in promiscuous mode go through
> the normal packet receive stack or do they hit “ieee802154_monitors_rx()”
> in mac802154.c? It seems a little odd to pass invalid packets up the stack
> without a way to later detect that the packet failed CRC.
> 

If monitor interface the frame isn't parse in any way, but we should
sure the buffer len is 802.15.4 valid, which is done by transceiver OR
driver (if transceiver doesn't support it).

Better, when it looks invalid then simple handle the frame as full
length, so monitors can see the full stuff.

> I’m interested in fixing the TODO in ieee802154_rx while I’m looking at
> this, at least for the CC2520. One way to do this is to:
> 
> 1. Remove the IEEE802154_HW_RX_OMIT_CKSUM flag from the CC2520
> driver.

Yes, this will do that the monitors will receive the CRC which was on
the air. You also need to remove the skb_trim for that. See below.

> 2. Check the CRC_OK bit upon receive. If it is 1 (valid packet), we calculate
> the CRC in software and append it to the packet. If it is 0, we append
> a known invalid CRC to the end of the packet.
> 3. Add the IEEE802154_HW_RX_DROP_BAD_CKSUM flag (which is a very
> strangely worded flag btw. Seems like it should be
> “IEEE802154_HW_RX_ALLOW_BAD_CKSUM”).
> 

Don't know, the cc2520 supports to readout the crc while read the
framebuffer. The IEEE802154_HW_RX_OMIT_CKSUM is only for transceivers
which doesn't support that. They simple don't allow to read out the CRC,
when receiving a frame.

If this is the case, an own CRC is appended. THIS is because wireshark,
etc. Needs a CRC here, otherwise the parsing will go wrong.

The TODO is mainly to implement some way to tell wireshark if there is a
CRC or not, at the moment wireshark thinks "there is always a CRC". To
always calculate an own CRC which is always correct is just ugly. ;-)


The flag IEEE802154_HW_RX_DROP_BAD_CKSUM is for phy's which supports CRC
delivering, but no CRC filtering option by transceiver. Then mac802154
will do the job. :-)

E.g. turn off filter functionality of CRC on transceiver side and then
add IEEE802154_HW_RX_DROP_BAD_CKSUM to the driver. Will do more workload
at linux side, but when the transceiver can do this... then simple let
transceiver do the job.

In CC2520 we can check the crc valid bit on linux side, this should be
done by driver and is better than recalculation CRC in mac802154 and
check if it's valid.

> This will let the ieee802154_rx function will pass all frames to the monitors and give
> them a way to determine valid packets from invalid packets, and the ieee802154_rx
> function will drop packets that fail CRC. The downside is the monitors will not be able to
> analyze how bad the CRC failure was (if anyone wants to do that…) and
> the ieee802154_rx function will include an extra call to compute the CRC in
> software to check if the CRC is bad that isn’t happening currently.
> 
> Alternatively, ieee802154_rx_irqsafe interface could be expanded to include
> a binary CRC pass/fail bit.
> 
> Thoughts?
> 

I think you only need some right handling inside the driver layer for that.
I did some quick draft (not functional) for supporting promiscuous mode
in CC2520. Maybe you can figure out the necessary register commands for
doing this.

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index e65b605..946c268 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -201,8 +201,18 @@ struct cc2520_private {
        struct work_struct fifop_irqwork;/* Workqueue for FIFOP */
        spinlock_t lock;                /* Lock for is_tx*/
        struct completion tx_complete;  /* Work completion for Tx */
+       bool promisc_mode;
 };
 
+static int promis_on(foobar, bool on) {
+       if (on)
+               /* disable all filter stuff */
+       else
+               /* enable all filter stuff */
+
+       priv->promisc_mode = on;
+}
+
 /* Generic Functions */
 static int
 cc2520_cmd_strobe(struct cc2520_private *priv, u8 cmd)
@@ -518,10 +528,20 @@ static int cc2520_rx(struct cc2520_private *priv)
        u8 len = 0, lqi = 0, bytes = 1;
        struct sk_buff *skb;
 
+       /* getting length? */
        cc2520_read_rxfifo(priv, &len, bytes, &lqi);
 
-       if (len < 2 || len > IEEE802154_MTU)
-               return -EINVAL;
+       if (!ieee802154_is_valid_psdu_len(len)) {
+               /* corrupted frame received, get full frame buffer */
+               len = IEEE802154_MTU;
+       }
+
+       /* len field may invalid, but doesn't matter. just handle it
+        * as it would be correct. The CRC is also no indicator that the
+	 * frame is correct received if CRC is correct.
+        */
+       if (!priv->promisc_mode) {
+               /* do validate of crc bit here and drop if invalid */

/* comment, this is better than doing calculation of CRC in mac802154 again */

+       }

        skb = dev_alloc_skb(len);
        if (!skb)
@@ -533,8 +553,6 @@ static int cc2520_rx(struct cc2520_private *priv)
                return -EINVAL;
        }
 
-       skb_trim(skb, skb->len - 2);
-
        ieee802154_rx_irqsafe(priv->hw, skb, lqi);
 
        dev_vdbg(&priv->spi->dev, "RXFIFO: %x %x\n", len, lqi);
@@ -749,7 +767,7 @@ static int cc2520_register(struct cc2520_private *priv)
 
        /* We do support only 2.4 Ghz */
        priv->hw->phy->supported.channels[0] = 0x7FFF800;
-       priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
+       priv->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
			  IEEE802154_HW_PROMISCUOUS;
 
        priv->hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
 
/* TODO add promis_on to callback_ops structure and make some nice
 * naming stuff :-) */

- Alex
