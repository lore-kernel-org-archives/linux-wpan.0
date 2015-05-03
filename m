Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:42851 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbECNvf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 3 May 2015 09:51:35 -0400
Date: Sun, 3 May 2015 15:51:31 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH wpan-next 1/2] nl802154: cleanup invalid argument handling
Message-ID: <20150503135131.GB19980@bogon.m.sigxcpu.org>
References: <1430387232-24878-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430387232-24878-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, Apr 30, 2015 at 11:47:11AM +0200, Alexander Aring wrote:
> This patch cleanups the -EINVAL cases by combining them in one
> condition.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/ieee802154/nl802154.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index f3c12f6..c01f4bb 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -668,10 +668,8 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
>  		return -EBUSY;
>  
>  	/* don't change address fields on monitor */
> -	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> -		return -EINVAL;
> -
> -	if (!info->attrs[NL802154_ATTR_PAN_ID])
> +	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
> +	    !info->attrs[NL802154_ATTR_PAN_ID])
>  		return -EINVAL;
>  
>  	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
> @@ -691,10 +689,8 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
>  		return -EBUSY;
>  
>  	/* don't change address fields on monitor */
> -	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> -		return -EINVAL;
> -
> -	if (!info->attrs[NL802154_ATTR_SHORT_ADDR])
> +	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
> +	    !info->attrs[NL802154_ATTR_SHORT_ADDR])
>  		return -EINVAL;
>  
>  	short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);

ACK
