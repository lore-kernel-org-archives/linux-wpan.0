Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:58960 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbD3Qup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 12:50:45 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 00/13] ieee802154: pending wpan-next patches for bluetooth-next
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 30 Apr 2015 09:50:39 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <7E2D5369-C3DA-41A4-9E15-4649BA9371EE@holtmann.org>
References: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> these are the current pending patches for bluetooth-next which contains
> two error handling fixes for mac802154. Additional Guido Günther implement
> cfg802154 tracing support based on cfg80211 tracing support. Varka Bhadram
> implemented the netdev sysfs name_assign_type attribute for wpan interface
> and improved mac802154 comments. At least Alexander Aring and Christoffer
> Holmstedt did cleanups and improves for the at86rf230 driver.
> 
> Thanks to all contributors.
> 
> - Alex
> 
> Alexander Aring (8):
>  mac802154: fix ieee802154_register_hw error handling
>  at86rf230: remove tabs after define
>  at86rf230: move cal_timeout to state change
>  at86rf230: add TX_ARET_ON for calibration timeout
>  at86rf230: remove unnecessary tx state change
>  at86rf230: change state change if from trx_off
>  at86rf230: add slp_tr support to start tx
>  ieee802154: trace: fix endian convertion
> 
> Christoffer Holmstedt (1):
>  at86rf230: Add macro for TRX STATE MASK
> 
> Guido Günther (1):
>  ieee802154: Add trace events for rdev->ops
> 
> Varka Bhadram (2):
>  mac802154: add description to mac802154 APIs
>  cfg802154: pass name_assign_type to rdev_add_virtual_intf()
> 
> Wei Yongjun (1):
>  mac802154: llsec: fix return value check in llsec_key_alloc()
> 
> drivers/net/ieee802154/at86rf230.c | 390 ++++++++++++++++++++-----------------
> include/net/cfg802154.h            |   2 +
> include/net/mac802154.h            |  94 ++++++++-
> net/ieee802154/Makefile            |   4 +-
> net/ieee802154/nl-phy.c            |   5 +-
> net/ieee802154/nl802154.c          |   2 +-
> net/ieee802154/rdev-ops.h          |  85 ++++++--
> net/ieee802154/trace.c             |   7 +
> net/ieee802154/trace.h             | 247 +++++++++++++++++++++++
> net/mac802154/cfg.c                |   9 +-
> net/mac802154/ieee802154_i.h       |   3 +-
> net/mac802154/iface.c              |   5 +-
> net/mac802154/llsec.c              |   4 +-
> net/mac802154/main.c               |   7 +-
> 14 files changed, 652 insertions(+), 212 deletions(-)
> create mode 100644 net/ieee802154/trace.c
> create mode 100644 net/ieee802154/trace.h

I applied 02/13 and 03/13 to bluetooth-stable tree and the rest to bluetooth-next tree.

Regards

Marcel

