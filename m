Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:50423 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbbF2NQK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 29 Jun 2015 09:16:10 -0400
Message-ID: <55914516.1070306@osg.samsung.com>
Date: Mon, 29 Jun 2015 15:16:06 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] mac802154: do not export ieee802154_rx()
References: <1435570267-12971-1-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1435570267-12971-1-git-send-email-varkabhadram@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

Hello.

On 29/06/15 11:31, Varka Bhadram wrote:
> Right now there are no other users for ieee802154_rx()
> in kernel. So lets remove EXPORT_SYMBOL() for this.
>
> Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
> ---
>   net/mac802154/rx.c |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 5a258c1..7791c9b 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -290,7 +290,6 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
>   drop:
>   	kfree_skb(skb);
>   }
> -EXPORT_SYMBOL(ieee802154_rx);
>   
>   void
>   ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

Looks good to me. As long as we don't have any pending users this sounds 
like a good idea to not expose it until needed.

regards
Stefan Schmidt
