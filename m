Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:53340 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaI3KEF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 06:04:05 -0400
Received: by mail-we0-f173.google.com with SMTP id p10so5195381wes.32
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 03:04:03 -0700 (PDT)
Date: Tue, 30 Sep 2014 12:03:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930100357.GD28060@omega>
References: <20140929164157.GA17633@omega>
 <542A6B15.7060203@xsilon.com>
 <20140930083835.GA20280@omega>
 <542A6DF6.809@gmail.com>
 <20140930085347.GA28060@omega>
 <542A73A3.5010705@gmail.com>
 <20140930092550.GB28060@omega>
 <542A7953.5080306@gmail.com>
 <20140930094320.GC28060@omega>
 <542A7D85.8050608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542A7D85.8050608@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

On Tue, Sep 30, 2014 at 03:23:09PM +0530, Varka Bhadram wrote:
> On 09/30/2014 03:13 PM, Alexander Aring wrote:
> >
> >>May be IEEE-802.11 packets send to IPv6 Layer. In that case Its not dead code.
> >>
> >
> >802.11 data frames will be converted to ethernet frames.
> >
> >Why we now talking about 802.11? 6LoWPAN set always PACKET_HOST and then
> >we never have PACKET_BROADCAST set in IPv6 Layer. Then matching pkt_type
> >with PACKET_BROADCAST is dead code.
> 
> We don't know in which scenario the IPv6 Layer checking that statement.
> 
> The control is reaching there when they got ICMPv6 message of typeICMPV6_MGM_REPORT  <http://lxr.free-electrons.com/ident?i=ICMPV6_MGM_REPORT>  [1] .
> 
> We don't know the significance of it..??
> 

Yep, we don't know it and it doesn't matter, but override the pkt_type
to PACKET_HOST when we have a broadcast frame is wrong.

Broadcast means it's IPv6 BROADCAST or MULTICAST, the detection if
LOGICAL MULTICAST over BROADCAST xor BROADCAST over BROADCAST is IPv6 Layer.

These ICMPv6 messages check on this and it's currently broken.

- Alex
