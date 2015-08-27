Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35584 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbH0KN1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 06:13:27 -0400
Received: by wicne3 with SMTP id ne3so69832616wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 03:13:25 -0700 (PDT)
Date: Thu, 27 Aug 2015 12:13:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 1/2] at86rf230: change trac status check
 behaviour
Message-ID: <20150827101318.GA2609@omega>
References: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
 <1438874501-19971-2-git-send-email-alex.aring@gmail.com>
 <55DEDEDB.1010302@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55DEDEDB.1010302@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, Aug 27, 2015 at 11:56:43AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 06/08/15 17:21, Alexander Aring wrote:
> >When transmit is done, indicated by trx_end irq, we do first a force
> >state change to TX_ON and then checking the trac status, if the trac
> >status is unequal zero we do a state change to TRX_OFF.
> >
> >This patch changes to the following behaviour, we first check on trac
> >status after trx_end occurs and then doing a normal change to TX_ON
> >without do the state change to TRX_OFF when trac status is unequal zero.
> >
> >The reasons are that the datasheet doesn't described when the trac
> >status register is cleared, we should doing to evaluate the trac status
> >at first. The reason to remove the TRX_OFF change if the trac status is
> >unequal to zero and it was force is the following paragraph inside The
> >at86rf2xx datasheets:
> >
> >"Using FORCE_PLL_ON to interrupt an TX_ARET transaction, it is
> >  recommended to check register bits [7:5] of register address 0x32 for
> >  value 0. If this value is different, TRX_CMD sequence FORCE_TRX_OFF shall
> >  be used immediately followed by TRX_CMD sequence PLL_ON. This performs a
> >  state transition to PLL_ON."
> I had a hard time finding a register description of 0x32 in my copies. Are
> they outdated or am I just blind? Any hints appreciated. :)
> 

I think this is a mistake in the datasheet, they mean the "TRAC_STATUS"
here, which is the only value which fits in the range of [7:5] in
Register 0x02.

Nevertheless this handling is for interrupt the TX_ARET transaction,
then maybe this would be more fit if we do a that on the only once
FORCE_TX_ON change, this is at [0] when the maximum of "trying to change
into TX_ON is reached".

This case is very unlikely I would simple move always to FORCE_TRX_OFF
when interrupt any TX_*ON state. From TRX_OFF you can reach
RX_AACK_ON/TX_*ON states on all at86rf2xx(except 230 which we don't
support) transceivers

- Alex

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L558
