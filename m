Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40428 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbdDLN6y (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 12 Apr 2017 09:58:54 -0400
Message-ID: <1492005529.2926.20.camel@linux.intel.com>
Subject: Re: [PATCH 6/6] bluetooth: Do not set IFF_POINTOPOINT
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 12 Apr 2017 16:58:49 +0300
In-Reply-To: <20170411192103.3209-6-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
         <20170411192103.3209-6-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org


On Tue, 2017-04-11 at 22:21 +0300, Luiz Augusto von Dentz wrote:
> From: Patrik Flykt <patrik.flykt@linux.intel.com>
> 
> The IPv6 stack needs to send and receive Neighbor Discovery
> messages. Remove the IFF_POINTOPOINT flag.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index a4deba6..6089599 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -592,8 +592,7 @@ static void netdev_setup(struct net_device *dev)
>  {
>  	dev->hard_header_len	= 0;
>  	dev->needed_tailroom	= 0;
> -	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
> -				  IFF_MULTICAST;
> +	dev->flags		= IFF_RUNNING | IFF_MULTICAST;
>  	dev->watchdog_timeo	= 0;
>  	dev->tx_queue_len	= DEFAULT_TX_QUEUE_LEN;
>  


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

