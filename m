Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37107 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaI2OvJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 10:51:09 -0400
Received: by mail-wi0-f174.google.com with SMTP id cc10so189490wib.13
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 07:51:08 -0700 (PDT)
Date: Mon, 29 Sep 2014 16:51:06 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929145106.GF15411@omega>
References: <5429466F.4080506@gmail.com>
 <54295556.3030800@xsilon.com>
 <20140929131200.GA14608@omega>
 <20140929133048.GB14608@omega>
 <54295FA9.8030506@xsilon.com>
 <20140929133841.GA15176@omega>
 <542963F7.4030903@xsilon.com>
 <20140929135759.GA15411@omega>
 <542968C5.7000505@xsilon.com>
 <20140929143941.GE15411@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140929143941.GE15411@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Mon, Sep 29, 2014 at 04:39:41PM +0200, Alexander Aring wrote:
> Simon,
> 
> On Mon, Sep 29, 2014 at 03:12:21PM +0100, Simon Vincent wrote:
> > 
> > On 29/09/14 14:58, Alexander Aring wrote:
> > >On Mon, Sep 29, 2014 at 02:51:51PM +0100, Simon Vincent wrote:
> > >>Sorry for the confusion. My problem is I am receiving all packets.
> > >>PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka was to
> > >>disable redirects however it now seems that this is not possible on a ipv6
> > >>interface.
> > >>
> > >>I can fix the problem by dropping PACKET_OTHERHOST in mac802154_subif_frame.
> > >The first what IPv6 does is [0].
> > >
> > >See my previous mail. Also that we should handle on 6LoWPAN packet
> > >handler function for receiving "lowpan_rcv" we should do the same,
> > >otherwise we parsing PACKET_OTHERHOST sk_buff's and drop these directly
> > >in IPv6 layer, which makes no sense.
> > >
> > >But what I see is that the current behaviour should also work.
> > >Instrument the IPv6 delivery function and be sure that the information
> > >about PACKET_OTHERHOST was not dropped.
> > I do not catch any PACKET_OTHERHOST packets in the ip6_input.c ipv6_rcv
> > function.
> > I don't think the packets get this far. Also in the ieee802154_rcv function
> > they are dropped. I will add some more debug to find where the redirects
> > come from.
> 
> I think I have it.
> 
> Remove this line [0].
> 
> This is wrong, all packets will be PACKET_HOST then.
> 
> Try and test it again, please.
> 
> - Alex
> 
> [0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/ieee802154/6lowpan_rtnl.c?id=f19f4f9525cf32f97341fac20ce66392e86a1b67#n527

Additional also remove the line [1]. :-) Ugly bug.

- Alex

[1] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/6lowpan/iphc.c?id=f19f4f9525cf32f97341fac20ce66392e86a1b67#n192
