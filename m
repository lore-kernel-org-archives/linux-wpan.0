Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36801 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdGGLAU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 7 Jul 2017 07:00:20 -0400
Received: by mail-wr0-f181.google.com with SMTP id c11so41703119wrc.3
        for <linux-wpan@vger.kernel.org>; Fri, 07 Jul 2017 04:00:19 -0700 (PDT)
Date: Fri, 7 Jul 2017 13:00:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Message-ID: <20170707110011.pwz272ppmwwu2wzh@omega>
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Jul 07, 2017 at 12:18:34PM +0200, Balz wrote:
> Dear IWPAN Team,
> 
> I’m not sure if you received my last mail because it get's declared as spam
> because of using HTML.
> Maybe there is a Problem with the Attachment (I’ve upload it to Dropbox).
> 

no, previous not. Now we received them.

> Original Mail:
> We (university of applied since Munich) are developing a multi-sensor
> Sniffer for IEEE 802.15.4 Networks, basted on your Linux-WPAN and the
> AT86RF233 Chip (with the REB233-XPRO).
> We connect the REB233-XPRO with a BeagleBone Black and implement the
> AT-REB233 chip as Network interface (via iwpan).
> The Beaglebone (BBB) is with at AT-REB233 via a 1Mhz SPI connected.
> 

I don't own this board, but I used openlabs board (rf233) with BeagleBone
already and with success. (without problems so far I noticed).

> The AT-REB is so configured, that after a frame has received it send a
> interrupt to the BBB with can then read out the Frame Buffer.
> The connection with the BeagleBone Works fine, but sometimes the network
> interface reads corrupted date.  That package starts normal but after +/- 6
> Byte the frame gets (at most) periodical byte sequence like (0xff 0 x30 0xf0
> 0x00 | 0xff 0 x30 0xf0 0x00 | ….).
> 

Can you provide dts entry? Maybe lower your spi clock but 1 Mhz should
be okay :-/ ... maybe it's actually too low, try to use 5-4 Mhz
(controller will round down the clock anyway) I expiered bad behaviours
with a low clock.

> We could evaluate, that the packages get corrupt after following situation:
> - AT-REB233 sends a first interrupt
> - The BBB ask what kind of interrupt it is and starts reading the
> Framebuffer
> - The AT-REB sends a second interrupt after about the sixed Byte of the
> Framebuffer. Since this second interrupt the content of the Frame Buffer is
> corrupt (detectable by the byte sequence).
> After the BBB has read the (corrupt) framebuffer it starts a new read
> (because of the second interrupt signalized that there are new data
> available), usually this is a ACK.
> Might it be possible that the AT-REB233 received a new Data-Frame and
> overwrite the current Framebuffer after receiving the new (ACK)Package ?
> The AT86RF233 does have a Framebuffer Protection (Section 9.3 in the
> Datasheet of the AT86RF233) (Dynamic Frame Buffer Reg 0x0C bit: 7 section
> 11.8 in the Datasheet) ore by setting PLL_ON in the TRX_STATE Register (Reg:
> 0x02 9.3.1)
> But I do not see such a configuration. May I have overseen it?
> 

We use them... See [0] and also the reason why we always read the _full_
frame buffer, because protection will lost after losing chip select when
start read frame command. [1]

> I have a PCAP package and a Logic dump attached. The logic dump could be
> analysed with the SALEAE Logic Tool(https://www.saleae.com/downloads )
> This errors could be seen e.g. at and sec. :
> - 10.099
> - 11.428
> - 11.433
> - 28.218
> I would be very grateful if you can help us with this problem.
>

If you see the error on the bus sounds like some framebuffer overwriting
issue sure... and lower/higher clock is unlikely that they fix your
issue..

I think I need more _important_ information:

- Kernel version (ti or mainline kernel?)

- cat /sys/kernel/debug/regmap/spi32766.0/registers

"spi32766.0" need to be changed to you spi controller name and mount
debugfs as well. Then you can check the current register settings on
your own as well.

- DTS entry section for AT86RF233 transceiver, you could change from
  level to edge triggered irqs (_maybe_? it will fix your issue, please
  provide if it fixed the issue then).

- You did the capture as monitor interface? (I think yes, otherwise you
  would not see ack frames)

- Alex

[0] http://elixir.free-electrons.com/linux/latest/source/drivers/net/ieee802154/at86rf230.c#L1404
[1] http://elixir.free-electrons.com/linux/latest/source/drivers/net/ieee802154/at86rf230.c#L759
