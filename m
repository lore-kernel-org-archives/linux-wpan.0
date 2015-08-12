Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57360 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754262AbbHLNhn (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 09:37:43 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 15/16] ieee802154: 6lowpan: check on valid 802.15.4 frame
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-16-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB4C24.1050707@osg.samsung.com>
Date: Wed, 12 Aug 2015 15:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-16-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This patch adds frame control checks to check if the received frame is
> something which could contain a 6LoWPAN packet.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   include/linux/ieee802154.h  | 48 ++++++++++++++++++++++++++++++++++++++++++++-
>   net/ieee802154/6lowpan/rx.c |  9 +++++++++
>   2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index 4f26c01..5a64fc0 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -208,7 +208,24 @@ enum {
>   };
>   
>   /* frame control handling */
> -#define IEEE802154_FCTL_ACKREQ	0x0020
> +#define IEEE802154_FCTL_FTYPE		0x0003
> +#define IEEE802154_FTYPE_DATA		0x0001
> +#define IEEE802154_FCTL_ACKREQ		0x0020
> +#define IEEE802154_FCTL_INTRA_PAN	0x0040
> +#define IEEE802154_FCTL_DADDR		0x0c00
> +#define IEEE802154_FCTL_DADDR_NONE	0x0000
> +#define IEEE802154_FCTL_SADDR		0xc000
> +#define IEEE802154_FCTL_SADDR_NONE	0x0000
> +
> +/*
> + * ieee802154_is_data - check if type is IEEE802154_FTYPE_DATA
> + * @fc: frame control bytes in little-endian byteorder
> + */
> +static inline int ieee802154_is_data(__le16 fc)
> +{
> +	return (fc & cpu_to_le16(IEEE802154_FCTL_FTYPE)) ==
> +		cpu_to_le16(IEEE802154_FTYPE_DATA);
> +}
>   
>   /**
>    * ieee802154_is_ackreq - check if acknowledgment request bit is set
> @@ -220,6 +237,35 @@ static inline bool ieee802154_is_ackreq(__le16 fc)
>   }
>   
>   /**
> + * ieee802154_is_intra_pan - check if intra pan id communication
> + * @fc: frame control bytes in little-endian byteorder
> + */
> +static inline bool ieee802154_is_intra_pan(__le16 fc)
> +{
> +	return fc & cpu_to_le16(IEEE802154_FCTL_INTRA_PAN);
> +}
> +
> +/**
> + * ieee802154_is_daddr_none - check if daddr mode is none
> + * @fc: frame control bytes in little-endian byteorder
> + */
> +static inline bool ieee802154_is_daddr_none(__le16 fc)
> +{
> +	return (fc & cpu_to_le16(IEEE802154_FCTL_DADDR)) ==
> +		cpu_to_le16(IEEE802154_FCTL_DADDR_NONE);
> +}
> +
> +/**
> + * ieee802154_is_saddr_none - check if saddr mode is none
> + * @fc: frame control bytes in little-endian byteorder
> + */
> +static inline bool ieee802154_is_saddr_none(__le16 fc)
> +{
> +	return (fc & cpu_to_le16(IEEE802154_FCTL_SADDR)) ==
> +		cpu_to_le16(IEEE802154_FCTL_SADDR_NONE);
> +}
> +
> +/**
>    * ieee802154_get_fc_from_skb - get the frame control field from an skb
>    * @skb: skb where the frame control field will be get from
>    */
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 48869ac..b1a9d14 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -264,6 +264,15 @@ static inline bool lowpan_is_reserved(u8 dispatch)
>    */
>   static bool lowpan_rx_h_check(struct sk_buff *skb)
>   {
> +	__le16 fc = ieee802154_get_fc_from_skb(skb);
> +
> +	/* check on ieee802154 conform 6LoWPAN header */
> +	if (!ieee802154_is_data(fc) ||
> +	    ieee802154_is_daddr_none(fc) ||
> +	    ieee802154_is_saddr_none(fc) ||
> +	    !ieee802154_is_intra_pan(fc))

Interesting, 6LoWPAN frames always have to have the intra PAN flag set? 
Did not know this until now.
> +		return false;
> +
>   	/* check for if we can evaluate the dispatch */
>   	if (unlikely(!skb->len))
>   		return false;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
