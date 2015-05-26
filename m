Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45801 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbbEZQDi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 12:03:38 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] mac802154: Avoid rtnl deadlock in mac802154_wpan_ioctl().
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150526120610.GT11340@wantstofly.org>
Date: Tue, 26 May 2015 18:03:34 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <009BC842-C8EA-4738-A686-7B27C98A5BB3@holtmann.org>
References: <20150526120610.GT11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

> ->ndo_do_ioctl() can be entered with the rtnl lock already held,
> for example when sending a wext ioctl to a device (in which case
> the rtnl lock is taken by wext_ioctl_dispatch()), but
> mac802154_wpan_ioctl() currently unconditionally takes the rtnl
> lock on entry, which can cause deadlocks.
> 
> To fix this, bail out of mac802154_wpan_ioctl() before taking the
> rtnl lock if the ioctl cmd is not one of the cmds we implement.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> Acked-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

