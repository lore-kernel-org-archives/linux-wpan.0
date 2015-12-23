Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34207 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933475AbbLWISZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Dec 2015 03:18:25 -0500
Received: by mail-ig0-f179.google.com with SMTP id m11so63257430igk.1
        for <linux-wpan@vger.kernel.org>; Wed, 23 Dec 2015 00:18:24 -0800 (PST)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCH v2 0/1] ieee802154: cc2520: Check CRC & add promiscuous
Date: Wed, 23 Dec 2015 03:17:57 -0500
Message-Id: <1450858678-59333-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: Brad Campbell <bradjc5@gmail.com>

I've updated the patch to provide monitors a method for determining if
the incoming packet had a valid CRC or not. This required adding promiscuous
mode, which is no longer the default.

Also, am I correct in noting that configuring a node interface to be in
promiscuous mode with something like:

ioctl(sockfd, SIOCGIFFLAGS, &ifopts);
ifopts.ifr_flags |= IFF_PROMISC;
ioctl(sockfd, SIOCSIFFLAGS, &ifopts);

is not currently supported? That's how I was testing at first and it
didn't seem to work.... Also, if a user does set an interface to
promiscuous using an ioctl, it seems like they would still want CRC
checking, which is not what would currently happen.


Changes since v1:
- Add support for promiscuous mode in cc2520
- Make frame filtering default
- Append CRC to incoming packets for monitors
- Actually calculate LQI

Brad Campbell (1):
  ieee802154: cc2520: Check CRC & add promiscuous

 drivers/net/ieee802154/cc2520.c | 128 ++++++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 17 deletions(-)

--
2.6.3

