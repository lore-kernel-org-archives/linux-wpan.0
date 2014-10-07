Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59101 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaJGI4k (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:56:40 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so9051676wib.4
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:56:39 -0700 (PDT)
Date: Tue, 7 Oct 2014 10:56:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/9] at86rf230: correct aret lifs and sifs
 handling
Message-ID: <20141007085629.GA27930@omega>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
 <1412671113-26675-4-git-send-email-alex.aring@gmail.com>
 <5433A9A0.5090407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5433A9A0.5090407@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, m.olbrich@pengutronix.de

On Tue, Oct 07, 2014 at 02:21:44PM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> On 10/07/2014 02:08 PM, Alexander Aring wrote:
> 
> >This patch adds lifs/sifs handling only if max_frame_retries is above
> >zero. The at86rf2xx datasheets says nothing about phy lifs/sifs
> >handling. I asked the atmel support and they said lifs/sifs is done
> >by phy when max_frame_retries is above zero.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  drivers/net/ieee802154/at86rf230.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> >diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> >index 44d2f1d..2a25324 100644
> >--- a/drivers/net/ieee802154/at86rf230.c
> >+++ b/drivers/net/ieee802154/at86rf230.c
> >@@ -89,6 +89,7 @@ struct at86rf230_local {
> >  	struct at86rf230_state_change irq;
> >  	bool tx_aret;
> >+	s8 max_frame_retries;
> 
> Why s8 here..? Is there any reason..
> 

yep.

> >  	bool is_tx;
> >  	/* spinlock for is_tx protection */
> >  	spinlock_t lock;
> >@@ -1001,6 +1002,9 @@ at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
> >  		return -ETIMEDOUT;
> >  	}
> >+	if (lp->max_frame_retries > 0)
> >+		return 0;
> >+
> >  	/* Interfame spacing time, which is phy depend.
> >  	 * TODO
> >  	 * Move this handling in MAC 802.15.4 layer.
> >@@ -1230,6 +1234,7 @@ at86rf230_set_frame_retries(struct ieee802154_dev *dev, s8 retries)
> >  		return -EINVAL;
> >  	lp->tx_aret = retries >= 0;
> >+	lp->max_frame_retries = retries;

this parameter retries is s8. The value "-1" means no ARET handling here.

If you do now u8 at max_frame_retries, then we get a overflow by setting
"-1" here and have a invalid max_frame_retries setting of 255.

Then checking via:

if (lp->max_frame_retries > 0)

doesn't work.

- Alex
