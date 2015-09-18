Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35332 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbbIRWOk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 18:14:40 -0400
Date: Sat, 19 Sep 2015 00:14:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/4] 6lowpan: add nhc module for GHC
 extension header detection
Message-ID: <20150918221429.GA12228@omega>
References: <1442577168-23183-1-git-send-email-stefan@osg.samsung.com>
 <1442577168-23183-3-git-send-email-stefan@osg.samsung.com>
 <20150918214415.GA6872@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150918214415.GA6872@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org

On Fri, Sep 18, 2015 at 11:44:15PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Fri, Sep 18, 2015 at 01:52:46PM +0200, Stefan Schmidt wrote:

....

> 
> btw:
> 
> Something is wrong at iana registration:
> 
> https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#lowpan_nhc
> 
> For RFC6282 they did each entry for each extension header, for GHC not.
> 
> Don't know why :-(
> 
> Also iana says it's
> 
> 10110EEN whereas RFC7400 says it's 1011EIDN
>     ^
>     |
>     I don't know where this bit comes from.
> 

it isn't wrong, GHC EID is defined for 0-3 only so the first bit is
always zero. So 10110 E E N is right whereas:

1011000N -> Hop
1011001N -> Routing
1011010N -> Fragment
1011011N -> Destination

Seems like Mobility and IPv6 is not defined for GHC.

But I still don't know why iana put it for RFC6282 in a new entry on the
list for each EID and for GHC they did only one entry for the mask without
EID bits.

- Alex
