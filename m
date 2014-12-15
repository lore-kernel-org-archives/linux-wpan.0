Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45803 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaLOIpo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:45:44 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so8144533wid.11
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 00:45:43 -0800 (PST)
Date: Mon, 15 Dec 2014 09:45:40 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/5] at86rf230: remove if branch
Message-ID: <20141215084538.GC7153@omega>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-2-git-send-email-alex.aring@gmail.com>
 <250701d01841$3bd6fb30$b384f190$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <250701d01841$3bd6fb30$b384f190$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Mon, Dec 15, 2014 at 08:29:24AM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 15/12/14 00:20, Alexander Aring wrote:
> >This patch removes an unnecessary if branch inside the tx complete
> >handler.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  drivers/net/ieee802154/at86rf230.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> >diff --git a/drivers/net/ieee802154/at86rf230.c
> >b/drivers/net/ieee802154/at86rf230.c
> >index 1c01356..4e983b3 100644
> >--- a/drivers/net/ieee802154/at86rf230.c
> >+++ b/drivers/net/ieee802154/at86rf230.c
> >@@ -715,10 +715,7 @@ at86rf230_tx_complete(void *context)
> >
> >  	enable_irq(lp->spi->irq);
> >
> >-	if (lp->max_frame_retries <= 0)
> >-		ieee802154_xmit_complete(lp->hw, skb, true);
> >-	else
> >-		ieee802154_xmit_complete(lp->hw, skb, false);
> >+	ieee802154_xmit_complete(lp->hw, skb, lp->max_frame_retries <= 0);
> >  }
> 
> It surely saves us some lines but personally I find it harder to read this
> way. Having the condition inside the function call breaks the reading flow
> for me. Is this the preferred coding style in the kernel?
> 

I agree this is more readable, maybe this is because I wrote this at
first time in this way.

But that reminds me to doing something like this:

if (bool)
	return true;
else
	return false;

instead:

return bool;

which is usually some beginners failure. I don't know if the kernel
conding style really discuss about that. The checkpatch script doesn't
report anything about this.


Maybe we can put something on the stack like:

bool ifs_handling = lp->max_frame_retries <= 0;

...

ieee802154_xmit_complete(lp->hw, skb, ifs_handling);

is that more readable?

- Alex
