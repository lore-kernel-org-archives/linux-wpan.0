Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56443 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbcCWKIV (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 06:08:21 -0400
Subject: Re: [RFC bluetooth-next 06/19] 6lowpan: move lowpan_802154_dev to
 6lowpan
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-7-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56F26B11.9000709@osg.samsung.com>
Date: Wed, 23 Mar 2016 11:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <1458652515-7862-7-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net

Hello.

On 22/03/16 14:15, Alexander Aring wrote:
> This patch moves the 802.15.4 link layer specific structures to generic
> 6lowpan. This is necessary for special 802.15.4 6lowpan handling in
> upper layers.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   include/net/6lowpan.h              | 12 ++++++++++++
>   net/ieee802154/6lowpan/6lowpan_i.h | 12 ------------
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index f204664..a0c01f5 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -144,6 +144,18 @@ struct lowpan_dev *lowpan_dev(const struct net_device *dev)
>   	return netdev_priv(dev);
>   }
>   
> +/* private device info */
> +struct lowpan_802154_dev {
> +	struct net_device	*wdev; /* wpan device ptr */
> +	u16			fragment_tag;
> +};
> +
> +static inline struct
> +lowpan_802154_dev *lowpan_802154_dev(const struct net_device *dev)
> +{
> +	return (struct lowpan_802154_dev *)lowpan_dev(dev)->priv;
> +}
> +
>   struct lowpan_802154_cb {
>   	u16 d_tag;
>   	unsigned int d_size;
> diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
> index b02b74d..5ac7789 100644
> --- a/net/ieee802154/6lowpan/6lowpan_i.h
> +++ b/net/ieee802154/6lowpan/6lowpan_i.h
> @@ -47,18 +47,6 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
>   	}
>   }
>   
> -/* private device info */
> -struct lowpan_802154_dev {
> -	struct net_device	*wdev; /* wpan device ptr */
> -	u16			fragment_tag;
> -};
> -
> -static inline struct
> -lowpan_802154_dev *lowpan_802154_dev(const struct net_device *dev)
> -{
> -	return (struct lowpan_802154_dev *)lowpan_dev(dev)->priv;
> -}
> -
>   int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
>   void lowpan_net_frag_exit(void);
>   int lowpan_net_frag_init(void);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
