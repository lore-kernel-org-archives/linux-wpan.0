Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37180 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbHOLuJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2015 07:50:09 -0400
Received: by wibhh20 with SMTP id hh20so43016032wib.0
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2015 04:50:07 -0700 (PDT)
Date: Sat, 15 Aug 2015 13:50:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC 04/16] ieee802154: 6lowpan: remove check on wdev is running
Message-ID: <20150815114959.GA1659@omega>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-5-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1438583035-6287-5-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On Mon, Aug 03, 2015 at 08:23:43AM +0200, Alexander Aring wrote:
> We don't need to check if the wpan interface is running because the
> lowpan_rcv is the packet layer receive handler for thw wpan interface.
> This means for the check if the wpan interface is running ends always in
> true.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/ieee802154/6lowpan/rx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 6302b94..99aeb56 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -71,9 +71,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
>  	if (!skb)
>  		goto drop;
>  
> -	if (!netif_running(wdev))
> -		goto drop_skb;
> -
> 

I think this check should be converted to check if lowpan_dev (which
belongs to the wdev) is running. Then we can drop it earlier. I think it
currently works because netif_rx handles that then when the interface is
down which belongs to the skb->dev.

There is a small window when the lowpan is down and while doing 6lowpan
stuff. It could be that the lowpan is set to up while doing the 6lowpan
stuff.

Vice versa it could be that the lowpan interface is up and then down
while doing 6lowpan stuff, but then again netif_rx will handle that
then right (I hope, since commit
e9e4dd3267d0c5234c5c0f47440456b10875dec9 "net: do not process device
backlog during unregistration" it does that with netif_running, but I
think there must be some machanism for that before otherwise we should
got issues when a lowpan_dev was down and receive skb's).


With changing this to netif_running according the lowpan_dev, we have
the second case only. Both cases are very unlikely.

It's just a likely case to have lowpan interface down and then we always
do 6lowpan adaptation layer and then netif_rx will drop it because
netif_running is false. We should check this earlier.

- Alex
