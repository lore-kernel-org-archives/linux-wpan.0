Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35595 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750786AbcGWMqf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 23 Jul 2016 08:46:35 -0400
Subject: Re: [PATCH 1/3] mac802154: don't warn on unsupported frames
References: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <78726941-7d65-1ece-e203-f1507597978a@pengutronix.de>
Date: Sat, 23 Jul 2016 14:46:28 +0200
MIME-Version: 1.0
In-Reply-To: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>


Hi,

On 07/22/2016 07:18 PM, Aristeu Rozanski wrote:
> Just because we don't support certain types of frames yet doesn't mean
> we have to flood the message log with warnings about "invalid" frames.
> 

agree, but this patch introduce a different stats handling right now. :-)

> Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
> ---
>  net/mac802154/rx.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 446e130..d388bf2 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -82,6 +82,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
>  		break;
>  	default:
>  		pr_debug("invalid dest mode\n");
> +		sdata->dev->stats.rx_frame_errors++;
>  		goto fail;
>  	}
>  
> @@ -97,15 +98,22 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
>  		goto fail;
>  	}
>  
> -	sdata->dev->stats.rx_packets++;
> -	sdata->dev->stats.rx_bytes += skb->len;
> -
>  	switch (mac_cb(skb)->type) {
> +	case IEEE802154_FC_TYPE_BEACON:
> +	case IEEE802154_FC_TYPE_ACK:
> +	case IEEE802154_FC_TYPE_MAC_CMD:
> +		sdata->dev->stats.rx_dropped++;
> +		goto fail;
> +
>  	case IEEE802154_FC_TYPE_DATA:
> +		sdata->dev->stats.rx_bytes += skb->len;
> +		sdata->dev->stats.rx_packets++;

This should be moved into ieee802154_deliver_skb, right before calling
netif_rx(...);

The reason is because we have for "stats.rx_bytes" and
"stats.rx_packets" a very clean definition what it means. It means, the
frames hit a state where it is ready to put it into the packet-layer,
this is what netif_rx is doing.

It's okay for me to add support for rx_frame_errors and also rx_dropped
stuff. But with a very big warning that the meaning of such stats will
be touched again later if we found some strategie where we we define
what each stats attribute means. Also there exists subsystems which
simple ignore these stats, because at userspace side you need always to
lookup what the definition means and when we run such stats counters and
when not and some subsystems don't care about that.

- Alex
