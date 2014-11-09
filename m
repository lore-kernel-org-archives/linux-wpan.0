Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:54053 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaKISwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 13:52:24 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next 00/15] ieee802154: introduce nl802154 framework
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 9 Nov 2014 10:52:19 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <D7A626B9-7D35-4E88-8F0C-B12D7AB93F49@holtmann.org>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series introduce the nl802154 framework. Code was mostly grabbed
> from wireless nl80211 implementation. Furthermore we should add some net
> namespace handling like wireless. I added some TODO comment for the things
> which we doesn't handled right now like wireless nl80211. Also add some
> cleanups and fixes for the deprecated netlink interface.
> 
> Alexander Aring (15):
>  mac802154: move mac pib attributes into wpan_dev
>  mac802154: remove mac_params in sdata
>  ieee802154: rename wpan_phy_alloc
>  ieee802154: add cfg802154_registered_device list
>  ieee802154: add iftype to wpan_dev
>  ieee802154: add wpan_dev_list
>  ieee802154: sysfs add wpan_phy index and name
>  ieee802154: add new nl802154 header
>  ieee802154: add nl802154 framework
>  ieee802154: add wpan_phy dump support
>  ieee802154: add wpan_dev dump support
>  mac820154: don't set monitor dev_addr
>  ieee802154: netlink add rtnl lock
>  ieee802154: fix iface dump with lowpan
>  mac802154: protect address changes via ioctl
> 
> MAINTAINERS                  |   1 +
> include/net/cfg802154.h      |  33 ++-
> include/net/nl802154.h       | 122 ++++++++
> net/ieee802154/Makefile      |   2 +-
> net/ieee802154/core.c        | 166 ++++++++++-
> net/ieee802154/core.h        |  17 ++
> net/ieee802154/ieee802154.h  |   2 +-
> net/ieee802154/netlink.c     |   2 +-
> net/ieee802154/nl-mac.c      |  23 +-
> net/ieee802154/nl802154.c    | 675 +++++++++++++++++++++++++++++++++++++++++++
> net/ieee802154/nl802154.h    |   7 +
> net/ieee802154/sysfs.c       |  24 ++
> net/mac802154/ieee802154_i.h |  12 -
> net/mac802154/iface.c        |  84 +++---
> net/mac802154/mac_cmd.c      |  36 ++-
> net/mac802154/main.c         |   2 +-
> net/mac802154/mib.c          |  10 +-
> net/mac802154/rx.c           |   7 +-
> 18 files changed, 1148 insertions(+), 77 deletions(-)
> create mode 100644 include/net/nl802154.h
> create mode 100644 net/ieee802154/nl802154.c
> create mode 100644 net/ieee802154/nl802154.h

all 15 patches have been applied to bluetooth-next tree.

Regards

Marcel

