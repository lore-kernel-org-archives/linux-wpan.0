Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56427 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbcCWJ7X (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 05:59:23 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC bluetooth-next 02/19] ieee802154: add short address helpers
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-3-git-send-email-aar@pengutronix.de>
Message-ID: <56F268F7.2070504@osg.samsung.com>
Date: Wed, 23 Mar 2016 10:59:19 +0100
MIME-Version: 1.0
In-Reply-To: <1458652515-7862-3-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net

Hello.

On 22/03/16 14:14, Alexander Aring wrote:
> This patch introduce some short address handling functionality into
> ieee802154 headers.
>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   include/linux/ieee802154.h | 29 +++++++++++++++++++++++++++++
>   include/net/mac802154.h    | 10 ++++++++++
>   2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index 303f446..3b3ea58 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -47,6 +47,7 @@
>   #define IEEE802154_ADDR_SHORT_UNSPEC	0xfffe
>   
>   #define IEEE802154_EXTENDED_ADDR_LEN	8
> +#define IEEE802154_SHORT_ADDR_LEN	2
>   
>   #define IEEE802154_LIFS_PERIOD		40
>   #define IEEE802154_SIFS_PERIOD		12
> @@ -280,6 +281,34 @@ static inline bool ieee802154_is_valid_extended_unicast_addr(__le64 addr)
>   }
>   
>   /**
> + * ieee802154_is_broadcast_short_addr - check if short addr is broadcast
> + * @addr: short addr to check
> + */
> +static inline bool ieee802154_is_broadcast_short_addr(__le16 addr)
> +{
> +	return addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);

If I wrote this I would put it into parenthesis like this for clarity:

return (addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST));

But this is basically a nitpick and I honestly do not know what the kernel coding style has to say about it.


> +}
> +
> +/**
> + * ieee802154_is_unspec_short_addr - check if short addr is unspecified
> + * @addr: short addr to check
> + */
> +static inline bool ieee802154_is_unspec_short_addr(__le16 addr)
> +{
> +	return addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
> +}
> +
> +/**
> + * ieee802154_is_valid_src_short_addr - check if source short address is valid
> + * @addr: short addr to check
> + */
> +static inline bool ieee802154_is_valid_src_short_addr(__le16 addr)
> +{
> +	return !(ieee802154_is_broadcast_short_addr(addr) ||
> +		 ieee802154_is_unspec_short_addr(addr));
> +}
> +
> +/**
>    * ieee802154_random_extended_addr - generates a random extended address
>    * @addr: extended addr pointer to place the random address
>    */
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 6cd7a70..e465c85 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -288,6 +288,16 @@ static inline void ieee802154_le16_to_be16(void *be16_dst, const void *le16_src)
>   }
>   
>   /**
> + * ieee802154_be16_to_le16 - copies and convert be16 to le16
> + * @le16_dst: le16 destination pointer
> + * @be16_src: be16 source pointer
> + */
> +static inline void ieee802154_be16_to_le16(void *le16_dst, const void *be16_src)
> +{
> +	put_unaligned_le16(get_unaligned_be16(be16_src), le16_dst);
> +}
> +
> +/**
>    * ieee802154_alloc_hw - Allocate a new hardware device
>    *
>    * This must be called once for each hardware device. The returned pointer

Besides the nitpick this looks fine to me as well.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
