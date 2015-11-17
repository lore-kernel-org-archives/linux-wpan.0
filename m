Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58469 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbbKQVEh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 17 Nov 2015 16:04:37 -0500
Subject: Re: [PATCH bluetooth-next 1/2] 6lowpan: iphc: add check for reserved
 values
References: <1447786441-17845-1-git-send-email-alex.aring@gmail.com>
 <1447786441-17845-2-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <564B9660.2040104@osg.samsung.com>
Date: Tue, 17 Nov 2015 22:04:32 +0100
MIME-Version: 1.0
In-Reply-To: <1447786441-17845-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de

Hello.

On 17/11/15 19:54, Alexander Aring wrote:
> This patch adds a check on reserved values for IPHC header. We should at
> first check on these fields instead of doing parsing before. Afterwards
> we can be sure there are no reserved values anymore. The reserved bits
> doesn't contain reserved values for NHC headers. This need to be handled
> inside the next layer.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/6lowpan/iphc.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 346b5c1..13f5424 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -455,6 +455,20 @@ static const u8 lowpan_ttl_values[] = {
>   	[LOWPAN_IPHC_HLIM_11] = 255,
>   };
>   
> +static inline bool lowpan_iphc_is_reserved(u8 iphc1)
> +{
> +	switch (iphc1 & (LOWPAN_IPHC_DAC | LOWPAN_IPHC_M |
> +			 LOWPAN_IPHC_DAM_MASK)) {
> +	case LOWPAN_IPHC_DAC | LOWPAN_IPHC_DAM_00:
> +	case LOWPAN_IPHC_DAC | LOWPAN_IPHC_M | LOWPAN_IPHC_DAM_01:
> +	case LOWPAN_IPHC_DAC | LOWPAN_IPHC_M | LOWPAN_IPHC_DAM_10:
> +	case LOWPAN_IPHC_DAC | LOWPAN_IPHC_M | LOWPAN_IPHC_DAM_11:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>   			     const void *daddr, const void *saddr)
>   {
> @@ -466,7 +480,8 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>   		       skb->data, skb->len);
>   
>   	if (lowpan_fetch_skb(skb, &iphc0, sizeof(iphc0)) ||
> -	    lowpan_fetch_skb(skb, &iphc1, sizeof(iphc1)))
> +	    lowpan_fetch_skb(skb, &iphc1, sizeof(iphc1)) ||
> +	    lowpan_iphc_is_reserved(iphc1))
>   		return -EINVAL;
>   
>   	/* another if the CID flag is set */

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
