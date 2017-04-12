Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27539 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752224AbdDLN4A (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 12 Apr 2017 09:56:00 -0400
Message-ID: <1492005346.2926.15.camel@linux.intel.com>
Subject: Re: [PATCH 1/6] 6lowpan: Don't set IFF_NO_QUEUE
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 12 Apr 2017 16:55:46 +0300
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org

Hi Luiz,

On Tue, 2017-04-11 at 22:20 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> There is no point in setting IFF_NO_QUEUE should already have taken
> care of setting it if tx_queue_len is not set, in fact this may
> actually disable queue for interfaces that require it and do set
> tx_queue_len.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/6lowpan/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> index 5f9909a..40d3d72 100644
> --- a/net/6lowpan/core.c
> +++ b/net/6lowpan/core.c
> @@ -35,7 +35,6 @@ int lowpan_register_netdevice(struct net_device
> *dev,
>  
>  	dev->type = ARPHRD_6LOWPAN;
>  	dev->mtu = IPV6_MIN_MTU;
> -	dev->priv_flags |= IFF_NO_QUEUE;
>  
>  	lowpan_dev(dev)->lltype = lltype;
>  

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

