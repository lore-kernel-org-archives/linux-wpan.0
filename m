Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:52231 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbATU6M (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:58:12 -0500
Received: by mail-wg0-f48.google.com with SMTP id x12so8666734wgg.7
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 12:58:11 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 0/4] ieee802154: UAPI changes
Date: Tue, 20 Jan 2015 21:57:38 +0100
Message-Id: <1421787462-24042-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains various UAPI changes. It's a RFC for now, to be sure
nobody will scream when I send real patches for this.

In my opnion patch "ieee802154: 6lowpan: fix ARPHRD to ARPHRD_6LOWPAN" is the
is the most important part of this series. I know this issue a long time
and some already used application really checks on this, but we need to change that.

Patch "ieee802154: change wpan-phy name to phy" will change that you will not type
"wpan-phy0" anymore on iwpan phy settings. After this patch it's "phy0" only. This
makes the handling similar like iw.

Patch "ieee802154: remove deprecated sysfs entries" will breaks some scripts if
somebody really use these sysfs entries.

So I would like her others opinions according to these changes.

- Alex

Alexander Aring (4):
  ieee802154: set wpan netdev devtype
  ieee802154: 6lowpan: fix ARPHRD to ARPHRD_6LOWPAN
  ieee802154: change wpan-phy name to phy
  ieee802154: remove deprecated sysfs entries

 net/ieee802154/6lowpan/core.c |  2 +-
 net/ieee802154/core.c         | 13 ++++++++++--
 net/ieee802154/sysfs.c        | 49 -------------------------------------------
 3 files changed, 12 insertions(+), 52 deletions(-)

-- 
2.2.2

