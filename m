Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53473 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957AbbEWP6t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 23 May 2015 11:58:49 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 0/4] mac802154: remove pib/mib locks and locking fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 23 May 2015 17:58:42 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <B91719FE-291A-47E3-B803-179BE2E6741A@holtmann.org>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patch series contains patches for remove pib and mib lock. We have now
> a other locking strategie inside this stack which requires at the moment the
> rtnl lock only. The first patch will hold the rtnl lock which is required to
> access the mib attributes while calling socket ioctl. The last patch will use
> atomic operations for incremet the dsn value for dataframes, currently it could
> be that this value is the same in two contiguous frames which could be occur a
> wrong ack frame handling in ARET mode.
> 
> - Alex
> 
> changes since v2:
> - switch patch 3 and 4.
> 
> Alexander Aring (4):
>  mac802154: fix hold rtnl while ioctl
>  mac802154: remove pib lock
>  mac802154: use atomic ops for sequence incrementation
>  mac802154: remove mib lock
> 
> include/net/cfg802154.h         |  6 ++--
> include/net/ieee802154_netdev.h | 10 -------
> net/ieee802154/6lowpan/core.c   | 28 ------------------
> net/ieee802154/6lowpan/tx.c     |  2 +-
> net/ieee802154/core.c           |  2 --
> net/ieee802154/nl-mac.c         | 14 ++++++---
> net/ieee802154/nl-phy.c         |  6 ++--
> net/ieee802154/socket.c         | 12 ++++----
> net/mac802154/ieee802154_i.h    |  7 -----
> net/mac802154/iface.c           | 29 ++++++-------------
> net/mac802154/mac_cmd.c         |  7 ++---
> net/mac802154/mib.c             | 63 ++---------------------------------------
> net/mac802154/rx.c              |  5 ----
> 13 files changed, 34 insertions(+), 157 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

