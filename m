Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53694 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbFRW1u (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 18:27:50 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 0/3] wpan-ping address handling rework and server simplification
Date: Fri, 19 Jun 2015 00:27:36 +0200
Message-Id: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

This needs to go on top of the extended address handling patchset.

Some unification of the address handling and as nice feature a simplified server
side where no destination needs to be given as parameter.

If you have remarks I should be able to reply next week as I will be off for a long
weekend in a few hours.

Stefan Schmidt (3):
  wpan-ping: Reduce packet recv timeout to 500ms from 2s
  wpan-ping: unify src and dst address handling
  wpan-ping: use recvfrom and sendto isntead of connecting the socket

 wpan-ping/wpan-ping.c | 137 ++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 72 deletions(-)

regards
Stefan Schmidt

-- 
2.4.3

