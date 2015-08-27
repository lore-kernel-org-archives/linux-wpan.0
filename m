Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38044 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbH0RxW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 13:53:22 -0400
Received: by wicgk12 with SMTP id gk12so16629090wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 10:53:20 -0700 (PDT)
Date: Thu, 27 Aug 2015 19:53:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv2 bluetooth-next 10/16] ieee820154: 6lowpan: dispatch
 evaluation rework
Message-ID: <20150827175316.GD686@omega>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-11-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1440089265-23366-11-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On Thu, Aug 20, 2015 at 06:47:39PM +0200, Alexander Aring wrote:
...
>  
>  	fq->q.stamp = skb->tstamp;
>  	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
> -		/* Calculate uncomp. 6lowpan header to estimate full size */
> -		fq->q.meat += lowpan_uncompress_size(skb, NULL);
> +		fq->q.meat += skb->len;
>  		fq->q.flags |= INET_FRAG_FIRST_IN;
>  	} else {
>  		fq->q.meat += skb->len;

removed the else branch and move "fq->q.meat += skb->len;" out of any
branches, we do "fq->q.meat += skb->len;" always.

> @@ -325,8 +316,59 @@ out_oom:
>  	return -1;
>  }
>  
...
>  
> -	if (frag_info->d_size > IPV6_MIN_MTU) {
> +	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
> +		lowpan_rx_result res;

changed to "int res".

> +
> +		res = lowpan_invoke_frag_rx_handlers(skb);
> +		if (res == NET_RX_DROP)
> +			goto err;
> +	}
> +
> +	if (cb->d_size > IPV6_MIN_MTU) {
>  		net_warn_ratelimited("lowpan_frag_rcv: datagram size exceeds MTU\n");
>  		goto err;
>  	}
>  
> -	fq = fq_find(net, frag_info, &source, &dest);
> +	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
>  	if (fq != NULL) {
>  		int ret;
>  

- Alex
