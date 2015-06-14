Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37545 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbbFNXYN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 19:24:13 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 3/4] at86rf230: use level high as fallback default
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434226554-1450-3-git-send-email-alex.aring@gmail.com>
Date: Mon, 15 Jun 2015 01:24:11 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <94A41698-38D7-477E-B5BB-6FC257FA5235@holtmann.org>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com> <1434226554-1450-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch use high level interrupt type as fallback handling when no
> irq type is given.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

