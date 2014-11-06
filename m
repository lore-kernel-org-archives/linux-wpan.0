Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57745 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaKFBym (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 20:54:42 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so186276pab.19
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 17:54:42 -0800 (PST)
Message-ID: <545AD4DD.9030101@gmail.com>
Date: Thu, 06 Nov 2014 07:24:37 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 11/18] ieee802154: add ieee802154_random_extended_addr
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com> <1415217089-24919-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-12-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hi Alex,

I have few doubts on this patch.

On Thursday 06 November 2014 01:21 AM, Alexander Aring wrote:

> This patch adds a new function to generate a random IEEE 802.15.4
> extended address.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   include/linux/ieee802154.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index a907fe5..d043449 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -24,6 +24,7 @@
>   #define LINUX_IEEE802154_H
>   
>   #include <linux/types.h>
> +#include <linux/random.h>
>   #include <asm/byteorder.h>
>   
>   #define IEEE802154_MTU			127
> @@ -215,4 +216,17 @@ static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
>   		(addr != cpu_to_le64(0xffffffffffffffffULL)));
>   }
>   
> +/**
> + * ieee802154_random_extended_addr - generates a random extended address
> + * @addr: extended addr pointer to place the random address
> + */
> +static inline void ieee802154_random_extended_addr(__le64 *addr)

First of all why do we need this functionality. Extended address will be configured by the
user by using iz ..?

> +{
> +	get_random_bytes(addr, IEEE802154_EXTENDED_ADDR_LEN);
> +

Here we are getting random bytes of 8.

> +	/* toggle some bit if we hit an invalid extended addr */
> +	if (!ieee802154_is_valid_extended_addr(*addr))
> +		((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] ^= 0x01;

If those 8 bytes not a valid addr, then you are toggling last bit, Why..?

> +}
> +
>   #endif /* LINUX_IEEE802154_H */
>

-- 
Thanks and Regards,
Varka Bhadram.

