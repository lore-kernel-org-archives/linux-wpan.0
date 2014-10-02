Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35137 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaJBJ3Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:29:16 -0400
Received: by mail-wi0-f182.google.com with SMTP id n3so3339836wiv.15
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 02:29:15 -0700 (PDT)
Date: Thu, 2 Oct 2014 11:29:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop
 PACKET_OTHERHOST skbs in 6lowpan
Message-ID: <20141002092911.GD3850@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <1412240206-6098-4-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412240206-6098-4-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, varkabhadram@gmail.com, jukka.rissanen@linux.intel.com

On Thu, Oct 02, 2014 at 09:56:46AM +0100, Simon Vincent wrote:
> There is no point processing pkts which are PACKET_OTHERHOST
> in 6lowpan as they are discarded as soon as they reach the
> ipv6 layer. Therefore we should drop them in the 6lowpan layer.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/ieee802154/6lowpan_rtnl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index e246edc..820922a 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -515,6 +515,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!netif_running(dev))
>  		goto drop_skb;
>  
> +	if (skb->pkt_type == PACKET_OTHERHOST)
> +		goto drop_skb;
> +
>  	if (dev->type != ARPHRD_IEEE802154)
>  		goto drop_skb;
>  

This one should also added in bluetooth, but I don't know where. Maybe
Jukka will take care of this.

- Alex
