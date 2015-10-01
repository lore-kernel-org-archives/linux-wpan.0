Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:42129 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbbJALjI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Oct 2015 07:39:08 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] ieee802154: handle datagram variables as u16
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443679386-16825-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 1 Oct 2015 13:38:55 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <3212750E-45CB-4422-9D94-BCB06F336CDC@holtmann.org>
References: <1443679386-16825-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This reverts commit 9abc378c66e3d6f437eed77c1c534cbc183523f7
> ("ieee802154: 6lowpan: change datagram var types").
> 
> The reason is that I forgot the IPv6 fragmentation here. Our MTU of
> lowpan interface is 1280 and skb->len should not above of that. If we
> reach a payload above 1280 in IPv6 header then we have a IPv6
> fragmentation above 802.15.4 6LoWPAN fragmentation. The type "u16" was
> fine, instead I added now a WARN_ON_ONCE if skb->len is above MTU which
> should never happen otherwise IPv6 on minimum MTU size is broken.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/6lowpan_i.h  |  4 ++--
> net/ieee802154/6lowpan/reassembly.c |  2 +-
> net/ieee802154/6lowpan/tx.c         | 10 ++++++----
> 3 files changed, 9 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

