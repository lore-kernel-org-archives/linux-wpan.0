Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39307 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759220AbbCDLZE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 06:25:04 -0500
Received: by wggx12 with SMTP id x12so45945885wgg.6
        for <linux-wpan@vger.kernel.org>; Wed, 04 Mar 2015 03:25:03 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/2] ieee802154: correct sifs handling and new defines
Date: Wed,  4 Mar 2015 12:24:48 +0100
Message-Id: <1425468290-24525-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this series corrects the interframe spacing time when
IEEE802154_HW_TX_OMIT_CKSUM phy flag is set. This flag is set when the
transceiver sets the crc on his own.

Also I add some defines from 802.15.4 standard. There is still some magic
values for IEEE802154_FCS_LEN everywhere in mac802154 implementation. We
should replace these values with IEEE802154_FCS_LEN later.

- Alex

changes since v2:
 - squash patch 3 into 2, which was suggested by Marc Kleine-Budde.

Alexander Aring (2):
  mac802154: correct max sifs size handling
  ieee802154: replace magic numbers by standard defines

 include/linux/ieee802154.h |  2 ++
 net/mac802154/util.c       | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.3.0

