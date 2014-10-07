Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47846 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbaJGLQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 07:16:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 0/9] at86rf230: various fixes and cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 7 Oct 2014 13:16:13 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <300D854B-CE6D-46AE-91D8-E9313F081D6C@holtmann.org>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, m.olbrich@pengutronix.de

Hi Alex,

> this series fix a race condition when switching to RX_AACK_ON and irq is
> enabled. Also contains correct handling of enable_irq if the irq was disabled
> before. Additional we fix the handling of lifs/sifs timing in ARET mode.
> 
> - Alex
> 
> Alexander Aring (9):
>  at86rf230: fix errno on tx timeout handling
>  at86rf230: add missing error handling
>  at86rf230: correct aret lifs and sifs handling
>  at86rf230: correct at86rf2xx lifs timings
>  at86rf230: squash unnecessary dereferencing
>  at86rf230: add missing enable_irq
>  at86rf230: fix race condition
>  at86rf230: fix enable_irq handling on async spi
>  at86rf230: remove unnecessary print of async error
> 
> drivers/net/ieee802154/at86rf230.c | 180 +++++++++++++++++++------------------
> 1 file changed, 92 insertions(+), 88 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

