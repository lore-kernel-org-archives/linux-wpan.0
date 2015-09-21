Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:57202 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbIUSpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 14:45:39 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] at86rf230: support edge triggered irq
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442821074-18592-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 21 Sep 2015 20:45:34 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <042A050F-CF3E-4277-8FF8-E0E435E486F8@holtmann.org>
References: <1442821074-18592-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch adds support for edge triggered irq types. We remove the
> locking for irq resources by enable/disable irq and allocate directly
> some heap buffer at isr. We have still a enable/disable irq path but
> this is for level-triggered irq's which need to be disabled until
> spi_async clear the irq line.
> 
> There is usually a little race condition between "irq line cleared" and
> "enable_irq". When in this time a edge triggered irq arrived, we will
> not recognize this interrupt. This case can't happend at at86rf230. The
> reason is that we unmask TRX_END irq's only which indicates a transmit
> or receive completion, which depends on the current state.
> 
> On Transmit:
> 
> TRX_END arrived and transceiver is in TX_ARET_ON state again, in this
> state no other TRX_END can happen until we leave the state.
> 
> On Receive:
> 
> This is protected with the RX_SAFE_MODE bit which leaves the transceiver
> in RX_AACK_BUSY until we readed the framebuffer. In this state no other
> TRX_END can happen.
> 
> Tested with RPi where I first detected issues between edge/level irq's.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 211 ++++++++++++++++---------------------
> 1 file changed, 89 insertions(+), 122 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

