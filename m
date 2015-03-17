Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53123 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbbCQPb2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 11:31:28 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next] at86rf230: fix at86rf230_read_subreg succeed handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426584759-29501-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 17 Mar 2015 08:31:23 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <8719FC61-F260-4EBE-832E-BA7213E4729D@holtmann.org>
References: <1426584759-29501-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch fix an issue when at86rf230_read_subreg was successful. The
> function at86rf230_read_subreg will directly call regmap_read which
> returns zero on successful. Nobody figured out issues yet because it was
> only necessary to evaluate dvdd state while probing. This could make
> trouble because the stack variable could have an random value.
> 
> The function is also used by reset the irq line before requesting irq, but
> the value isn't evaluated afterwards.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

