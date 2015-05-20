Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36834 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbbETJD1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 05:03:27 -0400
Received: by wizk4 with SMTP id k4so147131996wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 02:03:26 -0700 (PDT)
Date: Wed, 20 May 2015 11:03:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 21/34] ieee802154: add support for atusb
 transceiver
Message-ID: <20150520090322.GB3978@omega>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
 <1431891910-32231-22-git-send-email-alex.aring@gmail.com>
 <555B1531.3060500@osg.samsung.com>
 <555C49A5.40202@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <555C49A5.40202@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, marcel@holtmann.org, Werner Almesberger <werner@almesberger.net>, Richard Sharpe <realrichardsharpe@gmail.com>

Hi,

On Wed, May 20, 2015 at 10:45:25AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 19/05/15 12:49, Stefan Schmidt wrote:
> >
> >Besides the mentioned things this looks fine. Will give it some testing
> >later this week.
> 
> Testing showed no further problems. Driver loads fine, detects the hardware
> and I'm able to configure it and send ping's over 6LoWPAN to another node.
> 

thanks, now I can sleep a little bit better.

Was it a little bit too fast for bringing the atusb driver mainline? I
really had only the issues with the xmit_sync handling otherwise this
driver looked always fine for me.

I know you worked a little bit on the driver and hope that I didn't
destroyed your work and you can rebase it.

- Alex
