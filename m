Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33783 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbbJVKOl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Oct 2015 06:14:41 -0400
Received: by wijp11 with SMTP id p11so24312244wij.0
        for <linux-wpan@vger.kernel.org>; Thu, 22 Oct 2015 03:14:40 -0700 (PDT)
Date: Thu, 22 Oct 2015 12:14:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: fix memory leak
Message-ID: <20151022101433.GA8828@omega>
References: <1445508687-404-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1445508687-404-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com

On Thu, Oct 22, 2015 at 12:11:27PM +0200, Alexander Aring wrote:
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

s/filesystem/subsystems/

- Alex
