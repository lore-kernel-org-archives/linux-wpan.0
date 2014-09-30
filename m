Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61575 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbaI3KzR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 30 Sep 2014 06:55:17 -0400
Message-ID: <1412074514.4860.116.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: ICMPv6 Redirects
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 30 Sep 2014 13:55:14 +0300
In-Reply-To: <20140930100357.GD28060@omega>
References: <20140929164157.GA17633@omega> <542A6B15.7060203@xsilon.com>
	 <20140930083835.GA20280@omega> <542A6DF6.809@gmail.com>
	 <20140930085347.GA28060@omega> <542A73A3.5010705@gmail.com>
	 <20140930092550.GB28060@omega> <542A7953.5080306@gmail.com>
	 <20140930094320.GC28060@omega> <542A7D85.8050608@gmail.com>
	 <20140930100357.GD28060@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

Hi Alex,

On ti, 2014-09-30 at 12:03 +0200, Alexander Aring wrote:
> On Tue, Sep 30, 2014 at 03:23:09PM +0530, Varka Bhadram wrote:
> > On 09/30/2014 03:13 PM, Alexander Aring wrote:
> > >
> > >>May be IEEE-802.11 packets send to IPv6 Layer. In that case Its not dead code.
> > >>
> > >
> > >802.11 data frames will be converted to ethernet frames.
> > >
> > >Why we now talking about 802.11? 6LoWPAN set always PACKET_HOST and then
> > >we never have PACKET_BROADCAST set in IPv6 Layer. Then matching pkt_type
> > >with PACKET_BROADCAST is dead code.
> > 
> > We don't know in which scenario the IPv6 Layer checking that statement.
> > 
> > The control is reaching there when they got ICMPv6 message of typeICMPV6_MGM_REPORT  <http://lxr.free-electrons.com/ident?i=ICMPV6_MGM_REPORT>  [1] .
> > 
> > We don't know the significance of it..??
> > 
> 
> Yep, we don't know it and it doesn't matter, but override the pkt_type
> to PACKET_HOST when we have a broadcast frame is wrong.
> 
> Broadcast means it's IPv6 BROADCAST or MULTICAST, the detection if
> LOGICAL MULTICAST over BROADCAST xor BROADCAST over BROADCAST is IPv6 Layer.

I probably missed something from earlier mails but why are we talking
about broadcast with IPv6? After all IPv6 supports only multicast and
broadcasting is not supported.

Also what is this "logical multicast over broadcast"?

> 
> These ICMPv6 messages check on this and it's currently broken.
> 
> - Alex


Cheers,
Jukka


