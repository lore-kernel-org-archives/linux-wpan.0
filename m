Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38205 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbbEUO6W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 10:58:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 0/3] ATUSB driver updates
Date: Thu, 21 May 2015 16:51:34 +0200
Message-Id: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

Some updates for the atusb driver.

Checking for minimum firmware version now that we have a public release. It
only warns if an old version is used for now but updating in encouraged.

The newest firmware also handles AACK handling so we can indicate this to the
stack.

The last patch just sets the default ed level like the other drivers. Better
ed handling for atusb is planned for the future.

Stefan Schmidt (3):
  ieee802154/atusb: Warn about outdated device firmware.
  ieee802154/atusb: Mark driver as AACK enabled in hardware.
  ieee802154/atusb: Set default ed level to 0xbe like the rest of these
    drivers

 drivers/net/ieee802154/atusb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

regards
Stefan Schmidt

-- 
2.1.0

