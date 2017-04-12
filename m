Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33540 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbdDLN4V (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 12 Apr 2017 09:56:21 -0400
Message-ID: <1492005377.2926.16.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] Bluetooth: 6lowpan: Don't drop packets when run out
 of credits
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 12 Apr 2017 16:56:17 +0300
In-Reply-To: <20170411192103.3209-2-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
         <20170411192103.3209-2-luiz.dentz@gmail.com>
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
> Since l2cap_chan_send will now queue the packets there is no point in
> checking the credits anymore.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 5b91e85..22bd936 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -478,15 +478,8 @@ static int send_pkt(struct l2cap_chan *chan,
> struct sk_buff *skb,
>  		return 0;
>  	}
>  
> -	if (!err)
> -		err = (!chan->tx_credits ? -EAGAIN : 0);
> -
> -	if (err < 0) {
> -		if (err == -EAGAIN)
> -			netdev->stats.tx_dropped++;
> -		else
> -			netdev->stats.tx_errors++;
> -	}
> +	if (err < 0)
> +		netdev->stats.tx_errors++;
>  
>  	return err;
>  }


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

