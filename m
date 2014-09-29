Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:61895 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbaI2OTY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 10:19:24 -0400
Received: by mail-wi0-f182.google.com with SMTP id ex7so1709115wid.15
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 07:19:22 -0700 (PDT)
Date: Mon, 29 Sep 2014 16:19:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929141919.GD15411@omega>
References: <54295556.3030800@xsilon.com>
 <20140929131200.GA14608@omega>
 <20140929133048.GB14608@omega>
 <54295FA9.8030506@xsilon.com>
 <20140929133841.GA15176@omega>
 <542963F7.4030903@xsilon.com>
 <20140929135759.GA15411@omega>
 <54296711.8060006@gmail.com>
 <20140929141249.GB15411@omega>
 <54296996.1040507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54296996.1040507@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

Hi Varka,

On Mon, Sep 29, 2014 at 07:45:50PM +0530, Varka Bhadram wrote:
> 
> On Monday 29 September 2014 07:42 PM, Alexander Aring wrote:
> >On Mon, Sep 29, 2014 at 07:35:05PM +0530, Varka Bhadram wrote:
> >>On Monday 29 September 2014 07:28 PM, Alexander Aring wrote:
> >>>On Mon, Sep 29, 2014 at 02:51:51PM +0100, Simon Vincent wrote:
> >>>>Sorry for the confusion. My problem is I am receiving all packets.
> >>>>PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka was to
> >>>>disable redirects however it now seems that this is not possible on a ipv6
> >>>>interface.
> >>>>
> >>>>I can fix the problem by dropping PACKET_OTHERHOST in mac802154_subif_frame.
> >>>The first what IPv6 does is [0].
> >>>
> >>>See my previous mail. Also that we should handle on 6LoWPAN packet
> >>>handler function for receiving "lowpan_rcv" we should do the same,
> >>>otherwise we parsing PACKET_OTHERHOST sk_buff's and drop these directly
> >>>in IPv6 layer, which makes no sense.
> >>>
> >>>But what I see is that the current behaviour should also work.
> >>>Instrument the IPv6 delivery function and be sure that the information
> >>>about PACKET_OTHERHOST was not dropped.
> >>>
> >>>- Alex
> >>>
> >>>[0] http://lxr.free-electrons.com/source/net/ipv6/ip6_input.c#L72
> >>Generally Echo reply will happen at the IP Layer. But the dropping of packet is
> >>happening at IPv6 layer by as you mentioned above.
> >>
> >IP Layer == (IPv6 || IPv4)
> >
> >I don't understand what you mean. There is some code sharing between
> >IPv4 and IPv6 like neighbor discovery and ARP handling. Also for route
> >things...
> >
> I am taking about IPv6 stuff.. We need to debug from where the redirect is happening..?
> 

sorry, but the issue is that PACKET_OTHERHOST is not dropped by IPv6/6LoWPAN Layer.
We don't talking about ICMPv6 redirect messages now.

- Alex
