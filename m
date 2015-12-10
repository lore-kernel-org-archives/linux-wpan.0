Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:36055 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754369AbbLJSR4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 10 Dec 2015 13:17:56 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCHv2 bluetooth] mac802154: tx: fix synced xmit deadlock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449699836-8260-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 10 Dec 2015 08:17:49 -1000
Content-Transfer-Encoding: 7bit
Message-Id: <5696A6A3-DBB8-4775-9528-13890D584824@holtmann.org>
References: <1449699836-8260-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Michael Hennerich <michael.hennerich@analog.com>

Hi Alex,

> This patch reverts 6001d52 ("mac802154: tx: don't allow if down while
> sync tx"). This has side effects with stop callback which flush the
> transmit workqueue. The stop callback will wait until the workqueue is
> flushed and holding the rtnl lock. That means it can happen that the stop
> callback waits forever because it try to lock the rtnl mutex which is
> already hold by stop callback.
> 
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> changes since v2:
> - remove ASSERT_RTNL as well in "xmit sync" driver-ops.
> 
> net/mac802154/driver-ops.h | 3 ---
> net/mac802154/tx.c         | 9 ---------
> 2 files changed, 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

