Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53988 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSUO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Oct 2018 14:20:14 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154-next 2018-10-04
Date: Thu,  4 Oct 2018 13:27:16 +0200
Message-Id: <20181004112716.17565-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

A very quite cycle in the ieee802154 subsystem. We only have two cleanup
patches for this pull request.
Xue removed the platform_data struct handling from the mcr20a driver and
Alexander cleaned up some left overs in the hwsim driver.

Please pull, or let me know if there are any problems.

regards
Stefan Schmidt

The following changes since commit 1042caa79e9351b81ed19dc8d2d7fd6ff51a4422:

  net-ipv4: remove 2 always zero parameters from ipv4_redirect() (2018-09-26 20:30:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2018-10-04

for you to fetch changes up to 154113eb17735197796ff5f477c6243d00f2c5dc:

  ieee802154: hwsim: remove not used ifup list (2018-10-02 17:14:13 +0200)

----------------------------------------------------------------
Alexander Aring (1):
      ieee802154: hwsim: remove not used ifup list

Xue Liu (1):
      ieee802154: mcr20a: Remove struct mcr20a_platform_data

 drivers/net/ieee802154/mac802154_hwsim.c |  8 ----
 drivers/net/ieee802154/mcr20a.c          | 64 +++++++-------------------------
 2 files changed, 13 insertions(+), 59 deletions(-)
