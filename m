Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33717 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396AbbEVMMt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 08:12:49 -0400
Received: by wgez8 with SMTP id z8so16021108wge.0
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 05:12:48 -0700 (PDT)
Date: Fri, 22 May 2015 14:12:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 4/4] mac802154: use atomic ops for
 sequence incrementation
Message-ID: <20150522121238.GA748@omega>
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
 <1432285031-3360-5-git-send-email-alex.aring@gmail.com>
 <555EEFF1.90603@pengutronix.de>
 <555F0560.8060805@osg.samsung.com>
 <555F062B.3010107@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <555F062B.3010107@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Fri, May 22, 2015 at 12:34:19PM +0200, Marc Kleine-Budde wrote:
> On 05/22/2015 12:30 PM, Stefan Schmidt wrote:
> > Hello.
> > 
> > On 22/05/15 10:59, Marc Kleine-Budde wrote:
> >> On 05/22/2015 10:57 AM, Alexander Aring wrote:
> >>> This patch will use atomic operations for sequence number incrementation
> >>> while MAC header generation. Upper layers like af_802154 or 6LoWPAN
> >>> could call this function in a parallel context while generating 802.15.4
> >>> MAC header before queuing into wpan interfaces transmit queue.
> >> what about swapping patch 3 and 4?
> > 
> > To avoid having problems during a git bisect later one? E.g. having the 
> > lock removed but no atomic in place?
> 
> Yes, that's what I was thinking about. I don't know the code to tell if
> this is an issue here.
> 

The problem is more difficult because the dsn incrementation which I do
atomic now had never a locking mechanism. So this was always not working
correctly. Somebody need to scream now "hey fix that in net, not next".
I do at the moment only critical things fixed in net, like [0].


But we should swap it because I first wrote some "TODO we should use
atomic here" and then later I decide to implement this TODO. At the end
this results in some cherry-pick orgy and I did not change it.

- Alex

[0] ("mac802154: tx: fix sync xmit handling") can't find them in the
    archive
