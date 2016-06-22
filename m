Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:49858 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbcFVO1R (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 22 Jun 2016 10:27:17 -0400
Subject: Re: [PATCH bluetooth-next] ieee802154: fix skb get fc on big endian
References: <20160618083607.3538-1-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <576AA023.5080307@osg.samsung.com>
Date: Wed, 22 Jun 2016 16:26:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160618083607.3538-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 18/06/16 10:36, Alexander Aring wrote:
> This patch fixes ieee802154_get_fc_from_skb function on big endian
> machines. The function get_unaligned_le16 converts the byte order to
> host byte order but we want to keep the byte order like in mac header.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   include/net/mac802154.h | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index df34187..3d7fa73 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -247,14 +247,16 @@ struct ieee802154_ops {
>    */
>   static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
>   {
> +	__le16 fc;
> +
>   	/* check if we can fc at skb_mac_header of sk buffer */
> -	if (unlikely(!skb_mac_header_was_set(skb) ||
> -		     (skb_tail_pointer(skb) - skb_mac_header(skb)) < 2)) {
> -		WARN_ON(1);
> +	if (WARN_ON(!skb_mac_header_was_set(skb) ||
> +		    (skb_tail_pointer(skb) -
> +		     skb_mac_header(skb)) < IEEE802154_FC_LEN))
>   		return cpu_to_le16(0);
> -	}

The hunk above is totally unrelated to the change you describe in your 
commit messages and should imho be split off into a different patch.
>   
> -	return get_unaligned_le16(skb_mac_header(skb));
> +	memcpy(&fc, skb_mac_header(skb), IEEE802154_FC_LEN);
> +	return fc;
>   }
>   
>   /**

The actual fix for big endian looks fine to me.

regards
Stefan Schmidt
