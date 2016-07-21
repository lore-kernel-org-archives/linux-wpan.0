Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48652 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbcGUGhz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 21 Jul 2016 02:37:55 -0400
Subject: Re: [RFC bluetooth-next 01/20] 6lowpan: ndisc: don't remove short
 address
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-2-aar@pengutronix.de>
 <1996.1468934387@obiwan.sandelman.ca>
 <fef88ca3-84dc-822a-2ba1-0e593885bd8a@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <6d9dc3cd-c272-6f77-a81e-cc6556097c4f@pengutronix.de>
Date: Thu, 21 Jul 2016 08:37:51 +0200
MIME-Version: 1.0
In-Reply-To: <fef88ca3-84dc-822a-2ba1-0e593885bd8a@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org


Hi,

On 07/19/2016 08:03 PM, Alexander Aring wrote:
...
> 
>> I think that the above probably gets us all the mechanisms we need for
>> transmit.   For receive, I think that we have no APIs that will give you the
>> layer-2 address for an incoming packet the way that IPV6_RECVPKTINFO will
>> do for layer-3 addresses and extensions.   It would be nice to have such
>> an API.
> 
> I also have no idea to get L2 receive information to the userspace at
> the IPv6 socket yet. Need to take a look into ipv6 sockets,
> IPV6_RECVPKTINFO is a nice hint, if we can easly extend this information.
>

I looked into that and believe to know how the IPV6_RECVPKTINFO handling
works. Then we need to add something add [0]. For example:

unsigned char llsaddr[32];
unsigned char lldaddr[32];

where 32 is the current MAX_ADDR_LEN and put some 802.15.4 6LoWPAN
specific UAPI in there for representing the 802.15.4 address, should be
"struct ieee802154_addr". This requires to get dev->type and subtype
before.

I found some example code [1] for that and it seems that they using for a
similar use-case which we have:

 - We don't have working neighbour discovery yet
 - We want to do our own neighbour discovery in userspace

That's what libndp do also somehow as a library. In our case we need:

 - We need to control somehow from userspace side which mac address
   should be used (tx) or was used (rx), in case of 802.15.4 different
   mac addresses stuff.

To evaluate the "(struct in6_pktinfo *)" I found [2]. I think for
receive side this should working. I don't know how netdev people reacts
when we want to put L2 information into "in6_pktinfo". We simple need to
try that, L2 information requires to evaluate the device types before.

---

Another issue is that it's currently not possible to get mac header
inside the IPv6 subsystem. We should parse the mac header again there to
get the address, we need that to fill "in6_pktinfo".

So why this is not working currently? Because IPHC will overwrite the
mac header :-) while uncompression. We need to work with skb fragments
there and linearlize the skb afterwards to fiddle new data in the
middle of that again.

This is currently a bug and I want to look for that anyway, because skb
fragments should handle some parts better when doing NHC.

---

For the transmit side, I think receive side would be _per_ _socket_
then, if we using in6_pktinfo. For the transmit side we should have it
also per socket then.

My idea with "using neighbour discovery with flags" will not work!
Because if we doing our own neighbour over IPv6 RAW sockets then we
don't have a neighbour discovery yet.

The other solution might work with the "own" hash table and daddr as key
to map which l2 address will be used, but I think we should be able to
do this somehow like "IPV6_RECVPKTINFO" just for the tx side.

- Alex

[0] http://lxr.free-electrons.com/source/include/uapi/linux/ipv6.h#L19
[1] https://github.com/jpirko/libndp
[2] https://github.com/jpirko/libndp/blob/master/libndp/libndp.c#L174
