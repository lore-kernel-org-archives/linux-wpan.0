Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58717 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbaKLCho (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:44 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so3497400wib.5
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:43 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/18] ieee802154: iface handling and new nl802154 commands
Date: Wed, 12 Nov 2014 03:36:47 +0100
Message-Id: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains iface handling cleanup patches and mostly trivial
patches to support several netlink commands. Also removing the constraints
checks for 802.15.4 parameters from driver layer. This should be handled by
nl802154 layer now. The old netlink interface should be deprecated now and
these constraints checks are not supported anymore by the old netlink interface.
Some of the current driver never checked on these constraints so we don't fix
the old netlink interface anymore to check on "global" 802.15.4 constraints.

All users should use the wpan-tools from [0] now. Some cmd's are not supported
already like interface deletion or adding, but will be supported in near future.

[0] https://github.com/linux-wpan/wpan-tools/archive/wpan-tools-0.1.tar.gz

Alexander Aring (18):
  mac820154: move interface unregistration into iface
  mac820154: rename sdata next to tmp
  mac820154: move mutex locks out of loop
  mac802154: add wpan_phy priv id
  mac802154: change module description
  mac802154: add ifname change notifier
  ieee802154: cleanup cfg802154 intendation
  ieee820154: add channel set support
  ieee820154: remove valid page and channel checks
  ieee820154: add pan_id setting support
  ieee820154: add short_addr setting support
  ieee820154: add backoff exponent setting support
  at86rf230: remove invalid backoff exponent check
  ieee820154: add max csma backoffs setting support
  at86rf230: remove invalid max csma backoffs check
  ieee820154: add max frame retries setting support
  at86rf230: remove invalid max frame retries check
  ieee820154: add lbt setting support

 drivers/net/ieee802154/at86rf230.c |  20 +---
 drivers/net/ieee802154/fakelb.c    |   3 -
 include/linux/ieee802154.h         |   4 +
 include/net/cfg802154.h            |  28 ++++-
 net/ieee802154/nl802154.c          | 214 +++++++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h          |  55 ++++++++++
 net/mac802154/cfg.c                | 136 +++++++++++++++++++++++
 net/mac802154/ieee802154_i.h       |   7 ++
 net/mac802154/iface.c              |  48 +++++++++
 net/mac802154/main.c               |  28 +++--
 net/mac802154/util.c               |   3 +
 11 files changed, 513 insertions(+), 33 deletions(-)

-- 
2.1.3

