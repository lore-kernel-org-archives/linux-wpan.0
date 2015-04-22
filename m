Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34982 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063AbbDVIJq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Apr 2015 04:09:46 -0400
Received: by wgyo15 with SMTP id o15so238123268wgy.2
        for <linux-wpan@vger.kernel.org>; Wed, 22 Apr 2015 01:09:44 -0700 (PDT)
Date: Wed, 22 Apr 2015 10:09:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2] ieee802154: Add trace events for rdev->ops
Message-ID: <20150422080936.GA946@omega>
References: <20150420183656.GC5248@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150420183656.GC5248@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Mon, Apr 20, 2015 at 08:36:56PM +0200, Guido Günther wrote:
> Enabling tracing via
> 
>  echo 1 > /sys/kernel/debug/tracing/events/cfg802154/enable
> 
> enables event tracing like
> 
>  iwpan dev wpan0 set pan_id 0xbeef
>  cat /sys/kernel/debug/tracing/trace
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 2/2   #P:1
>  #
>  #                              _-----=> irqs-off
>  #                             / _----=> need-resched
>  #                            | / _---=> hardirq/softirq
>  #                            || / _--=> preempt-depth
>  #                            ||| /     delay
>  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>  #              | |       |   ||||       |         |
>             iwpan-2663  [000] ....   170.369142: 802154_rdev_set_pan_id: phy0, wpan_dev(1), pan id: 0xbeef
>             iwpan-2663  [000] ....   170.369177: 802154_rdev_return_int: phy0, returned: 0
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex
