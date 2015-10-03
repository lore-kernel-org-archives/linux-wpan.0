Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36525 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbbJCIhk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Oct 2015 04:37:40 -0400
Received: by pablk4 with SMTP id lk4so127036640pab.3
        for <linux-wpan@vger.kernel.org>; Sat, 03 Oct 2015 01:37:40 -0700 (PDT)
Date: Sat, 3 Oct 2015 02:40:25 -0600
From: =?utf-8?B?Ss61YW4=?= Sacren <sakiwit@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: fix rtnl_unlock() being missing
Message-ID: <20151003084025.GA9771@mail.gmail.com>
References: <1443847612-8933-1-git-send-email-sakiwit@gmail.com>
 <20151003064413.GA7178@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151003064413.GA7178@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

From: Alexander Aring <alex.aring@gmail.com>
Date: Sat, 03 Oct 2015 08:44:14 +0200
>
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

I'm so sorry. Thank you for teaching me again.
