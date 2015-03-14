Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33550 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbCNQOT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Mar 2015 12:14:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 0/3] ieee802154: UAPI changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 14 Mar 2015 09:14:16 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <FEC50144-3349-482D-8022-75F5EFCD46F7@holtmann.org>
References: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

> I think the stack implementation becomes more popular since the last year.
> This patch series contains heavy UAPI changes which will of course breaks
> some automated scripts by using iwpan and developed software which checks
> on ARPHRD on a lowpan interface and somebody which use sysfs entries for
> setting some phy settings.
> 
> I sent this series couple months ago and nobody screams, so I think the
> changes is okay for everybody. I removed to set the NETDEV type, we can
> do this still later and it's more a new feature than a change.
> 
> I currently also think about to remove the ioctl callbacks for setting
> addresses. Nowadays nobody should use them from userspace to set wpan
> addresses. But I want make this later after to be sure that we don't
> breaking crypto stuff.
> 
> - Alex
> 
> Alexander Aring (3):
>  ieee802154: 6lowpan: fix ARPHRD to ARPHRD_6LOWPAN
>  ieee802154: change wpan-phy name to phy
>  ieee802154: remove deprecated sysfs entries
> 
> net/ieee802154/6lowpan/core.c |  2 +-
> net/ieee802154/core.c         |  5 ++++-
> net/ieee802154/sysfs.c        | 49 -------------------------------------------
> 3 files changed, 5 insertions(+), 51 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

