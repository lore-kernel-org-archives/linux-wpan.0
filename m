Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:51198 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaKBUwz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:52:55 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next 0/6] ieee802154: solve make C=2 warnings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 2 Nov 2014 12:52:48 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <F15716CA-9248-4BA6-83DD-BB6FEEDD3E4D@holtmann.org>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series fixes warning when building with "make C=2". This was
> reported by Marcel Holtmann which told me to run "make C=2" and solve
> these warnings. Most of the issues was forgotten includes and byte ordering
> handling.
> 
> Alexander Aring (6):
>  ieee802154: add missing ULL definition
>  ieee802154: fix byteorder issues
>  mac802154: fix byteorder issues
>  ieee802154: sysfs: add missing include
>  mac802154: cfg: add missing include
>  ieee802154: remove unnecessary functions
> 
> include/linux/ieee802154.h |  4 +++-
> include/net/mac802154.h    |  6 +++---
> net/ieee802154/sysfs.c     |  1 +
> net/mac802154/cfg.c        |  1 +
> net/mac802154/iface.c      | 22 ----------------------
> 5 files changed, 8 insertions(+), 26 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

