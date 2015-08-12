Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57294 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbHLIto (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 04:49:44 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 02/16] ieee802154: 6lowpan: remove set to zero
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-3-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB08A5.505@osg.samsung.com>
Date: Wed, 12 Aug 2015 10:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> Internal mechanism by calling netdev_alloc which use kzalloc already
> sets these variables to zero. This patch cleanup the setup of net_device.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/core.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 46efaca..ca331bc 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -88,9 +88,7 @@ static void lowpan_setup(struct net_device *ldev)
>   	ldev->hard_header_len	= 2 + 1 + 20 + 14;
>   	ldev->needed_tailroom	= 2; /* FCS */
>   	ldev->mtu		= IPV6_MIN_MTU;
> -	ldev->tx_queue_len	= 0;
>   	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
> -	ldev->watchdog_timeo	= 0;
>   
>   	ldev->netdev_ops	= &lowpan_netdev_ops;
>   	ldev->header_ops	= &lowpan_header_ops;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
