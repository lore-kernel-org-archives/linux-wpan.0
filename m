Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:53432 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaIWOnW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 10:43:22 -0400
Received: by mail-wg0-f51.google.com with SMTP id z12so707544wgg.22
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 07:43:20 -0700 (PDT)
Date: Tue, 23 Sep 2014 16:43:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140923144315.GB24710@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923092653.GA12857@omega>
 <20140923093544.GB12857@omega>
 <1411482042.4860.81.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411482042.4860.81.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Jukka,

On Tue, Sep 23, 2014 at 05:20:42PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ti, 2014-09-23 at 11:35 +0200, Alexander Aring wrote:
> > Jukka,
> > 
> > I/Simon mainly add you here in cc because this bug what Simon fixed here
> > is also inside of bluetooth 6lowpan.
> > 
> > I see now [0]. And it seems to me that this also occurs at bluetooth
> > branch. Do you have any questions on how the fix now is? Sorry, but I
> > need to clarify that you understood this issue and you/others prepare a
> > patch for this.
> 
> I was trying to test this issue and send multicast packets to Bluetooth
> 6lowpan until I realized that the interface does not have IFF_MULTICAST
> enabled :) So this issue is not valid atm for Bluetooth.
> 

Sorry that confusing me now completely. I don't know how 6LoWPAN
Bluetooth works. But sending MULTICAST packets is part of IPv6 so
6LoWPAN need the possibility to send MULTICAST packets at L3.

On L2 (that's 802.15.4) we don't support MULTICAST but we sending
BROADCAST frames out. So we have a LOGICAL MULTICAST over BROADCAST.

I don't know how bluetooth works, if they have some MULTICAST support,
we don't have it. Ethernet has MULTICAST support (as L2 example).

We already talked about RFC6775 that's mainly an optimzation for
neighbor discovery. The ethernet neighbor discovery use's many MULTICAST
frames, because ethernet have PHYSICAL MULTICAST support. RFC6775 have
different strategy to use LOGICAL MULTICAST which have a PHYSICAL
BROADCAST to have less traffic afterwards. That's one of the big
benefits to use RFC6775.

Sorry, that 6LoWPAN Bluetooth doesn't support MULTICAST sounds for me
wrong. I mean the underlaying device supports BROADCAST, but then you
have a LOGICAL MULTICAST over a BROADCAST (that's how 802.15.4 deal with
that). How can neighbor discovery deal with that? I don't think that the
kernel implementation checks on IFF_MULTICAST flag. And now you can't
send no MULTICAST 6LoWPAN packets on an IPv6 socket? Don't know but
6LoWPAN is an adaptation layer, it should be support all things what's
also supported by IPv6.



To the fix:
But this issue "could" also occur on non multicast packets, it's better
to be sure that the buffer isn't shared when replacing IPv6 with 6LoWPAN
header.

- Alex
