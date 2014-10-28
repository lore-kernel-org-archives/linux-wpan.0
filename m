Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:58523 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaJ1WZJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 18:25:09 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next 00/17] mac802154: iface and driver-ops cleanup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 28 Oct 2014 15:24:40 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <C07C28A6-75A5-4FCD-ABA7-6ADBFEC6C705@holtmann.org>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series contains cleanups for iface handling driver-ops and
> sysfs handling. Also removing dead code of current behaviour of local->running
> and use it as local->started behaviour like mac8011.
> 
> Alexander Aring (17):
>  mac802154: monitor: merge into iface implementation
>  mac802154: main: move open and close into iface
>  mac802154: declare struct ieee802154_ops as const
>  mac802154: ops: declare channel and page as u8
>  mac802154: introduce driver-ops header
>  mac802154: use driver-ops function wrappers
>  mac802154: remove might_sleep from driver layer
>  mac802154: remove driver ops in wpan-phy
>  mac802154: rework sdata state change to running
>  mac802154: rename running to started
>  mac802154: move local started handling
>  mac802154: add synchronization handling
>  mac802154: iface: remove assign to zero
>  mac802154: remove channel attributes from sdata
>  mac802154: move mac_params functions into mac_cmd
>  mac802154: cleanup open count handling
>  ieee802154: introduce sysfs file
> 
> drivers/net/ieee802154/at86rf230.c |  13 +--
> drivers/net/ieee802154/cc2520.c    |   5 +-
> drivers/net/ieee802154/fakelb.c    |   8 +-
> drivers/net/ieee802154/mrf24j40.c  |   5 +-
> include/net/cfg802154.h            |   8 --
> include/net/mac802154.h            |   7 +-
> net/ieee802154/Makefile            |   2 +-
> net/ieee802154/core.c              |  73 +------------
> net/ieee802154/nl-mac.c            |  19 +---
> net/ieee802154/sysfs.c             |  94 ++++++++++++++++
> net/ieee802154/sysfs.h             |   9 ++
> net/mac802154/Makefile             |   2 +-
> net/mac802154/driver-ops.h         | 213 +++++++++++++++++++++++++++++++++++++
> net/mac802154/ieee802154_i.h       |  34 +++---
> net/mac802154/iface.c              | 119 +++++++++++++++++----
> net/mac802154/mac_cmd.c            |  22 ++++
> net/mac802154/main.c               | 166 +----------------------------
> net/mac802154/mib.c                |  56 ++--------
> net/mac802154/monitor.c            |  59 ----------
> net/mac802154/tx.c                 |   5 +-
> 20 files changed, 488 insertions(+), 431 deletions(-)
> create mode 100644 net/ieee802154/sysfs.c
> create mode 100644 net/ieee802154/sysfs.h
> create mode 100644 net/mac802154/driver-ops.h
> delete mode 100644 net/mac802154/monitor.c

all 17 patches have been applied to bluetooth-next tree.

Regards

Marcel

