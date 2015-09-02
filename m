Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43294 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbbIBJxI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 05:53:08 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 0/5] Various wpan-ping fixes
Date: Wed,  2 Sep 2015 11:52:52 +0200
Message-Id: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

Nothing major. Just smaller fixes all over the place in wpan-ping. Mostly related to option
handling.

Stefan Schmidt (5):
  wpan-ping: align wpan-ping version with the general wpan-tools version
  wpan-ping: remove no longer used b option from getopt string
  wpan-ping: fix usage message and mention -h option
  wpan-ping: use correct define to fix getopt_long usage
  wpan-ping: fix segfault for accessing invalid address

 wpan-ping/wpan-ping.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.4.3

