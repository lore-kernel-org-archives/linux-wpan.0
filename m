Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:58363 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbcINMNV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 14 Sep 2016 08:13:21 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 0/2] Some wpan-tools fixes and upcoming 0.7 release
Date: Wed, 14 Sep 2016 14:03:51 +0200
Message-Id: <1473854633-4391-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

These are two pending fixes I have sitting around for wpan-tools.

We are planning to have a 0.7 release soon. So far the major addition is network
namespaces support. If you have anything else pending please let us know quickly
so we can see if it should still go into 0.7 or wait for the next release.

Stefan Schmidt (2):
  info: remove confusing supported commands printout
  info: pretty print tx powers output

 src/info.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

regards
Stefan Schmidt

-- 
2.5.5

