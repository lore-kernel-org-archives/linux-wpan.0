Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56411 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcCWJ7A (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 05:59:00 -0400
Subject: Re: [RFC bluetooth-next 04/19] ieee802154: 6lowpan: fix short addr
 hash
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-5-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56F268DF.8020900@osg.samsung.com>
Date: Wed, 23 Mar 2016 10:58:55 +0100
MIME-Version: 1.0
In-Reply-To: <1458652515-7862-5-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net

Hello.

On 22/03/16 14:15, Alexander Aring wrote:
> The short address is unique in combination with the panid. This patch
> will add the panid for generating an ieee802154 address hash.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/ieee802154/6lowpan/6lowpan_i.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
> index b4e17a7..b4092a9 100644
> --- a/net/ieee802154/6lowpan/6lowpan_i.h
> +++ b/net/ieee802154/6lowpan/6lowpan_i.h
> @@ -41,7 +41,7 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
>   		return (((__force u64)a->extended_addr) >> 32) ^
>   			(((__force u64)a->extended_addr) & 0xffffffff);
>   	case IEEE802154_ADDR_SHORT:
> -		return (__force u32)(a->short_addr);
> +		return (__force u32)(a->short_addr + (a->pan_id << 16));
>   	default:
>   		return 0;
>   	}

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
