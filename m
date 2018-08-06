Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44929 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeHFLc6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Aug 2018 07:32:58 -0400
Subject: Re: [PATCHv2 wpan] net: 6lowpan: fix reserved space for single frames
References: <20180714165210.20517-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <2c6cad37-beea-e9ca-569a-5f976bdd2927@datenfreihafen.org>
Date: Mon, 6 Aug 2018 11:24:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180714165210.20517-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, david.palma@ntnu.no, rabinarayans0828@gmail.com

Hello.

On 07/14/2018 06:52 PM, Alexander Aring wrote:
> This patch fixes patch add handling to take care tail and headroom for
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
> changes since v2:
>  skb to nskb, pointed out by stefan
> 
>  net/ieee802154/6lowpan/tx.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> index e6ff5128e61a..ca53efa17be1 100644
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
> +		if (likely(nskb)) {
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

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

I know you submitted this for wpan instead of wpan-next, but with rc8
being out I will not submit another pull request for 4.18. Instead I
added cc stable to the patch to make sure it gets picked into the stable
tree once 4.18 is out.

regards
Stefan Schmidt
