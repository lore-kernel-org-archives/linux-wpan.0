Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53090 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaLOIjo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:39:44 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so13937547wgg.1
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 00:39:43 -0800 (PST)
Date: Mon, 15 Dec 2014 09:39:41 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/5] at86rf230: make at86rf230_async_error
 inline
Message-ID: <20141215083938.GB7153@omega>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-3-git-send-email-alex.aring@gmail.com>
 <250801d01841$3d4a6150$b7df23f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <250801d01841$3d4a6150$b7df23f0$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Mon, Dec 15, 2014 at 08:29:26AM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 15/12/14 00:20, Alexander Aring wrote:
> >This patch makes the at86rf230_async_error inline. This function is
> >small enough to handle inline.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  drivers/net/ieee802154/at86rf230.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ieee802154/at86rf230.c
> >b/drivers/net/ieee802154/at86rf230.c
> >index 4e983b3..430d3bd 100644
> >--- a/drivers/net/ieee802154/at86rf230.c
> >+++ b/drivers/net/ieee802154/at86rf230.c
> >@@ -450,7 +450,7 @@ at86rf230_async_error_recover(void *context)
> >  	ieee802154_wake_queue(lp->hw);
> >  }
> >
> >-static void
> >+static inline void
> >  at86rf230_async_error(struct at86rf230_local *lp,
> >  		      struct at86rf230_state_change *ctx, int rc)
> >  {
> 
> Hopefully we would not need this error function often enough to have a real
> benefit for inline but with only two function calls it should be small
> enough anyway for inline.

With Werner Almesberger words "If this fails something goes really wrong
with your spi controller and you can only save that the kernel doesn't
run amok" or something like that.

I also heard that we don't need to check errors for the spi calls.

For now I don't know what happens if an error occurs here, I activate
the irq again (if disabled before) and try to run some TRX_OFF to
RX_AACK_ON recover, so we can receive some frames again.

But I think it depends on "error case" if this mechanism really helps.

Nevertheless, still better than doing nothing.

- Alex
