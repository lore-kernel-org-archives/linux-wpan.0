Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34872 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbbE3K4o (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 30 May 2015 06:56:44 -0400
Received: by wgme6 with SMTP id e6so80480849wgm.2
        for <linux-wpan@vger.kernel.org>; Sat, 30 May 2015 03:56:43 -0700 (PDT)
Date: Sat, 30 May 2015 12:56:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: cc2520 issue
Message-ID: <20150530105639.GB4021@omega>
References: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com>
 <20150513164633.10c4d992@ws-entwicklun-18.phytec>
 <20150513173605.GA820@omega>
 <CAOoq=dQ1knk2wJ-r1szPzcBktJpyuuqh3Dv+DEK+teiT1Fc5Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOoq=dQ1knk2wJ-r1szPzcBktJpyuuqh3Dv+DEK+teiT1Fc5Zw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Karol Poczesny <kpoczesny@gmail.com>
Cc: varkabhadram@gmail.com, Johann Fischer <johann_fischer@posteo.de>, linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 09:18:35PM +0200, Karol Poczesny wrote:
> Hello all.
> 
> Finally I have found the bug.
> It was my hardware. Pin with fifo signal was unconnected. Sorry for the mess.
> After quick fix with my soldering machine it runs.
> Now I'm able to ping RPI with at86rf230 even without Alex's fix.
> 

my fix was just a shoot into the dark.

> Yes Johann. I use 2450BM15B0002 Balun. But now, after few tests it works fine.
> You can check the sequence of events (in debug mode via dmesg ) for
> those problematic modules.
> Make sure that SFD and FIFOP interrupts are received.
> 
> By the way. Maybe this is question for Varka.
> Why workqueue mechanism used to invoke cc2520_fifop_irqwork [0]?
> As far as I understand we can invoke this function straight from
> cc2520_fifop_isr.

At the moment you can't easily move it. Because cc2520_fifop_irqwork
will call cc2520_cmd_strobe which ends in a spi_sync call.

If you move it you would get a "BUG: scheduling while atomic..." notice.
This is because spi_sync, calls somewhere "wait_for_completion" which
waits until the spi messages is transmited and in this time spi_sync
will block. You can't do this in an interrupt context.

Alternative would be to use spi_async call, which do not wait and have
some complete handler to do the next operation when spi is finished. At
the moment with spi_async you could remove all the workqueues and also
use xmit_async callback instead spi_sync.

> I just wander, what are the advantages of this solution ?
> 

There are no advantages, the advantages would be to use spi_sync and
this is for some developers easilier to use. At the moment dealing with
workqueues will slow down the handling and you lost the context of
the called function like xmit_sync and xmit_async. In xmit_async context
you are inside the "ndo_do_xmit" callback of netdev_ops, in xmit_sync
you setup some workqueue and lost the context of "ndo_do_xmit". Simple
look here [0]. Then we queue it into a workqueue -> you will lost the
context of "ndo_do_xmit", I already tried to fix the context of this
callback while hold the rtnl lock while transmit, see [1]. But I don't
think that this will fix all the issues.

I would be very happy if we can remove the xmit_sync callback.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac802154/tx.c#L99
[1] http://lxr.free-electrons.com/source/net/mac802154/tx.c#L53
