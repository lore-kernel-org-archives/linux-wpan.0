Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57300 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbHLIt7 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 04:49:59 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 04/16] ieee802154: 6lowpan: remove check on wdev is running
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-5-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB08B3.3020508@osg.samsung.com>
Date: Wed, 12 Aug 2015 10:49:55 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-5-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> We don't need to check if the wpan interface is running because the
> lowpan_rcv is the packet layer receive handler for thw wpan interface.

Typo. s/thw/the/

> This means for the check if the wpan interface is running ends always in
> true.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 6302b94..99aeb56 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -71,9 +71,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
>   	if (!skb)
>   		goto drop;
>   
> -	if (!netif_running(wdev))
> -		goto drop_skb;
> -
>   	if (skb->pkt_type == PACKET_OTHERHOST)
>   		goto drop_skb;
>   

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
