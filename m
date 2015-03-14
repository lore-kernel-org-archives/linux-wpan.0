Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:60160 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbCNQNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Mar 2015 12:13:35 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 0/3] at86rf230: state delay over hrtimer and calibration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 14 Mar 2015 09:13:29 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <7CE0DF6C-2108-44BB-A9FB-EA12930966E8@holtmann.org>
References: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patch series contains for doing the state delay via hrtimer and introduce
> the transceiver calibration by doing a TRX_OFF -> TX_ON state before transmit
> and transceiver leaves 5 minutes in PLL state.
> 
> - Alex
> 
> Alexander Aring (3):
>  at86rf230: replace state change sleeps with hrtimer
>  at86rf230: add support for calibration timeout
>  at86rf230: fix volatile regmap registers
> 
> drivers/net/ieee802154/at86rf230.c | 113 +++++++++++++++++++++++++++++--------
> 1 file changed, 89 insertions(+), 24 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

