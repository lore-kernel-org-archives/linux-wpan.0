Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:49786 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeBRRgX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 18 Feb 2018 12:36:23 -0500
Date: Sun, 18 Feb 2018 18:36:22 +0100
From: anton@picapica.im
Subject: Re: issues with at86rf212b transceiver
Message-ID: <20180218173622.GA1991@picapica.im>
References: <20180217184113.GA7717@picapica.im>
 <CAB_54W7WdNDYgKN4gADN-bTRDoDz_TjYw2Bq8-=CLgF_CON-9w@mail.gmail.com>
 <20180218152128.GA31698@picapica.im>
 <CAB_54W74JZ55ehr1ZY2QZJD=k97jz_V=b8x0hhpb0ciYjd04tA@mail.gmail.com>
 <CAB_54W6YUYA8THF=QGxxQ0s1-9iagvAchs9KjQ+CjOhdYuQUmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB_54W6YUYA8THF=QGxxQ0s1-9iagvAchs9KjQ+CjOhdYuQUmg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

> >>
> >
> > This messages confused me, it should not happen unless you
> > reading/writing garbage on SPI bus.
> > We only use IRQ TRX_END and we are sure that we only receive these
> > IRQs by IRQ_MASK_MODE and IRQ_MASK.
> >
> > Check your wiring, make a lower spi clock (Maybe we should make the
> > clock at the devicetree documentation lower).
> >
> > But... this messages should not happen unless something is broken.
> >
> 
> You can try to read registers with debugfs and regmap entry... and
> look if the registers are the same as hw_init in the driver... if not
> something weird going on e.g. lossy connection, too high spi-clock,
> magnetic field, moon position, etc.
> 
> - Alex

Okay, seems like hardware issue, wiring and connectors on the devboard
are not high frequency friendly.

I tried to lower spi frequency from 7.5MHz to 4, then 2 and 1.
Most messages disappeared after switching to 4MHz,
but there were still these ones

at86rf230 spi32765.0: not supported irq 80 received
at86rf230 spi32765.0: not supported irq 00 received
at86rf230 spi32765.0: not supported irq 00 received

After switching to 1MHz I got only these ones, but 
many of them, probably one per packet or more

at86rf230 spi32765.0: not supported irq 00 received
at86rf230 spi32765.0: not supported irq 00 received
at86rf230 spi32765.0: not supported irq 00 received
at86rf230 spi32765.0: not supported irq 00 received

Now I am able to do wpan-ping and even ssh over IPv6
from one device to another. Thanks for your advices.

Now question is, what is the lowest possible spi frequency
still suitable for data transfers at 40kbps?

I also tried to change IRQ pin bias settings in device tree
from "bias-disable" to "bias-pull-down", I thought maybe there
are spurious interrupts triggered by interference, but it did not
help.



