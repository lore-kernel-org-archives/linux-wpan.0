Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54087 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaLOItQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 03:49:16 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so14048089wgg.29
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 00:49:15 -0800 (PST)
Date: Mon, 15 Dec 2014 09:49:13 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/5] at86rf230: remove if branch
Message-ID: <20141215084912.GD7153@omega>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
 <1418599232-6267-2-git-send-email-alex.aring@gmail.com>
 <250701d01841$3bd6fb30$b384f190$@samsung.com>
 <20141215084538.GC7153@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141215084538.GC7153@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

I think, I found a better solution:

static void                                      
at86rf230_tx_complete(void *context)             
{                                                
        struct at86rf230_state_change *ctx = context;
        struct at86rf230_local *lp = ctx->lp;     
        struct sk_buff *skb = lp->tx_skb;         
                                                  
        enable_irq(lp->spi->irq);                 
                                                  
        ieee802154_xmit_complete(lp->hw, skb, !lp->tx_aret);
}

lifs handling is only _inactive_ in ARET mode.

I will change it do this solution.

- Alex
