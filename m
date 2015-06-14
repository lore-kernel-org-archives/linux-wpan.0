Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37949 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbbFNXYX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 19:24:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 1/4] mac802154: iface: fix hrtimer cancel on ifdown
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 15 Jun 2015 01:24:22 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <C8F7DCF8-4761-4A91-ADE3-A25AFF7CB92A@holtmann.org>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> The interframe spacing timer is a per phy definition and is part of a
> ieee802154_local structure. If we have possible multiple interfaces
> ifdown one interface then the timer should not be cancled. First if the
> last interface is down and the receive handling is stopped we should be
> sure that the interframe spacing timer isn't run anymore.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

