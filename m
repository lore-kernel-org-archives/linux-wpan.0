Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:41012 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaKVIFp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 22 Nov 2014 03:05:45 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so8444166wgh.9
        for <linux-wpan@vger.kernel.org>; Sat, 22 Nov 2014 00:05:44 -0800 (PST)
Date: Sat, 22 Nov 2014 09:05:38 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Unused function mac802154_header_parse()
Message-ID: <20141122080535.GA7144@omega>
References: <546F62C1.6010500@gmail.com>
 <20141121171055.GE20364@omega>
 <546FD7F5.1060901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <546FD7F5.1060901@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

On Sat, Nov 22, 2014 at 05:55:25AM +0530, Varka Bhadram wrote:
> 
> My point is that no where mac802154_header_parse() function is called.
> 
> This has to be called by dev_parse header().
> 

Okay, I dig more into this code. Aigain

`grep -r -n "dev_parse_header" net` will result:

net/packet/af_packet.c:1823:	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
net/packet/af_packet.c:2030:	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);

`cat net/packet/Makefile` will result:

obj-$(CONFIG_PACKET) += af_packet.o

so af_packet is selected when CONFIG_PACKET is enabled.

CONFIG_PACKET help:

The Packet protocol is used by applications which communicate
directly with network devices without an intermediate network
protocol implemented in the kernel, e.g. tcpdump.  If you want them
to work, choose Y.

This is enabled on my side.

I did a (inside the mac802154_header_parse function):

printk(KERN_INFO "this crazy function was called!\n");

and start tcpdump on it.

`tcpdump -i wpan0` and ping6 on other node will result:

...
[   25.407216] this crazy function was called!
[   25.417991] this crazy function was called!
[   25.428034] this crazy function was called!
[   25.438051] this crazy function was called!
[   25.448058] this crazy function was called!
[   25.458231] this crazy function was called!
[   25.468280] this crazy function was called!
[   25.478334] this crazy function was called!
[   25.488386] this crazy function was called!
[   25.498445] this crazy function was called!
[   25.509029] this crazy function was called!
  1   0.000000      2001::4 -> ff02::1:ff00:1 ICMPv6 80 Neighbor Solicitation for 2001::1
  2   0.009032      2001::1 -> 2001::4      ICMPv6 96 Neighbor Advertisement 2001::1 (sol, ovr) from a0:b0:74:f3:c9:c8:0b:cc
  3   0.036129 02:12:13:ff:fe:14:15:16 -> a0:b0:74:f3:c9:c8:0b:cc 6LoWPAN 116 Data, Dst: a0:b0:74f3:c9:c80b:cc, Src: 02:12:13ff:fe:1415:16
  4   0.044886 02:12:13:ff:fe:14:15:16 -> a0:b0:74:f3:c9:c8:0b:cc 6LoWPAN 122 Data, Dst: a0:b0:74f3:c9:c80b:cc, Src: 02:12:13ff:fe:1415:16
  5   0.053285 02:12:13:ff:fe:14:15:16 -> a0:b0:74:f3:c9:c8:0b:cc 6LoWPAN 122 Data, Dst: a0:b0:74f3:c9:c80b:cc, Src: 02:12:13ff:fe:1415:16
  6   0.060645 02:12:13:ff:fe:14:15:16 -> a0:b0:74:f3:c9:c8:0b:cc 6LoWPAN 122 Data, Dst: a0:b0:74f3:c9:c80b:cc, Src: 02:12:13ff:fe:1415:16
  7   0.069100 02:12:13:ff:fe:14:15:16 -> a0:b0:74:f3:c9:c8:0b:cc 6LoWPAN 122 Data, Dst: a0:b0:74f3:c9:c80b:cc, Src: 02:12:13ff:fe:1415:16
  8   0.076858 02:12:13:ff:fe:14:15:16 -> a0:b0:74:f3:c9:c8:0b:cc 6LoWPAN 122 Data, Dst: a0:b0:74f3:c9:c80b:cc, Src: 02:12:13ff:fe:1415:16
...

So this function ist used for tcpdump, etc.



New questions are:

What exactly do this function?

-> I have no idea. It parse the source address to a allocated buffer and
   return the length of the address. But what af_packet does with that,
   currently I have no idea.

Should we remove this function?

-> No, if we don't know exactly what this function does.

Should the monitor device implement a header_parse function?

-> No, because we don't parse anything at monitor function.
   Parsing source address will depends on that the frame is correct.

Why I talked about "dev_hard_header" many times in my last mail.

-> Sorry, but I detected now that af_packet.c also call dev_hard_header.
   And calling dev_hard_header require currently to set the right
   control_block information. This seems to be buggy at the moment.
   Inside the rework I removed the header create callback because that
   and this is one more reason to remove this and create "global"
   802.15.4 mac header create functions.

Why I didn't do that already:

-> Currently I am busy because my university and it's not easy to
   replace the frame parsing and frame creation. It's used everywhere,
   the first step for now was to add support for nl802154 and many
   architecture changes. This is mostly done now.

- Alex
