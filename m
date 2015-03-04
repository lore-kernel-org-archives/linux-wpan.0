Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:36491 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbbCDUUI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Mar 2015 15:20:08 -0500
Received: by wesq59 with SMTP id q59so11780044wes.3
        for <linux-wpan@vger.kernel.org>; Wed, 04 Mar 2015 12:20:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next] ieee802154: correct sifs handling and new defines
Date: Wed,  4 Mar 2015 21:19:58 +0100
Message-Id: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
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

changes since v3:
 - squash patch 2 into 1, which was suggested by Marc Kleine-Budde.

changes since v2:
 - squash patch 3 into 2, which was suggested by Marc Kleine-Budde.

Alexander Aring (1):
  mac802154: correct max sifs size handling

 include/linux/ieee802154.h |  2 ++
 net/mac802154/util.c       | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.3.0

