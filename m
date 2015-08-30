Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32934 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbbH3Vsc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 30 Aug 2015 17:48:32 -0400
Subject: Re: [RFCv2 bluetooth-next 02/16] ieee802154: 6lowpan: register packet
 layer while open
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E37A2C.7080502@osg.samsung.com>
Date: Sun, 30 Aug 2015 23:48:28 +0200
MIME-Version: 1.0
In-Reply-To: <1440089265-23366-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 20/08/15 18:47, Alexander Aring wrote:
> This patch moves the open count handling while doing open of a lowpan
> interface. We need the packet handler register at first when one lowpan
> interface is up.
The code itself looks fine, but I have trouble to gte the why from your 
commit message. Why is this change needed?

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/core.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 3cc76f0..8e9da1d 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -76,9 +76,27 @@ static int lowpan_dev_init(struct net_device *ldev)
>   	return 0;
>   }
>   
> +static int lowpan_open(struct net_device *dev)
> +{
> +	if (!open_count)
> +		lowpan_rx_init();
> +	open_count++;
> +	return 0;
> +}
> +
> +static int lowpan_stop(struct net_device *dev)
> +{
> +	open_count--;
> +	if (!open_count)
> +		lowpan_rx_exit();
> +	return 0;
> +}
> +
>   static const struct net_device_ops lowpan_netdev_ops = {
>   	.ndo_init		= lowpan_dev_init,
>   	.ndo_start_xmit		= lowpan_xmit,
> +	.ndo_open		= lowpan_open,
> +	.ndo_stop		= lowpan_stop,
>   };
>   
>   static void lowpan_setup(struct net_device *ldev)
> @@ -149,11 +167,6 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
>   	}
>   
>   	wdev->ieee802154_ptr->lowpan_dev = ldev;
> -	if (!open_count)
> -		lowpan_rx_init();
> -
> -	open_count++;
> -
>   	return 0;
>   }
>   
> @@ -163,11 +176,6 @@ static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
>   
>   	ASSERT_RTNL();
>   
> -	open_count--;
> -
> -	if (!open_count)
> -		lowpan_rx_exit();
> -
>   	wdev->ieee802154_ptr->lowpan_dev = NULL;
>   	unregister_netdevice(ldev);
>   	dev_put(wdev);

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
