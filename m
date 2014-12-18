Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37816 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaLRXVF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Dec 2014 18:21:05 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCHv2 bluetooth-next 0/5] at86rf230: cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 19 Dec 2014 00:21:03 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <E1E567FF-2353-4C25-9391-A88C78291E76@holtmann.org>
References: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series contains various cleanups for the at86rf230.
> Except patch 3/5 which contains a fix for a rarely error handling.
> Because this error handling is very rarely and should only happens
> if something is wrong with the spi controller, it's okay to fix it
> in next.
> 
> - Alex
> 
> changes since v2:
> - make patch 1/5 "at86rf230: remove if branch" more human readable.
> 
> Alexander Aring (5):
>  at86rf230: remove if branch
>  at86rf230: make at86rf230_async_error inline
>  at86rf230: fix context pointer handling
>  at86rf230: cleanup check on trac status
>  at86rf230: remove unnecessary assign
> 
> drivers/net/ieee802154/at86rf230.c | 18 ++++++------------
> 1 file changed, 6 insertions(+), 12 deletions(-)

I applied patches 1-3 and 5 to bluetooth-next tree.

The patch 4 does not apply and so please re-send a new version.

Regards

Marcel

