Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:60642 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbcLORlF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 12:41:05 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 0/3] ieee802154: atusb: fixes for buffers to be DMA able
Date: Thu, 15 Dec 2016 18:40:13 +0100
Message-Id: <1481823616-13402-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, marcel@holtmann.org, dan.carpenter@oracle.com, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

Here is a set of patches coming up from a report of Dan Carpenter about some
buffers in atusb are on the stack and that produces a problem with DMA from 4.9
onwards.

The first patch covers existing code present in released 4.9. I added a stable
tag for it to make sure it gets into the stable updates. Marcel, I also checked
that this patch applies cleanly against bluetooth.git as well as bluetooth-next.git.

The second patch just handles a corner case a bit more cleanly and the third ones
fixes the buffer on a stack problem for code introduced in the 4.10 merge window
and should got.

Thanks to Dan for reporting this.

Stefan Schmidt (3):
  ieee802154: atusb: do not use the stack for buffers to make them DMA
    able
  ieee802154: atusb: make sure we set a randaom extended address if
    fetching fails
  ieee802154: atusb: do not use the stack for address fetching to make
    it DMA able

 drivers/net/ieee802154/atusb.c | 46 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

regards
Stefan Schmidt

-- 
2.5.5

