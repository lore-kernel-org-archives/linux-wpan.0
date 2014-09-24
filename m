Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:43836 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaIXMRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 08:17:11 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 0/4] ieee802154: mrf24j40 cleanups and 6lowpan fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 24 Sep 2014 14:17:13 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <A7357AD1-583F-4FB3-AF7E-4BDD1F824578@holtmann.org>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patches series contains cleanups for the mrf24j40 driver of the 802.15.4 subsystem.
> Also one patch to fix a 802.15.4 6LoWPAN bug if we replace the IPv6 header with 6LoWPAN
> header on a shared skb data buffer.
> 
> - Alex
> 
> Simon Vincent (1):
>  ieee802154: 6lowpan: ensure header compression does not corrupt ipv6
>    header
> 
> Varka Bhadram (3):
>  mrf24j40: fix Missing a blank line after declarations
>  mrf24j40: remove unnecessary return statement
>  mrf24j40: use pr_* / dev_* instead of printk()
> 
> drivers/net/ieee802154/mrf24j40.c |  19 +++---
> net/ieee802154/6lowpan_rtnl.c     | 125 +++++++++++++++++++++++++++-----------
> 2 files changed, 99 insertions(+), 45 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

