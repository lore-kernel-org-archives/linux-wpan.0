Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36792 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaJ0M3n (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 08:29:43 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so1768282lbi.3
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 05:29:42 -0700 (PDT)
Date: Mon, 27 Oct 2014 13:29:35 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 04/16] mac802154: rx: warn if ieee80211_rx
 call from irq
Message-ID: <20141027122932.GA24691@omega>
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
 <1414410189-20092-5-git-send-email-alex.aring@gmail.com>
 <544E364E.5090702@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <544E364E.5090702@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Marc,

On Mon, Oct 27, 2014 at 01:10:54PM +0100, Marc Kleine-Budde wrote:
> On 10/27/2014 12:42 PM, Alexander Aring wrote:
> > This patch adds a warning if the ieee80211_rx function is called from an
> > irq context which should never happen.
> 
> do you mean hard and/or softirq here?
> 

Comment for in_softirq() is "in_softirq - Are we currently processing
softirq or have bh disabled?"

Then we checking is (softirq_count() == 0) if true then print warning.

in_softirq is declared as:

#define in_softirq()            (softirq_count())

So (softirq_count() == 0) is identically with (!in_softirq()).

Translating the "deMorgan law" to the above sentence:

We print a warning when we are not in a softirq context and have bh
enabled.

So we need to be in a softirq context or bh enabled.

> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  net/mac802154/rx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> > index 2851a3f..c4df321 100644
> > --- a/net/mac802154/rx.c
> > +++ b/net/mac802154/rx.c
> > @@ -61,6 +61,8 @@ fail:
> >  
> >  void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
> >  {
> > +	WARN_ON_ONCE(softirq_count() == 0);
> > +
> 
> better use in_irq() or in_softirq(), see:
> 
> http://lxr.free-electrons.com/source/include/linux/preempt_mask.h#L64
> 

Okay, maybe want to fix that also in:

http://lxr.free-electrons.com/source/net/mac80211/rx.c#L3347



btw. I will also fix in this patch s/80211/802154/ at several places. I
should do a grep before.

Are you sure we can use in_irq here? I would change it to:

WARN_ON_ONCE(!in_softirq());

- Alex
