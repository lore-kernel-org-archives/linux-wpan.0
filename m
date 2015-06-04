Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47892 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbFDNZc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 09:25:32 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 0/3] wpan-ping utility
Date: Thu,  4 Jun 2015 15:25:20 +0200
Message-Id: <1433424323-24099-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

I had something similar around for a while and it proofed useful for some basic
testing on the ieee 802154 level. It also can be used to see if we regress for
non-6lowpan use cases like short address and ieee802154 sockets.

The only two things missing from my point of view is support for extended
addresses and using recvfrom to avoid specifying the client address on server
side.

Stefan Schmidt (3):
  wpan-ping: Ping utility on IEEE 802.15.4 level
  wpan-ping: Add README for some basic usage descriptions.
  COPYRIGHT: Add my own copyright due to wpan-ping contribution

 COPYING                    |   1 +
 Makefile.am                |   3 +-
 configure.ac               |   1 +
 wpan-ping/Makefile.am      |   8 +
 wpan-ping/README.wpan-ping |  26 +++
 wpan-ping/wpan-ping.c      | 416 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 454 insertions(+), 1 deletion(-)
 create mode 100644 wpan-ping/Makefile.am
 create mode 100644 wpan-ping/README.wpan-ping
 create mode 100644 wpan-ping/wpan-ping.c

regards
Stefan Schmidt

-- 
2.1.0

