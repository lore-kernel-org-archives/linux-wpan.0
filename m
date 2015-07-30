Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35356 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbbG3I5J (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 04:57:09 -0400
Received: by wibxm9 with SMTP id xm9so234779555wib.0
        for <linux-wpan@vger.kernel.org>; Thu, 30 Jul 2015 01:57:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv3 bluetooth-next 0/6] ieee802154: aret handling changes
Date: Thu, 30 Jul 2015 10:55:36 +0200
Message-Id: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
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

Alexander Aring (6):
  mac802154: cfg: remove test and set checks
  ieee802154: add helpers for frame control checks
  at86rf230: use aret mode if ackreq is set while xmit
  mac802154: change max_frame_retries behaviour
  at86rf230: remove max_frame_retries -1 check
  ieee802154: add ack request default handling

 drivers/net/ieee802154/at86rf230.c | 14 +++++---------
 include/linux/ieee802154.h         | 29 +++++++++++++++++++++++++++++
 include/net/cfg802154.h            |  5 +++++
 include/net/nl802154.h             |  4 ++++
 net/ieee802154/6lowpan/tx.c        |  2 +-
 net/ieee802154/nl802154.c          | 33 +++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h          | 13 +++++++++++++
 net/ieee802154/trace.h             | 19 +++++++++++++++++++
 net/mac802154/cfg.c                | 27 +++++++++++----------------
 net/mac802154/iface.c              |  3 +--
 net/mac802154/main.c               |  9 +++------
 11 files changed, 124 insertions(+), 34 deletions(-)

-- 
2.5.0

