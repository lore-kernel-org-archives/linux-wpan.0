Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55069 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeGKPcL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Jul 2018 11:32:11 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2018-07-11
Date: Wed, 11 Jul 2018 11:26:53 -0400
Message-Id: <20180711152653.28579-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Build system fix for a missing include from Arnd Bergmann.
Setting the IFLA_LINK for the lowpan parent from Lubomir Rintel.
Fixes for some RX corner cases in adf7242 driver by Michael Hennerich.
And some small patches to cleanup our BUG_ON vs WARN_ON usage.

regards
Stefan Schmidt


The following changes since commit 5e7ba042fd05043416babace5a4a953e29cf2826:

  qed: Fix reading stale configuration information (2018-07-05 13:27:09 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2018-07-11

for you to fetch changes up to 58e9683d14752debc6f22daf6b23e031787df31f:

  net: ieee802154: adf7242: Fix OCL calibration runs (2018-07-09 10:53:12 +0200)

----------------------------------------------------------------
Arnd Bergmann (1):
      ieee802154: mcr20a: add missing includes

Lubomir Rintel (1):
      ieee802154: 6lowpan: set IFLA_LINK

Michael Hennerich (2):
      net: ieee802154: adf7242: Fix erroneous RX enable
      net: ieee802154: adf7242: Fix OCL calibration runs

Stefan Schmidt (3):
      ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: at86rf230: use __func__ macro for debug messages
      ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

 drivers/net/ieee802154/adf7242.c   | 34 ++++++++++++++++++++++++++++++++--
 drivers/net/ieee802154/at86rf230.c | 15 +++++----------
 drivers/net/ieee802154/fakelb.c    |  2 +-
 drivers/net/ieee802154/mcr20a.c    |  3 ++-
 net/ieee802154/6lowpan/core.c      |  6 ++++++
 5 files changed, 46 insertions(+), 14 deletions(-)
