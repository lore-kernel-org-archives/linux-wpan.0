Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37536 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbFANiU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 09:38:20 -0400
Received: by wifw1 with SMTP id w1so105626790wif.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 06:38:19 -0700 (PDT)
Date: Mon, 1 Jun 2015 15:38:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC ben-wpan] atusb: fw: add support for rzusbstick
Message-ID: <20150601133815.GB1195@omega>
References: <1432471058-2920-1-git-send-email-alex.aring@gmail.com>
 <5565969E.8060000@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5565969E.8060000@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Werner Almesberger <werner@almesberger.net>

Hi,

On Wed, May 27, 2015 at 12:04:14PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 24/05/15 14:37, Alexander Aring wrote:
> >This patch adds support for the rzusbstick for the atusb firmware.
> >More detailed information about this usb stick:
> >
> >http://www.atmel.com/tools/rzusbstick.aspx
> Thanks a lot for working on this. Given that it is still available and the
> price is good it can help people to play around with ieee802154 a bit more.
> 
> >Original I have the rzraven kit:
> >
> >http://www.atmel.com/tools/rzraven.aspx
> >
> >Which comes with a special cable and avr dragon programmer. You need
> >some programmer and wires to the programmers pins. To lookup how to
> >connect the programmer to the rzusbstick pinout, see:
> >
> >http://www.atmel.com/Images/doc8117.pdf
> >
> >page 22 (schematics of the rzusbstick).
> >
> >Difference between atusb and rzusbstick(rzusb) is mainly the at86rf231
> >vs at86rf230 one. The rzusb contains the at86rf230 which is a little bit
> >hard to deal with it (and has a huge errata inside the datasheet).
> >Nevertheless with small schanges the atusb firmware can run now on the
> >rzusb. The rzusb contains also a bigger mcu, so we can maybe cache more
> >pdus for receive handling.
> >
> >To compile the rzusb firmware call:
> >make NAME=rzusb
> >
> >this will generate the rzusb.bin
> >
> >then call the programmer (in my case avrdude):
> >avrdude -P usb -c dragon_jtag -p usb1287 -U flash:w:rzusb.bin
> 
> Is there any chance we can get the DFU part of the atusb firmware also
> running on the rzusb? Sure, it would only work after the initial loading but
> updating would be more convenient without the need of a dedicated programmer
> cable. Nothing of priority, just thinking out loud here.
> 

Using DFU is possible. On the avr device exists room for Bootloader and
Application code. I need to figure out how this space is set in the atusb.

This setting is done by a fuse setting (BOOTSZ bits), I really don't
like to set fuse bits when I do have one rzusb only. :-) Maybe I can get
some more from the same source where I get the current one.

But then I think running DFU in the bootloader section should be
possible, maybe without change if we can do exact bootloader space like
the atusb. Currently this is also why we don't moving the interrupt vectors
in case of rzusb build of atusb firmware.

> 
> >NOTE: currently there is no chance (I suppose) to ensure that the atusb
> >receive the correct firmware, so don't try to flash the atusb with the
> >rzusb firmware! Also the vendor and product id is the same.
> Actually there is some logic inside dfu-util which could handle this.
> Firmware wise we don't check as far as I know.
> 
> With the 0.2 atusb release I added the DFU suffix which has the vendor and
> product id coded inside the suffix of the firmware to validate if we flash
> to the correct device and abort if not.
> 
> This obviously clashes with re-using same vendor and product ID for rzusb.
> Something we should avoid anyway as they are two different devices. It
> should be no problem to get another product id for rzusb (vendor stay same
> as atusb). Werner should know how the "USB registry" of Qi hardware works.
> Most likely a simple text file or wiki page.
> 
> That way we get a new product id for the firmware image build for rzusb and
> are able to verify the flashing with DFU. Adding the new product id to the
> driver table in the atusb driver is easy enough. What so you think?
> 
> 
> >This currently a RFC, it's a quick hack and I think we should update
> >more the documentation to support the rzusb.
> 
> General comment as Werner already stated. Less ifdef's :)
> 
> Try to factor out the parts which are different and have different init
> calls for example. Some ifdef's will always stay but reducing them would
> already help.
> 
ok. I will clean it up. Then I would be happy if I can upload a
"experimental" firmware on wpan.cakelab.org.

