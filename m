Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38686 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbbHIRMX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Aug 2015 13:12:23 -0400
Received: by wibxm9 with SMTP id xm9so122260940wib.1
        for <linux-wpan@vger.kernel.org>; Sun, 09 Aug 2015 10:12:21 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/4] ieee802154: aret handling changes
Date: Sun,  9 Aug 2015 21:12:11 +0200
Message-Id: <1439147535-14793-1-git-send-email-alex.aring@gmail.com>
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

