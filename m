Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59230 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaJFKmN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 06:42:13 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH wpan-next 3/3] ieee802154: 6lowpan: fix sign of errno return val
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412586052-27299-3-git-send-email-alex.aring@gmail.com>
Date: Mon, 6 Oct 2014 12:42:16 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <9D986FB4-7605-47C8-AD52-355FD847AF02@holtmann.org>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com> <1412586052-27299-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

> This patch fix ERR_PTR(-rc) to ERR_PTR(rc). The variable rc is already a
> negative errno value.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan_rtnl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

