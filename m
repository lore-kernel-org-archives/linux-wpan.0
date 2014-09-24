Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:39970 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaIXHMF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 03:12:05 -0400
Received: by mail-we0-f182.google.com with SMTP id u57so3769904wes.13
        for <linux-wpan@vger.kernel.org>; Wed, 24 Sep 2014 00:12:03 -0700 (PDT)
Date: Wed, 24 Sep 2014 09:11:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140924071156.GA24530@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923092653.GA12857@omega>
 <20140923093544.GB12857@omega>
 <1411482042.4860.81.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923144315.GB24710@omega>
 <1411542601.4860.85.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411542601.4860.85.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Wed, Sep 24, 2014 at 10:10:01AM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ti, 2014-09-23 at 16:43 +0200, Alexander Aring wrote:
> > Hi Jukka,
> > 
> > On Tue, Sep 23, 2014 at 05:20:42PM +0300, Jukka Rissanen wrote:
> > > Hi Alex,
> > > 
> > > On ti, 2014-09-23 at 11:35 +0200, Alexander Aring wrote:
> > > > Jukka,
> > > > 
> > > > I/Simon mainly add you here in cc because this bug what Simon fixed here
> > > > is also inside of bluetooth 6lowpan.
> > > > 
> > > > I see now [0]. And it seems to me that this also occurs at bluetooth
> > > > branch. Do you have any questions on how the fix now is? Sorry, but I
> > > > need to clarify that you understood this issue and you/others prepare a
> > > > patch for this.
> > > 
> > > I was trying to test this issue and send multicast packets to Bluetooth
> > > 6lowpan until I realized that the interface does not have IFF_MULTICAST
> > > enabled :) So this issue is not valid atm for Bluetooth.
> > > 
> > 
> > Sorry that confusing me now completely. I don't know how 6LoWPAN
> > Bluetooth works. But sending MULTICAST packets is part of IPv6 so
> > 6LoWPAN need the possibility to send MULTICAST packets at L3.
> 
> Yes, I know. I was just saying that IFF_MULTICAST is not set for the
> interface in current Bluetooth 6lowpan implementation. This will be
> fixed for sure.
> 

Okay. :-)

- Alex
