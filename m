Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:41572 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbCMK1E (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Mar 2015 06:27:04 -0400
Received: by wesw62 with SMTP id w62so22263962wes.8
        for <linux-wpan@vger.kernel.org>; Fri, 13 Mar 2015 03:27:03 -0700 (PDT)
Date: Fri, 13 Mar 2015 11:26:56 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Can I get the patches for 3.10 kernel
Message-ID: <20150313102653.GA7491@omega>
References: <CALw2d_OcB4XQhxC5KsQY_BsuE85jb_+VrkiRRciCz3hunyXs1Q@mail.gmail.com>
 <54F718AB.9020701@pengutronix.de>
 <CAAkeqgWqiDO_7_vULKugtm1h20BykOZvqiUcbMMhYg7rWzremQ@mail.gmail.com>
 <CALw2d_Mveq3nKV4eOpkN90HJ3K1hMid3yTq8c++sKW8szzA_EA@mail.gmail.com>
 <54F82234.7060704@pengutronix.de>
 <CALw2d_PPaKYSs16MNiBF71bRchdOyYzAAuhDp1fwatCErSVthA@mail.gmail.com>
 <550291B1.5070102@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <550291B1.5070102@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sujith H <hari.sujith@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, linux-wpan@vger.kernel.org

On Fri, Mar 13, 2015 at 08:28:49AM +0100, Marc Kleine-Budde wrote:
> On 03/13/2015 04:47 AM, Sujith H wrote:
> >     I don't think there's a ready to go patchset available, that ports the
> >     latest and greatest features to such an old kernel. I think you have to
> >     do it yourself or get some commercial support.
> 
> > The getting started guide points to creation of 3 nodes followed by
> > assigning ipv6 address and pinging between different interfaces/nodes
> > with the IP.
> > Is my understanding correct?
> 
> I don't know, I've never used getting stated guide. Probably others can
> comment.

If you use kernel version 3.18 or below:

You need the old lowpan-tools and the Getting Started guide from
sourceforge trac wiki. [0]


If you use kernel version 3.19 or above:

Don't use the Getting Started guide from obsolete sourceforge trac wiki
and some notes in current mainline Documentation/networking/ieee802154.txt

The ieee802154.txt needs some update, patches are welcome.

Instead use [1]. Sure this documentation can also improved, patches are
welcome. You can send patches for the website via wpan-misc repository. [2]
Please tag the patches then with "wpan-misc".



btw. for the 6lowpan_pending patches branch:

This was an experimental branch. There was also issues while bringing
mainline which was pointed out by David Miller. Maybe you can simple
search for the patch series on netdev archives for making 6lowpan
fragmentation handling better.

- Alex

[0] http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
[1] http://wpan.cakelab.org/
[2] https://github.com/linux-wpan/wpan-misc
