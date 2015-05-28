Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57774 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbbE1IWW (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 28 May 2015 04:22:22 -0400
Message-ID: <5566D03B.7080209@osg.samsung.com>
Date: Thu, 28 May 2015 10:22:19 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] ieee802154: 6lowpan: set ackreq when needed
References: <1432721532-21239-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432721532-21239-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 27/05/15 12:12, Alexander Aring wrote:
> This patch sets the acknowledge request bit inside the 802.15.4 mac
> header when frame retries is 0 or above. The other frame retries value
> which is -1 indicates that the transmitter doesn't care about an
> acknowledge frame which will be ignored after transmitting if the node
> sends anyway an ack frame after receiving. This is currently unnecessary
> traffic if the max frame retries parameter is -1. I hope transceivers
> which supports AACK handling will check on this bit and doesn't send an
> ack frame after receiving.

Do we know if AACK enbaled receivers really parse this and avoid sending 
the ACK? They should but I wonder if you did run any test for this.

regards
Stefan Schmidt

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/tx.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> index 98acf73..2597abb 100644
> --- a/net/ieee802154/6lowpan/tx.c
> +++ b/net/ieee802154/6lowpan/tx.c
> @@ -190,6 +190,7 @@ err:
>   
>   static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
>   {
> +	struct wpan_dev *wpan_dev = lowpan_dev_info(dev)->real_dev->ieee802154_ptr;
>   	struct ieee802154_addr sa, da;
>   	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
>   	struct lowpan_addr_info info;
> @@ -207,7 +208,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
>   
>   	/* prepare wpan address data */
>   	sa.mode = IEEE802154_ADDR_LONG;
> -	sa.pan_id = lowpan_dev_info(dev)->real_dev->ieee802154_ptr->pan_id;
> +	sa.pan_id = wpan_dev->pan_id;
>   	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
>   
>   	/* intra-PAN communications */
> @@ -223,7 +224,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
>   	} else {
>   		da.mode = IEEE802154_ADDR_LONG;
>   		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
> -		cb->ackreq = true;
> +		cb->ackreq = wpan_dev->frame_retries >= 0;
>   	}
>   
>   	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,

