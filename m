Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36315 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbDQKEH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 06:04:07 -0400
Received: by wizk4 with SMTP id k4so15804850wiz.1
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 03:04:05 -0700 (PDT)
Date: Fri, 17 Apr 2015 12:03:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
Message-ID: <20150417100355.GA3288@omega>
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150412120733.GA6181@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Sun, Apr 12, 2015 at 02:07:33PM +0200, Guido Günther wrote:
> This is based on the rdev->ops tracing code from net/wireless/.
> 

this patch looks good. I tested it with trace-cmd:

1. trace-cmd record -e cfg802154:802154_rdev_set_pan_id

2. iwpan dev wpan0 set pan_id 0xbeaa

3. trace-cmd report

result:

version = 6
cpus=1
           iwpan-1266  [000]   892.921639: 802154_rdev_set_pan_id: phy0, wpan_dev(1), pan id: 0xbeaa

also test it with channel and it works pretty well. (I am not a
trace-cmd export at the moment, my previous use-case was enough to use
the raw ftrace interface).


I looked again for the byteorder handling and detected that trace-cmd has
a cfg802154 plugin [0]. It looks like the plugin is there, to doing
byteorder translation in userspace instead kernelspace.

Looking into "__le16_to_cpup" stuff in wireless trace.h show something
like [1].

Do you think we can do this in the same way? Then we need some
plugin_cfg802154 in trace-cmd tool.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/rostedt/trace-cmd.git/tree/plugin_cfg80211.c
[1] http://lxr.free-electrons.com/source/net/wireless/trace.h?v=3.19#L2160
