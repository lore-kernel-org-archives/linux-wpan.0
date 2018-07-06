Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50603 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753605AbeGFKHC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jul 2018 06:07:02 -0400
Subject: Re: [PATCH wpan 1/2] net: 6lowpan: fix reserved space for single
 frames
References: <20180702203203.21316-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <51306609-93b9-0e80-34ef-f5692cf9e380@datenfreihafen.org>
Date: Fri, 6 Jul 2018 12:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180702203203.21316-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com

Hello.

On 02.07.2018 22:32, Alexander Aring wrote:
> This patch fixes patch add handling to take care tail and headroom for

The "patch add" text here is form some patch managing? Please fix this
when doing the re-spin for the problem below.

> single 6lowpan frames. We need to be sure we have a skb with the right
> head and tailroom for single frames. This patch do it by using
> skb_copy_expand() if head and tailroom is not enough allocated by upper
> layer.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
> Reported-by: David Palma <david.palma@ntnu.no>
> Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  net/ieee802154/6lowpan/tx.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> index e6ff5128e61a..d0c4d220de08 100644
> --- a/net/ieee802154/6lowpan/tx.c
> +++ b/net/ieee802154/6lowpan/tx.c
> @@ -265,9 +265,24 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
>  	/* We must take a copy of the skb before we modify/replace the ipv6
>  	 * header as the header could be used elsewhere
>  	 */
> -	skb = skb_unshare(skb, GFP_ATOMIC);
> -	if (!skb)
> -		return NET_XMIT_DROP;
> +	if (unlikely(skb_headroom(skb) < ldev->needed_headroom ||
> +		     skb_tailroom(skb) < ldev->needed_tailroom)) {
> +		struct sk_buff *nskb;
> +
> +		nskb = skb_copy_expand(skb, ldev->needed_headroom,
> +				       ldev->needed_tailroom, GFP_ATOMIC);
> +		if (likely(skb)) {

I think you wanted to check for nskb here.

> +			consume_skb(skb);
> +			skb = nskb;
> +		} else {
> +			kfree_skb(skb);
> +			return NET_XMIT_DROP;
> +		}
> +	} else {
> +		skb = skb_unshare(skb, GFP_ATOMIC);
> +		if (!skb)
> +			return NET_XMIT_DROP;
> +	}
>  
>  	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
>  	if (ret < 0) {
> 

The rest looks fine to me.

regards
Stefan Schmidt
