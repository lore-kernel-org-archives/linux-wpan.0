Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail102.csoft.net ([96.47.74.245]:13340 "EHLO mail102.csoft.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbaLGVlx (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 7 Dec 2014 16:41:53 -0500
Message-ID: <5484C900.2020402@fid4.com>
Date: Sun, 07 Dec 2014 16:39:12 -0500
From: Michael C Cambria <mcc@fid4.com>
MIME-Version: 1.0
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
References: <20141207150814.GA9532@omega> <548487CF.4060009@fid4.com> <20141207171311.GB9532@omega> <20141207171903.GC9532@omega>
In-Reply-To: <20141207171903.GC9532@omega>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On 12/07/14 12:19, Alexander Aring wrote:
> On Sun, Dec 07, 2014 at 06:13:11PM +0100, Alexander Aring wrote:
>> Hi,
>>
>> please use bluetooth-next [0] for the wpan-tools. For experiment things use
>> wpan_rework_rfc branch. I have still patches there which should be go
>> into mainline but isn't easy to touch the code without breaking.
> Now I remember, I changed the netlink interface too much and doesn't
> change it inside the wpan_rework_rfc branch.
>
> So it's only working if you hack the nl802154.h header and copy it into
> wpan-tools or simple forget this branch. This is my dirty dev branch
> only for bringing the rework mainline, which is still in progress.
>
> - Alex

Now I'm confused.  Forget using which branch? bluetooth-next? 
wpan_rework_rfc?  linux-wpan-next?

Which is the most current yet stable closest to rfc4944 compliance 
kernel to use? Which user tools should I use with it?

Initially I just want to ping between two of 6LoWPAN linux systems.

In time I'll create a 3 node mesh and ping from one node via the second 
to the third as a destination.

Eventually I add another 6LoWPAN node that will be a "Full Function 
Device" and routes to traditional IPv6.


Thanks,
MikeC

