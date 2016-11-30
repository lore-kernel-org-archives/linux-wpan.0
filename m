Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:52061 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbcK3ODh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 09:03:37 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [GIT pull] pull request for wpan-next 2016-11-30
Date: Wed, 30 Nov 2016 15:03:20 +0100
Message-Id: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Hello Marcel,

find below a pull request for all pending patches we have sitting on the linux-wpan mailing list.
I pulled them together to have a better chance to still get them into bluetooth-next and net-next
before the merge window opens. If you have a problem taking them or are not planning to do another
pull request towards net-next please let me know so I can try my luck with Dave directly. Missing
the window for things that are on the list for a while would be a pity.

The changes itself are non intrusive and sometimes even trivial. There is also no code touching
bluetooth or the shared 6lowpan subsystems. We have a fix for a potential NULL deref in the
ieee802154 netlink code, a fix for the ED values of the at86rf2xx driver, some doc update and the
addition of myself as the co-maintainer for ieee802154 to help Alex.

If you are uncomfortable to pull form the GitHub repo the patches are also coming as a re-posted
patchset in reply to this pull request.

regards
Stefan Schmidt

The following changes since commit 1ae6d00ad05730bca283dc09e7a9c162c2f22b01:

  Bluetooth: hci_qca: Use setup_timer Kernel API instead of init_timer (2016-11-27 07:41:05 +0100)

are available in the git repository at:

  https://github.com/linux-wpan/linux-wpan-next.git for-next

for you to fetch changes up to 6bf0d84d13e968b4f8bf0710e0cae785e228dbba:

  docs: ieee802154: update main documentation file (2016-11-30 12:33:07 +0100)

----------------------------------------------------------------
Alexander Aring (1):
      at86rf230: fix cca ed values for rf233

Stefan Schmidt (3):
      ieee802154: add myself as co-maintainer to MAINTAINERS file
      ieee802154: fakelb: print number of created fake devices during probe
      docs: ieee802154: update main documentation file

vegard.nossum@oracle.com (1):
      ieee802154: check device type

 Documentation/networking/ieee802154.txt | 26 +++++++++++---------------
 MAINTAINERS                             |  1 +
 drivers/net/ieee802154/at86rf230.c      | 16 +++++++++++-----
 drivers/net/ieee802154/fakelb.c         |  2 +-
 net/ieee802154/nl-phy.c                 |  6 +++++-
 5 files changed, 29 insertions(+), 22 deletions(-)
