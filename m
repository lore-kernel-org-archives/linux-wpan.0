Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37482 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbFFPbF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:05 -0400
Received: by wifx6 with SMTP id x6so46372623wif.0
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/8] mac802154: several cleanups
Date: Sat,  6 Jun 2015 17:30:45 +0200
Message-Id: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Varka Bhadram <varkab@cdac.in>, Alan Ott <alan@signal11.us>, Lennert Buytenhek <buytenh@wantstofly.org>

Hi,

this patch series contains various cleanups for mac802154 header. Also
I cleanup a little bit the comments for several structs and flag
definitions. This also prepares for handling a API documentation
generation via docbook. The flags are enums now which is similar like
mac80211 handling.

- Alex

Cc: Stefan Schmidt <s.schmidt@samsung.com>
Cc: Varka Bhadram <varkab@cdac.in>
Cc: Alan Ott <alan@signal11.us>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>

Alexander Aring (8):
  mac802154: remove unneeded vif struct
  mac802154: cleanup address filtering flags
  mac802154: remove aack hw flag
  mac802154: cleanup ieee802154 hardware flags
  mac802154: remove unused hw_filt attribute
  mac802154: rearrange attribute in ieee802154_hw
  mac802154: add missing structure comments
  mac802154: change pan_coord type to bool

 drivers/net/ieee802154/at86rf230.c |   3 +-
 drivers/net/ieee802154/atusb.c     |   2 +-
 drivers/net/ieee802154/cc2520.c    |   4 +-
 drivers/net/ieee802154/mrf24j40.c  |   3 +-
 include/net/mac802154.h            | 136 ++++++++++++++++++++++++-------------
 net/mac802154/ieee802154_i.h       |   2 -
 net/mac802154/iface.c              |   9 ++-
 net/mac802154/rx.c                 |   4 +-
 8 files changed, 97 insertions(+), 66 deletions(-)

-- 
2.4.1

