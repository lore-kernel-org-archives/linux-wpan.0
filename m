Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34940 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbbDKH4d (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Apr 2015 03:56:33 -0400
Received: by wgyo15 with SMTP id o15so36811176wgy.2
        for <linux-wpan@vger.kernel.org>; Sat, 11 Apr 2015 00:56:32 -0700 (PDT)
Date: Sat, 11 Apr 2015 09:56:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: add description to mac802154
 APIs
Message-ID: <20150411075624.GA25219@omega>
References: <1428581461-5312-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1428581461-5312-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Thu, Apr 09, 2015 at 05:41:01PM +0530, Varka Bhadram wrote:
> This patch adds the proper description to the mac802154 core APIs.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Acked-by: Alexander Aring <alex.aring@gmail.com>

> ---
>  include/net/mac802154.h |   94 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index e18e7fd..0553ec0 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -247,19 +247,109 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
>  	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
>  }
>  

...

just nitpicking here.

> +/**
> + * ieee802154_rx_irqsafe - receive frame
> + *

here you use the correct terminlogy "frame".

> + * Like ieee802154_rx() but can be called in IRQ context
> + * (internally defers to a tasklet.)
> + *
> + * @hw: the hardware this frame came in on
> + * @skb: the buffer to receive, owned by mac802154 after this call
> + * @lqi: link quality indicator
> + */
>  void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
>  			   u8 lqi);
> -
> +/**
> + * ieee802154_wake_queue - wake ieee802154 queue
> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> + *
> + * Drivers should use this function instead of netif_wake_queue.
> + */
>  void ieee802154_wake_queue(struct ieee802154_hw *hw);
> +
> +/**
> + * ieee802154_stop_queue - stop ieee802154 queue
> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> + *
> + * Drivers should use this function instead of netif_stop_queue.
> + */
>  void ieee802154_stop_queue(struct ieee802154_hw *hw);
> +
> +/**
> + * ieee802154_xmit_complete - packet transmission complete
> + *

here you use packet which is wrong. L2 is frame, see [0].

Nevertheless I like that somebody improve the commentation stuff. Thanks
:-)

> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> + * @skb: buffer for transmission
> + * @ifs_handling: indicate interframe space handling
> + */
>  void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
>  			      bool ifs_handling);
>  

- Alex

[0] http://en.wikipedia.org/wiki/Network_packet#Terminology
