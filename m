Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55553 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKIxI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Dec 2018 03:53:08 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2018-12-11
Date: Tue, 11 Dec 2018 09:53:02 +0100
Message-Id: <20181211085302.27306-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Just two more fixes for ieee802154 dribver before the final 4.20 release.
Alexander Aring fixes a problem in the nested parsing code of the
hwsim driver interface.
A fix for a potential overflow in the ca8210 driver by Yue Habing.

If there are any problems with taking these two before the final 4.20 let me
know.

regards
Stefan Schmidt

The following changes since commit 35b827b6d06199841a83839e8bb69c0cd13a28be:

  tun: forbid iface creation with rtnl ops (2018-11-30 17:31:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2018-12-11

for you to fetch changes up to 8e41cae64b08fe2e86a9ffb88b295c6b4b3a3322:

  ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done (2018-12-11 09:33:11 +0100)

----------------------------------------------------------------
Alexander Aring (1):
      ieee802154: hwsim: fix off-by-one in parse nested

YueHaibing (1):
      ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done

 drivers/net/ieee802154/ca8210.c          | 4 ++--
 drivers/net/ieee802154/mac802154_hwsim.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
