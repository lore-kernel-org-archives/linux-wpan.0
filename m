Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:38852 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbaIWKdt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 06:33:49 -0400
Received: by mail-we0-f170.google.com with SMTP id x48so2904840wes.1
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 03:33:48 -0700 (PDT)
Date: Tue, 23 Sep 2014 12:33:43 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140923103341.GA24710@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
 <20140923092653.GA12857@omega>
 <20140923093544.GB12857@omega>
 <1411467246.4860.68.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411467246.4860.68.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 23, 2014 at 01:14:06PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ti, 2014-09-23 at 11:35 +0200, Alexander Aring wrote:
> > Jukka,
> > 
> > I/Simon mainly add you here in cc because this bug what Simon fixed here
> > is also inside of bluetooth 6lowpan.
> 
> BTW, the v4 patch does not apply cleanly to bluetooth-next. The
> modifications were very small thou.
> 

It's a bug fix and should be go to wpan, then wpan goes to bluetooth. I
know there is some easy solveable merge conflict... but maintainers need to be
deal with it then. ;-)

When this is an easy conflict it doesn't matter to wait on it. I hope
that's okay for all maintainers, I am new in this handling. Maintainers
isn't just "apply patches", making the right workflow and solve merge
conflicts, I think. Otherwise some maintainer will tell me "don't making merge
conflicts!", but I heard nothing something like that now.

Or we wait when these changes are in bluetooth repo, which means also
wpan repo.


Also there is an option to send it to -stable, but for me that doesn't
matter currently, there are still other unsolved issues in 802.15.4
branch. When we know some "real" users and some of them wants support
for v3.16 or something else then we could try to make a backport for
this. At the moment we don't have a "real" -stable strategy.

And stable != bluetooth/wpan, okay the stable maintainers sometimes look
into bluetooth/wpan/net/wireless (the without -next) to grab some stable
patches from it. But to make a real stable patch you need to read:

Documentation/stable_kernel_rules.txt

- Alex
