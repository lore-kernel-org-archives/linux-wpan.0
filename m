Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:56085 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbaJHO71 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 10:59:27 -0400
Date: Wed, 8 Oct 2014 16:59:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141008145917.GA23456@omega>
References: <1412776015-372-1-git-send-email-martin.townsend@xsilon.com>
 <1412776015-372-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412776015-372-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Wed, Oct 08, 2014 at 02:46:55PM +0100, Martin Townsend wrote:
> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> pskb_expand_head.  It also checks to see if there is enough headroom
> first to ensure it's only done if necessary.
> As pskb_expand_head must only have one reference the calling code
> now ensures this.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
...
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -537,6 +537,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  		if (ret == NET_RX_DROP)
>  			goto drop;
>  	} else {
> +		/* Decompression may use pskb_expand_head so no shared skb's */
> +		skb = skb_share_check(skb, GFP_ATOMIC);
> +		if (!skb)
> +			goto drop;
> +

We do this already at [0], is it really necessary do it here again?

This ensures that 6lowpan header replacing doesn't affect the af_802154
implementation.

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L466