> regards
> Stefan Schmidt
> 
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >Cc: Stefan Schmidt <stefan@osg.samsung.com>
> >Cc: Werner Almesberger <werner@almesberger.net>
> >---
> >  atusb/fw/Makefile    |  6 ++++++
> >  atusb/fw/atusb.c     |  2 ++
> >  atusb/fw/board.c     | 24 +++++++++++++++++++++---
> >  atusb/fw/board.h     | 30 +++++++++++++++++++++++++++++-
> >  atusb/fw/board_app.c | 18 ++++++++++++++++--
> >  atusb/fw/mac.c       | 34 +++++++++++++++++++++++++---------
> >  atusb/fw/spi.c       | 29 ++++++++++++++++++++---------
> >  atusb/fw/usb/atu2.c  | 15 +++++++++++++++
> >  8 files changed, 134 insertions(+), 24 deletions(-)
> >
> >diff --git a/atusb/fw/Makefile b/atusb/fw/Makefile
> >index fb7d9a4..4153859 100644
> >--- a/atusb/fw/Makefile
> >+++ b/atusb/fw/Makefile
> >@@ -18,7 +18,13 @@ CFLAGS = -g -mmcu=$(CHIP) -DBOOT_ADDR=$(BOOT_ADDR) \
> >  	 -Wall -Wextra -Wshadow -Werror -Wno-unused-parameter \
> >  	 -Wmissing-prototypes -Wmissing-declarations -Wstrict-prototypes
> >+ifeq ($(NAME),rzusb)
> >+CHIP=at90usb1287
> >+CFLAGS += -DRZUSB
> >+else
> >  CHIP=atmega32u2
> >+CFLAGS += -DATUSB
> >+endif
> >  HOST=jlime
> >  BOOT_ADDR=0x7000
> >diff --git a/atusb/fw/atusb.c b/atusb/fw/atusb.c
> >index f526844..1f65d53 100644
> >--- a/atusb/fw/atusb.c
> >+++ b/atusb/fw/atusb.c
> >@@ -37,11 +37,13 @@ int main(void)
> >  	usb_init();
> >  	ep0_init();
> >+#ifdef ATUSB
> >  	timer_init();

I don't know why this timer runs on atusb. This is maybe useful for
timing measures, but currently this increments a uint64_t inside some
timer isr. I don't think that is really necessary to have some system
clock. This will increase overhead when doing atusb main tasks.

> >  	/* move interrupt vectors to 0 */
> >  	MCUCR = 1 << IVCE;
> >  	MCUCR = 0;
> >+#endif
> >  	sei();
...
> >-
> >+#ifdef ATUSB
> >  	spi_begin();
> >  	spi_send(AT86RF230_REG_WRITE | REG_TRX_CTRL_0);
> >  	spi_send(CLKM_CTRL_8MHz);
> >  	spi_end();
> >+#endif
> >+#ifdef RZUSB
> >+	spi_begin();
> >+	spi_send(AT86RF230_REG_WRITE | REG_TRX_CTRL_0);
> >+	spi_send(0x10);
> >+	spi_end();
> >+

This produdes that the at86rf230 will do no clock at CLKM ping but I saw
in the rzusb schematic that this is connected to some clock source of
AT90USB128x. But it's also connected to an 8 Mhz osc. I don't know the
electrical things what they did there, but getting the clock from
at86rf230 it's much cleaner clock source I think.

I lookup the contiki code, so far I see, they disable the pin. I already
tried to run with a 8Mhz clock and there no much changes, both works.
:-)

> >+	/* TX_AUTO_CRC_ON, default disabled */
> >+	spi_begin();
> >+	spi_send(AT86RF230_REG_WRITE | 0x05);
> >+	spi_send(0x80);
> >+	spi_end();

I move this out of clkm setting, it's just a hack.

- Alex
