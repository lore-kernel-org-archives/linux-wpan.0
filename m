Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:49125 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaI3LNd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 07:13:33 -0400
Received: by mail-we0-f179.google.com with SMTP id u56so6815527wes.38
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 04:13:31 -0700 (PDT)
Date: Tue, 30 Sep 2014 13:13:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930111324.GA12630@omega>
References: <20140930083835.GA20280@omega>
 <542A6DF6.809@gmail.com>
 <20140930085347.GA28060@omega>
 <542A73A3.5010705@gmail.com>
 <20140930092550.GB28060@omega>
 <542A7953.5080306@gmail.com>
 <20140930094320.GC28060@omega>
 <542A7D85.8050608@gmail.com>
 <20140930100357.GD28060@omega>
 <1412074514.4860.116.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412074514.4860.116.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

Hi Jukka,

On Tue, Sep 30, 2014 at 01:55:14PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ti, 2014-09-30 at 12:03 +0200, Alexander Aring wrote:
> > On Tue, Sep 30, 2014 at 03:23:09PM +0530, Varka Bhadram wrote:
> > > On 09/30/2014 03:13 PM, Alexander Aring wrote:
> > > >
> > > >>May be IEEE-802.11 packets send to IPv6 Layer. In that case Its not dead code.
> > > >>
> > > >
> > > >802.11 data frames will be converted to ethernet frames.
> > > >
> > > >Why we now talking about 802.11? 6LoWPAN set always PACKET_HOST and then
> > > >we never have PACKET_BROADCAST set in IPv6 Layer. Then matching pkt_type
> > > >with PACKET_BROADCAST is dead code.
> > > 
> > > We don't know in which scenario the IPv6 Layer checking that statement.
> > > 
> > > The control is reaching there when they got ICMPv6 message of typeICMPV6_MGM_REPORT  <http://lxr.free-electrons.com/ident?i=ICMPV6_MGM_REPORT>  [1] .
> > > 
> > > We don't know the significance of it..??
> > > 
> > 
> > Yep, we don't know it and it doesn't matter, but override the pkt_type
> > to PACKET_HOST when we have a broadcast frame is wrong.
> > 
> > Broadcast means it's IPv6 BROADCAST or MULTICAST, the detection if
> > LOGICAL MULTICAST over BROADCAST xor BROADCAST over BROADCAST is IPv6 Layer.
> 
> I probably missed something from earlier mails but why are we talking
> about broadcast with IPv6? After all IPv6 supports only multicast and
> broadcasting is not supported.

The issue what we talking about is:

6LoWPAN the header creating part is setting PACKET_HOST always to
skb->pkt_type, see [0].

These PACKET_FOO types is set by mac layer, means 802.15.1 (bluetooth <-
okay bluetooth low energy) or 802.15.4 (wpan <- we don't have a fancy name,
so we call it wpan).

After that 6LoWPAN replace the this value PACKET_HOST (don't know why,
but it's wrong. Somebody doesn't really realized what this do).

After 6LoWPAN handling we have IPv6 handling, what IPv6 do at first is
[1]. On handling without address filtering this doesn't work because we
always set (I don't know why we set it, but it's wrong. You know the
state before I worked with 6LoWPAN was also a awful state) PACKET_HOST.

The check on [1] is only that we don't want to parse frames that does
not belong to us. We need the same mechanism earlier in 6LoWPAN handling.
I already fixed it in the rework branch of 802.15.4, see [2]. But this
is only a performance hint! This performance hint you should also
implement in bluetooth 6lowpan.

Just for fun I did a 'grep -r "PACKET_BROADCAST" net/ipv6'. I only want
to know if there are also some other issues, because we always set to
PACKET_HOST which is wrong. And it's true, it matches on:

net/ipv6/mcast.c:	    skb->pkt_type != PACKET_BROADCAST)

which seems to be dead code [3]. In bluetooth and wpan(802.15.4).

> 
> Also what is this "logical multicast over broadcast"?
> 

I mean with logical multicast a multicast when the mac layer only
support broadcasts. Then IPv6 filtering the multicast packets when it's
broadcast. It's easy, you have broadcast frames only on MAC Layer (L2), then
you have MULTICAST over BROADCAST, some software filtering in IPv6 Layer
make some filtering so you have MULTICAST over BROADCAST.

I mean MULTICAST is a group of nodes of a BROADCAST. The filtering of
these groups is done by IPv6.



Sorry I know my english is hard to understand. Do you understand what I
mean now?

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/6lowpan/iphc.c?id=f19f4f9525cf32f97341fac20ce66392e86a1b67#n192
[1] http://lxr.free-electrons.com/source/net/ipv6/ip6_input.c#L72
[2] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L465
[3] http://lxr.free-electrons.com/source/net/ipv6/mcast.c#L1413
