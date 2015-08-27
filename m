Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36789 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbH0Ttf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 15:49:35 -0400
Received: by wicgk12 with SMTP id gk12so2174384wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 12:49:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/4] at86rf230: trac debugfs support
Date: Thu, 27 Aug 2015 21:49:16 +0200
Message-Id: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series based on:

 "[RFCv5 bluetooth-next 0/4] ieee802154: aret handling changes"

and can be used for testing the ARET/NO ARET mode with ARET_ON state only.
I add support for debugfs to check the trac status statistics.

In the previously patch series I said that the at86rf2xx transceivers
checks automatically if ack request is set or not in a 802.15.4 frame.

There exists two cases:

1. When the ackrequest bit is set and using STATE_ARET_ON the transceiver
   will wait for an ack frame after transmit. If ack is received then
   the transceiver logic is "SUCCESS" otherwise "NO_ACK".
2. When the ackrequest bit isn't set and using the STATE_ARET_ON the
   transceiver will not wait for an ack frame and the transceiver logic
   is "SUCCESS".

The transceiver logic is in this case the error code from transmit
algorithmn.

To the test (802.15.4 6LoWPAN):

1. Create some imagine 6LoWPAN node by using:

ip -6 neigh add fe80::abcd lladdr 02:01:02:03:04:05:06:07 dev lowpan0

This will create some neighbor discovery entry for some node which isn't
there in your network. We wan't just test some 802.15.4 unicast addressing.
This unicast addressing will not answer with an ACK frame, because there is
no node with this address.

2. Set ackrequest bit to 0 by using:

iwpan dev wpan0 set ackreq_default 0

3. Ping node:

ping6 fe80::abcd%lowpan0

4. Check trac status stats.

You will see that only "SUCCESS" will be increased, which is the behaviour
on no aret functionality.

5. Do it again but with ackrequest bit to 1 by using:

iwpan dev wpan0 set ackreq_default 1

6. Ping node again.

ping6 fe80::abcd%lowpan0

7. Check the trac status again.

Now, "SUCCESS" isn't increased (it could be for broadcast frames only). But
now you will see that "NO ACK" is increased which is the trac status that
no ack frames was received when using aret functionality.


Some additional notes:

I think the registration of debugfs failed when two at86rf230 will be probed,
because the debugfs "at86rf230" already exists. Is there some way to add a
number to it like the name "at86rf230%d"? Or we just leave it as it is, it's
just a debugging feature and should be disabled then when using two at86rf230
transceivers.

- Alex

changes since RFC becomes PATCH:
 - remove reserved trac value stats and print warning
 - print warning also on tx when trac status is not defined
 - print warning also on rx when trac status is not defined
 - add spi bus name to the debugfs entry of at86rf230
 - add patch for TRX_OFF for when tx_retries is above threshold
 - add patch for make a more detailed warning about edge triggered
   irq's.

Alexander Aring (4):
  at86rf230: change trac status check behaviour
  at86rf230: interrupt tx with force trx_off
  at86rf230: add debugfs support
  at86rf230: detailed edge triggered irq warning

 drivers/net/ieee802154/Kconfig     |   7 ++
 drivers/net/ieee802154/at86rf230.c | 195 ++++++++++++++++++++++++++++---------
 drivers/net/ieee802154/at86rf230.h |   8 ++
 3 files changed, 163 insertions(+), 47 deletions(-)

-- 
2.5.0

