Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33317 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbbGBQMu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Jul 2015 12:12:50 -0400
Received: by wiwl6 with SMTP id l6so201969076wiw.0
        for <linux-wpan@vger.kernel.org>; Thu, 02 Jul 2015 09:12:49 -0700 (PDT)
Date: Thu, 2 Jul 2015 18:12:43 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150702161239.GA1258@omega>
References: <CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
 <CAPpUg6NUwAGo402HgJkwcDTyT3HPBAAnSEW7V63zUyv5PHSJ8A@mail.gmail.com>
 <20150629220929.GB1165@omega>
 <CAPpUg6N5SAY3fOio7zGnsOPkYytgx5gRgfULO5=6Tz+fcN-9PA@mail.gmail.com>
 <20150701082130.GA1834@omega>
 <CAPpUg6P7ffx8yhcN7Oqjw6uK7-z1mBGNeHXJaBycbkbjYUSK=g@mail.gmail.com>
 <CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
 <CAPpUg6OiRu2XWb_xMXDVzuSLYP7=JeD1ULcksCh=WjprxxCbKA@mail.gmail.com>
 <20150701151653.GA969@omega>
 <CAPpUg6Obeifuy8eistOir7yjEkZOfbW8WEM8JTJ6v5LwY711EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6Obeifuy8eistOir7yjEkZOfbW8WEM8JTJ6v5LwY711EA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Thu, Jul 02, 2015 at 05:02:00PM +0200, Baptiste Clenet wrote:
