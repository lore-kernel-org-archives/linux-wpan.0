Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:48975 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759397AbbFBOoi (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 2 Jun 2015 10:44:38 -0400
Message-ID: <556DC152.1060505@osg.samsung.com>
Date: Tue, 02 Jun 2015 16:44:34 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: set ackreq when needed
References: <1433253317-30920-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433253317-30920-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 02/06/15 15:55, Alexander Aring wrote:
> This patch sets the acknowledge request bit inside the 802.15.4 mac
> header when frame retries is 0 or above. The other frame retries value
> which is -1 indicates that the transmitter doesn't care about an
> acknowledge frame which will be ignored after transmitting if the node
> sends anyway an ack frame after receiving. This is currently unnecessary
> traffic if the max frame retries parameter is -1.
>
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

I tested this here and verified with wireshark. ACK request bit is set 
correctly and no ACK is coming back. Idea is also sound.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
