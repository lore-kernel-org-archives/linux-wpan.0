Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:39720 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbaIRJpF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 05:45:05 -0400
Received: by mail-wi0-f173.google.com with SMTP id em10so2735229wid.6
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 02:45:04 -0700 (PDT)
Date: Thu, 18 Sep 2014 11:45:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918094501.GC4350@omega>
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de>
 <20140918083259.GA3774@omega>
 <541A99D4.8080509@xsilon.com>
 <20140918084515.GB3774@omega>
 <20140918085433.GC3774@omega>
 <541A9FD3.2030104@xsilon.com>
 <20140918094401.GB4350@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140918094401.GB4350@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Thu, Sep 18, 2014 at 11:44:01AM +0200, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 10:03:15AM +0100, Simon Vincent wrote:
> > There is just a single mrf24j40 on the host.
> > Some of the messages are sent to multicast addresses so this could be
> > causing it!
> > In particular the multicast address is ff02::1a. (all RPL nodes) I guess it
> > is likely this has not been implemented in the Linux kernel...
> > 
> 
> and we comming back to some other issue which Werner Almesberger
> detected. [0] :-)
> 
> There are also some IPv6 implementation issues why RPL sometimes not
> really working.
> 
> I cc Werner here, hope that's okay.
> 
> - Alex
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1c53c8e870cdedb6fc9550f41c558bab45b5219

and now really cc Werner, here. Sorry.
