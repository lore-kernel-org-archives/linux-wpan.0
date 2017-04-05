Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29091 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752287AbdDEMYT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 5 Apr 2017 08:24:19 -0400
Message-ID: <1491395056.3437.8.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] Bluetooth: L2CAP: Don't return -EAGAIN if out of
 credits
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 05 Apr 2017 15:24:16 +0300
In-Reply-To: <20170403144857.4661-3-luiz.dentz@gmail.com>
References: <20170403144857.4661-1-luiz.dentz@gmail.com>
         <20170403144857.4661-3-luiz.dentz@gmail.com>
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
> Just keep queueing them into TX queue since the caller might just
> have
> to do the same and there is no impact in adding another packet to the
> TX queue even if there aren't any credits to transmit them.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fc7f321..3a202b0 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2458,9 +2458,6 @@ int l2cap_chan_send(struct l2cap_chan *chan,
> struct msghdr *msg, size_t len)
>  		if (len > chan->omtu)
>  			return -EMSGSIZE;
>  
> -		if (!chan->tx_credits)
> -			return -EAGAIN;
> -
>  		__skb_queue_head_init(&seg_queue);
>  
>  		err = l2cap_segment_le_sdu(chan, &seg_queue, msg,
> len);


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

