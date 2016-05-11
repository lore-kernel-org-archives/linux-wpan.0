Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46850 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbcEKPSM (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 11:18:12 -0400
Subject: Re: [PATCH bluetooth-next 1/3] nl802154: move PAD to right position
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <57334D30.1020500@osg.samsung.com>
Date: Wed, 11 May 2016 17:18:08 +0200
MIME-Version: 1.0
In-Reply-To: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Hello.

On 11/05/16 11:44, Alexander Aring wrote:
> The PAD define should be above the experimental support. We don't care
> about if we break userspace in experimental stuff but PAD is part of the
> existing UAPI.
>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   include/net/nl802154.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index fcab4de..7aad2fd 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -124,6 +124,8 @@ enum nl802154_attrs {
>   
>   	NL802154_ATTR_ACKREQ_DEFAULT,
>   
> +	NL802154_ATTR_PAD,
> +
>   	/* add attributes here, update the policy in nl802154.c */
>   
>   #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> @@ -138,8 +140,6 @@ enum nl802154_attrs {
>   	NL802154_ATTR_SEC_KEY,
>   #endif /* CONFIG_IEEE802154_NL802154_EXPERIMENTAL */
>   
> -	NL802154_ATTR_PAD,
> -
>   	__NL802154_ATTR_AFTER_LAST,
>   	NL802154_ATTR_MAX = __NL802154_ATTR_AFTER_LAST - 1
>   };

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
