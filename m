Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57655 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaI3LfQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 07:35:16 -0400
Received: by mail-wi0-f182.google.com with SMTP id ex7so3772091wid.15
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 04:35:14 -0700 (PDT)
Date: Tue, 30 Sep 2014 13:35:12 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930113511.GB12630@omega>
References: <542A6DF6.809@gmail.com>
 <20140930085347.GA28060@omega>
 <542A73A3.5010705@gmail.com>
 <20140930092550.GB28060@omega>
 <542A7953.5080306@gmail.com>
 <20140930094320.GC28060@omega>
 <542A7D85.8050608@gmail.com>
 <20140930100357.GD28060@omega>
 <1412074514.4860.116.camel@jrissane-mobl.ger.corp.intel.com>
 <20140930111324.GA12630@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140930111324.GA12630@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

On Tue, Sep 30, 2014 at 01:13:24PM +0200, Alexander Aring wrote:
> Hi Jukka,
> 
> On Tue, Sep 30, 2014 at 01:55:14PM +0300, Jukka Rissanen wrote:
> > Hi Alex,
> > 
> > On ti, 2014-09-30 at 12:03 +0200, Alexander Aring wrote:
> > > On Tue, Sep 30, 2014 at 03:23:09PM +0530, Varka Bhadram wrote:
> > > > On 09/30/2014 03:13 PM, Alexander Aring wrote:
> > > > >
> > > > >>May be IEEE-802.11 packets send to IPv6 Layer. In that case Its not dead code.
> > > > >>
> > > > >
> > > > >802.11 data frames will be converted to ethernet frames.
> > > > >
> > > > >Why we now talking about 802.11? 6LoWPAN set always PACKET_HOST and then
> > > > >we never have PACKET_BROADCAST set in IPv6 Layer. Then matching pkt_type
> > > > >with PACKET_BROADCAST is dead code.
> > > > 
> > > > We don't know in which scenario the IPv6 Layer checking that statement.
> > > > 
> > > > The control is reaching there when they got ICMPv6 message of typeICMPV6_MGM_REPORT  <http://lxr.free-electrons.com/ident?i=ICMPV6_MGM_REPORT>  [1] .
> > > > 
> > > > We don't know the significance of it..??
> > > > 
> > > 
> > > Yep, we don't know it and it doesn't matter, but override the pkt_type
> > > to PACKET_HOST when we have a broadcast frame is wrong.
> > > 
> > > Broadcast means it's IPv6 BROADCAST or MULTICAST, the detection if
> > > LOGICAL MULTICAST over BROADCAST xor BROADCAST over BROADCAST is IPv6 Layer.
> > 
> > I probably missed something from earlier mails but why are we talking
> > about broadcast with IPv6? After all IPv6 supports only multicast and
> > broadcasting is not supported.
> 
> The issue what we talking about is:
> 

In a nutshell:

We have issues at [1] and [3] because [0]. For better performance we
should something do like [1] at 6LoWPAN packet receive function for
example [2].

:-)

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/6lowpan/iphc.c?id=f19f4f9525cf32f97341fac20ce66392e86a1b67#n192
[1] http://lxr.free-electrons.com/source/net/ipv6/ip6_input.c#L72
[2] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L465
[3] http://lxr.free-electrons.com/source/net/ipv6/mcast.c#L1413
