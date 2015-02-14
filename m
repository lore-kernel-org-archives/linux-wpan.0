Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:35520 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbbBNXK5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Feb 2015 18:10:57 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next] at86rf230: assign wait_for_completion_timeout to appropriately typed var
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423954668-21406-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 14 Feb 2015 15:10:35 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <F8640A7A-3D50-45D1-BEA6-69D1F6D4EF6E@holtmann.org>
References: <1423954668-21406-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Nicholas Mc Guire <hofrat@osadl.org>

Hi Alex,

> return type of wait_for_completion_timeout is unsigned long not int.
> As rc is used here only for wait_for_completion_timeout the type is simply
> changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

