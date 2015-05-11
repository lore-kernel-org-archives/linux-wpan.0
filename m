Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35087 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbEKVyk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 17:54:40 -0400
Received: by igbyr2 with SMTP id yr2so84304616igb.0
        for <linux-wpan@vger.kernel.org>; Mon, 11 May 2015 14:54:40 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 May 2015 23:54:40 +0200
Message-ID: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com>
Subject: cc2520 issue
From: Karol Poczesny <kpoczesny@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello all,

I have tested simple ping communication between two devices:
1.) Raspberry Pi with at86rf233 transceiver - (openlab module)
and
2.) Raspberry Pi with CC2520 transceiver - my own radio board.

I am able to run the interface and start transmit frames for both nodes,
but only node with at86rf233 respond.

Node with CC2520 can send e.g ping message but cannot answer for ping from
at86rf233 node and ignore any other requests.

I had checked my radio board - I complied my system with debug in cc2520.c
and received this:

...
[ 661.896458] cc2520 spi32766.0: SFD for RX
[ 937.179079] cc2520 spi32766.0: SFD for RX

so - I received SFD interrupt for RX this function is processed and it
seems that received packet stuck somewhere on Rx path.

I'm going to track this anomaly but maybe someone had similar problem.
Maybe there are some issues related with configuration cc2520 + RPi?
Somebody tested this configuration ?

I use pretty old kernel version (3.17.0-rc1+) and old userspace tool - iz
on both sides. Configuration is this same as on openlab web.

Solution is described on my blog:
[0] http://zanaster.blogspot.com/2015/05/rpi-6lowpan-solution-with-cc2520.html

Best,
Karol
