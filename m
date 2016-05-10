Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36907 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcEJLnz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 May 2016 07:43:55 -0400
Received: by mail-wm0-f47.google.com with SMTP id a17so22662903wme.0
        for <linux-wpan@vger.kernel.org>; Tue, 10 May 2016 04:43:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zulberti.luca@gmail.com
Date: Tue, 10 May 2016 13:43:54 +0200
Message-ID: <CAPzmaijHiW7fyS8hnx0Gg6Gb6PhTCqh3bVf5WTQQ+tOQUFG7Ww@mail.gmail.com>
Subject: Problems with 6lowpan on at91: ping (truncated)
From: Luca Zulberti <zulberti.luca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: jukka.rissanen@linux.intel.com, aar@pengutronix.de, giometti@hce-engineering.com

Hi all!

I'm using two boards with an at91 CPU and the at86rf233 xplained pro from Atmel.
Linux kernel: 4.1.
SPI max freq: 4MHz
Xtal-trim line removed.

To make the things work i had to remove "xtal-trim = /bits/ <0x0F>"
and change the interrupt type in the dts file to be activated on
rising edge because after each normally served interrupt routine, the
driver goes to read the interrupt register of the chip even if there
isn't any interrupt signal on the line, it reads 0x00 and warns about
the error.

Leaving apart this particular, now i can ping a board from the other,
but i have to use a small packet:
ping6 -s 32 fe80::xxxx%lowpan0

If i use a higher packet size, the responses from the other board are
acquired as "(truncated)". This problem is reflected on other
application, like tcp and udp.

Using netcat6 on server:
nc6 -l -p 8888 -v

Using netcat6 on client, sending "Hello":
nv6 -v fe80::xxxx 8888
Hello

On server:
[... connected]
Hello
<some characters without sense...>

The TCP connection now is gone. With UDP i can continue to send and
receive messages, but the stream has got these characters anyway.
I've tried to force nc6 using higher and lower mtu, but the error
seems to ignore it.
Also the wpan "max_frame_retries" property seems to be not relevant.

What should i try?

Thanks for your work,

Luca Zulberti.
