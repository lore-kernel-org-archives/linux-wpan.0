Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:46774 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbbFPQ45 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 12:56:57 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 1/3] at86rf230: fix phy settings while sleeping
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 16 Jun 2015 18:56:50 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <D6B0C9EE-E78A-4613-97BD-60F85C96CA4E@holtmann.org>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> While in sleep state then we can't access the at86rf2xx registers. This
> patch checks if the transceiver is in sleep state before sending spi
> messages via regmap. Regmap is used on every driver ops callback except
> for receive and xmit handling, but while receive and xmit handling the
> phy should not be inside the sleep state.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> change since v2:
> - I detect an issue with cca ed level setting in v1, there was a return in the
>   middle of awake and sleep transceiver. This results that the transceiver
>   wasn't again turn into sleep state afterwards.
>   To avoid such behaviour I moved the awake and sleep into lowlevel register io
>   functions. These functions "could" be called only when the phy is in sleep
>   state.
> 
> 
> drivers/net/ieee802154/at86rf230.c | 88 +++++++++++++++++++++++++++++---------
> 1 file changed, 68 insertions(+), 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

