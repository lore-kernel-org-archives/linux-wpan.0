Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55858 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbaIXHKE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 24 Sep 2014 03:10:04 -0400
Message-ID: <1411542601.4860.85.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 24 Sep 2014 10:10:01 +0300
In-Reply-To: <20140923144315.GB24710@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
	 <20140922162148.GA7282@omega>
	 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
	 <20140923092653.GA12857@omega> <20140923093544.GB12857@omega>
	 <1411482042.4860.81.camel@jrissane-mobl.ger.corp.intel.com>
	 <20140923144315.GB24710@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On ti, 2014-09-23 at 16:43 +0200, Alexander Aring wrote:
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

Yes, I know. I was just saying that IFF_MULTICAST is not set for the
interface in current Bluetooth 6lowpan implementation. This will be
fixed for sure.


Cheers,
Jukka


