Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50530 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753272AbeGFIMd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jul 2018 04:12:33 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 0/3] Misc fixes for problems found by checkpatch
Date: Fri,  6 Jul 2018 10:12:09 +0200
Message-Id: <20180706081212.4776-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

Hello.

I just relasied these three patches from an earlier batch have never been
applied. (Thanks patchwork for allowing me to stay on top of things).

Alex, I think the reason I did not apply them was that I waited for ACK's on
them.

Stefan Schmidt (3):
  ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
  ieee802154: at86rf230: use __func__ macro for debug messages
  ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

 drivers/net/ieee802154/at86rf230.c | 15 +++++----------
 drivers/net/ieee802154/fakelb.c    |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

regards
Stefan Schmidt

-- 
2.14.4

