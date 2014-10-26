Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:32867 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaJZQ0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 12:26:09 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCHv2 bluetooth-next 00/15] ieee802154: rework transmit handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 26 Oct 2014 09:26:03 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <97746F45-6173-41C7-B06D-D903119E5A16@holtmann.org>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This series contains patches for reworking tx handling.
> Also add a workaround to hold the xmit context when sending frames.
> Additional add support for asynchronous xmit handling and change the
> at86rf230 to do a asynchronous xmit handling.
> 
> Moving functions and renaming are necessary for the mac80211 naming
> convention.
> 
> changes since v2:
> - remove whitespace in PATCH 14/15
>   ("mac802154: tx: add comment at sync xmit callback")
> 
> Alexander Aring (15):
>  mac802154: tx: move xmit callback to tx file
>  mac802154: tx: remove kmalloc in xmit hotpath
>  mac802154: tx: squash multiple dereferencing
>  mac802154: tx: remove xmit channel context switch
>  mac802154: add netdev qeue helpers
>  mac802154: tx: use queue helpers in xmit worker
>  mac802154: tx: fix error handling while xmit
>  mac802154: tx: add support for xmit_async callback
>  mac802154: tx: don't allow if down while sync tx
>  mac802154: tx: use netdev print helpers
>  mac802154: tx: cleanup crc calculation
>  mac802154: tx: move stats tx increment
>  mac802154: tx: change naming convention
>  mac802154: tx: add comment at sync xmit callback
>  at86rf230: asynchronous xmit handling
> 
> drivers/net/ieee802154/at86rf230.c |  42 +++++------
> drivers/net/ieee802154/cc2520.c    |   2 +-
> drivers/net/ieee802154/fakelb.c    |   2 +-
> drivers/net/ieee802154/mrf24j40.c  |   2 +-
> include/net/mac802154.h            |  28 +++++--
> net/mac802154/Makefile             |   2 +-
> net/mac802154/ieee802154_i.h       |   7 +-
> net/mac802154/iface.c              |  37 +---------
> net/mac802154/main.c               |   4 +-
> net/mac802154/monitor.c            |  29 +-------
> net/mac802154/tx.c                 | 145 ++++++++++++++++++++++---------------
> net/mac802154/util.c               |  55 ++++++++++++++
> 12 files changed, 193 insertions(+), 162 deletions(-)
> create mode 100644 net/mac802154/util.c

all 15 patches have been applied to bluetooth-next tree.

Regards

Marcel

