Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43108 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734AbcGLUe4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 Jul 2016 16:34:56 -0400
Subject: Re: [RFC bluetooth-next 18/20] 6lowpan: move multicast flags to
 generic
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-19-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <1295fe6f-280f-90c1-bb06-a507ecd6dc2b@pengutronix.de>
Date: Tue, 12 Jul 2016 22:34:49 +0200
MIME-Version: 1.0
In-Reply-To: <20160711195044.25343-19-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com


Hi,

On 07/11/2016 09:50 PM, Alexander Aring wrote:
> These flags should be all the same for 6LoWPAN so move it to 6LoWPAN generic.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  net/6lowpan/core.c            | 1 +
>  net/ieee802154/6lowpan/core.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> index a978000..6b7de14 100644
> --- a/net/6lowpan/core.c
> +++ b/net/6lowpan/core.c
> @@ -62,6 +62,7 @@ int lowpan_register_netdevice(struct net_device *dev,
>  	dev->type = ARPHRD_6LOWPAN;
>  	dev->mtu = IPV6_MIN_MTU;
>  	dev->priv_flags |= IFF_NO_QUEUE;
> +	dev->flags = IFF_BROADCAST | IFF_MULTICAST;
>  
>  	dev->header_ops = &header_ops;
>  
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 228a711..a60abad 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -92,7 +92,6 @@ static void lowpan_setup(struct net_device *ldev)
>  	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
>  	/* We need an ipv6hdr as minimum len when calling xmit */
>  	ldev->hard_header_len	= sizeof(struct ipv6hdr);

This should be moved to generic 6lowpan as well.

This says at least, the skb->len at xmit callback must be at least a
length of "sizeof(struct ipv6hdr)" which should be correct.

BUT...

I still have (more than years) the use-case that somebody sends an
AF_PACKET raw socket over lowpan interface.

I didn't test it yet, but I think this is a simple way to crash the
kernel on all lowpan interfaces. I currently not sure if I can break
something there, but I am sure it will send garbage data.

The xmit callback needs data which is available in skb_headroom, this
data is set by header_create callback which will not called on AF_PACKET
RAW sockets.

The root of this issue is that we don't have L2 here for creating mac
headers. The header_create callback should do that, but we do 6LoWPAN
adaptation here and the header_create callback will be used by ndisc to
say "here are the addresses, generate a mac header" and AF_PACKET
_DGRAM_ (for putting mac header in front of AF_PACKET payload).

We use this callback for the first use-case of ndisc only.

AF_PACKET RAW receive make sense, because tcpdump/wireshark needs to
capture data. Sending AF_PACKET RAW makes no sense and will I suppose
crash the kernel and I think every user can do that.

DGRAM sockets maybe makes sense, but I would disable that also for
(receive and transmit). You need to use PF_INET6 socket types for lowpan
interfaces only. That issue is somehow described at [0].

> -	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
>  
>  	ldev->netdev_ops	= &lowpan_netdev_ops;
>  	ldev->destructor	= free_netdev;
> 

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/tx.c#L43
