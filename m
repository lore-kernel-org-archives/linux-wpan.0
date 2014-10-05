Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:39886 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbaJESRb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Oct 2014 14:17:31 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so4916350wgh.23
        for <linux-wpan@vger.kernel.org>; Sun, 05 Oct 2014 11:17:30 -0700 (PDT)
Date: Sun, 5 Oct 2014 20:17:24 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop
 PACKET_OTHERHOST skbs in 6lowpan
Message-ID: <20141005181722.GA651@omega>
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

Simon,

I applied now this patch to linux-wpan-next/testing, this should fix
routing problems. For the upcomming issue "always set PACKET_HOST"... I
put it on the TODO list. ;-)

Thanks.

I will send it to bluetooth-next now, then Martin can base his patches
on it.

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
> -- 
> 1.9.1
> 
