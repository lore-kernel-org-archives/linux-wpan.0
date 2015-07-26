Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35359 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbbGZVRq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Jul 2015 17:17:46 -0400
Received: by wibxm9 with SMTP id xm9so87795227wib.0
        for <linux-wpan@vger.kernel.org>; Sun, 26 Jul 2015 14:17:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 0/4] ieee802154: aret handling changes
Date: Sun, 26 Jul 2015 23:17:27 +0200
Message-Id: <1437945451-8093-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

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

Alexander Aring (4):
  ieee802154: add helpers for frame control checks
  at86rf230: use aret mode if ackreq is set while xmit
  mac802154: change max_frame_retries behaviour
  ieee802154: add ack request default handling

 drivers/net/ieee802154/at86rf230.c | 11 +++++++----
 include/linux/ieee802154.h         | 31 +++++++++++++++++++++++++++++++
 include/net/cfg802154.h            |  5 +++++
 include/net/nl802154.h             |  4 ++++
 net/ieee802154/6lowpan/tx.c        |  2 +-
 net/ieee802154/nl802154.c          | 33 +++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h          | 13 +++++++++++++
 net/ieee802154/trace.h             | 19 +++++++++++++++++++
 net/mac802154/cfg.c                | 14 ++++++++++++++
 net/mac802154/iface.c              |  3 +--
 net/mac802154/main.c               |  9 +++------
 11 files changed, 131 insertions(+), 13 deletions(-)

-- 
2.4.6

