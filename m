Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:58867 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaJAGdZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 02:33:25 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so230254wgh.24
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 23:33:24 -0700 (PDT)
Date: Wed, 1 Oct 2014 08:33:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] ieee802154: cleanup for lowpan_rcv
Message-ID: <20141001063319.GB23043@omega>
References: <1412143306-21716-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412143306-21716-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>, martin.townsend@xsilon.com

On Wed, Oct 01, 2014 at 11:31:46AM +0530, Varka Bhadram wrote:
> instead of collecting the return value into 'ret' varible and

s/varible/variable

> checking the perticular return value specifically, this patch
> remove these by directly including function within 'if' statement
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  net/ieee802154/6lowpan_rtnl.c |   21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 4413629..657940e 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -506,7 +506,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  		      struct packet_type *pt, struct net_device *orig_dev)
>  {
>  	struct ieee802154_hdr hdr;
> -	int ret;
>  
>  	skb = skb_share_check(skb, GFP_ATOMIC);
>  	if (!skb)
> @@ -529,31 +528,23 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  		/* Pull off the 1-byte of 6lowpan header. */
>  		skb_pull(skb, 1);
>  
> -		ret = lowpan_give_skb_to_devices(skb, NULL);
> -		if (ret == NET_RX_DROP)
> +		if (lowpan_give_skb_to_devices(skb, NULL))
>  			goto drop;
>  	} else {
>  		switch (skb->data[0] & 0xe0) {
>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> -			ret = process_data(skb, &hdr);
> -			if (ret == NET_RX_DROP)
> +			if (process_data(skb, &hdr))
>  				goto drop;
>  			break;
>  		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
> -			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
> -			if (ret == 1) {
> -				ret = process_data(skb, &hdr);
> -				if (ret == NET_RX_DROP)
> +			if (lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1))
> +				if (process_data(skb, &hdr))
>  					goto drop;
> -			}
>  			break;
>  		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
> -			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
> -			if (ret == 1) {
> -				ret = process_data(skb, &hdr);
> -				if (ret == NET_RX_DROP)
> +			if (lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN))
> +				if (process_data(skb, &hdr))
>  					goto drop;
> -			}
>  			break;
>  		default:
>  			break;

Mainly I would ack this, I detect no change. But this handling is
currently complete broken and Martin already work on this. [0]

I will not apply it. First fix the broken error handling, then you can
send cleanups for everything in 6LoWPAN receive handling.

Martin:

ping ping ping, this needs a fix by you! I also have the next header
compression framework and I begin to forget what I did there. ;-)


Otherwise I could try to send another version for this issue, when you
are fine with that? Or do you nearly at the end to send a new version?

- Alex

[0] http://marc.info/?l=linux-bluetooth&m=141079021702990&w=2
