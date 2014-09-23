Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36084 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbaIWPD6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 11:03:58 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so5289953wiv.0
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 08:03:56 -0700 (PDT)
Date: Tue, 23 Sep 2014 17:03:54 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140923150353.GC24710@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923092653.GA12857@omega>
 <20140923093544.GB12857@omega>
 <1411482042.4860.81.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923144315.GB24710@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140923144315.GB24710@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 23, 2014 at 04:43:15PM +0200, Alexander Aring wrote:
> Hi Jukka,
> 
> On Tue, Sep 23, 2014 at 05:20:42PM +0300, Jukka Rissanen wrote:
> > Hi Alex,
> > 
> > On ti, 2014-09-23 at 11:35 +0200, Alexander Aring wrote:
> > > Jukka,
> > > 
> > > I/Simon mainly add you here in cc because this bug what Simon fixed here
> > > is also inside of bluetooth 6lowpan.
> > > 
> > > I see now [0]. And it seems to me that this also occurs at bluetooth
> > > branch. Do you have any questions on how the fix now is? Sorry, but I
> > > need to clarify that you understood this issue and you/others prepare a
> > > patch for this.
> > 
> > I was trying to test this issue and send multicast packets to Bluetooth
> > 6lowpan until I realized that the interface does not have IFF_MULTICAST
> > enabled :) So this issue is not valid atm for Bluetooth.
> > 
> 
> Sorry that confusing me now completely. I don't know how 6LoWPAN
> Bluetooth works. But sending MULTICAST packets is part of IPv6 so
> 6LoWPAN need the possibility to send MULTICAST packets at L3.
> 
> On L2 (that's 802.15.4) we don't support MULTICAST but we sending
> BROADCAST frames out. So we have a LOGICAL MULTICAST over BROADCAST.
> 

See [0]. That's also what the neighbor discovery do when no special
multicast address map generation is implemented.

So 802.15.4 and bluetooth running at the moment into the default branch
which is always the BROADCAST address -> then this is LOGICAL MULTICAST
over BROADCAST.


Sorry for the upper case words. :-)

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/ndisc.c#L263
