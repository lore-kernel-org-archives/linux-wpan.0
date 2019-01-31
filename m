Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:35435 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfAaRAI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 31 Jan 2019 12:00:08 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2019-01-31
Date: Thu, 31 Jan 2019 18:00:01 +0100
Message-Id: <20190131170001.25905-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

I waited a while to see if anything else comes up, but it seems this time
we only have one fixup patch for the -rc rounds.
Colin fixed some indentation in the mcr20a drivers. That's about it.

If there are any problems with taking these two before the final 5.0 let
me know.

Greetings from Brussels, FOSDEM ahead. :-)

regards
Stefan Schmidt

The following changes since commit 3aa9179b2dfe06d32d4248f07cf6dd005a964507:

  Merge branch 'stmmac-fixes' (2019-01-30 22:24:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2019-01-31

for you to fetch changes up to 34aaaac815d166daef361f49529f4c6b77da49f1:

  ieee802154: mcr20a: fix indentation, remove tabs (2019-01-31 17:42:05 +0100)

----------------------------------------------------------------
Colin Ian King (1):
      ieee802154: mcr20a: fix indentation, remove tabs

 drivers/net/ieee802154/mcr20a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
