Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33715 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbcFOLFQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 15 Jun 2016 07:05:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id i123so4171369pfg.0
        for <linux-wpan@vger.kernel.org>; Wed, 15 Jun 2016 04:05:15 -0700 (PDT)
Subject: Re: [PATCHv3 net-next 01/12] 6lowpan: add private neighbour data
References: <20160614115239.17788-1-aar@pengutronix.de>
 <20160614115239.17788-2-aar@pengutronix.de>
From: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <57613667.7040308@miraclelinux.com>
Date: Wed, 15 Jun 2016 20:05:11 +0900
MIME-Version: 1.0
In-Reply-To: <20160614115239.17788-2-aar@pengutronix.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: hideaki.yoshifuji@miraclelinux.com, kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>



Alexander Aring wrote:
> This patch will introduce a 6lowpan neighbour private data. Like the
> interface private data we handle private data for generic 6lowpan and
> for link-layer specific 6lowpan.
> 
> The current first use case if to save the short address for a 802.15.4
> 6lowpan neighbour.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>

Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

> ---
>  include/linux/netdevice.h     |  3 +--
>  include/net/6lowpan.h         | 10 ++++++++++
>  net/ieee802154/6lowpan/core.c | 12 ++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d101e4d..36e43bd 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1483,8 +1483,7 @@ enum netdev_priv_flags {
>   * 	@perm_addr:		Permanent hw address
>   * 	@addr_assign_type:	Hw address assignment type
>   * 	@addr_len:		Hardware address length
> - * 	@neigh_priv_len;	Used in neigh_alloc(),
> - * 				initialized only in atm/clip.c
> + *	@neigh_priv_len:	Used in neigh_alloc()
>   * 	@dev_id:		Used to differentiate devices that share
>   * 				the same link layer address
>   * 	@dev_port:		Used to differentiate devices that share
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index da84cf9..2d9b9d3 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -141,6 +141,16 @@ struct lowpan_dev {
>  	u8 priv[0] __aligned(sizeof(void *));
>  };
>  
> +struct lowpan_802154_neigh {
> +	__le16 short_addr;
> +};
> +
> +static inline
> +struct lowpan_802154_neigh *lowpan_802154_neigh(void *neigh_priv)
> +{
> +	return neigh_priv;
> +}
> +
>  static inline
>  struct lowpan_dev *lowpan_dev(const struct net_device *dev)
>  {
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 4e2b308..8c004a0 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -81,11 +81,21 @@ static int lowpan_stop(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int lowpan_neigh_construct(struct neighbour *n)
> +{
> +	struct lowpan_802154_neigh *neigh = lowpan_802154_neigh(neighbour_priv(n));
> +
> +	/* default no short_addr is available for a neighbour */
> +	neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
> +	return 0;
> +}
> +
>  static const struct net_device_ops lowpan_netdev_ops = {
>  	.ndo_init		= lowpan_dev_init,
>  	.ndo_start_xmit		= lowpan_xmit,
>  	.ndo_open		= lowpan_open,
>  	.ndo_stop		= lowpan_stop,
> +	.ndo_neigh_construct    = lowpan_neigh_construct,
>  };
>  
>  static void lowpan_setup(struct net_device *ldev)
> @@ -150,6 +160,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
>  				wdev->needed_headroom;
>  	ldev->needed_tailroom = wdev->needed_tailroom;
>  
> +	ldev->neigh_priv_len = sizeof(struct lowpan_802154_neigh);
> +
>  	ret = lowpan_register_netdevice(ldev, LOWPAN_LLTYPE_IEEE802154);
>  	if (ret < 0) {
>  		dev_put(wdev);
> 

-- 
Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Technical Division, MIRACLE LINUX CORPORATION
