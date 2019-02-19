Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:57748 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSQLa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Feb 2019 11:11:30 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154-next 2019-02-19
Date: Tue, 19 Feb 2019 17:11:23 +0100
Message-Id: <20190219161123.24965-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

Another quite quite cycle in the ieee802154 subsystem.
Peter did a rework of the IP frag queue handling to make it use rbtree and get
in line with the core IPv4 and IPv6 implementatiosn in the kernel.

Please pull, or let me know if there are any problems.

regards
Stefan Schmidt

The following changes since commit c9b747dbc2036c917b1067fbb78dc38b105c4454:

  bnx2x: Remove set but not used variable 'mfw_vn' (2019-02-18 16:47:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2019-02-19

for you to fetch changes up to 254c5dbe15d44c9d76a3ccd3724eb1befb7adf99:

  6lowpan: use rbtree for IP frag queue (2019-02-19 10:38:01 +0100)

----------------------------------------------------------------
Peter Oskolkov (1):
      6lowpan: use rbtree for IP frag queue

 net/ieee802154/6lowpan/reassembly.c | 141 ++++++++----------------------------
 1 file changed, 29 insertions(+), 112 deletions(-)
