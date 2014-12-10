Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:48039 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbaLJOde (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Dec 2014 09:33:34 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so5343543wiw.16
        for <linux-wpan@vger.kernel.org>; Wed, 10 Dec 2014 06:33:33 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/4] ieee802154: rework cca settings
Date: Wed, 10 Dec 2014 15:33:10 +0100
Message-Id: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch changes the CCA setting handling. I know this will completely
broken the deprecated netlink call for cca setting. This call is driver
specific and we need to change that. Since this interface is deprecated
we don't care about this now. Also the official userspace tool software
"lowpan-tools" doesn't support this netlink interface.

I will send later patches for wpan-tools to support the new cca setting.

- Alex

Alexander Aring (4):
  nl802154: introduce cca mode enums
  ieee802154: rework cca setting
  nl802154: introduce support for cca settings
  at86rf230: add reset state cca handling

 drivers/net/ieee802154/at86rf230.c | 32 ++++++++++++++++++++++++--
 include/net/cfg802154.h            | 10 ++++++++-
 include/net/ieee802154_netdev.h    |  4 +++-
 include/net/mac802154.h            |  5 ++++-
 include/net/nl802154.h             | 45 ++++++++++++++++++++++++++++++++++++-
 net/ieee802154/nl-mac.c            |  4 ++--
 net/ieee802154/nl802154.c          | 46 +++++++++++++++++++++++++++++++++++---
 net/ieee802154/rdev-ops.h          |  7 ++++++
 net/ieee802154/sysfs.c             |  2 +-
 net/mac802154/cfg.c                | 21 +++++++++++++++++
 net/mac802154/driver-ops.h         |  5 +++--
 net/mac802154/mac_cmd.c            |  6 ++---
 12 files changed, 170 insertions(+), 17 deletions(-)

-- 
2.1.3

