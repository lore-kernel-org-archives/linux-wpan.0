Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59972 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbdIAX2e (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 1 Sep 2017 19:28:34 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: [PATCH bluetooth-next 1/2] atusb/fw: Introduce DEBUG flag
Date: Sat,  2 Sep 2017 01:28:21 +0200
Message-Id: <20170901232822.31901-2-j.filzmaier@gmx.at>
In-Reply-To: <20170901232822.31901-1-j.filzmaier@gmx.at>
References: <20170901232822.31901-1-j.filzmaier@gmx.at>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Josef Filzmaier <j.filzmaier@gmx.at>

This flag can be used to enable debugging over uart. Currently only
available for boards with the at90usb1287 chip.

Signed-off-by: Josef Filzmaier <j.filzmaier@gmx.at>
---
 atusb/fw/Makefile | 10 ++++++++-
 atusb/fw/atusb.c  | 11 ++++++++++
 atusb/fw/ep0.c    |  7 ++++++
 atusb/fw/uart.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 atusb/fw/uart.h   | 25 ++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 atusb/fw/uart.c
 create mode 100644 atusb/fw/uart.h

diff --git a/atusb/fw/Makefile b/atusb/fw/Makefile
index c1c68d7..4cc749c 100644
--- a/atusb/fw/Makefile
+++ b/atusb/fw/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile - Makefile of the ATUSB firmware 
+# Makefile - Makefile of the ATUSB firmware
 #
 # Written 2010-2011, 2013 by Werner Almesberger
 # Copyright 2010-2011, 2013 by Werner Almesberger
@@ -13,11 +13,16 @@
 SHELL = /bin/bash
 
 NAME = atusb
+DEBUG = false
 
 CFLAGS = -g -mmcu=$(CHIP) -DBOOT_ADDR=$(BOOT_ADDR) \
 	 -Wall -Wextra -Wshadow -Werror -Wno-unused-parameter \
 	 -Wmissing-prototypes -Wmissing-declarations -Wstrict-prototypes
 
+ifeq ($(DEBUG),true)
+CFLAGS += -DDEBUG
+endif
+
 ifeq ($(NAME),rzusb)
 CHIP=at90usb1287
 CFLAGS += -DRZUSB -DAT86RF230
@@ -46,6 +51,9 @@ OBJS = atusb.o board.o board_app.o sernum.o spi.o descr.o ep0.o \
 BOOT_OBJS = boot.o board.o sernum.o spi.o flash.o dfu.o \
             dfu_common.o usb.o boot-atu2.o
 
+ifeq ($(DEBUG),true)
+OBJS +=  uart.o
+endif
 
 ifeq ($(NAME),rzusb)
 OBJS += board_rzusb.o
diff --git a/atusb/fw/atusb.c b/atusb/fw/atusb.c
index 1f65d53..28faf40 100644
--- a/atusb/fw/atusb.c
+++ b/atusb/fw/atusb.c
@@ -24,6 +24,10 @@
 #include "spi.h"
 #include "atusb/ep0.h"
 
+#ifdef DEBUG
+#include "uart.h"
+#endif
+
 
 int main(void)
 {
@@ -35,6 +39,13 @@ int main(void)
 
 	/* now we should be at 8 MHz */
 
+#ifdef DEBUG
+	uart_init();
+	static FILE atben_stdout = FDEV_SETUP_STREAM(uart_write_char, NULL,
+						     _FDEV_SETUP_WRITE);
+	stdout = &atben_stdout;
+#endif
+
 	usb_init();
 	ep0_init();
 #ifdef ATUSB
diff --git a/atusb/fw/ep0.c b/atusb/fw/ep0.c
index 2b92f6d..674f9de 100644
--- a/atusb/fw/ep0.c
+++ b/atusb/fw/ep0.c
@@ -45,8 +45,15 @@
 #define	HW_TYPE		HW_TYPE_RZUSB
 #endif
 
+#ifdef DEBUG
+#include "uart.h"
+#include <stdio.h>
+#define debug(FORMAT,args...) printf(FORMAT,##args)
+#define error(FORMAT,args...) printf(FORMAT,##args)
+#else
 #define debug(...)
 #define error(...)
+#endif
 
 
 static const uint8_t id[] = { EP0ATUSB_MAJOR, EP0ATUSB_MINOR, HW_TYPE };
diff --git a/atusb/fw/uart.c b/atusb/fw/uart.c
new file mode 100644
index 0000000..44bec27
--- /dev/null
+++ b/atusb/fw/uart.c
@@ -0,0 +1,64 @@
+/*
+ * fw/uart.h - Functions needed for debugging over uart
+ *
+ * Code adapted from http://www.roboternetz.de/wissen/index.php/UART_mit_avr-gcc
+ * and http://www.mikrocontroller.net/articles/AVR-GCC-Tutorial
+ *
+ * Published under the Creative Commons Share-Alike licence
+ * https://creativecommons.org/licenses/by-sa/2.0/de/
+ *
+ * S. Salewski 2007
+ *
+ * Adapted by
+ * Josef Filzmaier 2017
+ */
+
+#include <avr/io.h>
+#include "uart.h"
+
+#define USART_BAUD 38400UL
+#define F_CPU 8000000UL
+
+#define Wait_USART_Ready() while (!(UCSR1A & (1<<UDRE1)))
+#define UART_UBRR (F_CPU/(16L*USART_BAUD)-1)
+
+// initialize USART, 8N1 mode
+void
+uart_init(void)
+{
+/* TODO: Find a working configuration for uart for the atmega32u2 */
+#if CHIP == at90usb1287
+	CLKPR = (1 << CLKPCE);
+	CLKPR = 0; // clock prescaler == 0, so we have 16 MHz mpu frequency
+	UBRR1 = UART_UBRR;
+	UCSR1C = (1 << UCSZ10) | (1 << UCSZ11);
+	UCSR1B = (1 << TXEN1);
+	do
+	{
+		UDR1;
+	}
+	while (UCSR1A & (1 << RXC1));
+#endif
+
+}
+
+int uart_write_char(char c, FILE* stream)
+{
+	if (c == '\n'){
+		uart_new_line();
+	}
+	else {
+		Wait_USART_Ready();
+		UDR1 = c;
+	}
+	return 0;
+}
+
+void
+uart_new_line(void)
+{
+	Wait_USART_Ready();
+	UDR1 = '\r';
+	Wait_USART_Ready();
+	UDR1 = '\n';
+}
diff --git a/atusb/fw/uart.h b/atusb/fw/uart.h
new file mode 100644
index 0000000..4810f9c
--- /dev/null
+++ b/atusb/fw/uart.h
@@ -0,0 +1,25 @@
+/*
+ * fw/uart.h - Functions needed for debugging over uart
+ *
+ * Code adapted from http://www.roboternetz.de/wissen/index.php/UART_mit_avr-gcc
+ * and http://www.mikrocontroller.net/articles/AVR-GCC-Tutorial
+ *
+ * Published under the Creative Commons Share-Alike licence
+ * https://creativecommons.org/licenses/by-sa/2.0/de/
+ *
+ * S. Salewski 2007
+ *
+ * Adapted by
+ * Josef Filzmaier 2017
+ */
+
+#ifndef UART_H_
+#define	UART_H_
+
+#include <stdio.h>
+
+void uart_init(void);
+int uart_write_char(char c, FILE* stream);
+void uart_new_line(void);
+
+#endif /* UART_H_ */
-- 
2.14.1

