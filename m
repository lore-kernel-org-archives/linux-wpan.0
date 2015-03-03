Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41049 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbbCCW1v (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Mar 2015 17:27:51 -0500
Received: by widex7 with SMTP id ex7so26332305wid.0
        for <linux-wpan@vger.kernel.org>; Tue, 03 Mar 2015 14:27:50 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/3] ieee802154: correct sifs handling and new defines
Date: Tue,  3 Mar 2015 23:27:32 +0100
Message-Id: <1425421655-21420-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this series corrects the interframe spacing time when
IEEE802154_HW_TX_OMIT_CKSUM phy flag is set. This flag is set when the
transceiver sets the crc on his own.

Also I add some defines from 802.15.4 standard. There is still some magic
values for IEEE802154_FCS_LEN everywhere in mac802154 implementation. We
should replace these values with IEEE802154_FCS_LEN later.

- Alex

Alexander Aring (3):
  mac802154: correct max sifs size handling
  ieee802154: add IEEE802154_MAX_SIFS_FRAME_SIZE
  ieee802154: add IEEE802154_FCS_LEN

 include/linux/ieee802154.h |  2 ++
 net/mac802154/util.c       | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.3.0

