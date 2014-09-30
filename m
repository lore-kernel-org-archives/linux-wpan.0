Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:61154 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaI3Ixz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 04:53:55 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so3844170wiv.2
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 01:53:54 -0700 (PDT)
Date: Tue, 30 Sep 2014 10:53:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930085347.GA28060@omega>
References: <20140929133048.GB14608@omega>
 <54295FA9.8030506@xsilon.com>
 <20140929133841.GA15176@omega>
 <542963F7.4030903@xsilon.com>
 <20140929135759.GA15411@omega>
 <542968C5.7000505@xsilon.com>
 <20140929164157.GA17633@omega>
 <542A6B15.7060203@xsilon.com>
 <20140930083835.GA20280@omega>
 <542A6DF6.809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542A6DF6.809@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hi Varka,

On Tue, Sep 30, 2014 at 02:16:46PM +0530, Varka Bhadram wrote:
> Alex,
> 
> On 09/30/2014 02:09 PM, Alexander Aring wrote:
> >On Tue, Sep 30, 2014 at 09:34:29AM +0100, Simon Vincent wrote:
> >>I can confirm that this fixes the problem. I will create some patches when I
> >>get a chance.
> >>Thanks
> >>
> >This should make trouble on phy's which have no address filter...
> 
> I didnt get what do you mean by this..?
> 

The mac802154 address filter sets PACKET_BROADCAST, PACKET_HOST and
PACKET_OTHERHOST. When you have an address filter on PHY, then
PACKET_OTHERHOST should never happen (on good phy's).

So you always set PACKET_HOST xor PACKET_BROADCAST.

> >But when IPv6 Layer look on PACKET_BROADCAST then this is also another
> >bug...
> >
> >I did a grep:
> >
> >grep -r "PACKET_BROADCAST" net/IPv6
> >
> >matches on:
> >
> >net/ipv6/mcast.c:	    skb->pkt_type != PACKET_BROADCAST)
> 

6LoWPAN layer always override the mac802154 parse value to PACKET_HOST.
Now I want to check if IPv6 Layer ever evaluate this value to
PACKET_BROADCAST and yes it seems so. So there is some other bug which
nobody detected.

Ok?

- Alex
