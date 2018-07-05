Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28911 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753635AbeGELnA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 5 Jul 2018 07:43:00 -0400
Message-ID: <1530790975.5103.16.camel@linux.intel.com>
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 05 Jul 2018 14:42:55 +0300
In-Reply-To: <20180619234406.8217-1-michael@opensourcefoundries.com>
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Scott <michael@opensourcefoundries.com>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 16:44 -0700, Michael Scott wrote:
> After decompression of 6lowpan socket data, an IPv6 header is
> inserted
> before the existing socket payload.  After this, we reset the
> network_header value of the skb to account for the difference in
> payload
> size from prior to decompression + the addition of the IPv6 header.
> 
> 
> Signed-off-by: Michael Scott <michael@opensourcefoundries.com>
> ---
>  net/6lowpan/iphc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 6b1042e21656..52fad5dad9f7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb,
> const struct net_device *dev,
>  		hdr.hop_limit, &hdr.daddr);
>  
>  	skb_push(skb, sizeof(hdr));
> +	skb_reset_mac_header(skb);
>  	skb_reset_network_header(skb);
>  	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
>  

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka



