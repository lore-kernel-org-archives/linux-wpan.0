Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53523 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754329AbcK3JUV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 30 Nov 2016 04:20:21 -0500
Subject: Re: Project Todo list updated
References: <6e9208bd-cd35-bf0b-e55a-b06b0202c79a@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <d54f371e-ba02-71dc-6208-228560a51d00@pengutronix.de>
Date: Wed, 30 Nov 2016 10:19:20 +0100
MIME-Version: 1.0
In-Reply-To: <6e9208bd-cd35-bf0b-e55a-b06b0202c79a@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 11/29/2016 11:08 PM, Stefan Schmidt wrote:
> Hello.
> 
> I just took a moment and updated our project Todo list we keep on GitHub project page. It covers all aspects of Linux-wpan: wpan-tools, kernel drivers, kernel MAC layer, socket and netlink interfaces, the 6LoWPAN implementation as well as integration with other projects.
> 

cool thank you.

> Some of the items have GitHub issues attached to it and some not. Its not the holy grail of Todo lists but its a good start if you want to see what needs to be done and especially if you are interested in picking an item and working on it. :) Before spending days on something you might want to talk to Alexander and myself to see if we know someone working on it or maybe having some ideas about the implementation.
> 
> https://github.com/linux-wpan/wpan-tools/wiki/todo
> 

During my thesis I think I found some stuff which I want to bring
mainline to the subsystems 802.15.4/6lowpan can deal with some parts.

Currently I have very hacked solutions for it, but I think I know what I
need to make it mainline acceptable. This is:

1. 6lowpan netlink interface.

2. L2_PKTINFO for SOCK_RAW/SOCK_DGRAM IPv6 sockets

3. iptable 6lowpan stuff/which can also deal with some L2 infos. Really
   weird mixing L3 and L2 info in rules. :-/ Currently it's hard coded
   at my side.

4. node info dump

5. etc.

- Alex
