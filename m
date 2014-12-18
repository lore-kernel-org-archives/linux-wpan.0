Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38069 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbaLRXVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Dec 2014 18:21:12 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 0/4] ieee802154: rework cca settings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 19 Dec 2014 00:21:09 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <DE72037B-F4B1-4E7A-8F7B-67A3112751D4@holtmann.org>
References: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patch changes the CCA setting handling. I know this will completely
> broken the deprecated netlink call for cca setting. This call is driver
> specific and we need to change that. Since this interface is deprecated
> we don't care about this now. Also the official userspace tool software
> "lowpan-tools" doesn't support this netlink interface.
> 
> I will send later patches for wpan-tools to support the new cca setting.
> 
> - Alex
> 
> Alexander Aring (4):
>  nl802154: introduce cca mode enums
>  ieee802154: rework cca setting
>  nl802154: introduce support for cca settings
>  at86rf230: add reset state cca handling
> 
> drivers/net/ieee802154/at86rf230.c | 32 ++++++++++++++++++++++++--
> include/net/cfg802154.h            | 10 ++++++++-
> include/net/ieee802154_netdev.h    |  4 +++-
> include/net/mac802154.h            |  5 ++++-
> include/net/nl802154.h             | 45 ++++++++++++++++++++++++++++++++++++-
> net/ieee802154/nl-mac.c            |  4 ++--
> net/ieee802154/nl802154.c          | 46 +++++++++++++++++++++++++++++++++++---
> net/ieee802154/rdev-ops.h          |  7 ++++++
> net/ieee802154/sysfs.c             |  2 +-
> net/mac802154/cfg.c                | 21 +++++++++++++++++
> net/mac802154/driver-ops.h         |  5 +++--
> net/mac802154/mac_cmd.c            |  6 ++---
> 12 files changed, 170 insertions(+), 17 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

