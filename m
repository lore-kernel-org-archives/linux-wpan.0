Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37241 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965247AbaLLLpq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:46 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 0/6] Various coding style cleanups and typo fixes
Date: Fri, 12 Dec 2014 12:45:27 +0100
Message-Id: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Hello.

Just some smaller cleanups while going through the codebase. I'm aware that the
3.19 merge window is already open. If you feel these are .20 material feel free to
stick them in a branch or let me know when you want me to re-submit them.

regards
Stefan Schmidt

Stefan Schmidt (6):
  ieee802154/at86rf230: Remove unneeded blank lines
  ieee802154/at86rf230: Align to opening parenthesis
  ieee802154/at86rf230: Fix typo unkown -> unknown
  ieee802154/cc2520: Remove extra blank lines
  ieee802154/mrf24j40: Fix typo begining -> beginning
  ieee802154/mrf24j40: Fix alignment of parenthesis

 drivers/net/ieee802154/at86rf230.c | 12 +++++-------
 drivers/net/ieee802154/cc2520.c    |  2 --
 drivers/net/ieee802154/mrf24j40.c  |  6 +++---
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
1.9.3

