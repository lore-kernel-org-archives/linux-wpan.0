Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45241 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFVtd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Aug 2018 17:49:33 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154-next 2018-08-06
Date: Mon,  6 Aug 2018 21:38:50 +0200
Message-Id: <20180806193850.31949-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

Romuald added a socket option to get the LQI value of the received datagram.
Alexander added a new hardware simulation driver modelled after hwsim of the
wireless people. It allows runtime configuration for new nodes and edges over a
netlink interface (a config utlity is making its way into wpan-tools).
We also have three fixes in here. One from Colin which is more of a cleanup and
two from Alex fixing tailroom and single frame space problems.
I would normally put the last two into my fixes tree, but given we are already
in -rc8 I simply put them here and added a cc: stable to them.

Please pull, or let me know if there are any problems.

regards
Stefan Schmidt


The following changes since commit 981467033a37d916649647fa3afe1fe99bba1817:

  tc-testing: remove duplicate spaces in skbedit match patterns (2018-08-05 17:39:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2018-08-06

for you to fetch changes up to be10d5d1c2d15252624e965202508f30a218a46a:

  ieee802154: fakelb: add deprecated msg while probe (2018-08-06 11:21:15 +0200)

----------------------------------------------------------------
Alexander Aring (4):
      net: 6lowpan: fix reserved space for single frames
      net: mac802154: tx: expand tailroom if necessary
      ieee802154: hwsim: add replacement for fakelb
      ieee802154: fakelb: add deprecated msg while probe

Colin Ian King (1):
      net: ieee802154: 6lowpan: remove redundant pointers 'fq' and 'net'

Romuald CARI (1):
      ieee802154: add rx LQI from userspace

Stefan Schmidt (1):
      Merge remote-tracking branch 'net-next/master'

 drivers/net/ieee802154/Kconfig           |  11 +
 drivers/net/ieee802154/Makefile          |   1 +
 drivers/net/ieee802154/fakelb.c          |   3 +
 drivers/net/ieee802154/mac802154_hwsim.c | 919 +++++++++++++++++++++++++++++++
 drivers/net/ieee802154/mac802154_hwsim.h |  73 +++
 include/net/af_ieee802154.h              |   1 +
 net/ieee802154/6lowpan/reassembly.c      |   5 -
 net/ieee802154/6lowpan/tx.c              |  21 +-
 net/ieee802154/socket.c                  |  17 +
 net/mac802154/tx.c                       |  15 +-
 10 files changed, 1057 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ieee802154/mac802154_hwsim.c
 create mode 100644 drivers/net/ieee802154/mac802154_hwsim.h
