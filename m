Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:34041 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaHLNOc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:32 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so7997855lab.12
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:30 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:04 +0200
Message-Id: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 00/11] ieee802154: mac802154: wireless transformation
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this is the first part to make the mac802154/ieee802154 implementation like
wireless. There is much things do to but at around 10 patches I will send
a complete patch series of my work to make the review easier.

This patch renames more variables/structs like it's also available in wireless.
I think this was done also in the current implementation but all variables
was renamed and now I get confuse about priv/ipriv (I call it priv variable hell)
and netdev/ieee802154_dev.

We rename the ieee802154_dev to ieee802154_hw, like a ieee80211_hw.

The mac802154_priv is now ieee802154_local, like a ieee80211_local.
The mac802154_sub_if_data is now ieee802154_sub_if_data.

Also change the variables name to this so there should never be a variable priv
and you don't know if it's a mac802154_sub_if_data or mac802154_priv. That's
confusing me so much sometimes. Now it's also clear to see mutliple dereferencing.
Please send patches for this, if you like.

The next step is the frame parsing like wireless and interface registration like
wireless.


The last one replace the receiving workqueue with a tasklet, which is also used
in wireless. This have a less overhead and I removed a kmalloc call in this hot
path.

- Alex

Alexander Aring (11):
  ieee802154: rename ieee802154_dev to ieee802154_hw
  mac802154: rename ieee802154_dev.c to main.c
  mac802154: remove not functional monitor device
  ieee802154: add new interface types
  nl802154: add missing endif comment
  mac802154: rename mac802154_priv to ieee802154_local
  mac802154: rename mac802154_sub_if_data to ieee802154_sub_if_data
  mac802154: rename mac802154.h to ieee802154_i.h
  mac802154: rename hw subif_data variable to local
  mac802154: use hw_to_local
  mac802154: rx: use tasklet instead workqueue

 drivers/net/ieee802154/at86rf230.c |  90 ++++----
 drivers/net/ieee802154/cc2520.c    |  50 ++---
 drivers/net/ieee802154/mrf24j40.c  |  48 ++--
 include/linux/nl802154.h           |  15 +-
 include/net/mac802154.h            |  46 ++--
 net/ieee802154/nl-phy.c            |   4 +-
 net/mac802154/Makefile             |   4 +-
 net/mac802154/ieee802154_dev.c     | 415 -----------------------------------
 net/mac802154/ieee802154_i.h       | 178 +++++++++++++++
 net/mac802154/llsec.c              |   2 +-
 net/mac802154/mac802154.h          | 172 ---------------
 net/mac802154/mac_cmd.c            |   6 +-
 net/mac802154/main.c               | 435 +++++++++++++++++++++++++++++++++++++
 net/mac802154/mib.c                | 207 +++++++++---------
 net/mac802154/monitor.c            | 117 ----------
 net/mac802154/rx.c                 |  60 ++---
 net/mac802154/tx.c                 |  42 ++--
 net/mac802154/wpan.c               | 145 +++++++------
 18 files changed, 958 insertions(+), 1078 deletions(-)
 delete mode 100644 net/mac802154/ieee802154_dev.c
 create mode 100644 net/mac802154/ieee802154_i.h
 delete mode 100644 net/mac802154/mac802154.h
 create mode 100644 net/mac802154/main.c
 delete mode 100644 net/mac802154/monitor.c

-- 
2.0.3

