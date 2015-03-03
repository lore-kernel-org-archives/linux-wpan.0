Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56431 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbbCCBRf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 20:17:35 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 0/6] at86rf230: improvements and cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 2 Mar 2015 17:17:31 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <42CD64B2-908F-4C7D-A704-3DE54E212F80@holtmann.org>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this series contains some improvements in transmit handling which insert
> a retry mode for going into STATE_TX_ON instead of turning into this state
> with forcing after the first try. This series contains also some improvements
> /cleanups which squash some multiple dereferencing and don't overwrite a
> memory space always with the same number.
> 
> - Alex
> 
> Alexander Aring (6):
>  at86rf230: add transmit retry support
>  at86rf230: cleanup and squash stack variable
>  at86rf230: refactor receive handling
>  at86rf230: remove multiple dereferencing for irq
>  at86rf230: remove multiple dereferencing for ctx
>  at86rf230: restore trx len when needed
> 
> drivers/net/ieee802154/at86rf230.c | 117 +++++++++++++++++++++----------------
> 1 file changed, 67 insertions(+), 50 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

