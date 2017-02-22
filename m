Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from r0.smtpout1.alwaysdata.com ([176.31.58.0]:40642 "EHLO
        r0.smtpout1.alwaysdata.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934363AbdBVT1x (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 22 Feb 2017 14:27:53 -0500
Received: from 85.131.11.109.rev.sfr.net ([109.11.131.85] helo=laptop.numericable.fr)
        by smtpout1.roubaix1.alwaysdata.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.88)
        (envelope-from <web+oss@zopieux.com>)
        id 1cgbnX-0001Fx-9W
        for linux-wpan@vger.kernel.org; Wed, 22 Feb 2017 19:37:55 +0100
From: Alexandre Macabies <web+oss@zopieux.com>
Subject: Review request: add pseudo-hardware timestamps to mrf24j40 driver
Date: Wed, 22 Feb 2017 19:37:41 +0100
Message-Id: <20170222183741.20408-1-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello,

This is not a formal patch. I am trying to add timestamping support to
the drivers/net/ieee802154/mrf24j40.c driver. I need more precise
timestamps that the software ones attached to the packets when
entering/leaving the kernel.

As far as I am aware, the MRF24J40 has no registers[1] to retrieve
hardware timestamps. Thus the idea is to use ktime_get() timestamps at
the proper places in the driver -- hence the *pseudo*-hardware.

- for incoming packets, call ktime_get() in the interrupt handler and
store it for later user. Then push it to skb_hwtstamps just before
sending the skb to ieee802154_rx_irqsafe().
- for outgoing packets, call ktime_get() in the "TX complete"
interrupt handler. This interrupt will only be triggered if the packet
is indeed going out the physical radio, which may no always be the
case, eg. if we send raw garbage on the wpan interface. But I guess
this is fine.

I implemented these changes according to [2] and by looking at existing
timestamping code in other (mostly ethernet) drivers.

Does this method make any sense? Could you do a review of my changes?
Would you be interested in up-streaming these changes once review and
cleaned up?

Thanks for your time.

Alexandre

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/39776C.pdf
[2] https://www.kernel.org/doc/Documentation/networking/timestamping.txt

---
 drivers/net/ieee802154/mrf24j40.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index f446db828561..165c86992672 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/ieee802154.h>
 #include <linux/irq.h>
+#include <linux/ktime.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
 
@@ -236,6 +237,7 @@ struct mrf24j40 {
 	struct spi_transfer rx_lqi_trx;
 	u8 rx_fifo_buf[RX_FIFO_SIZE];
 	struct spi_transfer rx_fifo_buf_trx;
+	ktime_t rx_tstamp;
 
 	/* isr handling for reading intstat */
 	struct spi_message irq_msg;
@@ -558,6 +560,8 @@ static void write_tx_buf_complete(void *context)
 	if (ieee802154_is_ackreq(fc))
 		val |= BIT_TXNACKREQ;
 
+	skb_tx_timestamp(devrec->tx_skb);
+
 	devrec->tx_post_msg.complete = NULL;
 	devrec->tx_post_buf[0] = MRF24J40_WRITESHORT(REG_TXNCON);
 	devrec->tx_post_buf[1] = val;
@@ -604,6 +608,9 @@ static int mrf24j40_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	dev_dbg(printdev(devrec), "tx packet of %d bytes\n", skb->len);
 	devrec->tx_skb = skb;
 
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
 	return write_tx_buf(devrec, 0x000, skb->data, skb->len);
 }
 
@@ -774,6 +781,9 @@ static void mrf24j40_handle_rx_read_buf_complete(void *context)
 	}
 
 	memcpy(skb_put(skb, len), rx_local_buf, len);
+
+	skb_hwtstamps(skb)->hwtstamp = devrec->rx_tstamp;
+
 	ieee802154_rx_irqsafe(devrec->hw, skb, 0);
 
 #ifdef DEBUG
@@ -1038,12 +1048,25 @@ static void mrf24j40_intstat_complete(void *context)
 				   BIT_SECIGNORE);
 
 	/* Check for TX complete */
-	if (intstat & BIT_TXNIF)
-		ieee802154_xmit_complete(devrec->hw, devrec->tx_skb, false);
+	if (intstat & BIT_TXNIF) {
+		struct sk_buff *skb = devrec->tx_skb;
+		/* Set hardware timestamp */
+		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
+			struct skb_shared_hwtstamps shhwtstamps;
+
+			memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+			shhwtstamps.hwtstamp = ktime_get_real();
+			skb_tstamp_tx(skb, &shhwtstamps);
+		}
+		ieee802154_xmit_complete(devrec->hw, skb, false);
+	}
 
 	/* Check for Rx */
-	if (intstat & BIT_RXIF)
+	if (intstat & BIT_RXIF) {
+		/* Save system clock timestamp for later */
+		devrec->rx_tstamp = ktime_get_real();
 		mrf24j40_handle_rx(devrec);
+	}
 }
 
 static irqreturn_t mrf24j40_isr(int irq, void *data)
-- 
2.11.1

