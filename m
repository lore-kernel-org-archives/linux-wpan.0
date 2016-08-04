Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55907 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758601AbcHDNLO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Aug 2016 09:11:14 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 linux-wpan/radvd for-upstream 0/2] radvd: upstream patches
Date: Thu,  4 Aug 2016 15:09:30 +0200
Message-Id: <20160804130932.4429-2-aar@pengutronix.de>
In-Reply-To: <20160804130932.4429-1-aar@pengutronix.de>
References: <20160804130932.4429-1-aar@pengutronix.de>
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
address length (not 8 bytes, with U/L bit).

If everything seems fine I will send a pull-request for radvd github
repository. Please reply if this "hopefully final version" is okay for
all 6LoWPAN people. Then I will try to get this upstream, at last the
radvd maintainer need to apply this patch series if this looks okay
for him.

- Alex

changes since v2:

I need to correct me here, I think the buggy btle 6lowpan implementation
addr_len == 8 and U/L will work. This is because the U/L bit is part of
interface device address and radvd will use them. But anyway it's wrong
and the next step will be to fix BTLE 6LoWPAN mainline.

- change device address length UAPI to netlink
- correct commit message in PATCH 1/2 - remove the part that all 6LoWPAN
  types has the same device address length.

Alexander Aring (2):
  device-linux: replace ARPHRD_IEEE802154 to ARPHRD_6LOWPAN
  device-linux: get address length via netlink

 device-linux.c | 27 ++++++++++++++++++++-----
 netlink.c      | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h      |  1 +
 3 files changed, 87 insertions(+), 5 deletions(-)

-- 
2.9.2

