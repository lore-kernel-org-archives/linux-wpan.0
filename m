Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:40012 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbCBOK2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 09:10:28 -0500
Received: by wghl18 with SMTP id l18so33630609wgh.7
        for <linux-wpan@vger.kernel.org>; Mon, 02 Mar 2015 06:10:27 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/3] ieee802154: UAPI changes
Date: Mon,  2 Mar 2015 15:10:02 +0100
Message-Id: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

I think the stack implementation becomes more popular since the last year.
This patch series contains heavy UAPI changes which will of course breaks
some automated scripts by using iwpan and developed software which checks
on ARPHRD on a lowpan interface and somebody which use sysfs entries for
setting some phy settings.

I sent this series couple months ago and nobody screams, so I think the
changes is okay for everybody. I removed to set the NETDEV type, we can
do this still later and it's more a new feature than a change.

I currently also think about to remove the ioctl callbacks for setting
addresses. Nowadays nobody should use them from userspace to set wpan
addresses. But I want make this later after to be sure that we don't
breaking crypto stuff.

- Alex

Alexander Aring (3):
  ieee802154: 6lowpan: fix ARPHRD to ARPHRD_6LOWPAN
  ieee802154: change wpan-phy name to phy
  ieee802154: remove deprecated sysfs entries

 net/ieee802154/6lowpan/core.c |  2 +-
 net/ieee802154/core.c         |  5 ++++-
 net/ieee802154/sysfs.c        | 49 -------------------------------------------
 3 files changed, 5 insertions(+), 51 deletions(-)

-- 
2.3.0

