Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35321 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbJCG5J (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Oct 2015 02:57:09 -0400
Received: by wicge5 with SMTP id ge5so58759546wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 02 Oct 2015 23:57:08 -0700 (PDT)
Date: Sat, 3 Oct 2015 08:57:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: fix rtnl_unlock() being missing
Message-ID: <20151003065703.GB7178@omega>
References: <1443847612-8933-1-git-send-email-sakiwit@gmail.com>
 <20151003064413.GA7178@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151003064413.GA7178@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?utf-8?B?Ss61YW4=?= Sacren <sakiwit@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Sat, Oct 03, 2015 at 08:44:13AM +0200, Alexander Aring wrote:
> Hi Jean,
> 
> On Fri, Oct 02, 2015 at 10:46:52PM -0600, Jεan Sacren wrote:
> > From: Jean Sacren <sakiwit@gmail.com>
> > 
> > In nl802154_prepare_wpan_dev_dump(), rtnl_unlock() was missing if it
> 
> There is no rtnl_unlock missing, the rtnl_unlock call will be done by
> function "nl802154_finish_wpan_dev_dump".
> 
> The rtnl lock need to be held at the full netlink _dump_ callback, e.g.:
> 
> 1. call nl802154_prepare_wpan_dev_dump
> 
> 2. doing netlink things
> 
> 3. nl802154_finish_wpan_dev_dump
> 

Actually we have something like that for the "doit" callback. In this case
netlink offers a "pre" and "post" callback for doing things before and
after the netlink call, see [0].

Maybe another idea is to have a "pre_dumpit" and "post_dumpit", but then
we need to care about dump callbacks which doesn't use
"nl802154_prepare_wpan_dev_dump" - these callbacks exist. I have not
exactly look at it and don't know how possible it is. It would be a nice
cleanup. Maybe this can be workarounded by some FLAG to do WDEV_PEPARE
or not. I don't know, just an idea. ;-)

But then do it at first in wireless subsystem. I also don't know if
the wireless community likes this idea or not.

The "pre" "post" ensures that we always handles the rtnl locks
correctly.

- Alex

[0]http://lxr.free-electrons.com/source/net/wireless/nl80211.c#L47
