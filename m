Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:61390 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbdIAX2g (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 1 Sep 2017 19:28:36 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: [PATCH bluetooth-next 2/2] atusb/fw: Introduction of a new board named HULUSB
Date: Sat,  2 Sep 2017 01:28:22 +0200
Message-Id: <20170901232822.31901-3-j.filzmaier@gmx.at>
In-Reply-To: <20170901232822.31901-1-j.filzmaier@gmx.at>
References: <20170901232822.31901-1-j.filzmaier@gmx.at>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Josef Filzmaier <j.filzmaier@gmx.at>

The Busware HUL v1.1 dongle is a product very similar
to the rzusb dongle but with the at86rf212 instead of
the at86rf230 transceiver.

Some code refactoring has been made in order to better
support multiple hardware targets. This includes:

The reset_rf functions are now in the board specific files.
The led functions are now in the board specific files.
The register read/write functions are moved from mac.c to the generic
board.c file as they are used by functions like reset_rf that are
not within the mac.c file. Also the subreg_read and subreg_write
functions were introduced for convenience.
The function to change state is now also in board.c.

The hardware types are moved into the atusb.h file (which is always
synchrornized with the linux atusb driver) because they are now used
by the driver to identify and configure the hardware.

Within the makefile a new target name is specified called: hulusb

Signed-off-by: Josef Filzmaier <j.filzmaier@gmx.at>
---
 atusb/fw/Makefile              |   6 ++
 atusb/fw/board.c               |  68 ++++++++++------
 atusb/fw/board.h               |   9 +++
 atusb/fw/board_atusb.c         |  40 +++++++++
 atusb/fw/board_hulusb.c        | 179 +++++++++++++++++++++++++++++++++++++++++
 atusb/fw/board_hulusb.h        |  66 +++++++++++++++
 atusb/fw/board_rzusb.c         |  40 +++++++++
 atusb/fw/ep0.c                 |   8 +-
 atusb/fw/include/atusb/atusb.h |   8 ++
 atusb/fw/include/atusb/ep0.h   |   5 --
 atusb/fw/mac.c                 |  32 --------
 11 files changed, 397 insertions(+), 64 deletions(-)
 create mode 100644 atusb/fw/board_hulusb.c
 create mode 100644 atusb/fw/board_hulusb.h

diff --git a/atusb/fw/Makefile b/atusb/fw/Makefile
index 4cc749c..c79cb26 100644
--- a/atusb/fw/Makefile
+++ b/atusb/fw/Makefile
@@ -26,6 +26,9 @@ endif
 ifeq ($(NAME),rzusb)
 CHIP=at90usb1287
 CFLAGS += -DRZUSB -DAT86RF230
+else ifeq ($(NAME),hulusb)
+CHIP=at90usb1287
+CFLAGS += -DHULUSB -DAT86RF212
 else
 CHIP=atmega32u2
 CFLAGS += -DATUSB -DAT86RF231
@@ -58,6 +61,9 @@ endif
 ifeq ($(NAME),rzusb)
 OBJS += board_rzusb.o
 BOOT_OBJS += board_rzusb.o
+else ifeq ($(NAME),hulusb)
+OBJS += board_hulusb.o
+BOOT_OBJS += board_hulusb.o
 else
 OBJS += board_atusb.o
 BOOT_OBJS += board_atusb.o
diff --git a/atusb/fw/board.c b/atusb/fw/board.c
index 8567589..c3b8d26 100644
--- a/atusb/fw/board.c
+++ b/atusb/fw/board.c
@@ -29,45 +29,63 @@
 
 uint8_t board_sernum[42] = { 42, USB_DT_STRING };
 
-void reset_rf(void)
+/* ----- Register access --------------------------------------------------- */
+
+void change_state(uint8_t new)
 {
-	/* set up all the outputs; default port value is 0 */
+	while ((reg_read(REG_TRX_STATUS) & TRX_STATUS_MASK) ==
+		TRX_STATUS_TRANSITION);
+	reg_write(REG_TRX_STATE, new);
+}
 
-	DDRB = 0;
-	DDRC = 0;
-	DDRD = 0;
-	PORTB = 0;
-	PORTC = 0;
-	PORTD = 0;
 
-	OUT(LED);
-	OUT(nRST_RF);   /* this also resets the transceiver */
-	OUT(SLP_TR);
+uint8_t reg_read(uint8_t reg)
+{
+	uint8_t value;
 
-	spi_init();
+	spi_begin();
+	spi_send(AT86RF230_REG_READ | reg);
+	value = spi_recv();
+	spi_end();
 
-	/* AT86RF231 data sheet, 12.4.13, reset pulse width: 625 ns (min) */
+	return value;
+}
 
-	CLR(nRST_RF);
-	_delay_us(2);
-	SET(nRST_RF);
 
-	/* 12.4.14: SPI access latency after reset: 625 ns (min) */
+uint8_t subreg_read(uint8_t address, uint8_t mask, uint8_t position)
+{
+	/* Read current register value and mask out subregister. */
+	uint8_t register_value = reg_read(address);
+	register_value &= mask;
+	register_value >>= position; /* Align subregister value. */
 
-	_delay_us(2);
+	return register_value;
+}
 
-	/* we must restore TRX_CTRL_0 after each reset (9.6.4) */
 
-	set_clkm();
+void reg_write(uint8_t reg, uint8_t value)
+{
+	spi_begin();
+	spi_send(AT86RF230_REG_WRITE | reg);
+	spi_send(value);
+	spi_end();
 }
 
 
-void led(bool on)
+void subreg_write(uint8_t address, uint8_t mask, uint8_t position, uint8_t value)
 {
-	if (on)
-		SET(LED);
-	else
-		CLR(LED);
+	/* Read current register value and mask area outside the subregister. */
+	uint8_t register_value = reg_read(address);
+	register_value &= ~mask;
+
+	/* Start preparing the new subregister value. shift in place and mask. */
+	value <<= position;
+	value &= mask;
+
+	value |= register_value; /* Set the new subregister value. */
+
+	/* Write the modified register value. */
+	reg_write(address, value);
 }
 
 
diff --git a/atusb/fw/board.h b/atusb/fw/board.h
index 78a9065..dbcd410 100644
--- a/atusb/fw/board.h
+++ b/atusb/fw/board.h
@@ -24,6 +24,9 @@
 #ifdef RZUSB
 #include "board_rzusb.h"
 #endif
+#ifdef HULUSB
+#include "board_hulusb.h"
+#endif
 
 #define	SET_2(p, b)	PORT##p |= 1 << (b)
 #define	CLR_2(p, b)	PORT##p &= ~(1 << (b))
@@ -83,4 +86,10 @@ void get_sernum(void);
 
 void board_app_init(void);
 
+uint8_t reg_read(uint8_t reg);
+uint8_t subreg_read(uint8_t address, uint8_t mask, uint8_t position);
+void reg_write(uint8_t reg, uint8_t value);
+void subreg_write(uint8_t address, uint8_t mask, uint8_t position, uint8_t value);
+void change_state(uint8_t new);
+
 #endif /* !BOARD_H */
diff --git a/atusb/fw/board_atusb.c b/atusb/fw/board_atusb.c
index 518fe78..a02fb7f 100644
--- a/atusb/fw/board_atusb.c
+++ b/atusb/fw/board_atusb.c
@@ -29,6 +29,46 @@
 
 static bool spi_initialized = 0;
 
+void reset_rf(void)
+{
+	/* set up all the outputs; default port value is 0 */
+
+	DDRB = 0;
+	DDRC = 0;
+	DDRD = 0;
+	PORTB = 0;
+	PORTC = 0;
+	PORTD = 0;
+
+	OUT(LED);
+	OUT(nRST_RF);   /* this also resets the transceiver */
+	OUT(SLP_TR);
+
+	spi_init();
+
+	/* AT86RF231 data sheet, 12.4.13, reset pulse width: 625 ns (min) */
+
+	CLR(nRST_RF);
+	_delay_us(2);
+	SET(nRST_RF);
+
+	/* 12.4.14: SPI access latency after reset: 625 ns (min) */
+
+	_delay_us(2);
+
+	/* we must restore TRX_CTRL_0 after each reset (9.6.4) */
+
+	set_clkm();
+}
+
+void led(bool on)
+{
+	if (on)
+		SET(LED);
+	else
+		CLR(LED);
+}
+
 void set_clkm(void)
 {
 	/* switch CLKM to 8 MHz */
diff --git a/atusb/fw/board_hulusb.c b/atusb/fw/board_hulusb.c
new file mode 100644
index 0000000..084714e
--- /dev/null
+++ b/atusb/fw/board_hulusb.c
@@ -0,0 +1,179 @@
+/*
+ * fw/board_hulusb.c - Busware HUL Board-specific functions (for boot loader and application)
+ *
+ * Written 2017 by Filzmaier Josef
+ * Based on fw/board_rzusb written and Copyright 2016 Stefan Schmidt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <avr/io.h>
+#include <avr/interrupt.h>
+#include <avr/boot.h>
+
+#define F_CPU   8000000UL
+#include <util/delay.h>
+
+#include "usb.h"
+#include "at86rf230.h"
+#include "board.h"
+#include "spi.h"
+#include "usb/usb.h"
+
+static bool spi_initialized = 0;
+
+void reset_rf(void)
+{
+	/* set up all the outputs; default port value is 0 */
+
+	DDRB = 0;
+	DDRC = 0;
+	DDRD = 0;
+	PORTB = 0;
+	PORTC = 0;
+	PORTD = 0;
+
+	OUT(LED_RED);
+	OUT(LED_GREEN);
+	SET(LED_RED); /* Leds are active low on HULUSB board */
+	CLR(LED_GREEN); /* Green Led indicates the dongle is running */
+	OUT(nRST_RF);   /* this also resets the transceiver */
+	OUT(SLP_TR);
+
+	spi_init();
+
+	/* AT86RF212 data sheet, Appendix B, p166 Power-On Reset procedure */
+	/*-----------------------------------------------------------------*/
+	CLR(SLP_TR);
+	SET(nRST_RF);
+	SET(nSS);
+	_delay_us(400);
+
+	CLR(nRST_RF);
+	_delay_us(2);
+	SET(nRST_RF);
+
+	/* 5.1.4.5: Wait t10: 625 ns (min) */
+
+	_delay_us(2);
+
+	reg_write(REG_TRX_CTRL_0, 0x19);
+
+	change_state(TRX_CMD_FORCE_TRX_OFF);
+	/*-----------------------------------------------------------------*/
+
+	/* we must restore TRX_CTRL_0 after each reset (7.7.4) */
+
+	set_clkm();
+}
+
+void led_red(bool on) {
+	if (on)
+		CLR(LED_RED);
+	else
+		SET(LED_RED);
+}
+
+void led_green(bool on) {
+	if (on)
+		CLR(LED_GREEN);
+	else
+		SET(LED_GREEN);
+}
+
+void led(bool on)
+{
+	led_red(on);
+}
+
+void set_clkm(void)
+{
+	/* CLKM is not connected on BUSWARE HUL and therefore it is running in
+	 * async mode. */
+	reg_write(REG_TRX_CTRL_0, 0x00);
+
+	/* TX_AUTO_CRC_ON, default disabled */
+	subreg_write(SR_TX_AUTO_CRC_ON, 1);
+}
+
+void board_init(void)
+{
+	/* Disable the watchdog timer */
+
+	MCUSR = 0;		/* Remove override */
+	WDTCSR |= 1 << WDCE;	/* Enable change */
+	WDTCSR = 1 << WDCE;	/* Disable watchdog while still enabling
+	change */
+
+	CLKPR = 1 << CLKPCE;
+	/* We start with a 16 MHz/8 clock. Put the prescaler to 2. */
+	CLKPR = 1 << CLKPS0;
+
+	get_sernum();
+}
+
+void spi_begin(void)
+{
+	if (!spi_initialized)
+		spi_init();
+	CLR(nSS);
+}
+
+void spi_off(void)
+{
+	spi_initialized = 0;
+	SPCR &= ~(1 << SPE);
+}
+
+void spi_init(void)
+{
+	SET(nSS);
+	OUT(SCLK);
+	OUT(MOSI);
+	OUT(nSS);
+	IN(MISO);
+
+	SPCR = (1 << SPE) | (1 << MSTR);
+	SPSR = (1 << SPI2X);
+
+	spi_initialized = 1;
+}
+
+void usb_init(void)
+{
+	USBCON |= 1 << FRZCLK;		/* freeze the clock */
+
+	/* enable the PLL and wait for it to lock */
+	/* TODO sheet page 50 For Atmel AT90USB128x only. Do not use with Atmel AT90USB64x. */
+	/*  FOR 8 XTAL Mhz only!!! */
+	PLLCSR = ((1 << PLLP1) | (1 << PLLP0));
+	PLLCSR |= 1 << PLLE;
+	while (!(PLLCSR & (1 << PLOCK)));
+
+	UHWCON |= (1 << UVREGE);
+
+	USBCON &= ~((1 << USBE) | (1 << OTGPADE));		/* reset the controller */
+	USBCON |= ((1 << USBE) | (1 << OTGPADE));
+
+	USBCON &= ~(1 << FRZCLK);	/* thaw the clock */
+
+	UDCON &= ~(1 << DETACH);	/* attach the pull-up */
+	UDIEN = 1 << EORSTE;		/* enable device interrupts  */
+	//	UDCON |= 1 << RSTCPU;		/* reset CPU on bus reset */
+
+	ep_init();
+}
+
+void board_app_init(void)
+{
+	/* enable INT0, trigger on rising edge */
+	EICRA = 1 << ISC01 | 1 << ISC00;
+	EIMSK = 1 << INT0;
+}
diff --git a/atusb/fw/board_hulusb.h b/atusb/fw/board_hulusb.h
new file mode 100644
index 0000000..a1dadf0
--- /dev/null
+++ b/atusb/fw/board_hulusb.h
@@ -0,0 +1,66 @@
+/*
+ * fw/board_hulusb.h - Busware HUL Board-specific functions (for boot loader and application)
+ *
+ * Written 2017 by Filzmaier Josef
+ * Based on fw/board_rzusb written and Copyright 2016 Stefan Schmidt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef BOARD_HULUSB_H
+#define	BOARD_HULUSB_H
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#define LED_RED_PORT		A
+#define LED_GREEN_PORT		A
+#define LED_RED_BIT		3
+#define LED_GREEN_BIT 		4
+#define LED_PORT		LED_RED_PORT
+#define LED_BIT		  	LED_RED_BIT
+
+#define nRST_RF_PORT		B
+#define nRST_RF_BIT	  	5
+#define SLP_TR_PORT		B
+#define SLP_TR_BIT	  	4
+
+#define SCLK_PORT		B
+#define SCLK_BIT	  	1
+#define MOSI_PORT		B
+#define MOSI_BIT	  	2
+
+#define MISO_PORT		B
+#define MISO_BIT	  	3
+#define nSS_PORT		B
+#define nSS_BIT		  	0
+#define IRQ_RF_PORT		D
+#define IRQ_RF_BIT	  	4
+
+#define SR_TX_AUTO_CRC_ON	0x04, 0x20, 5
+#define SR_CHANNEL		0x08, 0x1f, 0
+
+#define RG_CC_CTRL_1		(0x14)
+
+#define SPI_WAIT_DONE()	while ((SPSR & (1 << SPIF)) == 0)
+#define SPI_DATA	SPDR
+
+void set_clkm(void);
+void board_init(void);
+
+void led_red(bool on);
+void led_green(bool on);
+
+void spi_begin(void);
+void spi_off(void);
+void spi_init(void);
+
+#ifdef DEBUG
+void printStatus(void);
+#define PRINT_STATUS() printStatus()
+#endif
+
+#endif /* !BOARD_HULUSB_H */
diff --git a/atusb/fw/board_rzusb.c b/atusb/fw/board_rzusb.c
index 83333f8..e83d6fa 100644
--- a/atusb/fw/board_rzusb.c
+++ b/atusb/fw/board_rzusb.c
@@ -29,6 +29,46 @@
 
 static bool spi_initialized = 0;
 
+void reset_rf(void)
+{
+	/* set up all the outputs; default port value is 0 */
+
+	DDRB = 0;
+	DDRC = 0;
+	DDRD = 0;
+	PORTB = 0;
+	PORTC = 0;
+	PORTD = 0;
+
+	OUT(LED);
+	OUT(nRST_RF);   /* this also resets the transceiver */
+	OUT(SLP_TR);
+
+	spi_init();
+
+	/* AT86RF231 data sheet, 12.4.13, reset pulse width: 625 ns (min) */
+
+	CLR(nRST_RF);
+	_delay_us(2);
+	SET(nRST_RF);
+
+	/* 12.4.14: SPI access latency after reset: 625 ns (min) */
+
+	_delay_us(2);
+
+	/* we must restore TRX_CTRL_0 after each reset (9.6.4) */
+
+	set_clkm();
+}
+
+void led(bool on)
+{
+	if (on)
+		SET(LED);
+	else
+		CLR(LED);
+}
+
 void set_clkm(void)
 {
 	/* switch CLKM to 8 MHz */
diff --git a/atusb/fw/ep0.c b/atusb/fw/ep0.c
index 674f9de..fa43f3b 100644
--- a/atusb/fw/ep0.c
+++ b/atusb/fw/ep0.c
@@ -38,11 +38,15 @@
 #include "mac.h"
 
 #ifdef ATUSB
-#define	HW_TYPE		HW_TYPE_110131
+#define	HW_TYPE		ATUSB_HW_TYPE_110131
 #endif
 
 #ifdef RZUSB
-#define	HW_TYPE		HW_TYPE_RZUSB
+#define	HW_TYPE		ATUSB_HW_TYPE_RZUSB
+#endif
+
+#ifdef HULUSB
+#define HW_TYPE		ATUSB_HW_TYPE_HULUSB
 #endif
 
 #ifdef DEBUG
diff --git a/atusb/fw/include/atusb/atusb.h b/atusb/fw/include/atusb/atusb.h
index b22bbaa..555d14b 100644
--- a/atusb/fw/include/atusb/atusb.h
+++ b/atusb/fw/include/atusb/atusb.h
@@ -50,6 +50,14 @@ enum atusb_requests {
 	ATUSB_EUI64_READ,
 };
 
+enum {
+	ATUSB_HW_TYPE_100813,	/* 2010-08-13 */
+	ATUSB_HW_TYPE_101216,	/* 2010-12-16 */
+	ATUSB_HW_TYPE_110131,	/* 2011-01-31, ATmega32U2-based */
+	ATUSB_HW_TYPE_RZUSB,	/* Atmel Raven USB dongle with at86rf230 */
+	ATUSB_HW_TYPE_HULUSB,	/* Busware HUL USB dongle with at86rf212 */
+};
+
 /*
  * Direction	bRequest		wValue		wIndex	wLength
  *
diff --git a/atusb/fw/include/atusb/ep0.h b/atusb/fw/include/atusb/ep0.h
index dd76d8d..7777345 100644
--- a/atusb/fw/include/atusb/ep0.h
+++ b/atusb/fw/include/atusb/ep0.h
@@ -32,11 +32,6 @@
 #define EP0ATUSB_MAJOR	0	/* EP0 protocol, major revision */
 #define EP0ATUSB_MINOR	3	/* EP0 protocol, minor revision */
 
-#define	HW_TYPE_100813	0	/* 2010-08-13 */
-#define	HW_TYPE_101216	1	/* 2010-12-16 */
-#define	HW_TYPE_110131	2	/* 2011-01-31, ATmega32U2-based */
-#define	HW_TYPE_RZUSB	3	/* Atmel Raven USB dongle with at86rf230 */
-
 
 /*
  * bmRequestType:
diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 265d542..cc52234 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -47,31 +47,6 @@ static inline void next_buf(uint8_t *index)
 }
 
 
-/* ----- Register access --------------------------------------------------- */
-
-
-static uint8_t reg_read(uint8_t reg)
-{
-	uint8_t value;
-
-	spi_begin();
-	spi_send(AT86RF230_REG_READ | reg);
-	value = spi_recv();
-	spi_end();
-
-	return value;
-}
-
-
-static void reg_write(uint8_t reg, uint8_t value)
-{
-	spi_begin();
-	spi_send(AT86RF230_REG_WRITE | reg);
-	spi_send(value);
-	spi_end();
-}
-
-
 /* ----- Interrupt handling ------------------------------------------------ */
 
 
@@ -101,13 +76,6 @@ static void tx_ack_done(void *user)
 	usb_next();
 }
 
-static void change_state(uint8_t new)
-{
-	while ((reg_read(REG_TRX_STATUS) & TRX_STATUS_MASK) ==
-	    TRX_STATUS_TRANSITION);
-	reg_write(REG_TRX_STATE, new);
-}
-
 static void rx_done(void *user)
 {
 	led(0);
-- 
2.14.1

