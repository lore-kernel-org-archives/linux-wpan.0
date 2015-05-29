Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48567 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbbE2Ivi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:51:38 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCHv2 bluetooth-next 0/4] Atusb driver improvements
Date: Fri, 29 May 2015 10:51:24 +0200
Message-Id: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

Some patches to let the atusb driver catchup a bit with newer stack features.
Namely we now support tx power and promiscuous mode setting. The first patch
adds some infrastructure for this by adding a function to write parts of a
register.

The last patch adds me as the maintainer for the driver. Alex suggested that
I should do this and as I have the device, working on the firmware as well
and are motivated to enhance it I think its a good idea.

Changes in v2:
	Fix checkpatch complains pointed out by Varka Bhadram

Stefan Schmidt (4):
  ieee802154/atusb: Add function for partial register writes
  ieee802154/atusb: Add .set_txpower operation to the driver
  ieee802154/atusb: Add .set_promiscuous_mode driver operation
  MAINTAINERS: Add myself as maintainer for the atusb driver

 MAINTAINERS                    |   8 ++++
 drivers/net/ieee802154/atusb.c | 101 +++++++++++++++++++++++++++++++++--------
 2 files changed, 90 insertions(+), 19 deletions(-)

regards
Stefan Schmidt

-- 
2.1.0

