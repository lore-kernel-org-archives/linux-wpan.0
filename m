Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57304 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965037AbbHLJEV (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 05:04:21 -0400
Subject: Re: [RFC 06/16] ieee802154: 6lowpan: trivial checks at first
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-7-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55CB0C12.4050001@osg.samsung.com>
Date: Wed, 12 Aug 2015 11:04:18 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-7-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch moves some trivial checks at first before calling
> skb_share_check which could do some memcpy if the buffer is shared.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 7b6b038..11a5629 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -62,16 +62,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
>   	struct ieee802154_hdr hdr;
>   	int ret;
>   
> +	if (skb->pkt_type == PACKET_OTHERHOST ||
> +	    wdev->type != ARPHRD_IEEE802154)
> +		goto drop;
> +
>   	skb = skb_share_check(skb, GFP_ATOMIC);
>   	if (!skb)
>   		goto drop;
>   
> -	if (skb->pkt_type == PACKET_OTHERHOST)
> -		goto drop_skb;
> -
> -	if (wdev->type != ARPHRD_IEEE802154)
> -		goto drop_skb;
> -
>   	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
>   		goto drop_skb;
>   

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
