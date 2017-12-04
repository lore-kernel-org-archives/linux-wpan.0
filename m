Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48122 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdLDQvW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 4 Dec 2017 11:51:22 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: pull-request: ieee802154-next 2017-12-04
Date: Mon,  4 Dec 2017 17:51:11 +0100
Message-Id: <20171204165111.29240-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

Some update from ieee802154 to *net-next*

Jian-Hong Pan updated our docs to match the APIs in code.
Michael Hennerichs enhanced the adf7242 driver to work with adf7241
devices and reworked the IRQ and packet handling in the driver.


The following changes since commit 1d3b78bbc6e983fabb3fbf91b76339bf66e4a12c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-11-23 21:18:46 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2017-12-04

for you to fetch changes up to 8f1878a182dcc5a15a57c7fc7d8182bea0733dfa:

  net: ieee802154: adf7242: Rework IRQ and packet handling (2017-11-29 16:49:41 +0100)

----------------------------------------------------------------
Jian-Hong Pan (1):
      doc: linux-wpan: Fulfill the description of missed 802.15.4 APIs

Michael Hennerich (5):
      net: ieee802154: adf7242: Add support for ADF7241 devices
      net: ieee802154: adf7242: Fix bug if defined DEBUG
      net: ieee802154: adf7242: Add additional DEBUG information
      net: ieee802154: adf7242: Avoid redundant RC_READY polling
      net: ieee802154: adf7242: Rework IRQ and packet handling

 .../devicetree/bindings/net/ieee802154/adf7242.txt |  2 +-
 Documentation/networking/ieee802154.txt            | 40 ++++++++++
 drivers/net/ieee802154/adf7242.c                   | 90 +++++++++++++++-------
 3 files changed, 105 insertions(+), 27 deletions(-)


regards
Stefan Schmidt
