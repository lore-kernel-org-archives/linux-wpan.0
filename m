Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:54910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCERAq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Mar 2018 12:00:46 -0500
Date: Mon, 05 Mar 2018 12:00:43 -0500 (EST)
Message-Id: <20180305.120043.460580025683278621.davem@davemloft.net>
Subject: Re: [PATCH net] ieee802154: 6lowpan: fix possible NULL deref in
 lowpan_device_event()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520268663.109662.5.camel@gmail.com>
References: <1520268663.109662.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org, alex.aring@gmail.com, stefan@osg.samsung.com, linux-wpan@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 05 Mar 2018 08:51:03 -0800

> From: Eric Dumazet <edumazet@google.com>
> 
> A tun device type can trivially be set to arbitrary value using
> TUNSETLINK ioctl().
> 
> Therefore, lowpan_device_event() must really check that ieee802154_ptr
> is not NULL.
> 
> Fixes: 2c88b5283f60d ("ieee802154: 6lowpan: remove check on null")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@osg.samsung.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Adding linux-wpan list.

> ---
>  net/ieee802154/6lowpan/core.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 974765b7d92a..e9f0489e4229 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -206,9 +206,13 @@ static inline void lowpan_netlink_fini(void)
>  static int lowpan_device_event(struct notifier_block *unused,
>  			       unsigned long event, void *ptr)
>  {
> -	struct net_device *wdev = netdev_notifier_info_to_dev(ptr);
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct wpan_dev *wpan_dev;
>  
> -	if (wdev->type != ARPHRD_IEEE802154)
> +	if (ndev->type != ARPHRD_IEEE802154)
> +		return NOTIFY_DONE;
> +	wpan_dev = ndev->ieee802154_ptr;
> +	if (!wpan_dev)
>  		return NOTIFY_DONE;
>  
>  	switch (event) {
> @@ -217,8 +221,8 @@ static int lowpan_device_event(struct notifier_block *unused,
>  		 * also delete possible lowpan interfaces which belongs
>  		 * to the wpan interface.
>  		 */
> -		if (wdev->ieee802154_ptr->lowpan_dev)
> -			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
> +		if (wpan_dev->lowpan_dev)
> +			lowpan_dellink(wpan_dev->lowpan_dev, NULL);
>  		break;
>  	default:
>  		return NOTIFY_DONE;
> 
