Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57303 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965284AbbHLJDS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 05:03:18 -0400
Subject: Re: [RFC 05/16] ieee802154: 6lowpan: cleanup pull of iphc bytes
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-6-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55CB0BD2.5040605@osg.samsung.com>
Date: Wed, 12 Aug 2015 11:03:14 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-6-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch cleanups the pull of the iphc bytes. We don't need to check
> if the skb->len contains two bytes, this will be checked by
> lowpan_fetch_skb_u8.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/rx.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 99aeb56..7b6b038 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -33,14 +33,9 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
>   	void *sap, *dap;
>   
>   	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
> -	/* at least two bytes will be used for the encoding */
> -	if (skb->len < 2)
> -		return -EINVAL;
> -
> -	if (lowpan_fetch_skb_u8(skb, &iphc0))
> -		return -EINVAL;
>   
> -	if (lowpan_fetch_skb_u8(skb, &iphc1))
> +	if (lowpan_fetch_skb_u8(skb, &iphc0) ||
> +	    lowpan_fetch_skb_u8(skb, &iphc1))
>   		return -EINVAL;
>   
>   	ieee802154_addr_to_sa(&sa, &hdr->source);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
