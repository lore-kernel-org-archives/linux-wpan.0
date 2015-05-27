Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54124 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbbE0KES (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 May 2015 06:04:18 -0400
Message-ID: <5565969E.8060000@osg.samsung.com>
Date: Wed, 27 May 2015 12:04:14 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [RFC ben-wpan] atusb: fw: add support for rzusbstick
References: <1432471058-2920-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432471058-2920-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Werner Almesberger <werner@almesberger.net>

Hello.

On 24/05/15 14:37, Alexander Aring wrote:
> This patch adds support for the rzusbstick for the atusb firmware.
> More detailed information about this usb stick:
>
> http://www.atmel.com/tools/rzusbstick.aspx
Thanks a lot for working on this. Given that it is still available and 
the price is good it can help people to play around with ieee802154 a 
bit more.

> Original I have the rzraven kit:
>
> http://www.atmel.com/tools/rzraven.aspx
>
> Which comes with a special cable and avr dragon programmer. You need
> some programmer and wires to the programmers pins. To lookup how to
> connect the programmer to the rzusbstick pinout, see:
>
> http://www.atmel.com/Images/doc8117.pdf
>
> page 22 (schematics of the rzusbstick).
>
> Difference between atusb and rzusbstick(rzusb) is mainly the at86rf231
> vs at86rf230 one. The rzusb contains the at86rf230 which is a little bit
> hard to deal with it (and has a huge errata inside the datasheet).
> Nevertheless with small schanges the atusb firmware can run now on the
> rzusb. The rzusb contains also a bigger mcu, so we can maybe cache more
> pdus for receive handling.
>
> To compile the rzusb firmware call:
> make NAME=rzusb
>
> this will generate the rzusb.bin
>
> then call the programmer (in my case avrdude):
> avrdude -P usb -c dragon_jtag -p usb1287 -U flash:w:rzusb.bin

Is there any chance we can get the DFU part of the atusb firmware also 
running on the rzusb? Sure, it would only work after the initial loading 
but updating would be more convenient without the need of a dedicated 
programmer cable. Nothing of priority, just thinking out loud here.


> NOTE: currently there is no chance (I suppose) to ensure that the atusb
> receive the correct firmware, so don't try to flash the atusb with the
> rzusb firmware! Also the vendor and product id is the same.
Actually there is some logic inside dfu-util which could handle this. 
Firmware wise we don't check as far as I know.

With the 0.2 atusb release I added the DFU suffix which has the vendor 
and product id coded inside the suffix of the firmware to validate if we 
flash to the correct device and abort if not.

This obviously clashes with re-using same vendor and product ID for 
rzusb. Something we should avoid anyway as they are two different 
devices. It should be no problem to get another product id for rzusb 
(vendor stay same as atusb). Werner should know how the "USB registry" 
of Qi hardware works. Most likely a simple text file or wiki page.

That way we get a new product id for the firmware image build for rzusb 
and are able to verify the flashing with DFU. Adding the new product id 
to the driver table in the atusb driver is easy enough. What so you think?


> This currently a RFC, it's a quick hack and I think we should update
> more the documentation to support the rzusb.

General comment as Werner already stated. Less ifdef's :)

Try to factor out the parts which are different and have different init 
calls for example. Some ifdef's will always stay but reducing them would 
already help.

regards
Stefan Schmidt

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@osg.samsung.com>
> Cc: Werner Almesberger <werner@almesberger.net>
> ---
>   atusb/fw/Makefile    |  6 ++++++
>   atusb/fw/atusb.c     |  2 ++
>   atusb/fw/board.c     | 24 +++++++++++++++++++++---
>   atusb/fw/board.h     | 30 +++++++++++++++++++++++++++++-
>   atusb/fw/board_app.c | 18 ++++++++++++++++--
>   atusb/fw/mac.c       | 34 +++++++++++++++++++++++++---------
>   atusb/fw/spi.c       | 29 ++++++++++++++++++++---------
>   atusb/fw/usb/atu2.c  | 15 +++++++++++++++
>   8 files changed, 134 insertions(+), 24 deletions(-)
>
> diff --git a/atusb/fw/Makefile b/atusb/fw/Makefile
> index fb7d9a4..4153859 100644
> --- a/atusb/fw/Makefile
> +++ b/atusb/fw/Makefile
> @@ -18,7 +18,13 @@ CFLAGS = -g -mmcu=$(CHIP) -DBOOT_ADDR=$(BOOT_ADDR) \
>   	 -Wall -Wextra -Wshadow -Werror -Wno-unused-parameter \
>   	 -Wmissing-prototypes -Wmissing-declarations -Wstrict-prototypes
>   
> +ifeq ($(NAME),rzusb)
> +CHIP=at90usb1287
> +CFLAGS += -DRZUSB
> +else
>   CHIP=atmega32u2
> +CFLAGS += -DATUSB
> +endif
>   HOST=jlime
>   BOOT_ADDR=0x7000
>   
> diff --git a/atusb/fw/atusb.c b/atusb/fw/atusb.c
> index f526844..1f65d53 100644
> --- a/atusb/fw/atusb.c
> +++ b/atusb/fw/atusb.c
> @@ -37,11 +37,13 @@ int main(void)
>   
>   	usb_init();
>   	ep0_init();
> +#ifdef ATUSB
>   	timer_init();
>   
>   	/* move interrupt vectors to 0 */
>   	MCUCR = 1 << IVCE;
>   	MCUCR = 0;
> +#endif
>   
>   	sei();
>   
> diff --git a/atusb/fw/board.c b/atusb/fw/board.c
> index dc507e3..b141e70 100644
> --- a/atusb/fw/board.c
> +++ b/atusb/fw/board.c
> @@ -41,11 +41,24 @@ static void set_clkm(void)
>   	 * clock. The clock switching procedure is described in the ATmega32U2
>   	 * data sheet in secton 8.2.2.
>   	 */
> -
> +#ifdef ATUSB
>   	spi_begin();
>   	spi_send(AT86RF230_REG_WRITE | REG_TRX_CTRL_0);
>   	spi_send(CLKM_CTRL_8MHz);
>   	spi_end();
> +#endif
> +#ifdef RZUSB
> +	spi_begin();
> +	spi_send(AT86RF230_REG_WRITE | REG_TRX_CTRL_0);
> +	spi_send(0x10);
> +	spi_end();
> +
> +	/* TX_AUTO_CRC_ON, default disabled */
> +	spi_begin();
> +	spi_send(AT86RF230_REG_WRITE | 0x05);
> +	spi_send(0x80);
> +	spi_end();
> +#endif
>   }
>   
>   
> @@ -131,10 +144,15 @@ void board_init(void)
>   	WDTCSR = 1 << WDCE;	/* Disable watchdog while still enabling
>   				   change */
>   
> -	/* We start with a 1 MHz/8 clock. Disable the prescaler. */
> -
>   	CLKPR = 1 << CLKPCE;
> +#ifdef ATUSB
> +	/* We start with a 1 MHz/8 clock. Disable the prescaler. */
>   	CLKPR = 0;
> +#endif
> +#ifdef RZUSB
> +	/* We start with a 16 MHz/8 clock. Put the prescaler to 2. */
> +	CLKPR = 1 << CLKPS0;
> +#endif
>   
>   	get_sernum();
>   }
> diff --git a/atusb/fw/board.h b/atusb/fw/board.h
> index 89e9eed..72fe89c 100644
> --- a/atusb/fw/board.h
> +++ b/atusb/fw/board.h
> @@ -18,7 +18,7 @@
>   
>   #include <atusb/atusb.h>
>   
> -
> +#ifdef ATUSB
>   #define	LED_PORT	B
>   #define	LED_BIT		  6
>   #define	nRST_RF_PORT	C
> @@ -38,6 +38,34 @@
>   #define	IRQ_RF_PORT	D
>   #define	IRQ_RF_BIT	  0
>   
> +#define SPI_WAIT_DONE()	while (!(UCSR1A & 1 << RXC1))
> +#define SPI_DATA	UDR1
> +
> +#endif
> +#ifdef RZUSB
> +#define	LED_PORT	D
> +#define	LED_BIT		  7
> +#define	nRST_RF_PORT	B
> +#define	nRST_RF_BIT	  5
> +#define	SLP_TR_PORT	B
> +#define	SLP_TR_BIT	  4
> +
> +#define SCLK_PORT	B
> +#define SCLK_BIT	  1
> +#define	MOSI_PORT	B
> +#define	MOSI_BIT	  2
> +
> +#define	MISO_PORT	B
> +#define	MISO_BIT	  3
> +#define	nSS_PORT	B
> +#define	nSS_BIT		  0
> +#define	IRQ_RF_PORT	D
> +#define	IRQ_RF_BIT	  4
> +
> +#define SPI_WAIT_DONE()	while ((SPSR & (1 << SPIF)) == 0)
> +#define SPI_DATA	SPDR
> +
> +#endif
>   
>   #define	SET_2(p, b)	PORT##p |= 1 << (b)
>   #define	CLR_2(p, b)	PORT##p &= ~(1 << (b))
> diff --git a/atusb/fw/board_app.c b/atusb/fw/board_app.c
> index a83b6c8..22bae19 100644
> --- a/atusb/fw/board_app.c
> +++ b/atusb/fw/board_app.c
> @@ -154,8 +154,12 @@ static void done(void *user)
>   
>   uint8_t irq_serial;
>   
> -
> +#ifdef ATUSB
>   ISR(INT0_vect)
> +#endif
> +#ifdef RZUSB
> +ISR(TIMER1_CAPT_vect)
> +#endif
>   {
>   	if (mac_irq) {
>   		if (mac_irq())
> @@ -168,10 +172,20 @@ ISR(INT0_vect)
>   	}
>   }
>   
> -
> +#ifdef ATUSB
>   void board_app_init(void)
>   {
>   	/* enable INT0, trigger on rising edge */
>   	EICRA = 1 << ISC01 | 1 << ISC00;
>   	EIMSK = 1 << 0;
>   }
> +#endif
> +#ifdef RZUSB
> +void board_app_init(void)
> +{
> +	/* enable timer input capture 1, trigger on rising edge */
> +	TCCR1B = (1 << ICES1);
> +	TIFR1 = (1 << ICF1);
> +	TIMSK1 = (1 << ICIE1);
> +}
> +#endif
> diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
> index 08ed00a..f2f278d 100644
> --- a/atusb/fw/mac.c
> +++ b/atusb/fw/mac.c
> @@ -21,7 +21,6 @@
>   #include "board.h"
>   #include "mac.h"
>   
> -
>   #define	RX_BUFS	3
>   
>   
> @@ -102,12 +101,22 @@ static void tx_ack_done(void *user)
>   	usb_next();
>   }
>   
> +static void change_state(uint8_t new)
> +{
> +	while ((reg_read(REG_TRX_STATUS) & TRX_STATUS_MASK) ==
> +	    TRX_STATUS_TRANSITION);
> +	reg_write(REG_TRX_STATE, new);
> +}
>   
>   static void rx_done(void *user)
>   {
>   	led(0);
>   	next_buf(&rx_out);
>   	usb_next();
> +#ifdef RZUSB
> +	/* slap at86rf230 - reduce fragmentation issue */
> +	change_state(TRX_STATUS_RX_AACK_ON);
> +#endif
>   }
>   
>   
> @@ -117,10 +126,16 @@ static void receive_frame(void)
>   	uint8_t *buf;
>   
>   	spi_begin();
> +#ifdef ATUSB
>   	if (!(spi_io(AT86RF230_BUF_READ) & RX_CRC_VALID)) {
>   		spi_end();
>   		return;
>   	}
> +#endif
> +#ifdef RZUSB
> +	spi_io(AT86RF230_BUF_READ);
> +#endif
> +
>   	size = spi_recv();
>   	if (!size || (size & 0x80)) {
>   		spi_end();
> @@ -169,14 +184,6 @@ static bool handle_irq(void)
>   /* ----- TX/RX ------------------------------------------------------------- */
>   
>   
> -static void change_state(uint8_t new)
> -{
> -	while ((reg_read(REG_TRX_STATUS) & TRX_STATUS_MASK) ==
> -	    TRX_STATUS_TRANSITION);
> -	reg_write(REG_TRX_STATE, new);
> -}
> -
> -
>   bool mac_rx(int on)
>   {
>   	if (on) {
> @@ -209,12 +216,21 @@ static void do_tx(void *user)
>   	}
>   	while (status != TRX_STATUS_RX_ON && status != TRX_STATUS_RX_AACK_ON);
>   
> +#ifdef ATUSB
>   	/*
>   	 * We use TRX_CMD_FORCE_PLL_ON instead of TRX_CMD_PLL_ON because a new
>   	 * reception may have begun while we were still working on the previous
>   	 * one.
>   	 */
>   	reg_write(REG_TRX_STATE, TRX_CMD_FORCE_PLL_ON);
> +#endif
> +#ifdef RZUSB
> +	/*
> +	 * at86rf230 doesn't support force change, nevetherless this works
> +	 * somehow
> +	 */
> +	reg_write(REG_TRX_STATE, TRX_CMD_PLL_ON);
> +#endif
>   
>   	handle_irq();
>   
> diff --git a/atusb/fw/spi.c b/atusb/fw/spi.c
> index ded5673..d159728 100644
> --- a/atusb/fw/spi.c
> +++ b/atusb/fw/spi.c
> @@ -34,9 +34,9 @@ void spi_begin(void)
>   uint8_t spi_io(uint8_t v)
>   {
>   //      while (!(UCSR1A & 1 << UDRE1));
> -        UDR1 = v;
> -        while (!(UCSR1A & 1 << RXC1));
> -        return UDR1;
> +	SPI_DATA = v;
> +	SPI_WAIT_DONE();
> +        return SPDR;
>   }
>   
>   
> @@ -51,21 +51,26 @@ void spi_recv_block(uint8_t *buf, uint8_t n)
>   {
>   	if (!n)
>   		return;
> -        UDR1 = 0;
> +	SPI_DATA = 0;
>   	while (--n) {
> -		while (!(UCSR1A & 1 << RXC1));
> -		*buf++ = UDR1;
> -		UDR1 = 0;
> +		SPI_WAIT_DONE();
> +		*buf++ = SPI_DATA;
> +		SPI_DATA = 0;
>   	}
> -	while (!(UCSR1A & 1 << RXC1));
> -	*buf++ = UDR1;
> +	SPI_WAIT_DONE();
> +	*buf++ = SPI_DATA;
>   }
>   
>   
>   void spi_off(void)
>   {
>   	spi_initialized = 0;
> +#ifdef ATUSB
>   	UCSR1B = 0;
> +#endif
> +#ifdef RZUSB
> +	SPCR &= ~(1 << SPE);
> +#endif
>   }
>   
>   
> @@ -77,12 +82,18 @@ void spi_init(void)
>   	OUT(nSS);
>   	IN(MISO);
>   
> +#ifdef ATUSB
>   	UBRR1 = 0;	/* set bit rate to zero to begin */
>   	UCSR1C = 1 << UMSEL11 | 1 << UMSEL10;
>   			/* set MSPI, MSB first, SPI data mode 0 */
>   	UCSR1B = 1 << RXEN1 | 1 << TXEN1;
>   			/* enable receiver and transmitter */
>   	UBRR1 = 0;	/* reconfirm the bit rate */
> +#endif
> +#ifdef RZUSB
> +	SPCR = (1 << SPE) | (1 << MSTR);
> +	SPSR = (1 << SPI2X);
> +#endif
>   
>   	spi_initialized = 1;
>   }
> diff --git a/atusb/fw/usb/atu2.c b/atusb/fw/usb/atu2.c
> index e030bfa..bc1118b 100644
> --- a/atusb/fw/usb/atu2.c
> +++ b/atusb/fw/usb/atu2.c
> @@ -252,12 +252,27 @@ void usb_init(void)
>   	USBCON |= 1 << FRZCLK;		/* freeze the clock */
>   
>   	/* enable the PLL and wait for it to lock */
> +#ifdef ATUSB
>   	PLLCSR &= ~(1 << PLLP2 | 1 << PLLP1 | 1 << PLLP0);
> +#endif
> +#ifdef RZUSB
> +	/* TODO sheet page 50 For Atmel AT90USB128x only. Do not use with Atmel AT90USB64x. */
> +	/*  FOR 8 XTAL Mhz only!!! */
> +	PLLCSR = ((1 << PLLP1) | (1 << PLLP0));
> +#endif
>   	PLLCSR |= 1 << PLLE;
>   	while (!(PLLCSR & (1 << PLOCK)));
>   
> +#ifdef ATUSB
>   	USBCON &= ~(1 << USBE);		/* reset the controller */
>   	USBCON |= 1 << USBE;
> +#endif
> +#ifdef RZUSB
> +	UHWCON |= (1 << UVREGE);
> +
> +	USBCON &= ~((1 << USBE) | (1 << OTGPADE));		/* reset the controller */
> +	USBCON |= ((1 << USBE) | (1 << OTGPADE));
> +#endif
>   
>   	USBCON &= ~(1 << FRZCLK);	/* thaw the clock */
>   

