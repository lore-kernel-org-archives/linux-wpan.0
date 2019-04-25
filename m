Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47781 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDYQDR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Apr 2019 12:03:17 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2019-04-25
Date: Thu, 25 Apr 2019 18:03:11 +0200
Message-Id: <20190425160311.19767-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Another fix from Kangjie Lu to ensure better checking regmap updates in the
mcr20a driver. Nothing else I have pending for the final release.

If there are any problems let me know.

---

During the preparation of this pull request a workflow question on my side came
up and wonder if you (or some subsystem maintainer sending you pull requests)
does have a comment on this. The ieee802154 subsystem has a low activity in the
number of patches coming through it. I still wanted to pull from your net tree
regularly to test if changes have implications to it. During this pulls I often
end up with merge of the remote tracking branch. Which in the end could mean
that I would have something like 3-4 merge commits in my tree with only one
actual patch I want to send over to you. Feels and looks kind of silly to be
honest.

How do other handle this? Just merge once every rc? Merge just before sending a
pull request? Never merge, wait for Dave to pull and merge and do a pull of his
tree directly afterwards?

regards
Stefan Schmidt

The following changes since commit 1c5c12ee308aacf635c8819cd4baa3bd58f8a8b7:

  net/ncsi: handle overflow when incrementing mac address (2019-04-23 21:15:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2019-04-25

for you to fetch changes up to 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4:

  net: ieee802154: fix missing checks for regmap_update_bits (2019-04-24 20:15:15 +0200)

----------------------------------------------------------------
Kangjie Lu (1):
      net: ieee802154: fix missing checks for regmap_update_bits

 drivers/net/ieee802154/mcr20a.c | 6 ++++++
 1 file changed, 6 insertions(+)
