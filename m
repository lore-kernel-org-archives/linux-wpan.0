Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45684 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHXMT7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 24 Aug 2019 08:19:59 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2019-08-24
Date: Sat, 24 Aug 2019 14:19:53 +0200
Message-Id: <20190824121953.27839-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Yue  Haibing fixed two bugs discovered by KASAN in the hwsim driver for
ieee802154 and Colin Ian King cleaned up a redundant variable assignment.

If there are any problems let me know.

regards
Stefan Schmidt

The following changes since commit 6c0afef5fb0c27758f4d52b2210c61b6bd8b4470:

  ipv6/flowlabel: wait rcu grace period before put_pid() (2019-04-29 23:30:13 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2019-08-24

for you to fetch changes up to 074014abdf2bd2a00da3dd14a6ae04cafc1d62cc:

  net: ieee802154: remove redundant assignment to rc (2019-08-14 01:10:41 +0200)

----------------------------------------------------------------
Colin Ian King (1):
      net: ieee802154: remove redundant assignment to rc

YueHaibing (2):
      ieee802154: hwsim: Fix error handle path in hwsim_init_module
      ieee802154: hwsim: unregister hw while hwsim_subscribe_all_others fails

 drivers/net/ieee802154/mac802154_hwsim.c | 8 +++++---
 net/ieee802154/socket.c                  | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)