> 2015-07-01 17:16 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> > Hi,
> >
> > On Wed, Jul 01, 2015 at 01:59:58PM +0200, Baptiste Clenet wrote:
> >> 2015-07-01 11:45 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> >> > 2015-07-01 11:22 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> >> >>
> >> >> 2015-07-01 10:21 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> >> >> > Hi,
> >> >> >
> >> >> > On Tue, Jun 30, 2015 at 11:12:36AM +0200, Baptiste Clenet wrote:
> >> >> > ....
> >> >> >>
> >> >> >> root@OpenWrt:/# dmesg | grep at86rf230
> >> >> >> [   94.820000] at86rf230 spi32766.1: Detected at86rf212 chip version 3
> >> >> >> [   94.830000] at86rf230 spi32766.1: unexcept state change from 0x00
> >> >> >> to 0x08. Actual state: 0x00
> >> >> >>
> >> >> >> It detects the chip but yes definitely, there is problem to read the state.
> >> >> >> Will check the pins
> >> >> >>
> >> >> >
> >> >> > if you have debugfs support and mounted it, then you could dump all
> >> >> > register settings by doing something similar like:
> >> >> >
> >> >> > cat /sys/kernel/debug/regmap/spi1.0/registers
> >> >> >
> >> >> > result would be some $REGISTER <-> $VALUE mapping.
> >> >> >
> >> >> > Note:
> >> >> >
> >> >> > One interface of the 802.15.4 phy should be up for this development method,
> >> >> > because the transceiver isn't in sleep mode then.
> >> >> >
> >> >> > - Alex
> >> >>
> >> >> The mapping:
> >> >>
> >> >> root@OpenWrt:/# cat /sys/kernel/debug/regmap/spi32766.1/registers
> >> >> 01: 16
> >
> > this looks good, because 01 is a volatile register. Means it can be
> > changed during runtime by the transceiver and regmap _always_ get the
> > current register values when we send a get request.
> >
> > And it looks good, because you don't reading zeros on this register.
> >
> >> >> 02: f6
> >> >> 03: 10
> >> >> 04: 20
> >> >> 05: 60
> >> >> 06: 80
> >> >> 07: 2c
> >> >> 08: 25
> >> >> 09: 77
> >> >> 0a: 17
> >> >> 0b: a7
> >> >> 0c: a4
> >> >> 0d: 01
> >> >> 0e: 08
> >> >> 10: 44
> >> >> 11: a2
> >> >> 12: f0
> >> >> 15: 00
> >> >> 17: 00
> >> >> 18: 50
> >> >> 1a: 47
> >> >> 1b: 54
> >> >> 1c: 07
> >> >> 1d: 03
> >> >> 1e: 1f
> >> >> 1f: 00
> >> >> 20: ff
> >> >> 21: ff
> >> >> 22: ef
> >> >> 23: be
> >> >> 24: 05
> >> >> 25: 45
> >> >> 26: 92
> >> >> 27: 92
> >> >> 28: 1e
> >> >> 29: 52
> >> >> 2a: e4
> >> >> 2b: d0
> >> >> 2c: 38
> >> >> 2d: 98
> >> >> 2e: 42
> >> >> 2f: 53
> >> >>
> >> >>
> >> >> --
> >> >> Baptiste
> >> >
> >> >
> >> >
> >> > I can set a different channel and see the difference in the regmap,
> >> > I'm definitely able to communicate with the transceiver.
> >
> > Don't trust change on registers which are not volatile. Regmap will do
> > some caching after the frist GET request of a register. If the value is
> > changed, regmap will not do a get request before again the first one.
> > The cached value will be used and then we do some bit magic on the
> > cached values and send a set register value command on the bus.
> >
> > This will reduce some traffic on the bus for configuration setting only,
> > which are done by regmap.
> >
> > When you want to look if the value for channel settings is really
> > changed, then simple add the "RG_PHY_CC_CCA" value to the volatile
> > function, see [1]. Otherwise the value is cached.
> >
> > btw:
> > For transmit/receive handling we use lowlevel spi_async calls on
> > registers which are volatile.
> >
> >> > I'm not sure about my interrupt pin definition in my dts. That might
> >> > be the problem.
> >> >
> >> > in palmbus
> >> >     spi
> >> >       at86rf212@0 {
> >> >           compatible = "atmel,at86rf212";
> >> >           reg = <1>;
> >> >           interrupt-parent = <&gpio0>;
> >> >           interrupts = <15 1>;
> >
> > Please use "interrupts = <15 4>;" here, 4 indicates high-level triggered
> > interrupt and I experience on some systems deadlocks (on newer driver
> > versions you will get a warning about that).
> >
> > The reason is that we need to protect some irq resources and we do a
> > disable_irq and enable_irq path. See [0]. On _some_ architectures while
> > edge-triggered while irq is disabled, the irq won't fire after
> > enable_irq. In other hand high-level triggered irq will fire after
> > enable_irq.
> >
> >> >           reset-gpio = <&gpio0 16 1>;
> >> >           sleep-gpio = <&gpio0 17 1>;
> >> >           spi-max-frequency = <1000000>;
> >
> > Maybe try there 4-5 Mhz?
> >
> >> >       };
> >> >
> >> >
> >> > and gpio
> >> > gpio@600 {
> >> >        #address-cells = <1>;
> >> >        #size-cells = <0>;
> >> >        interrupt-parent = <&intc>;
> >> >        interrupts = <6>;
> >> >
> >> >        compatible = "mtk,mt7628-gpio", "mtk,mt7621-gpio";
> >> >        reg = <0x600 0x100>;
> >> >
> >> >        gpio0: bank@0 {
> >> >             reg = <0>;
> >> >             ...
> >> >
> >> >
> >> > I define pin 15 as the interrupt pin here but how can I check it while
> >> > OpenWRT is running?
> >
> > I can only review the at86rf212 entry, don't know how to mux your pins
> > on your architecture correctly.
> >
> > You could try to make a "cat /proc/interrupts", this will show all
> > interrupts and check if the interrupt is increased, but the interrupt
> > should only increased by receiving and transmit complete.
> >
> > ...
> >>
> >> I'm wondering how regmap works. the at86rf230 write and read functions
> >> call regmap functions. I suppose regmap communicates with spi?
> >>
> >> Are values displayed by 'cat
> >> /sys/kernel/debug/regmap/spi32766.1/registers' read from the
> >> transceiver? (updated every time) or is it in the flash of my board
> >> and change one by one when it is required?
> >>
> >> When I change the channel, it obviously changes the regmap but how may
> >> I check that at86rf230 channel is really edited? (calling spi
> >> function)
> >>
> >
> > See my above comments about "how regmap works" there are registers which
> > are cached, but also some registers which can't be cached -> volatile
> > registers. For testing you could add the RG_PHY_CC_CCA register to the
> > volatile function.
> >
> > - Alex
> >
> > [0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L930
> > [1] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L422
> 
> Hi!
> 
> Thanks a lot Alex for the clarification! Regmap is clear for me now :-)
> I've looked at every single exchange over SPI for the AT86RF230, I
> better understand the functioning and how your driver initializes it.
> (I've worked ont the 212B on another platform)
> 

The transceiver is after reset inside the RESET state, look "Extended
Operation Mode" inside at86rf212 datasheet.

On probing for init the hw we going into TRX_OFF state.

> Everything seems fine apart from the "at86rf230 spi32766.1: unexcept
> state change from 0x00 to 0x08. Actual state: 0x00"
> 0x01 (RG_TRX_STATUS) is volatile so the value in regmap is up to date.
> When setting up the transceiver, it goes to TRX_OFF which is the
> default state after starting. Why is it unexpected?
> 

On probing we need to "wait until the state change is done" while
hw_init. This is why we introduced the SYNCED state_change function. It
blocks while it is done. See [0].

This synced mechanism is build above the async state change. It does:

1. wait_for_completion_timeout which completes until somebody called a
   "complete"
2. in the complete handler of at86rf230_async_state_change we call the
   complete -> this lets wait_for_completion_timeout unblock.

This is the big difference between the async and synced framework of
state change.

sync -> blocks until it's done.
async -> it does not block and have a complete handler.

In some context of linux, of course in hard/soft irqs. We can't call
synced operations because it will run some scheduling and blocks the
function. You don't want that, if you do that you will get some "BUG -
scheduling while atomic".

We have one callback "xmit_async" which is called in such context ->
soft irq. Or the isr routine -> hard irq.

I hope until now it's all correct what I tell you. I am also not 100%
sure of this, but this is my point of view.

> I don't really understand all the functions related to state change
> and async ... If you've got some time to explain me that and it will
> be maybe easier for me to debug this part and see why there is an
> unexpected change.
> 

For the state change calls we don't using the regmap framework, we using
the lowlevel spi_async calls. We use volatile registers there which are
not used by the regmap framework (except dumping the register values
over debugfs).

If regmap dumping works for you maybe then spi_async calls doesn't work
for you? We can't also use regmap for everything, we need to load the
data into the frame buffer and regmap is only for register settings, not
huge payload of data.


I don't know why you reading zeros only on your spi bus, I would check
if the chipselect is right when calling spi_async. Did you changed
something according the chipselect handling? Again, note when we change
the state we don't using at86rf230_write/read/_*reg functions, we use
lowlevel spi calls.

- Alex

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L749
