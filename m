Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55975 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbbHDQ3Q (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 4 Aug 2015 12:29:16 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFCv3 bluetooth-next 2/6] ieee802154: add helpers for frame
 control checks
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-3-git-send-email-alex.aring@gmail.com>
Message-ID: <55C0E859.2010503@osg.samsung.com>
Date: Tue, 4 Aug 2015 18:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <1438246542-17633-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 30/07/15 10:55, Alexander Aring wrote:
> This patch introduce two static inline functions. The first to get the
> frame control field from an sk_buff. The second is for checking on the
> acknowledgment request bit on the frame control field. Later we can
> introduce more functions to check on the frame control fields.
>
> These will deprecate the current behaviour which requires a
> host-byteorder conversion and manually bit handling.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---

Some language suggestions inside.
>   include/linux/ieee802154.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index 1dc1f4e..4f26c01 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -25,6 +25,8 @@
>   
>   #include <linux/types.h>
>   #include <linux/random.h>
> +#include <linux/skbuff.h>
> +#include <linux/unaligned/memmove.h>
>   #include <asm/byteorder.h>
>   
>   #define IEEE802154_MTU			127
> @@ -205,6 +207,33 @@ enum {
>   	IEEE802154_SCAN_IN_PROGRESS = 0xfc,
>   };
>   
> +/* frame control handling */
> +#define IEEE802154_FCTL_ACKREQ	0x0020
> +
> +/**
> + * ieee802154_is_ackreq - check if acknowledgment request bit is set
> + * @fc: frame control bytes in little-endian byteorder
> + */
> +static inline bool ieee802154_is_ackreq(__le16 fc)
> +{
> +	return fc & cpu_to_le16(IEEE802154_FCTL_ACKREQ);
> +}
> +
> +/**
> + * ieee802154_get_fc_from_skb - get the frame control field from an skb

... from a skb
> + * @skb: skb where the frame control field will be get from
Maybe:

skb which contains the frame control field

> + */
> +static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
> +{
> +	/* return some invalid fc on failure */
Maybe:

return on invalid fc

> +	if (unlikely(skb->mac_len < 2)) {
> +		WARN_ON(1);
> +		return cpu_to_le16(0);
> +	}
> +
> +	return (__force __le16)__get_unaligned_memmove16(skb_mac_header(skb));

Just to make sure we don't run into problems like we did with the 
6lowpan stack. __get_unaligned_memmove16 is not pulling the fc bytes out 
of the skb, right? The skb stays as it is.

> +}
> +
>   /**
>    * ieee802154_is_valid_psdu_len - check if psdu len is valid
>    * available lengths:

Given the above is true you have my:

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
