Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42805 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932119AbcEMMeQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 13 May 2016 08:34:16 -0400
Subject: Re: [PATCHv2 bluetooth-next 00/10] 6lowpan: introduce basic
 6lowpan-nd
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <D212A5BF-A414-403B-A409-1F8C2D279883@holtmann.org>
 <57354315.2050509@miraclelinux.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <f1898362-7bf3-705b-d72a-289e81910be8@pengutronix.de>
Date: Fri, 13 May 2016 14:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <57354315.2050509@miraclelinux.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, hannes@stressinduktion.org, Stefan Schmidt <stefan@osg.samsung.com>, mcr@sandelman.ca, Werner Almesberger <werner@almesberger.net>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>


Hi,

On 05/13/2016 04:59 AM, YOSHIFUJI Hideaki wrote:
> Hi,
> 
> Marcel Holtmann wrote:
>> Hi Dave,
> :
>>> include/linux/netdevice.h     |   6 +-
>>> include/net/6lowpan.h         |  24 ++
>>> include/net/addrconf.h        |   3 +
>>> include/net/ndisc.h           | 124 ++++++++-
>>> net/6lowpan/6lowpan_i.h       |   2 +
>>> net/6lowpan/Makefile          |   2 +-
>>> net/6lowpan/core.c            |  50 +++-
>>> net/6lowpan/iphc.c            | 167 +++++++++--
>>> net/6lowpan/ndisc.c           | 633 ++++++++++++++++++++++++++++++++++++++++++
>>> net/bluetooth/6lowpan.c       |   2 +
>>> net/ieee802154/6lowpan/core.c |  12 +
>>> net/ieee802154/6lowpan/tx.c   | 107 ++++---
>>> net/ipv6/addrconf.c           |   7 +-
>>> net/ipv6/ndisc.c              | 132 +++++----
>>> net/ipv6/route.c              |   4 +-
>>> 15 files changed, 1117 insertions(+), 158 deletions(-)
>>> create mode 100644 net/6lowpan/ndisc.c
>>
>> is there a chance that we get input into this patch set? I wonder also if it would be acceptable to take this through bluetooth-next or should it better go straight into net-next?
> 
> The core idea of introducing ndisc_ops is okay, but I do think this
> series of patches should be refactored; we should not make another
> "copy" of core of ndisc logic.  We can introduce "ops" for each
> option, for example.
> 

Thanks for your suggestion. I will try to make another patch series
which introduce ops for each option.

I also thinks it's better now. E.g. some days ago there was another
question on netdev for doing more ndp_proxy stuff inside the kernel [0].
If such feature will be added later then both implementation would be
touched (which almost introduce the same code).

- Alex

[0] http://marc.info/?l=linux-netdev&m=146278123414146
