Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37876 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaLGVy7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 16:54:59 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so3150658wiw.16
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 13:54:58 -0800 (PST)
Date: Sun, 7 Dec 2014 22:54:55 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141207215452.GB20260@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega>
 <20141207171903.GC9532@omega>
 <5484C900.2020402@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5484C900.2020402@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael C Cambria <mcc@fid4.com>
Cc: linux-wpan@vger.kernel.org

On Sun, Dec 07, 2014 at 04:39:12PM -0500, Michael C Cambria wrote:
> On 12/07/14 12:19, Alexander Aring wrote:
> >On Sun, Dec 07, 2014 at 06:13:11PM +0100, Alexander Aring wrote:
> >>Hi,
> >>
> >>please use bluetooth-next [0] for the wpan-tools. For experiment things use
> >>wpan_rework_rfc branch. I have still patches there which should be go
> >>into mainline but isn't easy to touch the code without breaking.
> >Now I remember, I changed the netlink interface too much and doesn't
> >change it inside the wpan_rework_rfc branch.
> >
> >So it's only working if you hack the nl802154.h header and copy it into
> >wpan-tools or simple forget this branch. This is my dirty dev branch
> >only for bringing the rework mainline, which is still in progress.
> >
> >- Alex
> 
> Now I'm confused.  Forget using which branch? bluetooth-next?
> wpan_rework_rfc?  linux-wpan-next?
> 

the linux-wpan-next/wpan_rework_rfc and linux-wpan-next/master.

Please use bluetooth-next/master. Also if you want to send patches,
please base it on top of bluetooth-next/master.

> Which is the most current yet stable closest to rfc4944 compliance kernel to
> use? Which user tools should I use with it?
> 

Doesn't matter for your use case. The wpan-tools has a little bit more
features than the lowpan-tools.

> Initially I just want to ping between two of 6LoWPAN linux systems.
> 

ok. Read introductions at [0]. Begin at "Bring up 6LoWPAN" section.

For the at86rf230 you should have default a wpan0 interface. If you use
wpan-tools simple type "iwpan" and read the help for setting address
information. I think for at86rf230 you need to set the panid only, phy
settings should be transceiver defaults and short address isn't supported
for 6LoWPAN (except broadcast address, of course).

The documentation is a little bit outdated currently.

> In time I'll create a 3 node mesh and ping from one node via the second to
> the third as a destination.
> 

ok.

> Eventually I add another 6LoWPAN node that will be a "Full Function Device"
> and routes to traditional IPv6.
> 

FFD with coordinator support? We don't support such functionality at L2
level yet.




If you need help simple ask here or for better fast live supporting you
can contact me via IRC #linux-wpan on irc.freenode.net. Ping between two
nodes should be an easy setup.

- Alex

[0] http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
