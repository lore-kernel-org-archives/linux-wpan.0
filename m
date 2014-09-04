Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43189 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122AbaIDIEJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 04:04:09 -0400
Received: by mail-wi0-f178.google.com with SMTP id r20so565760wiv.11
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 01:04:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 0/6] wpan-tools: new netlink interfaces calls
Date: Thu,  4 Sep 2014 10:03:48 +0200
Message-Id: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi all,

this patch series adds support for new netlink interfaces. For all
new users on this mailinglist. This is the new userspace tool for the
wpan rework [0] branch.

I removed the mib lock in the rework. Now you can only set the pan_id or
short address (don't implement the setting of short address now) when the
netdevice is _down_.

Then we don't need the the mib lock anymore. It's protected by RTNL if
netdevice is down. When it's up it's a read only variable and we can
use the variable in hot path like tx/rx without locking. (This is like
setting and use of dev_addr of an netdev device).

I disabled the af802154 and security layer for now, but I will add this later
at the end of the rework.

I also detected that our cca_mode handling is a driver specific netlink call.
This is... not good. :-) And this is the current mainline behaviour...

In the rework I added enums for the 802.15.4 CCA_MODE numbers and now the
at86rf231 makes a mapping from 802.15.4 specifc CCA_MODE to driver cca_mode(
which is the register value).

I need to begin to write more text about the new behaviour, is there anybody
outside who already test something?

We don't have the multiple phy layer, I dropped them. This was needed for the
channel hoping. We need some new idea to provide a channel hoping logic, or
simple but the logic for this in userspace. (You can change the channel while
netdev is up).

There are several other netlink interfaces (setting short_address,setting energy
detection value of phy)

The energy detection level is not part of the 802.15.4 pib, so this will be
a direct call to the driver (not saving any value of this in the pib).

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/tree/wpan_rework_rfc

Alexander Aring (6):
  nl_updates: initial commit of nl_updates
  phy: add support for tx power pib attribute
  phy: add support for setting cca_mode
  mac: add support for setting max_frame_retries
  mac: initial support for setting csma params
  phy: add support for cca mode 3 and/or handling

 src/mac.c        | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/nl802154.h   |  20 ++++++++++
 src/nl_updates.h |  75 ++++++++++++++++++++++++++++++++++++
 src/phy.c        |  67 +++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 src/nl_updates.h

-- 
2.1.0

