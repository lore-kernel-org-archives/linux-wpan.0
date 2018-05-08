Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:51830 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeEHIih (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 8 May 2018 04:38:37 -0400
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: pull-request: ieee802154 2018-05-08
Date: Tue,  8 May 2018 10:29:27 +0200
Message-Id: <20180508082927.7928-1-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Two fixes for the mcr20a driver, which was being added in the 4.17 merge window,
by Gustavo and myself.
The atusb driver got a change to GFP_KERNEL where no GFP_ATOMIC is needed by
Jia-Ju.

The last and most important fix is from Alex to get IPv6 reassembly working
again for the ieee802154 6lowpan adaptation. This got broken in 4.16 so please
queue this one also up for the 4.16 stable tree.

regards
Stefan Schmidt

The following changes since commit aa8f8778493c85fff480cdf8b349b1e1dcb5f243:

  ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy (2018-04-23 12:01:21 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2018-05-08

for you to fetch changes up to f18fa5de5ba7f1d6650951502bb96a6e4715a948:

  net: ieee802154: 6lowpan: fix frag reassembly (2018-04-23 20:56:24 +0200)

----------------------------------------------------------------
Alexander Aring (1):
      net: ieee802154: 6lowpan: fix frag reassembly

Gustavo A. R. Silva (1):
      ieee802154: mcr20a: Fix memory leak in mcr20a_probe

Jia-Ju Bai (1):
      net: ieee802154: atusb: Replace GFP_ATOMIC with GFP_KERNEL in atusb_probe

Stefan Schmidt (1):
      net: ieee802154: mcr20a: do not leak resources on error path

 drivers/net/ieee802154/atusb.c      |  2 +-
 drivers/net/ieee802154/mcr20a.c     | 15 ++++++++++-----
 net/ieee802154/6lowpan/6lowpan_i.h  |  4 ++--
 net/ieee802154/6lowpan/reassembly.c | 14 +++++++-------
 4 files changed, 20 insertions(+), 15 deletions(-)
