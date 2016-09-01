Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:43724 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933938AbcIAQIa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Sep 2016 12:08:30 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next] fakelb: fix schedule while atomic
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160901092457.26010-1-aar@pengutronix.de>
Date: Thu, 1 Sep 2016 08:58:33 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <549BEB42-C647-4FC1-9024-C11A1AD7A298@holtmann.org>
References: <20160901092457.26010-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch changes the spinlock to mutex for the available fakelb phy
> list. When holding the spinlock the ieee802154_unregister_hw is called
> which holding the rtnl_mutex, in that case we get a "BUG: sleeping function
> called from invalid context" error. We simple change the spinlock to
> mutex which allows to hold the rtnl lock there.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> I think for the current use case, we don't need any locking anyway, but when
> we add support for runtime add/del phy's then we need it... so I let the lock
> there.
> 
> drivers/net/ieee802154/fakelb.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

