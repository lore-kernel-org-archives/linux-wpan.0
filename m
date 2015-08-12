Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57363 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbbHLNht (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 09:37:49 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 16/16] ieee802154: 6lowpan: remove packet type to host
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-17-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB4C2A.6060806@osg.samsung.com>
Date: Wed, 12 Aug 2015 15:37:46 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-17-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch remove the packet_type to host and leave the mac pkt_type.
> By running 'grep -r "pkt_type" net/ipv6', the IPv6 stack will evaluate
> this value for PACKET_BROADCAST. Instead of overwriting this value we
> will leave the mac value there which is broadcasts if the mac frame was
> a broadcast frame.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index b1a9d14..1d9866a 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -56,7 +56,6 @@ static int lowpan_give_skb_to_device(struct sk_buff *skb)
>   	int ret;
>   
>   	skb->protocol = htons(ETH_P_IPV6);
> -	skb->pkt_type = PACKET_HOST;
>   
>   	ret = netif_rx(skb);
>   	/* kfree_skb handled by netif_rx, so RX_DROP on failure */

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
