Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36429 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbbGUGw7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Jul 2015 02:52:59 -0400
Received: by qgy5 with SMTP id 5so83572286qgy.3
        for <linux-wpan@vger.kernel.org>; Mon, 20 Jul 2015 23:52:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150715174830.GA2288@omega>
References: <CAPpUg6Nyo1C9HDWqOOK-=ziP3sKECnWL=QX5vXLjYDu=Lc=ySQ@mail.gmail.com>
	<20150713174807.GA3056@omega>
	<CAPpUg6PO=E8pgxtuV+Z0Khq44XZ73D7968X35BCvca43DZkrsQ@mail.gmail.com>
	<CAPpUg6OQLD=4Kc-zz+dv5PCkPyWJ5hed22i_1CP7Gcoxy3vjuQ@mail.gmail.com>
	<20150714181114.GA3113@omega>
	<CAPpUg6NgesUxPYqSMkGm1O3suKdw7br6eCNfWAVwrVzE1HVXdA@mail.gmail.com>
	<CAPpUg6Odxw1F6+3frQibxtORaUic0M1F_9rGdY6RWZK1uaM17Q@mail.gmail.com>
	<20150715071214.GA5680@omega>
	<20150715071339.GB5680@omega>
	<CAPpUg6MmQ2KJe1XJmkv+q0L-+pQkbmh1NdBvpNY6nH=KTKXQRQ@mail.gmail.com>
	<20150715174830.GA2288@omega>
Date: Tue, 21 Jul 2015 08:52:58 +0200
Message-ID: <CAPpUg6NrQZ76Sgy8_HqpGE8sxVy=zwhqL4HyB-WaKU9f6B9uOQ@mail.gmail.com>
Subject: Re: ping6 -> lowpan0 -> wpan0. Ping6 doesn't succeed to send messages
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Le 15 juil. 2015 19:48, "Alexander Aring" <alex.aring@gmail.com> a écrit :
>
> On Wed, Jul 15, 2015 at 04:34:09PM +0200, Baptiste Clenet wrote:
> > 2015-07-15 9:13 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> > > Hi,
> > >
> > > adding missed cc.
> > >
> > > On Wed, Jul 15, 2015 at 09:12:14AM +0200, Alexander Aring wrote:
> > >> On Tue, Jul 14, 2015 at 11:22:32PM +0200, Baptiste Clenet wrote:
> > >> ...
> > >> >
> > >> > Kind of a backtrace (printk at each beginning of a function)
> > >> > root@OpenWrt:/# ip link set lowpan0 up
> > >> > [  214.708111] lowpan_header_create
> > >> > [  214.714520] lowpan_xmit
> > >> > [  214.719378] lowpan_header
> > >> > [  214.724569] tx.c dev_queue_xmit
> > >> > [  214.730795] at86rf230_xmit_start
> > >> > [  214.737669] at86rf230_write_frame
> > >> > [  214.745539] at86rf230_write_frame_complete
> > >> > [  214.828082] lowpan_header_create
> > >> > [  214.834484] lowpan_xmit
> > >> > [  214.839334] lowpan_header
> > >> > [  214.844523] tx.c dev_queue_xmit
> > >> > [  215.368119] lowpan_header_create
> > >> > [  215.374529] lowpan_xmit
> > >> > [  215.379398] lowpan_header
> > >> > [  215.384589] tx.c dev_queue_xmit
> > >> > [  216.368196] lowpan_header_create
> > >> > [  216.374604] lowpan_xmit
> > >> > [  216.379468] lowpan_header
> > >> > [  216.384658] tx.c dev_queue_xmit
> > >> > [  216.390934] lowpan_header_create
> > >> > [  216.397319] lowpan_xmit
> > >> > [  216.402168] lowpan_header
> > >> > [  216.407351] tx.c dev_queue_xmit
> > >> > [  216.898090] lowpan_header_create
> > >> >
> > >> >     [  216.904496] lowpan_xmit
> > >> >
> > >> >                  [  216.909350] lowpan_header
> > >> > [  216.914539] tx.c dev_queue_xmit
> > >> > [  216.978063] lowpan_header_create
> > >> > [  216.984464] lowpan_xmit
> > >> > [  216.989312] lowpan_header
> > >> > [  216.994498] tx.c dev_queue_xmit
> > >> >
> > >> > You see that at86rf230_xmit_start is called only once so I seems
> > >> > logical that while doing a ping6, it's not called as well.
> > >>
> > >> I maybe know what happens here.
> > >>
> > >> You transmit only one frame at beginning, this occurs that the netdev
> > >> queue will be stopped -> The driver layer doesn't get new "send a frame",
> > >> the xmit callback.
> > >>
> > >> This happens once, then the queue is stopped on the "tx completion
> > >> interrupt" we awake the queue again. -> The driver layer can send a
> > >> frame again.
> > >>
> > >> It seems for me that you don't get any irq, instrument please the function:
> > >>
> > >> at86rf230_isr
> > No call for isr but most of all, no irq on the irq line. polarity set
> > to 0 (reg 0x04), TRX enable (reg 0x0E)
> > This is definitely the problem
> >
>
> "no irq on the irq line" -> this means you check the irq line on the
> at86rf212 and it's not high?

Yes indeed, I solved that first problem.

If not can you please check that with some
> multimeter.
>
> > >>
> > >> and check
> > >>
> > >> cat /proc/interrupts
> > Yes the spi int is defined
> >  23:          0      INTC  15  spi32765.0
> > Why 23 on the left and 15 ont the right?
> >
>
> 23 is definitely the irqnum, the 15 is some system internal number of
> your arm soc. Maybe 15 is GPIO15, does this makes any sense? :-)

Yes it makes sense, I'm looking at how are defined the irq in my dts.
Which file should take of setting the irq ? Gpio driver of each board
?  Or is there another driver for irq ?  Because in gpio-mt7621, I
can't see any write in the registers for handling IRQ...

>
> I have there (beaglebone):
>
> 141:      77445  481ae000.gpio  19 Level     spi1.0
>
> (RPi):
>
> 111:        129  pinctrl-bcm2835  23 Level     spi32766.0
>
> When the above test results into "the irq line is high and the system
> doesn't do anything at the at86rf230_isr function" then something is
> wrong with your interrupt setup in your device tree file and I can't
> help you there.

Yep I know :-\
I'm going to look a bit more a those drivers and see how they set IRQs

>
> - Alex
