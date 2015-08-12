Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57334 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbbHLMvT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 08:51:19 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 11/16] ieee802154: 6lowpan: fix fragmentation dispatch mask
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-12-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB4144.5050102@osg.samsung.com>
Date: Wed, 12 Aug 2015 14:51:16 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-12-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch fix the dispatch fragmentation masking. With "0xe" we also
> get some reserved dispatch values.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index b0066b7..595830f 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -122,7 +122,8 @@ static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
>   	      lowpan_is_fragn(*skb_network_header(skb))))
>   		return RX_CONTINUE;
>   
> -	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) & 0xe0);
> +	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) &
> +			      LOWPAN_DISPATCH_FRAG_MASK);
>   	if (ret == 1)
>   		return RX_CONTINUE;
>   

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
