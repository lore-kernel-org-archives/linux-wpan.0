Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36658 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbbDQVkr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 17:40:47 -0400
Received: by wgsk9 with SMTP id k9so125764314wgs.3
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 14:40:46 -0700 (PDT)
Date: Fri, 17 Apr 2015 23:40:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: [joao.p.taveira@gmail.com: Re: [Roll] Looking for Linux
 implementation of RPL for interop testing]
Message-ID: <20150417214036.GA847@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: joao.p.taveira@gmail.com

Hi,

I forward this mail to linux-wpan, maybe somebody will be happy about
this information.

The blog post which João mentioned here is available at:

http://sixpinetrees.blogspot.de/2014/11/linux-rpl-router.html

- Alex

----- Forwarded message from João Pedro Taveira <joao.p.taveira@gmail.com> -----

Date: Fri, 17 Apr 2015 20:57:03 +0000
From: João Pedro Taveira <joao.p.taveira@gmail.com>
To: Routing Over Low power and Lossy networks <roll@ietf.org>
Subject: Re: [Roll] Looking for Linux implementation of RPL for interop testing

Hi to all,

I'm glad to know that there's some interested on my RPL linux
implementation.

Since september 2014, I had no opportunity to work on RPL on linux.

When I started this implementation, I thought on possible roadmap:
1. RFC 6206 trickle
2. RFC 6550 RPL
3. RFC 6552 OF0
4. Root Node mode
5. Router Node mode
6. userland tools
7. OF0 Integration tests Linux/Linux
8. OF0 Integration tests with Linux/contiki
9. Tests with Linux/at86rf23x + contiki/atmega128rfa1
10. Tests with Linux/xbee + contiki/m1284p+xbee
11. RFC 6719 MRHOF
12. RFC 6551 Routing Metrics
...

I also tested rpl linux implementation using CORE (
http://www.nrl.navy.mil/itd/ncs/products/core). Using kernel namespaces,
it's easy to test the implementation.

I stop on issues 11. and 12. I got stuck when I start to get MRHOF, ETX and
metrics working. I had to dive on linux netstack to figure out how to get
ETX without breaking (or breaking too much) abstraction layers on netstack.

Since RPL Linux implementation worked very well with 0OF and contiki, I
just tried to make some use of linux nodes with very basic network support
on a small mesh with contiki and linux nodes. The results could be better.
I faced too many basic issues, with very simple resolutions but that would
require some free time to fix that I hadn't.
Regarding to contiki, there's nothing to say since RPL it's quite solid. I
simply needed more ram for the IP buffer since it was only 400bytes long
(there wos no more free space). About RPL implementation, it took too long
to react on mesh changes. At least, multi-hop worked. About linux nodes
within the mesh, I tried to fly to high and I can say that ssh really want
the minimum of ipv6 max MTU. Connecting one of the linux nodes to internet
as gw, the network basic protocols seam to work without problems like DNS,
ICMP6 and CoAP.

Still on MRHOF, I contact linux-zigbee/linux-wpan group to get some
information about roadmap about MAC802154 and I was told that it was too
soon to know what and how things would be. I think there was a merge from
linux zigbee to linux-wpan, but in the meanwhile, it was agreed between
linux groups to merge wpan with bluetooth.

As last resort on ETX and MRHOF on linux and to see it working, I just
tried to use nd6 timers as indication on link quality on linux side.
Basically, when some neighbour moved to state REACHABLE would count as a
good packet delivered. When a neighbour moved to state FAILED would count
as several non-acked packets. Assuming that nodes wouldn't send too many
packets, neighbours would move frequently to IDLE state. On each packet
exchange this would make state to move to REACHABLE and count as good
packet. Using RPL linux as root, this metric would be more or less
acceptable but I didn't like the idea of different metrics. Anyway, I was
able to get correct behaviour from MRHOF from linux nodes (even with a
strange metric).

Since 4thQ 2014, I had no time available to work on this. I think I already
know how to get ETX working. I'll see linux-wpan/linux-bluebooth current
status and I hope to continue what I was doing back then.

About the blog which talks about tests to RPL Linux implementation, I just
want to say that I wasn't contact about it before the post.

Best Regards,
João Pedro Taveira

_______________________________________________
Roll mailing list
Roll@ietf.org
https://www.ietf.org/mailman/listinfo/roll


----- End forwarded message -----
