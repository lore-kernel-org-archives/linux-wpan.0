Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbdDEMXp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 5 Apr 2017 08:23:45 -0400
Message-ID: <1491395022.3437.7.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] Bluetooth: 6lowpan: Print errors during recv_pkt
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 05 Apr 2017 15:23:42 +0300
In-Reply-To: <20170403144857.4661-2-luiz.dentz@gmail.com>
References: <20170403144857.4661-1-luiz.dentz@gmail.com>
         <20170403144857.4661-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: aar@pengutronix.de, linux-wpan@vger.kernel.org

Hi Luiz,

On Mon, 2017-04-03 at 17:48 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes should make it more clear why a packet is being dropped.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 2063e96..5b91e85 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -337,6 +337,7 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  
>  		ret = iphc_decompress(local_skb, dev, peer);
>  		if (ret < 0) {
> +			BT_DBG("iphc_decompress failed: %d", ret);
>  			kfree_skb(local_skb);
>  			goto drop;
>  		}
> @@ -356,6 +357,7 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  		consume_skb(local_skb);
>  		consume_skb(skb);
>  	} else {
> +		BT_DBG("unknown packet type");
>  		goto drop;
>  	}
>  

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

