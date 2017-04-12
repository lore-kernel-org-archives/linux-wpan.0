Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63063 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752484AbdDLN6T (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 12 Apr 2017 09:58:19 -0400
Message-ID: <1492005494.2926.19.camel@linux.intel.com>
Subject: Re: [PATCH 5/6] Bluetooth: 6lowpan: Set tx_queue_len to
 DEFAULT_TX_QUEUE_LEN
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 12 Apr 2017 16:58:14 +0300
In-Reply-To: <20170411192103.3209-5-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
         <20170411192103.3209-5-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org

Hi Luiz,

On Tue, 2017-04-11 at 22:21 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Make netdev queue packets if we run out of credits.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index dc7fda3..a4deba6 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -20,6 +20,7 @@
>  #include <net/ipv6.h>
>  #include <net/ip6_route.h>
>  #include <net/addrconf.h>
> +#include <net/pkt_sched.h>
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -594,6 +595,7 @@ static void netdev_setup(struct net_device *dev)
>  	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
>  				  IFF_MULTICAST;
>  	dev->watchdog_timeo	= 0;
> +	dev->tx_queue_len	= DEFAULT_TX_QUEUE_LEN;
>  
>  	dev->netdev_ops		= &netdev_ops;
>  	dev->header_ops		= &header_ops;


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

