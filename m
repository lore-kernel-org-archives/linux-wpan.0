Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37735 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196AbaIWKps (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 23 Sep 2014 06:45:48 -0400
Message-ID: <1411469144.4860.73.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 23 Sep 2014 13:45:44 +0300
In-Reply-To: <20140923103341.GA24710@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
	 <20140922162148.GA7282@omega>
	 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
	 <20140923092653.GA12857@omega> <20140923093544.GB12857@omega>
	 <1411467246.4860.68.camel@jrissane-mobl.ger.corp.intel.com>
	 <20140923103341.GA24710@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

On ti, 2014-09-23 at 12:33 +0200, Alexander Aring wrote:
> On Tue, Sep 23, 2014 at 01:14:06PM +0300, Jukka Rissanen wrote:
> > Hi Alex,
> > 
> > On ti, 2014-09-23 at 11:35 +0200, Alexander Aring wrote:
> > > Jukka,
> > > 
> > > I/Simon mainly add you here in cc because this bug what Simon fixed here
> > > is also inside of bluetooth 6lowpan.
> > 
> > BTW, the v4 patch does not apply cleanly to bluetooth-next. The
> > modifications were very small thou.
> > 
> 
> It's a bug fix and should be go to wpan, then wpan goes to bluetooth. I
> know there is some easy solveable merge conflict... but maintainers need to be
> deal with it then. ;-)
> 
> When this is an easy conflict it doesn't matter to wait on it. I hope
> that's okay for all maintainers, I am new in this handling. Maintainers
> isn't just "apply patches", making the right workflow and solve merge
> conflicts, I think. Otherwise some maintainer will tell me "don't making merge
> conflicts!", but I heard nothing something like that now.
> 
> Or we wait when these changes are in bluetooth repo, which means also
> wpan repo.

Actually, the v4 patch only touches net/ieee802154/6lowpan_rtnl.c which
is not used by bluetooth so no worries here. 


Cheers,
Jukka



