Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45148 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaLaSjg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:39:36 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so22387508wgh.17
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:39:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/6] ieee802154: kconfig entries and socket handling
Date: Wed, 31 Dec 2014 19:39:07 +0100
Message-Id: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains some cleanups to put all related socket handling
functionality into one file. Also updates the Kconfig menu entries to
preparing a movement out of "Networking Options".

The last series contains patches to create an af802154 subdirectory. I removed
this way and but all things of af802154 (socket handling) into one file.
After this series I will send the still the 6lowpan changes to put it into
a 6lowpan subdirectory.

- Alex

Alexander Aring (6):
  ieee802154: handle socket functionality as module
  ieee802154: socket: change module name
  ieee802154: socket: put handling into one file
  ieee802154: socket: fix checkpatch issue
  ieee802154: rename af_ieee802154.c to socket.c
  ieee802154: handle config as menuconfig

 net/ieee802154/Kconfig         |   16 +-
 net/ieee802154/Makefile        |    5 +-
 net/ieee802154/af802154.h      |   33 --
 net/ieee802154/af_ieee802154.c |  369 -------------
 net/ieee802154/dgram.c         |  549 --------------------
 net/ieee802154/raw.c           |  270 ----------
 net/ieee802154/socket.c        | 1125 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1142 insertions(+), 1225 deletions(-)
 delete mode 100644 net/ieee802154/af802154.h
 delete mode 100644 net/ieee802154/af_ieee802154.c
 delete mode 100644 net/ieee802154/dgram.c
 delete mode 100644 net/ieee802154/raw.c
 create mode 100644 net/ieee802154/socket.c

-- 
2.2.0

