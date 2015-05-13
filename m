Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:36353 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934415AbbEMOqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 May 2015 10:46:36 -0400
Date: Wed, 13 May 2015 16:46:33 +0200
From: Johann Fischer <johann_fischer@posteo.de>
Subject: Re: cc2520 issue
Message-ID: <20150513164633.10c4d992@ws-entwicklun-18.phytec>
In-Reply-To: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com>
References: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Karol Poczesny <kpoczesny@gmail.com>, linux-wpan@vger.kernel.org

Hi Karol,

> Hello all,
> 
> I have tested simple ping communication between two devices:
> 1.) Raspberry Pi with at86rf233 transceiver - (openlab module)
> and
> 2.) Raspberry Pi with CC2520 transceiver - my own radio board.
> 
> I am able to run the interface and start transmit frames for both
> nodes, but only node with at86rf233 respond.
> 
> Node with CC2520 can send e.g ping message but cannot answer for ping
> from at86rf233 node and ignore any other requests.
> 

As I see, you used a reference Design with 2450BM15B0002 Balun?

I use also TI's reference design with the Balun and have the same
problems. Original TI CC2520EM 2.1 Board functions fine.
I use Kernel 3.19.0.

The problem appears only after immediately switching from tx to 
rx mode. (e.g. ping6). Just send or receive is fine.

 From our adapters about 40% do not work properly. This behavior depends
on temperature and the channel (frequency).

I have also observed the SPI and GPIO communication. 
If I remember correctly, it was the transceiver, which had simple not
received the packages. I will examine SPI and GPIO communication this
week (if I have time :-)).

> I had checked my radio board - I complied my system with debug in
> cc2520.c and received this:
> 
> ...
> [ 661.896458] cc2520 spi32766.0: SFD for RX
> [ 937.179079] cc2520 spi32766.0: SFD for RX
> 
> so - I received SFD interrupt for RX this function is processed and it
> seems that received packet stuck somewhere on Rx path.
> 
> I'm going to track this anomaly but maybe someone had similar problem.
> Maybe there are some issues related with configuration cc2520 + RPi?
> Somebody tested this configuration ?
> 
> I use pretty old kernel version (3.17.0-rc1+) and old userspace tool
> - iz on both sides. Configuration is this same as on openlab web.
> 
> Solution is described on my blog:
> [0]
> http://zanaster.blogspot.com/2015/05/rpi-6lowpan-solution-with-cc2520.html
> 
> Best,
> Karol


-- 
Johann Fischer
