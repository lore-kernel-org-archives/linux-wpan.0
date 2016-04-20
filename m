Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:56744 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932107AbcDTOTA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 Apr 2016 10:19:00 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next] at86rf230: increase sleep to off timings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
Date: Wed, 20 Apr 2016 16:18:57 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <81C78E98-88E4-4E0D-90A3-CFCCC5012B0E@holtmann.org>
References: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Oleg Hahm <oliver.hahm@inria.fr>

Hi Alex,

> I expierenced when setting channel while sleep mode it didn't changed
> the channel inside the hardware registers. Then I got another report of
> an user which has similar issues.
> 
> I increased the sleep to off state change timing, which is according
> at86rf233 at maximum 1000 us. After this change I got no similar effects
> again.
> 
> I tried another option to wait on AWAKE_END irq, which can be used to
> wait until the transceiver is awaked. I tested it and the IRQ took 4
> seconds after starting state change. I don't believe it takes 4 seconds
> to go into the TRX_OFF state from SLEEP state. The alternative is to
> increase the timings which seems to work.
> 
> Cc: Oleg Hahm <oliver.hahm@inria.fr>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> drivers/net/ieee802154/at86rf230.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

