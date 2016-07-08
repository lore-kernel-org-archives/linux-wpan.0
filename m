Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59054 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbcGHLXL (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 8 Jul 2016 07:23:11 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCHv4 bluetooth-next 7/8] ieee802154: cleanup WARN_ON for fc
 fetch
References: <20160706213231.23058-1-aar@pengutronix.de>
 <20160706213231.23058-8-aar@pengutronix.de>
Message-ID: <e0ac3240-328f-7a7b-b0e8-1319fdbe1d07@osg.samsung.com>
Date: Fri, 8 Jul 2016 13:23:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160706213231.23058-8-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.


On 06/07/16 23:32, Alexander Aring wrote:
> This patch cleanups the WARN_ON which occurs when the sk buffer has
> insufficient buffer space by moving the WARN_ON into if condition.
>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   include/net/mac802154.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index bb7bfec..286824a 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -250,11 +250,10 @@ static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
>   	__le16 fc;
>   
>   	/* check if we can fc at skb_mac_header of sk buffer */
> -	if (unlikely(!skb_mac_header_was_set(skb) ||
> -		     (skb_tail_pointer(skb) - skb_mac_header(skb)) < 2)) {
> -		WARN_ON(1);
> +	if (WARN_ON(!skb_mac_header_was_set(skb) ||
> +		    (skb_tail_pointer(skb) -
> +		     skb_mac_header(skb)) < IEEE802154_FC_LEN))
>   		return cpu_to_le16(0);
> -	}
>   
>   	memcpy(&fc, skb_mac_header(skb), IEEE802154_FC_LEN);
>   	return fc;


Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
