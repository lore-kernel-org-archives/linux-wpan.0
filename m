Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34445 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbEFNTW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 09:19:22 -0400
Received: by wgso17 with SMTP id o17so11386258wgs.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 06:19:21 -0700 (PDT)
Date: Wed, 6 May 2015 15:19:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-next 09/16] ieee802154: add support for get tx
 powers
Message-ID: <20150506131915.GB1026@omega>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
 <1430912428-17284-10-git-send-email-alex.aring@gmail.com>
 <20150506140204.59159002@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150506140204.59159002@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, May 06, 2015 at 02:02:04PM +0200, Phoebe Buckheister wrote:
> On Wed,  6 May 2015 13:40:21 +0200
> Alexander Aring <alex.aring@gmail.com> wrote:
> 
> > This patch adds support for get transmit power levels. The driver
> > needs to implement a driver ops callback which can iterate over each
> > transmit power level index. This callback can return zero for
> > successful iteration, 1 for ending the iteration, 2 for continue the
> > iteration which an index increment and values below 0 zero if failed.
> 
> Now that every tx power value can be represented, why not just return a
> const s32* and a number of elements in that array?

ok, I will try to implement it, sounds better.

I followed the first implementation like the station dump in wireless
[0]. (Some example to print a list over netlink) Now I detect that they
use "-ENOENT" for the last entry which should be better than "1".

Nevertheless I think this is only good for dynamic changeable list like
the use case for [0]. It's very unlikely that the capabilities changes
while using of the stack.

- Alex

[0] http://lxr.free-electrons.com/source/net/wireless/nl80211.c#L3876
