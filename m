Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55064 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbAJWex (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 10 Jan 2015 17:34:53 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 0/2] ieee802154: socket: fix buffer overflow
Date: Sat, 10 Jan 2015 23:33:24 +0100
Message-Id: <1420929206-5771-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, marcel@holtmann.org, werner@almesberger.net, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this is some critical bug fix here and I don't know how do deal with that now.
I don't know if you can "get root" by this security issue. But the socket interface
can be simple loaded by user via module-autoloading while using the address family.
Maybe there is no security issue and the buffers are cutted off. I don't know, but
there is definitely something wrong here.

In my opinion af_ieee802154 should go to stable (bluetooth), but this will break
the complete userspace interface for every application. I think there are no many
users so I will simple send

Patch 1/2 "af_ieee802154: fix struct ieee802154_addr_sa size"

to bluetooth. This is a RFC to talk about this issue and if somebody knows a better
way please tell that here. Note also all userspace applications need to be updated
after this patch. I really don't know how to deal with such issue and CC here a lot
of well known linux hackers and would be glad if I get any suggestions about that.

Or maybe I should go to the netdev mailinglist with this issue.

- Alex

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Werner Almesberger <werner@almesberger.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Alexander Aring (2):
  af_ieee802154: fix struct ieee802154_addr_sa size
  ieee802154: socket: add BUILD_BUG_ON for cast check

 include/net/af_ieee802154.h | 2 +-
 net/ieee802154/socket.c     | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.2.1

