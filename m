Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42500 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929AbcGUHKT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 21 Jul 2016 03:10:19 -0400
Subject: Re: [RFC bluetooth-next 01/20] 6lowpan: ndisc: don't remove short
 address
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-2-aar@pengutronix.de>
 <1996.1468934387@obiwan.sandelman.ca>
 <fef88ca3-84dc-822a-2ba1-0e593885bd8a@pengutronix.de>
 <6d9dc3cd-c272-6f77-a81e-cc6556097c4f@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <88ca76b5-2fb4-6201-1bb9-2a6ec2a46fc9@pengutronix.de>
Date: Thu, 21 Jul 2016 09:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <6d9dc3cd-c272-6f77-a81e-cc6556097c4f@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hi,

On 07/21/2016 08:37 AM, Alexander Aring wrote:
> 
...
> ---
> 
> For the transmit side, I think receive side would be _per_ _socket_
> then, if we using in6_pktinfo. For the transmit side we should have it
> also per socket then.
> 
> My idea with "using neighbour discovery with flags" will not work!
> Because if we doing our own neighbour over IPv6 RAW sockets then we
> don't have a neighbour discovery yet.
> 
> The other solution might work with the "own" hash table and daddr as key
> to map which l2 address will be used, but I think we should be able to
> do this somehow like "IPV6_RECVPKTINFO" just for the tx side.
> 

The b) case and I think this is to control source address as "interface"
attribute to prefer short or extended will be complicated. I currently
think about if you doing that fast while a current socket connection.

You can't control it because sockets have queues (so far I know).
Maybe I am wrong and synced send handling will wait until "xmit
callback" of the interface will be called (It's a zero queue interface).
Zero queue means that there is no qdisc but socket queues exists, so far
I know.

It should be possible to tell somehow over IPv6 raw sockets which
destination address for the l2 address should be used, or? I think the
solution is maybe somewhere in libndp.c I didn't found it yet. We just
need to add support for the 802.15.4 short or extended addr.

Our current implementation will not work with disabled kernelspace
neighbour discovery yet and currently I don't know how it can work when
holding the complete cache inside the userspace. :-/

Disable ndisc handling in kernelspace and do handling in userspace
(RS/RA/NS/NA) but using the neighbour cache in kernel. Means: fill the
neighbour entries in the cache with netlink might work. Don't know which
way we should going here. I need to look into libndp, I think we should
extend it that we can handle short+extended handling from userspace side.

- Alex
