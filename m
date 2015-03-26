Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:55822 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbbCZPBi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 11:01:38 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next 3/3] at86rf230: fix is_tx while error handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150326120620.GB5394@omega>
Date: Thu, 26 Mar 2015 08:01:33 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <CD5CEAF7-9103-411A-8173-1295D2F3706E@holtmann.org>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com> <1427370390-31302-3-git-send-email-alex.aring@gmail.com> <5513F38B.30007@pengutronix.de> <20150326120620.GB5394@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

>>> This patch fix the error handling when is_tx is true. The error handling
>>> tries to get the transceiver into RX_AACK_ON mode then we need to be
>>> sure that is_tx is false.
>> 
>> Generally speaking, first fix errors, then clean up and improve code.
>> 
> 
> should I resend again with a new sequence of this patch series?
> 
> I know it's some mixed things which I detect while hacking the nl802154
> crypto foo. But I will remember Marc's words before sending next series.
> :-)

I am fine either way. I can apply the patches as you sent them.

Regards

Marcel

