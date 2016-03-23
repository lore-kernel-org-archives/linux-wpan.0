Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56433 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153AbcCWJ73 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 05:59:29 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC bluetooth-next 03/19] nl802154: avoid address change while
 running lowpan
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-4-git-send-email-aar@pengutronix.de>
Message-ID: <56F268FD.8020301@osg.samsung.com>
Date: Wed, 23 Mar 2016 10:59:25 +0100
MIME-Version: 1.0
In-Reply-To: <1458652515-7862-4-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net

Hello.

On 22/03/16 14:14, Alexander Aring wrote:
> he whole generating of autoconfiguration IPv6 link-local addresses based
> on a notification on interface up.
Maybe this?

"The generation of autoconfigured IPv6 link-local addresses starts with 
a notification on interface up."

> These addresses are based on mac
> addresses and are not changeable during interface up of IPv6 interfaces.
> This patch will disallow mac address changes while a lowpan interface
> for a wpan interface is up.

It might be worthwhile mentioning why we disallow the change of pan_id 
and short address here while you talk about the mac address. Knowing 
that pan_id plus some padding plus short address can be used as 
permanent address for SLA is not common knowledge.

> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   net/ieee802154/nl802154.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 16ef0d9..5f1dc4b 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -1074,6 +1074,11 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
>   	if (netif_running(dev))
>   		return -EBUSY;
>   
> +	if (wpan_dev->lowpan_dev) {
> +		if (netif_running(wpan_dev->lowpan_dev))
> +			return -EBUSY;
> +	}
> +
>   	/* don't change address fields on monitor */
>   	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
>   	    !info->attrs[NL802154_ATTR_PAN_ID])
> @@ -1105,6 +1110,11 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
>   	if (netif_running(dev))
>   		return -EBUSY;
>   
> +	if (wpan_dev->lowpan_dev) {
> +		if (netif_running(wpan_dev->lowpan_dev))
> +			return -EBUSY;
> +	}
> +
>   	/* don't change address fields on monitor */
>   	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
>   	    !info->attrs[NL802154_ATTR_SHORT_ADDR])

While I truly dislike behaviour changes I consider this one an actual 
bug fix as changing these values during runtime would not trigger a SLA 
change and we would thus be out of sync address wise which can lead to 
reall problematic situations.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
