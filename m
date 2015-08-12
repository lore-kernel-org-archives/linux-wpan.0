Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57355 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbbHLNh3 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 09:37:29 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 13/16] ieee802154: 6lowpan: add handler for all dispatch
 values
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-14-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB4C16.5060502@osg.samsung.com>
Date: Wed, 12 Aug 2015 15:37:26 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-14-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch adds dummy handlers for all known IEEE 802.15.4 dispatch
> values which prints a warning that we don't support these dispatches
> right now. Also we add a warning to the RX_CONTINUE case inside of
> lowpan_rx_handlers_result which should now never happend.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 62d181a..146aa14 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -37,6 +37,9 @@ lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
>   	switch (res) {
>   	/* nobody cared about this packet */
>   	case RX_CONTINUE:
> +		net_warn_ratelimited("%s: %s 0x%02x\n", skb->dev->name,
> +				     "received unknown dispatch",
> +				     *skb_network_header(skb));
>   	case RX_DROP_UNUSABLE:
>   		kfree_skb(skb);
>   	case RX_DROP:
> @@ -149,6 +152,70 @@ static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
>   	return lowpan_give_skb_to_device(skb);
>   }
>   
> +static inline bool lowpan_is_hc1(u8 dispatch)
> +{
> +	return dispatch == LOWPAN_DISPATCH_HC1;
> +}
> +
> +static lowpan_rx_result lowpan_rx_h_hc1(struct sk_buff *skb)
> +{
> +	if (!lowpan_is_hc1(*skb_network_header(skb)))
> +		return RX_CONTINUE;
> +
> +	net_warn_ratelimited("%s: %s\n", skb->dev->name,
> +			     "6LoWPAN HC1 not supported\n");
> +
> +	return RX_DROP_UNUSABLE;
> +}
> +
> +static inline bool lowpan_is_bc0(u8 dispatch)
> +{
> +	return dispatch == LOWPAN_DISPATCH_BC0;
> +}
> +
> +static lowpan_rx_result lowpan_rx_h_bc0(struct sk_buff *skb)
> +{
> +	if (!lowpan_is_bc0(*skb_network_header(skb)))
> +		return RX_CONTINUE;
> +
> +	net_warn_ratelimited("%s: %s\n", skb->dev->name,
> +			     "6LoWPAN BC0 not supported\n");
> +
> +	return RX_DROP_UNUSABLE;
> +}
> +
> +static inline bool lowpan_is_esc(u8 dispatch)
> +{
> +	return dispatch == LOWPAN_DISPATCH_ESC;
> +}
> +
> +static lowpan_rx_result lowpan_rx_h_esc(struct sk_buff *skb)
> +{
> +	if (!lowpan_is_esc(*skb_network_header(skb)))
> +		return RX_CONTINUE;
> +
> +	net_warn_ratelimited("%s: %s\n", skb->dev->name,
> +			     "6LoWPAN ESC not supported\n");
> +
> +	return RX_DROP_UNUSABLE;
> +}
> +
> +static inline bool lowpan_is_mesh(u8 dispatch)
> +{
> +	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_MESH;
> +}
> +
> +static lowpan_rx_result lowpan_rx_h_mesh(struct sk_buff *skb)
> +{
> +	if (!lowpan_is_mesh(*skb_network_header(skb)))
> +		return RX_CONTINUE;
> +
> +	net_warn_ratelimited("%s: %s\n", skb->dev->name,
> +			     "6LoWPAN MESH not supported\n");
> +
> +	return RX_DROP_UNUSABLE;
> +}
> +
>   int lowpan_invoke_rx_handlers(struct sk_buff *skb)
>   {
>   	lowpan_rx_result res;
> @@ -166,6 +233,10 @@ int lowpan_invoke_rx_handlers(struct sk_buff *skb)
>   	/* likely at first */
>   	CALL_RXH(lowpan_rx_h_iphc);
>   	CALL_RXH(lowpan_rx_h_ipv6);
> +	CALL_RXH(lowpan_rx_h_hc1);
> +	CALL_RXH(lowpan_rx_h_bc0);
> +	CALL_RXH(lowpan_rx_h_esc);
> +	CALL_RXH(lowpan_rx_h_mesh);
>   
>   rxh_next:
>   	return lowpan_rx_handlers_result(skb, res);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
