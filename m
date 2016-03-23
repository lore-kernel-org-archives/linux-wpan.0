Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56420 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbcCWJ7Q (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 05:59:16 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC bluetooth-next 01/19] ieee802154: cleanups for ieee802154.h
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-2-git-send-email-aar@pengutronix.de>
Message-ID: <56F268F1.4080403@osg.samsung.com>
Date: Wed, 23 Mar 2016 10:59:13 +0100
MIME-Version: 1.0
In-Reply-To: <1458652515-7862-2-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net

Hello.

On 22/03/16 14:14, Alexander Aring wrote:
> This patch removes some const from non-pointer types and fixes the
> function name for the ieee802154_is_valid_extended_unicast_addr
> comment.
>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   include/linux/ieee802154.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index d3e4156..303f446 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -260,17 +260,17 @@ static inline bool ieee802154_is_intra_pan(__le16 fc)
>    *
>    * @len: psdu len with (MHR + payload + MFR)
>    */
> -static inline bool ieee802154_is_valid_psdu_len(const u8 len)
> +static inline bool ieee802154_is_valid_psdu_len(u8 len)
>   {
>   	return (len == IEEE802154_ACK_PSDU_LEN ||
>   		(len >= IEEE802154_MIN_PSDU_LEN && len <= IEEE802154_MTU));
>   }
>   
>   /**
> - * ieee802154_is_valid_psdu_len - check if extended addr is valid
> + * ieee802154_is_valid_extended_unicast_addr - check if extended addr is valid
>    * @addr: extended addr to check
>    */
> -static inline bool ieee802154_is_valid_extended_unicast_addr(const __le64 addr)
> +static inline bool ieee802154_is_valid_extended_unicast_addr(__le64 addr)
>   {
>   	/* Bail out if the address is all zero, or if the group
>   	 * address bit is set.

Looks fine. This one does not need to wait for the rest of the patches 
to go in either.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
