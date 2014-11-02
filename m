Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52642 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaKBUnX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:23 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so4973842wib.5
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:21 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/6] ieee802154: solve make C=2 warnings
Date: Sun,  2 Nov 2014 21:43:00 +0100
Message-Id: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series fixes warning when building with "make C=2". This was
reported by Marcel Holtmann which told me to run "make C=2" and solve
these warnings. Most of the issues was forgotten includes and byte ordering
handling.

Alexander Aring (6):
  ieee802154: add missing ULL definition
  ieee802154: fix byteorder issues
  mac802154: fix byteorder issues
  ieee802154: sysfs: add missing include
  mac802154: cfg: add missing include
  ieee802154: remove unnecessary functions

 include/linux/ieee802154.h |  4 +++-
 include/net/mac802154.h    |  6 +++---
 net/ieee802154/sysfs.c     |  1 +
 net/mac802154/cfg.c        |  1 +
 net/mac802154/iface.c      | 22 ----------------------
 5 files changed, 8 insertions(+), 26 deletions(-)

-- 
2.1.3

