Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33234 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbJCGoW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Oct 2015 02:44:22 -0400
Received: by wiclk2 with SMTP id lk2so58813377wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 02 Oct 2015 23:44:20 -0700 (PDT)
Date: Sat, 3 Oct 2015 08:44:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: fix rtnl_unlock() being missing
Message-ID: <20151003064413.GA7178@omega>
References: <1443847612-8933-1-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1443847612-8933-1-git-send-email-sakiwit@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?utf-8?B?Ss61YW4=?= Sacren <sakiwit@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Jean,

On Fri, Oct 02, 2015 at 10:46:52PM -0600, Jεan Sacren wrote:
> From: Jean Sacren <sakiwit@gmail.com>
> 
> In nl802154_prepare_wpan_dev_dump(), rtnl_unlock() was missing if it

There is no rtnl_unlock missing, the rtnl_unlock call will be done by
function "nl802154_finish_wpan_dev_dump".

The rtnl lock need to be held at the full netlink _dump_ callback, e.g.:

1. call nl802154_prepare_wpan_dev_dump

2. doing netlink things

3. nl802154_finish_wpan_dev_dump

The 3. point is important and we have a bug if we don't call
"nl802154_finish_wpan_dev_dump" at least. Except
"nl802154_prepare_wpan_dev_dump" returns an error.


This mechanism was copy&pasted(with minor changes) from wireless which
we use as reference design. If you like to change this behaviour, then
you need to first change it in wireless, then here.

The identical function can be found at [0].

btw:
Doing some shared code between wireless/802.15.4 would be great but at
first we try to reach some stable subsystem implementation.

- Alex

[0] http://lxr.free-electrons.com/source/net/wireless/nl80211.c#L481
