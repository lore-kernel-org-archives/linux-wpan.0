Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:54727 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaJONi2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 15 Oct 2014 09:38:28 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 2/2] ieee802154: 6lowpan: add RTNL assertion
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413189187-27123-2-git-send-email-alex.aring@gmail.com>
Date: Wed, 15 Oct 2014 15:38:22 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <41761012-1D4F-48DC-9C87-7BFB4D785B6E@holtmann.org>
References: <1413189187-27123-1-git-send-email-alex.aring@gmail.com> <1413189187-27123-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch ensure that the rtnl lock is hold while newlink callback.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan_rtnl.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

