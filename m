Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37473 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756856AbcHBOix (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Aug 2016 10:38:53 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH linux-wpan/radvd for-upstream 0/2] radvd: upstream patches
Date: Tue,  2 Aug 2016 16:37:50 +0200
Message-Id: <20160802143752.12831-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi,

this patch series has some overdue updates for radvd upstream version.
It doesn't contain rework of 6CO handling, since we don't have a stable
UAPI to provide stateful compression to userspace.

Anyway radvd has actually 6CO handling which is ?broken? don't know what
it should do at the moment. 6CO without stateful compression setting
makes no sense for me. If you like to use 6CO over debugfs use
linux-wpan/radvd "6lowpan" branch.

---

I will update the "6lowpan" branch also with Patch 2/2 which adds support
to get address length via sysfs. This patch will prepare correct handling
for the new BTLE 6LoWPAN handling to use the correct address and
address length (not 8 bytes, with U/L bit). It will not work with the
current mainline version because the address option will set the address
length with U/L bitflip in NS/NA/RS, but radvd will not do this because
it's simple wrong to do it. :-)

Everbody which wants to have this bug compatible stuff should change
radvd in their own source code.

- Alex

Alexander Aring (2):
  device-linux: replace ARPHRD_IEEE802154 to ARPHRD_6LOWPAN
  device-linux: get address length via sysfs

 device-linux.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 pathnames.h    |  1 +
 2 files changed, 45 insertions(+), 5 deletions(-)

-- 
2.9.0

