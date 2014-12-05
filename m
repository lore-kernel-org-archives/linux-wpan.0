Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43050 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaLERz5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 12:55:57 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH wpan-tools 0/3] Distcheck and dependency fixes
Date: Fri,  5 Dec 2014 18:55:41 +0100
Message-Id: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Hello.

Some small patches I did when I first tried wpan-tools. I hit the first one when trying to compile
them without libnl3-devel installed and configure happily worked. The last two are two make sure we
can use make distcheck to generate some release tarballs at some point.

Stefan Schmidt (3):
  configure: Fail if libnl3 dependency is not found
  build: add header files to SOURCES
  configure: do not use check-news for now

 configure.ac    | 3 +--
 src/Makefile.am | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.3

