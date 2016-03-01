Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52399 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbcCAIsp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 1 Mar 2016 03:48:45 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: Issues about 802.15.4 packet transmission and getting RSSI,LQI
 info using at86rf233
References: <CACP_RqzU5LXKd3dMUDvmg08=BaHBxCvTige1MrBzgiPY4jfgYQ@mail.gmail.com>
Message-ID: <56D5576A.2010406@osg.samsung.com>
Date: Tue, 1 Mar 2016 09:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <CACP_RqzU5LXKd3dMUDvmg08=BaHBxCvTige1MrBzgiPY4jfgYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Zhengming Shi <zmingshi@gmail.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

Sorry for the delay I was on vacation. I suggest you directly address 
the linux-wpan mailing list for questions as there are more people that 
might be able to help you.
I cc'ed the list now. You might want to subscribe to it for discussions 
about work on linux-wpan.

[Resend as vger wants plain text, my fault]

On 21/02/16 07:33, Zhengming Shi wrote:
> Hi, Stefan
>
> I'm working on a project about 6lowpan. Now, I'm using Raspberry Pi 
> 802.15.4 radio (based on at86rf233 chip) on the Raspberry Pi B 1. I 
> have two RPis, each with a Raspberry Pi 802.15.4 radio hooked up. 
> Also, Linux kernel (v4.1.15) is installed in RPi.

Great. You might want to try a development kernel if you are seeking the 
latest development. The bluetooth-next git tree has out latest changes.
>
> The two nodes can ping successfully via ping6 and wpan-ping, but now I 
> want to make the two nodes transmit/receive packets normally. I'm a 
> newer about it, I want to know if I need to write some codes to 
> implement it, if not, do you have any suggestions about how to make 
> it? thank you very much!

The normal way of transfer data over a correctly setup 6lowpan would be 
the ipv6 socket interface of the Linux kernel. Thanks to the 6lowpan 
adaptation layer there should be no extra steps involved after setting 
up your nodes.

>
> Also, I want to get RSSI and LQI info during the node communication. I 
> saw an issue you released several days ago 
> (https://github.com/linux-wpan/wpan-tools/issues/6), I want to know 
> how long the implementation for wpan node dump functionality will be 
> done.

There is no timeline for it. We noted this issue down as we know it is 
missing. So far nobody started to work on it.

> If it cannot be implemented currently, can I get these info (RSSI, 
> LQI) via other methods? I also saw another similar issue 
> (http://www.spinics.net/lists/linux-wpan/msg02513.html) on Internet, 
> it is suggested to '/echo $(( 0x`cat 
> /sys/kernel/debug/regmap/spi32766.0/registers | sed -ne "s/06: 
> \(.*\)/\1/p"` & 0x1f ))/', when I tried it via ping6, I found there is 
> nothing in the directory '/sys/kernel/debug'. If the reason is as the 
> debug mode is off, if so, how can I start the debug mode? thank you 
> very much!
>

My first guess would be that you did not mount debugfs. Try doing that 
first.

regards
Stefan Schmidt
