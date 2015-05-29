Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38515 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbbE2TSg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 15:18:36 -0400
Received: by igbjd9 with SMTP id jd9so21989820igb.1
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 12:18:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150513173605.GA820@omega>
References: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com>
	<20150513164633.10c4d992@ws-entwicklun-18.phytec>
	<20150513173605.GA820@omega>
Date: Fri, 29 May 2015 21:18:35 +0200
Message-ID: <CAOoq=dQ1knk2wJ-r1szPzcBktJpyuuqh3Dv+DEK+teiT1Fc5Zw@mail.gmail.com>
Subject: Re: cc2520 issue
From: Karol Poczesny <kpoczesny@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, varkabhadram@gmail.com
Cc: Johann Fischer <johann_fischer@posteo.de>, linux-wpan@vger.kernel.org

Hello all.

Finally I have found the bug.
It was my hardware. Pin with fifo signal was unconnected. Sorry for the mess.
After quick fix with my soldering machine it runs.
Now I'm able to ping RPI with at86rf230 even without Alex's fix.

Yes Johann. I use 2450BM15B0002 Balun. But now, after few tests it works fine.
You can check the sequence of events (in debug mode via dmesg ) for
those problematic modules.
Make sure that SFD and FIFOP interrupts are received.

By the way. Maybe this is question for Varka.
Why workqueue mechanism used to invoke cc2520_fifop_irqwork [0]?
As far as I understand we can invoke this function straight from
cc2520_fifop_isr.
I just wander, what are the advantages of this solution ?

Karol

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/cc2520.c#L693
