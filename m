Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33297 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcEMC7i (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 12 May 2016 22:59:38 -0400
Received: by mail-pa0-f47.google.com with SMTP id xk12so35991863pac.0
        for <linux-wpan@vger.kernel.org>; Thu, 12 May 2016 19:59:38 -0700 (PDT)
Subject: Re: [PATCHv2 bluetooth-next 00/10] 6lowpan: introduce basic
 6lowpan-nd
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <D212A5BF-A414-403B-A409-1F8C2D279883@holtmann.org>
From: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <57354315.2050509@miraclelinux.com>
Date: Fri, 13 May 2016 11:59:33 +0900
MIME-Version: 1.0
In-Reply-To: <D212A5BF-A414-403B-A409-1F8C2D279883@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, Alexander Aring <aar@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: hideaki.yoshifuji@miraclelinux.com, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, hannes@stressinduktion.org, Stefan Schmidt <stefan@osg.samsung.com>, mcr@sandelman.ca, Werner Almesberger <werner@almesberger.net>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

Hi,

Marcel Holtmann wrote:
> Hi Dave,
:
>> include/linux/netdevice.h     |   6 +-
>> include/net/6lowpan.h         |  24 ++
>> include/net/addrconf.h        |   3 +
>> include/net/ndisc.h           | 124 ++++++++-
>> net/6lowpan/6lowpan_i.h       |   2 +
>> net/6lowpan/Makefile          |   2 +-
>> net/6lowpan/core.c            |  50 +++-
>> net/6lowpan/iphc.c            | 167 +++++++++--
>> net/6lowpan/ndisc.c           | 633 ++++++++++++++++++++++++++++++++++++++++++
>> net/bluetooth/6lowpan.c       |   2 +
>> net/ieee802154/6lowpan/core.c |  12 +
>> net/ieee802154/6lowpan/tx.c   | 107 ++++---
>> net/ipv6/addrconf.c           |   7 +-
>> net/ipv6/ndisc.c              | 132 +++++----
>> net/ipv6/route.c              |   4 +-
>> 15 files changed, 1117 insertions(+), 158 deletions(-)
>> create mode 100644 net/6lowpan/ndisc.c
> 
> is there a chance that we get input into this patch set? I wonder also if it would be acceptable to take this through bluetooth-next or should it better go straight into net-next?

The core idea of introducing ndisc_ops is okay, but I do think this
series of patches should be refactored; we should not make another
"copy" of core of ndisc logic.  We can introduce "ops" for each
option, for example.

Thank you.

-- 
Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Technical Division, MIRACLE LINUX CORPORATION
