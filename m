Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38009 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422809AbcBQM0V (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Feb 2016 07:26:21 -0500
Received: by mail-wm0-f48.google.com with SMTP id a4so25582602wme.1
        for <linux-wpan@vger.kernel.org>; Wed, 17 Feb 2016 04:26:20 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 17 Feb 2016 13:26:19 +0100
Message-ID: <CAAifSFx1c4d2h7yL-MSRZi8A6_Ro+q+faZo+Zu5w34b4oVFAVQ@mail.gmail.com>
Subject: mrf24j40: security-enabled RX issue with 802.15.4 rev 2011
From: Dkhold Dkhold <dkhold@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello,

I am developing applications using the Linux IEEE 802.15.4 stack with
experimental LLSEC support. My test radios are the MRF24J40MC[1]
(discontinued) and its successor, the MRF24J40MD/ME[2]. They both use
the same Microchip MRF24J40[3] chipset, which already has a driver
module by Alan Ott.

It appears the radio has an issue with the recent versions of
802.15.4, namely anything newer than 2006. If I'm not mistaken, the
current 802.15.4 stack is based on the 2011[4] spec. Here is how I
trigger the issue:

0. Setup: Linux 4.4.y (raspbian)
1. Setup the wpan0 interface (type node) with a PAN ID, short &
extended address eg. using iwpan[5].
2. Send 802.15.4 packets with no security (FCF security-enabled bit to
0) to the MRF: the packets trigger an interrupt from the radio,
everything is fine.
3. Send one 802.15.4 packet with *security enabled* (whatever the
security level, just set the FCF security-enabled bit to 1): the radio
does not interrupt (!)
4. Send more 802.15.4 packets, with or without security: the radio
still does not interrupt but register 0x30, which was 0x00, is now
0x10 ie. the bit 5 is now 1. Datasheet[3] says this is a reserved bit
that should stay at 0.

One has to perform a reset of the radio (eg. by unloading and loading
the mrf24j40 module) to reenable RX capability. Please note that TX
still works fine even when RX is "frozen".

My guess is that the MRF tries to decode the 802.15.4 frame header
according to rev 2003, and it tries harder (or tries to read other
fields) when security is enabled in the FCF, killing the RX circuit.
Please note I did *not* enable the hardware security features of the
MRF as they implement rev 2003, that was reported broken from a
security standpoint.

I was able to work around this bug, within the mrf24j40 module, by
disabling all hardware filtering of the frames, as if the radio was in
monitor mode. Please see the patch below. I can now receive any
frames, secured or not.

Does this workaround make sense to you? Do you think the patch (or an
adaptation thereof) should be merged upstream?

Cheers,
Alexandre

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/75002A.pdf
[2] http://ww1.microchip.com/downloads/en/DeviceDoc/70005173A.pdf
[3] http://ww1.microchip.com/downloads/en/DeviceDoc/39776C.pdf
[4] http://standards.ieee.org/getieee802/download/802.15.4-2011.pdf
[5] http://wpan.cakelab.org/

---
 drivers/net/ieee802154/mrf24j40.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c
b/drivers/net/ieee802154/mrf24j40.c
index 4cdf516..d0c9531 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -610,12 +610,34 @@ static int mrf24j40_ed(struct ieee802154_hw *hw,
u8 *level)
 static int mrf24j40_start(struct ieee802154_hw *hw)
 {
        struct mrf24j40 *devrec = hw->priv;
+       int ret, reg;

        dev_dbg(printdev(devrec), "start\n");

+       /* Enable promiscuous mode to workaround security-enabled RX issues */
+       ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR,
BIT_PROMI, BIT_PROMI);
+       if (ret)
+               goto err_ret;
+
+       /* Accept all PAN ID and short addresses */
+       for (reg = REG_PANIDL; reg <= REG_SADRH; reg++) {
+               ret = regmap_write(devrec->regmap_short, reg, 0xff);
+               if (ret)
+                       goto err_ret;
+       }
+
+       /* Clear out extended address filter */
+       for (reg = REG_EADR0; reg <= REG_EADR7; reg++) {
+               ret = regmap_write(devrec->regmap_short, reg, 0x00);
+               if (ret)
+                       goto err_ret;
+       }
+
        /* Clear TXNIE and RXIE. Enable interrupts */
        return regmap_update_bits(devrec->regmap_short, REG_INTCON,
                                  BIT_TXNIE | BIT_RXIE, 0);
+err_ret:
+       return ret;
 }

 static void mrf24j40_stop(struct ieee802154_hw *hw)
-- 
2.1.4
