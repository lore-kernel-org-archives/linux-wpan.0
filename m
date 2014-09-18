Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:33313 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbaIRVhC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 17:37:02 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so1606368wes.0
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 14:37:01 -0700 (PDT)
Date: Thu, 18 Sep 2014 23:36:55 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] 802.15.4 scan, scan_req and
 ieee802154_nl_scan_confirm()
Message-ID: <20140918213653.GA15411@omega>
References: <CAAkeqgW=Y4-L1uhGfS7=2-4ZLKWzhKTgJjmxKvOW74N9jNVREw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAkeqgW=Y4-L1uhGfS7=2-4ZLKWzhKTgJjmxKvOW74N9jNVREw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrey Yurovsky <yurovsky@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 02:07:21PM -0700, Andrey Yurovsky wrote:
> I'm troubleshooting issues with an Atmel AT86RF212 radio on mainline
> (3.17-rc5 at this time) and was wondering about forcing an active scan
> via the "iz scan" command.  This comes back as not supported so I
> wanted to understand why.
> 
> It looks like ieee802154_scan_req() should be invoked in nl-mac.c in
> response to a netlink message, this will return -EOPNOTSUPP when
> ieee802154_mlme_ops(dev)->scan_req is NULL, and indeed that appears to
> be the case.  I can't find anyone in the soft-MAC setting .scan_req in
> the MLME ops structure, is that correct?
> 
> The only place I see it set is the fake full-MAC radio (fakehard.c)
> where it's implemented as fake_scan_req() which in turn calls
> ieee802154_nl_scan_confirm() to report the fake scan result.
> 
> I then tried to find anything else calling
> ieee802154_nl_scan_confirm() and was unable to, is that right or am I
> missing something?
> 
> Please forgive my ignorance but is scanning "broken" at this time?

yep, I would say the mac802154, netlink interface is completely broken.
And didn't work ever at any mainline status.

Rework is in progress [0]. Please also note the project mailinglist is
moved to [1].

It will take abouth a month when I have a first RFC which has the
possibility to send mainline. Sorry.

For rework testing you need also wpan-tools, which based on iw tool from
wireless. (Have similar feeling).

[0] https://github.com/linux-wpan/linux-wpan-next/tree/wpan_rework_rfc
[1] http://vger.kernel.org/vger-lists.html#linux-wpan
[2] https://github.com/linux-wpan/wpan-tools
