Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56659 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbbC0SWb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Mar 2015 14:22:31 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 3/3] at86rf230: fix is_tx while error handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427370390-31302-3-git-send-email-alex.aring@gmail.com>
Date: Fri, 27 Mar 2015 11:22:23 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <86950E30-4BEB-465F-A8AF-8E01EC9F1E57@holtmann.org>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com> <1427370390-31302-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

> This patch fix the error handling when is_tx is true. The error handling
> tries to get the transceiver into RX_AACK_ON mode then we need to be
> sure that is_tx is false.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

