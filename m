Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59570 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412AbbJVKZj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Oct 2015 06:25:39 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: fix memory leak
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445508687-404-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 22 Oct 2015 12:25:31 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <C1F48BEB-8656-4F4F-858C-0F778CAD0D53@holtmann.org>
References: <1445508687-404-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hi Alex,

> Looking at current situation of memory management in 6lowpan receive
> function I detected some invalid handling. After calling
> lowpan_invoke_rx_handlers we will do a kfree_skb and then NET_RX_DROP on
> error handling. We don't do this before, also on
> skb_share_check/skb_unshare which might manipulate the reference
> counters.
> 
> After running some 'grep -r "dev_add_pack" net/' to look how others
> packet-layer receive callbacks works I detected that every subsystem do
> a kfree_skb, then NET_RX_DROP without calling skb functions which
> might manipulate the skb reference counters. This is the reason why we
> should do the same here like all others subsystems. I didn't find any
> documentation how the packet-layer receive callbacks handle NET_RX_DROP
> return values either.
> 
> This patch will add a kfree_skb, then NET_RX_DROP handling for the
> "trivial checks", in case of skb_share_check/skb_unshare the kfree_skb
> call will be done inside these functions.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> References how other filesystem handle the callback:
> 
> [0] http://lxr.free-electrons.com/source/net/ipx/af_ipx.c#L1638
> [1] http://lxr.free-electrons.com/source/net/can/af_can.c#L709
> [2] http://lxr.free-electrons.com/source/net/phonet/af_phonet.c#L371
> 
> net/ieee802154/6lowpan/rx.c | 13 +++++++++----
> 1 file changed, 9 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

