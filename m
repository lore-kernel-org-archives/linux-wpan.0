Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45540 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaL3GSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Dec 2014 01:18:36 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 0/5] ieee802154: structural directory changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 29 Dec 2014 22:18:32 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <1BF47DD7-0408-4A64-BA37-0A749CDDCAE5@holtmann.org>
References: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series contains structural changes according the ieee802154
> directory. The current situation is that this directory contains stuff
> about ieee802154 6lowpan, ieee802154 address family and netlink interface.
> This patch series introduce now sub directories for 6lowpan and af802154
> implementation to getting a better overview about these implementations.
> The ieee802154 directory contains stuff for nl802154, netlink and sysfs
> only.
> 
> Alexander Aring (5):
>  ieee802154: create af802154 sub-directory
>  ieee802154: af802154: rename internal header
>  ieee802154: af802154: rename af_ieee802154 to core
>  ieee802154: create 6lowpan sub-directory
>  ieee802154: 6lowpan: rename internal header
> 
> net/ieee802154/{reassembly.h => 6lowpan/6lowpan_i.h} | 6 +++---
> net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c          | 2 +-
> net/ieee802154/6lowpan/Makefile                      | 3 +++
> net/ieee802154/{ => 6lowpan}/reassembly.c            | 2 +-
> net/ieee802154/Makefile                              | 6 ++----
> net/ieee802154/af802154/Makefile                     | 3 +++
> net/ieee802154/{af802154.h => af802154/af802154_i.h} | 6 +++---
> net/ieee802154/{af_ieee802154.c => af802154/core.c}  | 2 +-
> net/ieee802154/{ => af802154}/dgram.c                | 2 +-
> net/ieee802154/{ => af802154}/raw.c                  | 2 +-
> 10 files changed, 19 insertions(+), 15 deletions(-)
> rename net/ieee802154/{reassembly.h => 6lowpan/6lowpan_i.h} (85%)
> rename net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c (99%)
> create mode 100644 net/ieee802154/6lowpan/Makefile
> rename net/ieee802154/{ => 6lowpan}/reassembly.c (99%)
> create mode 100644 net/ieee802154/af802154/Makefile
> rename net/ieee802154/{af802154.h => af802154/af802154_i.h} (93%)
> rename net/ieee802154/{af_ieee802154.c => af802154/core.c} (99%)
> rename net/ieee802154/{ => af802154}/dgram.c (99%)
> rename net/ieee802154/{ => af802154}/raw.c (99%)

the move of the 6lowpan stuff into net/ieee802154/6lowpan/ I can understand. That should be an optional piece. And I assume for 802.15.4 the 6LoWPAN support is more complex since it has to do segmentation and reassembly.

The net/ieee802154/af802154/ part seems pointless to me. What is this trying to achieve? I see that you can build af_802154.ko as a separate module. Which is something that I have not realized until now. So this is something that is intentional. So having ieee802154.ko and ieee802154_6lowpan.ko by itself without the socket is something that is functional?

If so, I find the naming of af_802154.ko and net/ieee802154/af802154/ rather complicated and convoluted. Would ieee802154_socket.ko net/ieee802154/socket/ not something more logical split in this regard?

Regards

Marcel

