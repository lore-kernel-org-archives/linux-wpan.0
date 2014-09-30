Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34933 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbaI3Jn0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 05:43:26 -0400
Received: by mail-we0-f174.google.com with SMTP id w62so14216089wes.33
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 02:43:24 -0700 (PDT)
Date: Tue, 30 Sep 2014 11:43:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140930094320.GC28060@omega>
References: <20140929135759.GA15411@omega>
 <542968C5.7000505@xsilon.com>
 <20140929164157.GA17633@omega>
 <542A6B15.7060203@xsilon.com>
 <20140930083835.GA20280@omega>
 <542A6DF6.809@gmail.com>
 <20140930085347.GA28060@omega>
 <542A73A3.5010705@gmail.com>
 <20140930092550.GB28060@omega>
 <542A7953.5080306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542A7953.5080306@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

On Tue, Sep 30, 2014 at 03:05:15PM +0530, Varka Bhadram wrote:
....
> >>Enabling address filtering is in drivers hand..
> >no, drivers doesn't parse anything. Address filtering "CAN" done on phy.
> >But afterwards we set PACKET_FOO in mac802154 this is another address filtering.
> >
> >Dropping frames when PACKET_OTHERHOST is part of next layer like (IPv6/6LoWPAN).
> 
> For enabling filtering, driver has to update one of the radio chip register.
> 
yep, for enable the filter on phy level it's driver handling.

> >>Few hardware devices may not be handling the address filtering (SOftMAC devices).
> >>So we need take care of this at Software layers.
> >>
> >Yes that's what we do mac802154 set PACKET_FOO and next layer will drop
...
> 
> May be IEEE-802.11 packets send to IPv6 Layer. In that case Its not dead code.
> 


802.11 data frames will be converted to ethernet frames.

Why we now talking about 802.11? 6LoWPAN set always PACKET_HOST and then
we never have PACKET_BROADCAST set in IPv6 Layer. Then matching pkt_type
with PACKET_BROADCAST is dead code.

- Alex
