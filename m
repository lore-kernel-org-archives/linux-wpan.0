Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50342 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204AbcGNIg4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 14 Jul 2016 04:36:56 -0400
Subject: Re: [RFC bluetooth-next 18/20] 6lowpan: move multicast flags to
 generic
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-19-aar@pengutronix.de>
 <1295fe6f-280f-90c1-bb06-a507ecd6dc2b@pengutronix.de>
 <1468408545.3075.21.camel@linux.intel.com>
 <387348cd-0e5e-45e8-5117-42aed5d945b9@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <3898a593-538d-6ca5-9ab0-177e1ccfdb3f@pengutronix.de>
Date: Thu, 14 Jul 2016 10:36:50 +0200
MIME-Version: 1.0
In-Reply-To: <387348cd-0e5e-45e8-5117-42aed5d945b9@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com


Hi,

On 07/14/2016 10:21 AM, Alexander Aring wrote:
> 
> Hi,
> 
> On 07/13/2016 01:15 PM, Jukka Rissanen wrote:
>> Hi Alex,
>>
>> On Tue, 2016-07-12 at 22:34 +0200, Alexander Aring wrote:
>>> Hi,
>>>
>>> On 07/11/2016 09:50 PM, Alexander Aring wrote:
>>>>
>>>> These flags should be all the same for 6LoWPAN so move it to
>>>> 6LoWPAN generic.
>>>>
>>>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>>>> ---
>>>>  net/6lowpan/core.c            | 1 +
>>>>  net/ieee802154/6lowpan/core.c | 1 -
>>>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
>>>> index a978000..6b7de14 100644
>>>> --- a/net/6lowpan/core.c
>>>> +++ b/net/6lowpan/core.c
>>>> @@ -62,6 +62,7 @@ int lowpan_register_netdevice(struct net_device
>>>> *dev,
>>>>  	dev->type = ARPHRD_6LOWPAN;
>>>>  	dev->mtu = IPV6_MIN_MTU;
>>>>  	dev->priv_flags |= IFF_NO_QUEUE;
>>>> +	dev->flags = IFF_BROADCAST | IFF_MULTICAST;
>>>>  
>>>>  	dev->header_ops = &header_ops;
>>>>  
>>>> diff --git a/net/ieee802154/6lowpan/core.c
>>>> b/net/ieee802154/6lowpan/core.c
>>>> index 228a711..a60abad 100644
>>>> --- a/net/ieee802154/6lowpan/core.c
>>>> +++ b/net/ieee802154/6lowpan/core.c
>>>> @@ -92,7 +92,6 @@ static void lowpan_setup(struct net_device *ldev)
>>>>  	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
>>>>  	/* We need an ipv6hdr as minimum len when calling xmit */
>>>>  	ldev->hard_header_len	= sizeof(struct ipv6hdr);
>>> This should be moved to generic 6lowpan as well.
>>>
>>> This says at least, the skb->len at xmit callback must be at least a
>>> length of "sizeof(struct ipv6hdr)" which should be correct.
>>>
>>> BUT...
>>>
>>> I still have (more than years) the use-case that somebody sends an
>>> AF_PACKET raw socket over lowpan interface.
>>
>> According to packet(7), the "Packet sockets are used to receive or send
>> raw packets at the device driver (OSI Layer 2) level."
>> But lowpan0 interface is meant to compress IPv6 header so it is working
>> on L3 data (or more precisely between L2 and L3).
>> So I am wondering how this is suppose to work and what kind of use case
>> you have for this?
>>
> 
> I think the issue is more complex, forget what the man page says here.
> We use this callback for something which isn't made for, because the
> IPv6 ndisc will tell us over this callback "what's the destination L2
> address".
> 
> Sorry, I wrote something here which confused you. I meant more I think
> about the use-case that users could try to using AF_PACKET RAW sockets
> here and I think they can kill the kernel with the right parameters.
> 
> Sending AF_PACKET RAW here makes completely no sense and should be
> disabled. Because we set in this callback something in the skb_headroom
> and xmit callback will use it.
> 
> IMPORTANT NOTE: this handling is weird, because we except here that
> between header_create and xmit the IPv6 subsytem will not do
> skb_put/skb_push anymore. I currently think they will never do that
> because the header_create callback is normally there to put a mac header
> to the socket buffer. So IPv6 creation should be mostly done.
> 
> Sending DGRAM sockets it could make sense somehow for a crazy use-case
> which maybe under 0.1% users wants. You can give the ndisc information
> from userspace over that, source and destination address.
> 
> Nevertheless I would disable AF_PACKET DGRAM/RAW handling, EXCEPT RAW
> RECEIVE handling. This will already be used by wireshark/tcpdump/etc.
> 
> ---
> 
> Alternative half solution:
> 
> I already thought about to simple make a re-lookup on ipv6 ndisc
> cache for L3 destination address. Like we do for short address handling.
> 
> But this will not work for broadcast addresses, I would more use the
> normally functionality in IPv6 to tell us the L2 destination address
> which is "header_create".
> 
> I need to think about the real solution to handle everything, you could
> also except that somebody sends IPv6 raw over AF_PACKET here, then
> parsing L3 daddr and do such lookup on ndisc for L2 daddr, but there
> exists this problem with broadcast. I need to look into IPv6 how we
> otherwise can detect unicast or multicast, maybe it's just when L3 is
> multicast, but I would not bet on that. I need to look into IPv6 to
> get an answer.
> 

But this handling to send RAW IPv6 on AF_PACKET should not be done over
AF_PACKET, there exists sockets in AF_INET6 to do that. So I think
disable AF_PACKET (except RAW rx functionality) would be okay...
using AF_PACKET for such use-case is wrong anyway.

- Alex
