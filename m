Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54274 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbbFENcW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 09:32:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 0/3] wpan-ping fixes
Date: Fri,  5 Jun 2015 15:32:09 +0200
Message-Id: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

Some smaller fixes. wpan-ping no plays nicely in 6LoWPAN networks by settign
the dispatch byte to not a 6LoWPAN frame. The other two are just some
missing gitignore entries I spotted.

Stefan Schmidt (3):
  wpan-ping: Take 6LoWPAN dispatch byte into account
  gitignore: add generated iwpan-info
  wpan-ping: Add .gitignore to ignore generated files

 src/.gitignore        |  1 +
 wpan-ping/.gitignore  |  2 ++
 wpan-ping/wpan-ping.c | 17 ++++++++++-------
 3 files changed, 13 insertions(+), 7 deletions(-)
 create mode 100644 wpan-ping/.gitignore

regards
Stefan Schmidt

-- 
2.1.0

