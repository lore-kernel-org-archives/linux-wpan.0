Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33332 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbbCRN1S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 09:27:18 -0400
Received: by weop45 with SMTP id p45so32349338weo.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 06:27:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 0/2] mac: phy: change to new nl802154 cmds
Date: Wed, 18 Mar 2015 14:27:07 +0100
Message-Id: <1426685229-31900-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains patches to change all netlink phy and mac settings
into one phy/interface command. I will applu this series mainline to wpan-tools
and make a new release when the corresponding kernel nl802154 are mainline.

There is one maybe _some_ cleaner solution to make something like:

#include <linux/version.h>

#if LINUX_VERSION_CODE <= KERNEL_VERSION(foo)
...
#else
...
#endif

this would rescue newer wpan-tools with older kernels. But requires the right
kernel-headers while cross-compiling and such things. I don't think that this
is really necessary here now. We make a simple cut now.

- Alex

Alexander Aring (2):
  phy: use NL802154_CMD_SET_WPAN_PHY
  mac: use NL802154_CMD_SET_INTERFACE

 src/mac.c | 12 ++++++------
 src/phy.c |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.3.3

