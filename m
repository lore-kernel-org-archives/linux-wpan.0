Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33807 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbCZMG2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 08:06:28 -0400
Received: by wibg7 with SMTP id g7so14910449wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 26 Mar 2015 05:06:27 -0700 (PDT)
Date: Thu, 26 Mar 2015 13:06:24 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/3] at86rf230: fix is_tx while error
 handling
Message-ID: <20150326120620.GB5394@omega>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
 <1427370390-31302-3-git-send-email-alex.aring@gmail.com>
 <5513F38B.30007@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5513F38B.30007@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, Mar 26, 2015 at 12:54:51PM +0100, Marc Kleine-Budde wrote:
> On 03/26/2015 12:46 PM, Alexander Aring wrote:
> > This patch fix the error handling when is_tx is true. The error handling
> > tries to get the transceiver into RX_AACK_ON mode then we need to be
> > sure that is_tx is false.
> 
> Generally speaking, first fix errors, then clean up and improve code.
> 

should I resend again with a new sequence of this patch series?

I know it's some mixed things which I detect while hacking the nl802154
crypto foo. But I will remember Marc's words before sending next series.
:-)

btw:
I think if an spi_async error occurs then something goes really wrong
and a rescue by doing a TRX_OFF -> RX_AACK_ON doesn't help also anymore.

We need then something like rf_kill framework.

- Alex
