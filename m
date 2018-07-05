Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:49726 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeGEJ5r (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Jul 2018 05:57:47 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH] ieee802154: 6lowpan: set IFLA_LINK
References: <20180702092147.56331-1-lkundrak@v3.sk>
Message-ID: <8bfde3d9-b096-a533-81ff-026ab214920f@datenfreihafen.org>
Date: Thu, 5 Jul 2018 11:57:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180702092147.56331-1-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

On 02.07.2018 11:21, Lubomir Rintel wrote:
> Otherwise NetworkManager (and iproute alike) is not able to identify the
> parent IEEE 802.15.4 interface of a 6LoWPAN link.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  net/ieee802154/6lowpan/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 275449b0d633..3297e7fa9945 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -90,12 +90,18 @@ static int lowpan_neigh_construct(struct net_device *dev, struct neighbour *n)
>  	return 0;
>  }
>  
> +static int lowpan_get_iflink(const struct net_device *dev)
> +{
> +	return lowpan_802154_dev(dev)->wdev->ifindex;
> +}
> +
>  static const struct net_device_ops lowpan_netdev_ops = {
>  	.ndo_init		= lowpan_dev_init,
>  	.ndo_start_xmit		= lowpan_xmit,
>  	.ndo_open		= lowpan_open,
>  	.ndo_stop		= lowpan_stop,
>  	.ndo_neigh_construct    = lowpan_neigh_construct,
> +	.ndo_get_iflink         = lowpan_get_iflink,
>  };
>  
>  static void lowpan_setup(struct net_device *ldev)
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
