Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:53765 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeCFM45 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 6 Mar 2018 07:56:57 -0500
Subject: Re: [PATCH net] ieee802154: 6lowpan: fix possible NULL deref in
 lowpan_device_event()
References: <1520268663.109662.5.camel@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <99cd0859-4d7a-92a2-03e6-f0ab7daf2bc8@osg.samsung.com>
Date: Tue, 6 Mar 2018 13:56:48 +0100
MIME-Version: 1.0
In-Reply-To: <1520268663.109662.5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>, David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.


On 03/05/2018 05:51 PM, Eric Dumazet wrote:
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

Not sure why you think there is a rename from wdev to ndev necessary.
I see this more of a rolled in cosmetic change, but its not a real problem from my side.

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

Thanks a lot for fixing this and syzbot for finding it.


Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

Dave, could you take this one directly? I have no other patches pending for your net tree (only net-next) and having a pull request for just
this patch does not make much sense.

regards
Stefan Schmidt
