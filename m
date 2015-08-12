Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57353 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbbHLNhW (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 09:37:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 12/16] ieee802154: 6lowpan: add generic lowpan header check
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-13-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB4C0E.7020509@osg.samsung.com>
Date: Wed, 12 Aug 2015 15:37:18 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-13-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch introduce an earlier check if a 6LoWPAN can be valid. This
Missing the worde frame here? ...6LoWPAN frame can be valid...


> contains at first for checking if the header contains a dispatch byte
> and isn't the nalp dispatch value, which means it isn't a 6LoWPAN
> packet.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 595830f..62d181a 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -172,11 +172,34 @@ rxh_next:
>   #undef CALL_RXH
>   }
>   
> +static inline bool lowpan_is_nalp(u8 dispatch)
> +{
> +	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
> +}
> +
> +/* lowpan_rx_h_check checks on generic 6LoWPAN requirements
> + * in MAC and 6LoWPAN header.
> + *
> + * Don't manipulate the skb here, it could be shared buffer.
> + */
> +static bool lowpan_rx_h_check(struct sk_buff *skb)
> +{
> +	/* check for if we can evaluate the dispatch */

check if... no need for a for here.
> +	if (unlikely(!skb->len))
> +		return false;
> +
> +	if (lowpan_is_nalp(*skb_network_header(skb)))
> +		return false;
> +
> +	return true;
> +}
> +
>   static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
>   		      struct packet_type *pt, struct net_device *orig_wdev)
>   {
>   	if (skb->pkt_type == PACKET_OTHERHOST ||
> -	    wdev->type != ARPHRD_IEEE802154)
> +	    wdev->type != ARPHRD_IEEE802154 ||
> +	    !lowpan_rx_h_check(skb))
>   		return NET_RX_DROP;
>   
>   	skb = skb_share_check(skb, GFP_ATOMIC);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
