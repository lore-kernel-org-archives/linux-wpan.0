Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38708 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbHFH2L (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Aug 2015 03:28:11 -0400
Received: by wibxm9 with SMTP id xm9so11522750wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 06 Aug 2015 00:28:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv5 bluetooth-next 0/4] ieee802154: aret handling changes 
Date: Thu,  6 Aug 2015 09:28:32 +0200
Message-Id: <1438846116-4787-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains a RFC for changing the max_frame_retries behaviour.
The current behaviour is that we allow a range from -1 until 7 (802.15.4
standard describes a range from 0 until 7 only). Nevertheless for historical
reason we have the "-1" value, which describes no aret handling.

The point is when the ack request bit is set inside the mac header the
transceiver need to handle the ack somehow, this is mostly the aret mode
which is done by hardware. Instead to having this as mac setting which doesn't
allow a change during interface up, we simple do this handling per frame
indicated by the ack request bit.

Instead of max_frame_retries "-1" value which could be useful for making a
default ack request bit handling if no information is given if it should be
set or not, we have now the ack request default entry inside the mib.

This could be useful for the 6LoWPAN stack which have this as default
behaviour for data frames.

- Alex

changes since v5:
 - complete different handling for support no aret/aret mode in at86rf230.
   The reason is: I finally figured out that the TX_ARET state will self
   detect if the acknowledge bit is set or not. This is a little embarrassing
   because I thought always ARET means always to wait for the ack frame, but
   it isn't. But this answers another question because TX_ON mode will not
   do any CSMA-CA handling before, so then we could not have any CSMA-CA handling
   by sending frames without acknowledge request bit. Now we always do CSMA-CA
   handling and the ARET state do the rest.
   All at86rf230 users will expierence now by default CSMA handling, this will make
   some more (random more) delays per transmit. You can disable this handling by
   setting minBe = 0. E.g "iwpan dev wpan0 set backoff_exponents 0 3".
 - I also thought about to add a capability for if the transceiver supports no aret
   handling. But if the ackreq bit is set then nothing at functionality will be
   changed, the transceiver don't know then if sending was successful or not by
   waiting for the acknowledge frame. NO ARET able transceivers should only try
   to avoid the acknowledge request bit at 802.15.4 frame which is done by the
   ackreq default setting which is false by default. We cannot complete avoid
   the sending frames where the acknowledge request bit is not set.

changes since v4:
 - change language suggestions at patch 2/6
 - change "max_frame_retries" to "frame_retries" inside commit messages, when
   the kernel value "frame_retries" is meant.
 - add several reviewed-by tags to patches which was reviewed

changes since v3:
 - remove unnecessary brackets inside of ieee802154_is_ackreq
 - use ieee802154_get_fc_from_skb __get_unaligned_memmove16 instead memcpy

changes since v2:
 - add patch "mac802154: cfg: remove test and set checks" because Phoebe
   notice that in v1 and we did that at several other places. Makes only
   sense on a followed another layer call like driverops.
 - remove if branch in "at86rf230: use aret mode if ackreq is set while xmit"
   for check if aret handling is necessary.
 - add patch "at86rf230: remove max_frame_retries -1 check" because previous
   patch removed the "-1" max_frame_retries handling.

Alexander Aring (4):
  mac802154: cfg: remove test and set checks
  mac802154: change frame_retries behaviour
  at86rf230: use STATE_TX_ARET mode only
  ieee802154: add ack request default handling

 drivers/net/ieee802154/at86rf230.c | 52 ++++++++++----------------------------
 include/net/cfg802154.h            |  5 ++++
 include/net/nl802154.h             |  4 +++
 net/ieee802154/6lowpan/tx.c        |  2 +-
 net/ieee802154/nl802154.c          | 33 ++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h          | 13 ++++++++++
 net/ieee802154/trace.h             | 19 ++++++++++++++
 net/mac802154/cfg.c                | 27 ++++++++------------
 net/mac802154/iface.c              |  3 +--
 net/mac802154/main.c               |  9 +++----
 10 files changed, 104 insertions(+), 63 deletions(-)

-- 
2.5.0

