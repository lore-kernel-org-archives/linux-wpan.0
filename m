Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44936 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeHFLfE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Aug 2018 07:35:04 -0400
Subject: Re: [PATCH wpan 2/2] net: mac802154: tx: expand tailroom if necessary
References: <20180702203203.21316-1-aring@mojatatu.com>
 <20180702203203.21316-2-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <11cbdc42-feb6-28af-db3f-2b28cd22700e@datenfreihafen.org>
Date: Mon, 6 Aug 2018 11:26:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180702203203.21316-2-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com

Hello.

On 07/02/2018 10:32 PM, Alexander Aring wrote:
> This patch is necessary if case of AF_PACKET or other socket interface
> which I am aware of it and didn't allocated the necessary room.
> 
> Reported-by: David Palma <david.palma@ntnu.no>
> Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  net/mac802154/tx.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 7e253455f9dd..bcd1a5e6ebf4 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -63,8 +63,21 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
>  	int ret;
>  
>  	if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
> -		u16 crc = crc_ccitt(0, skb->data, skb->len);
> +		struct sk_buff *nskb;
> +		u16 crc;
> +
> +		if (unlikely(skb_tailroom(skb) < IEEE802154_FCS_LEN)) {
> +			nskb = skb_copy_expand(skb, 0, IEEE802154_FCS_LEN,
> +					       GFP_ATOMIC);
> +			if (likely(nskb)) {
> +				consume_skb(skb);
> +				skb = nskb;
> +			} else {
> +				goto err_tx;
> +			}
> +		}
>  
> +		crc = crc_ccitt(0, skb->data, skb->len);
>  		put_unaligned_le16(crc, skb_put(skb, 2));
>  	}
>  
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

I know you submitted this for wpan instead of wpan-next, but with rc8
being out I will not submit another pull request for 4.18. Instead I
added cc stable to the patch to make sure it gets picked into the stable
tree once 4.18 is out.

regards
Stefan Schmidt
