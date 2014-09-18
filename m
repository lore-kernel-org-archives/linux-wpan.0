Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:51671 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaIRIyi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 04:54:38 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so541289wes.14
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 01:54:36 -0700 (PDT)
Date: Thu, 18 Sep 2014 10:54:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918085433.GC3774@omega>
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de>
 <20140918083259.GA3774@omega>
 <541A99D4.8080509@xsilon.com>
 <20140918084515.GB3774@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140918084515.GB3774@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 10:45:15AM +0200, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 09:37:40AM +0100, Simon Vincent wrote:
> > Sorry if I confused you, It is not a fakelb problem I get the same problem
> > if I run using real 802.15.4 hardware (mrf24j40). The packet is put out by
> > the driver but also sent to the RAW socket.
> > 
> Two mrf24j40 on the same host?

I mean, my theory is that there are two IPv6 _interfaces_ are on the
same host. Then Linux do some optimization and necessary callbacks for
replacing 6LoWPAN header header will never called. Linux do this
optimization because Linux see it's local.

Then doesn't matter if two mrf24j40, fakelb, etc... or some combinations
of them. :-)

- Alex
