Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37579 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269AbaIWPXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 11:23:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header compression does not corrupt ipv6 header
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140923103341.GA24710@omega>
Date: Tue, 23 Sep 2014 17:23:19 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <75E2311D-E166-4891-B57B-390E5BFC8BB5@holtmann.org>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com> <20140922162148.GA7282@omega> <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com> <20140923092653.GA12857@omega> <20140923093544.GB12857@omega> <1411467246.4860.68.camel@jrissane-mobl.ger.corp.intel.com> <20140923103341.GA24710@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

Hi Alex,

>>> I/Simon mainly add you here in cc because this bug what Simon fixed here
>>> is also inside of bluetooth 6lowpan.
>> 
>> BTW, the v4 patch does not apply cleanly to bluetooth-next. The
>> modifications were very small thou.
>> 
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

since 3.17 is basically around the corner, adding it to bluetooth tree is not getting us anywhere right now. So what I would do is include it in bluetooth-next and add a CC: stable tag to it.

Regards

Marcel

