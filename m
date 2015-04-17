Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36540 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbDQKcq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 06:32:46 -0400
Received: by wgsk9 with SMTP id k9so108544944wgs.3
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 03:32:45 -0700 (PDT)
Date: Fri, 17 Apr 2015 12:32:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
Message-ID: <20150417103241.GC3288@omega>
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
 <20150417100355.GA3288@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150417100355.GA3288@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 17, 2015 at 12:03:55PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Sun, Apr 12, 2015 at 02:07:33PM +0200, Guido Günther wrote:
> > This is based on the rdev->ops tracing code from net/wireless/.
> > 
> 
> this patch looks good. I tested it with trace-cmd:
> 
> 1. trace-cmd record -e cfg802154:802154_rdev_set_pan_id
> 
> 2. iwpan dev wpan0 set pan_id 0xbeaa
> 
> 3. trace-cmd report
> 
> result:
> 
> version = 6
> cpus=1
>            iwpan-1266  [000]   892.921639: 802154_rdev_set_pan_id: phy0, wpan_dev(1), pan id: 0xbeaa
> 
> also test it with channel and it works pretty well. (I am not a
> trace-cmd export at the moment, my previous use-case was enough to use
> the raw ftrace interface).
> 
> 
> I looked again for the byteorder handling and detected that trace-cmd has
> a cfg802154 plugin [0]. It looks like the plugin is there, to doing

s/cfg802154/cfg80211/

> byteorder translation in userspace instead kernelspace.
> 
> Looking into "__le16_to_cpup" stuff in wireless trace.h show something
> like [1].
> 
> Do you think we can do this in the same way? Then we need some
> plugin_cfg802154 in trace-cmd tool.
> 

Please read the other mail which I also mark an issue and we should move
the byteorder translation into the format string argument. I suppose, what
wireless do with the cfg80211 plugin is to printout the handling of function
__le16_to_cpup (in our case __le16_to_cpu) more correct. So we need
both, translation byteorder in kernelspace (for the __le16 parameter)
and (to show the __le16_to_cpu in userspace correct).

- Alex
