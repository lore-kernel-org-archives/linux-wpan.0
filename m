Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38616 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbbGOHNn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 15 Jul 2015 03:13:43 -0400
Received: by wicmv11 with SMTP id mv11so32162021wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 15 Jul 2015 00:13:42 -0700 (PDT)
Date: Wed, 15 Jul 2015 09:13:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 -> lowpan0 -> wpan0. Ping6 doesn't succeed to send messages
Message-ID: <20150715071339.GB5680@omega>
References: <CAPpUg6NHtUaebTAgQjypqVndvTfpjU+bmnmrcSiTN60pkhJv+g@mail.gmail.com>
 <CAPpUg6Nyo1C9HDWqOOK-=ziP3sKECnWL=QX5vXLjYDu=Lc=ySQ@mail.gmail.com>
 <20150713174807.GA3056@omega>
 <CAPpUg6PO=E8pgxtuV+Z0Khq44XZ73D7968X35BCvca43DZkrsQ@mail.gmail.com>
 <CAPpUg6OQLD=4Kc-zz+dv5PCkPyWJ5hed22i_1CP7Gcoxy3vjuQ@mail.gmail.com>
 <20150714181114.GA3113@omega>
 <CAPpUg6NgesUxPYqSMkGm1O3suKdw7br6eCNfWAVwrVzE1HVXdA@mail.gmail.com>
 <CAPpUg6Odxw1F6+3frQibxtORaUic0M1F_9rGdY6RWZK1uaM17Q@mail.gmail.com>
 <20150715071214.GA5680@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150715071214.GA5680@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

adding missed cc.

On Wed, Jul 15, 2015 at 09:12:14AM +0200, Alexander Aring wrote:
> On Tue, Jul 14, 2015 at 11:22:32PM +0200, Baptiste Clenet wrote:
> ...
> > 
> > Kind of a backtrace (printk at each beginning of a function)
> > root@OpenWrt:/# ip link set lowpan0 up
> > [  214.708111] lowpan_header_create
> > [  214.714520] lowpan_xmit
> > [  214.719378] lowpan_header
> > [  214.724569] tx.c dev_queue_xmit
> > [  214.730795] at86rf230_xmit_start
> > [  214.737669] at86rf230_write_frame
> > [  214.745539] at86rf230_write_frame_complete
> > [  214.828082] lowpan_header_create
> > [  214.834484] lowpan_xmit
> > [  214.839334] lowpan_header
> > [  214.844523] tx.c dev_queue_xmit
> > [  215.368119] lowpan_header_create
> > [  215.374529] lowpan_xmit
> > [  215.379398] lowpan_header
> > [  215.384589] tx.c dev_queue_xmit
> > [  216.368196] lowpan_header_create
> > [  216.374604] lowpan_xmit
> > [  216.379468] lowpan_header
> > [  216.384658] tx.c dev_queue_xmit
> > [  216.390934] lowpan_header_create
> > [  216.397319] lowpan_xmit
> > [  216.402168] lowpan_header
> > [  216.407351] tx.c dev_queue_xmit
> > [  216.898090] lowpan_header_create
> > 
> >     [  216.904496] lowpan_xmit
> > 
> >                  [  216.909350] lowpan_header
> > [  216.914539] tx.c dev_queue_xmit
> > [  216.978063] lowpan_header_create
> > [  216.984464] lowpan_xmit
> > [  216.989312] lowpan_header
> > [  216.994498] tx.c dev_queue_xmit
> > 
> > You see that at86rf230_xmit_start is called only once so I seems
> > logical that while doing a ping6, it's not called as well.
> 
> I maybe know what happens here.
> 
> You transmit only one frame at beginning, this occurs that the netdev
> queue will be stopped -> The driver layer doesn't get new "send a frame",
> the xmit callback.
> 
> This happens once, then the queue is stopped on the "tx completion
> interrupt" we awake the queue again. -> The driver layer can send a
> frame again.
> 
> It seems for me that you don't get any irq, instrument please the function:
> 
> at86rf230_isr
> 
> and check
> 
> cat /proc/interrupts 
> 
> if you see that the at86rf230 driver gets any interrupt. If not check
> your irq settings.
> 
> - Alex
