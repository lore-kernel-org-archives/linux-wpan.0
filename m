Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:43351 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaI3JZ4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 05:25:56 -0400
Received: by mail-we0-f173.google.com with SMTP id p10so5143210wes.18
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 02:25:54 -0700 (PDT)
Date: Tue, 30 Sep 2014 11:25:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930092550.GB28060@omega>
References: <20140929133841.GA15176@omega>
 <542963F7.4030903@xsilon.com>
 <20140929135759.GA15411@omega>
 <542968C5.7000505@xsilon.com>
 <20140929164157.GA17633@omega>
 <542A6B15.7060203@xsilon.com>
 <20140930083835.GA20280@omega>
 <542A6DF6.809@gmail.com>
 <20140930085347.GA28060@omega>
 <542A73A3.5010705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542A73A3.5010705@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

On Tue, Sep 30, 2014 at 02:40:59PM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> 
> On 09/30/2014 02:23 PM, Alexander Aring wrote:
> >Hi Varka,
> >
> >On Tue, Sep 30, 2014 at 02:16:46PM +0530, Varka Bhadram wrote:
> >>Alex,
> >>
> >>On 09/30/2014 02:09 PM, Alexander Aring wrote:
> >>>On Tue, Sep 30, 2014 at 09:34:29AM +0100, Simon Vincent wrote:
> >>>>I can confirm that this fixes the problem. I will create some patches when I
> >>>>get a chance.
> >>>>Thanks
> >>>>
> >>>This should make trouble on phy's which have no address filter...
> >>I didnt get what do you mean by this..?
> >>
> >The mac802154 address filter sets PACKET_BROADCAST, PACKET_HOST and
> >PACKET_OTHERHOST. When you have an address filter on PHY, then
> >PACKET_OTHERHOST should never happen (on good phy's).
> >
> >So you always set PACKET_HOST xor PACKET_BROADCAST.
> 
> Enabling address filtering is in drivers hand..

no, drivers doesn't parse anything. Address filtering "CAN" done on phy.
But afterwards we set PACKET_FOO in mac802154 this is another address filtering.

Dropping frames when PACKET_OTHERHOST is part of next layer like (IPv6/6LoWPAN).
> 
> Few hardware devices may not be handling the address filtering (SOftMAC devices).
> So we need take care of this at Software layers.
> 
Yes that's what we do mac802154 set PACKET_FOO and next layer will drop
if it's OTHERHOST.

> >>>But when IPv6 Layer look on PACKET_BROADCAST then this is also another
> >>>bug...
> >>>
> >>>I did a grep:
> >>>
> >>>grep -r "PACKET_BROADCAST" net/IPv6
> >>>
> >>>matches on:
> >>>
> >>>net/ipv6/mcast.c:	    skb->pkt_type != PACKET_BROADCAST)
> >6LoWPAN layer always override the mac802154 parse value to PACKET_HOST.
> >Now I want to check if IPv6 Layer ever evaluate this value to
> >PACKET_BROADCAST and yes it seems so. So there is some other bug which
> >nobody detected.
> >
> >Ok?
> 
> 6LoWPAN layer override the mac802154 parse value to PACKET_HOST, but that you only
> fixed yesterday. Now we need not to worry about override.
> 

Of course we need to worry about that, it's not fixed mainline. :-)

> Here we need to consider one point. IPv6 layer deals with MUTICAST addresses, there is no
> broadcast address at this pint.
> 

In 802.15.4 the MULTICAST in our case is BROADCAST. We don't have any MULTICAST
feature. Only logical MULTICAST over BROADCAST. If you want to see a L2 Layer with
multicast support and address filtering on L2 see [0] as ethernet example.

> MAC802154 deals with BROADCAST addresses...?
> 

yes.

> What is the bug that you are talking about..?
> 

Don't know I didn't hit the bug and doesn't care about that. Point is
"that skb->pkt_type != PACKET_BROADCAST" is dead code in IPv6 and 6LoWPAN
because we always setting it to PACKET_HOST.

The code shows:
        
	if (skb->pkt_type != PACKET_MULTICAST &&
            skb->pkt_type != PACKET_BROADCAST)
                return 0;

We need to set PACKET_BROADCAST here otherwise some weird things happen. But
we don't need to set PACKET_MULTICAST, this code accept MULTICAST and BROADCAST.

When 6LoWPAN Layer always sets PACKET_HOST, this code is dead.

- Alex

[0] http://lxr.free-electrons.com/source/net/ethernet/eth.c#L168
