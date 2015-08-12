Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57357 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009AbbHLNhg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 09:37:36 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 14/16] ieee802154: 6lowpan: add check for reserved dispatch
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-15-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB4C1D.8000300@osg.samsung.com>
Date: Wed, 12 Aug 2015 15:37:33 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-15-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch adds checks for reserved dispatch value by check on all known
> dispatch values.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 146aa14..48869ac 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -248,6 +248,15 @@ static inline bool lowpan_is_nalp(u8 dispatch)
>   	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
>   }
>   
> +static inline bool lowpan_is_reserved(u8 dispatch)
> +{
> +	return !(lowpan_is_nalp(dispatch) || lowpan_is_iphc(dispatch) ||

OK, this is fishy. First of all you check lowpan_is_nalp here and negate 
it, but below you are checking without negation.
One must be wrong. :)


> +		 lowpan_is_ipv6(dispatch) || lowpan_is_hc1(dispatch) ||
> +		 lowpan_is_bc0(dispatch) || lowpan_is_mesh(dispatch) ||
> +		 lowpan_is_esc(dispatch) || lowpan_is_frag1(dispatch) ||
> +		 lowpan_is_fragn(dispatch));
> +}
> +
>   /* lowpan_rx_h_check checks on generic 6LoWPAN requirements
>    * in MAC and 6LoWPAN header.
>    *
> @@ -259,7 +268,8 @@ static bool lowpan_rx_h_check(struct sk_buff *skb)
>   	if (unlikely(!skb->len))
>   		return false;
>   
> -	if (lowpan_is_nalp(*skb_network_header(skb)))
> +	if (lowpan_is_nalp(*skb_network_header(skb)) ||

Here are you checking it as well. but without negating it.
> +	    lowpan_is_reserved(*skb_network_header(skb)))
>   		return false;
>   
>   	return true;

regards
Stefan Schmidt


