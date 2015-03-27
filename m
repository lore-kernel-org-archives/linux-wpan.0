Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56620 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbC0SWb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Mar 2015 14:22:31 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 2/3] at86rf230: remove unnecessary spinlock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427370390-31302-2-git-send-email-alex.aring@gmail.com>
Date: Fri, 27 Mar 2015 11:22:25 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <2700ABC8-B772-4B2E-A723-1A5D25CA5CFA@holtmann.org>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com> <1427370390-31302-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

> This spinlock isn't necessary because if we are in TX_ON/TX_ARET_ON
> state the transceiver can't be interrupted e.g. by receiving a frame
> when a SHR was detected. In this time the transceiver doesn't leave
> the TX_ON/TX_ARET_ON state until the tx complete irq change the state
> into RX_AACK_ON again. This means a receiving interrupt in state
> TX_ON/TX_ARET_ON can't happen and is_tx is protected by transceiver.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> drivers/net/ieee802154/at86rf230.c | 9 ---------
> 1 file changed, 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

