Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:53136 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaJWOFb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Oct 2014 10:05:31 -0400
Date: Thu, 23 Oct 2014 16:28:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth-next 1/4] 6lowpan: remove skb_deliver from
 IPHC
Message-ID: <20141023142854.GA22555@x61s.guest.pengutronix.de>
References: <1414069948-29731-1-git-send-email-martin.townsend@xsilon.com>
 <1414069948-29731-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1414069948-29731-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Thu, Oct 23, 2014 at 02:12:25PM +0100, Martin Townsend wrote:
...
>  	} else {
>  		switch (skb->data[0] & 0xe0) {
>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
>  			ret = process_data(skb, &hdr);
>  			if (ret == NET_RX_DROP)
>  				goto drop;
> -			break;
> +
> +			return lowpan_give_skb_to_devices(skb, NULL);
>  		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
>  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
>  			if (ret == 1) {
>  				ret = process_data(skb, &hdr);
>  				if (ret == NET_RX_DROP)
>  					goto drop;
> +
> +				return lowpan_give_skb_to_devices(skb, NULL);
> +			} else if (ret == -1) {
> +				return NET_RX_DROP;
> +			} else {
> +				return NET_RX_SUCCESS;
>  			}
>  			break;

break isn't necessary here.

>  		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
> @@ -558,6 +566,12 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  				ret = process_data(skb, &hdr);
>  				if (ret == NET_RX_DROP)
>  					goto drop;
> +
> +				return lowpan_give_skb_to_devices(skb, NULL);
> +			} else if (ret == -1) {
> +				return NET_RX_DROP;
> +			} else {
> +				return NET_RX_SUCCESS;
>  			}
>  			break;

same here.

You tagged this patch series as v3 but should be v4. Next series should
be v5.

- Alex
