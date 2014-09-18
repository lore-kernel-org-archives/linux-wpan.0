Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:45089 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbaIRVxE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 17:53:04 -0400
Received: by mail-wg0-f49.google.com with SMTP id m15so1562677wgh.32
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 14:53:03 -0700 (PDT)
Date: Thu, 18 Sep 2014 23:52:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] 802.15.4 scan, scan_req and
 ieee802154_nl_scan_confirm()
Message-ID: <20140918215250.GB15411@omega>
References: <CAAkeqgW=Y4-L1uhGfS7=2-4ZLKWzhKTgJjmxKvOW74N9jNVREw@mail.gmail.com>
 <20140918213653.GA15411@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140918213653.GA15411@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrey Yurovsky <yurovsky@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 11:36:53PM +0200, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 02:07:21PM -0700, Andrey Yurovsky wrote:
> > I'm troubleshooting issues with an Atmel AT86RF212 radio on mainline
> > (3.17-rc5 at this time) and was wondering about forcing an active scan
> > via the "iz scan" command.  This comes back as not supported so I
> > wanted to understand why.
> > 
> > It looks like ieee802154_scan_req() should be invoked in nl-mac.c in
> > response to a netlink message, this will return -EOPNOTSUPP when
> > ieee802154_mlme_ops(dev)->scan_req is NULL, and indeed that appears to
> > be the case.  I can't find anyone in the soft-MAC setting .scan_req in
> > the MLME ops structure, is that correct?
> > 
> > The only place I see it set is the fake full-MAC radio (fakehard.c)
> > where it's implemented as fake_scan_req() which in turn calls
> > ieee802154_nl_scan_confirm() to report the fake scan result.
> > 
> > I then tried to find anything else calling
> > ieee802154_nl_scan_confirm() and was unable to, is that right or am I
> > missing something?
> > 
> > Please forgive my ignorance but is scanning "broken" at this time?
> 
> yep, I would say the mac802154, netlink interface is completely broken.
> And didn't work ever at any mainline status.
> 

but hey I still accept patches for bug fixes. :-)

New features depends -> if it's useful to integrate it in the rework
branch. I tried to figure out how the netlink interface works, I gave up
when I saw the "extern struct nl_policy foo" in the netlink interface
header. This is normally a uapi header, so I don't know why
this is there. netlink is one piece which is completely different in the
rework.

Sorry, if you thought that the 802.15.4 branch is in any useful state.
:-(

- Alex
