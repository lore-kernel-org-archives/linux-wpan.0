Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:37084 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030471AbbDWTqG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 15:46:06 -0400
Date: Thu, 23 Apr 2015 21:45:32 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v2] ieee802154: Add trace events for rdev->ops
Message-ID: <20150423194532.GA2902@bogon.m.sigxcpu.org>
References: <20150420183656.GC5248@bogon.m.sigxcpu.org>
 <20150422080936.GA946@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150422080936.GA946@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,
On Wed, Apr 22, 2015 at 10:09:37AM +0200, Alexander Aring wrote:
> On Mon, Apr 20, 2015 at 08:36:56PM +0200, Guido Günther wrote:
> > Enabling tracing via
> > 
> >  echo 1 > /sys/kernel/debug/tracing/events/cfg802154/enable
> > 
> > enables event tracing like
> > 
> >  iwpan dev wpan0 set pan_id 0xbeef
> >  cat /sys/kernel/debug/tracing/trace
> >  # tracer: nop
> >  #
> >  # entries-in-buffer/entries-written: 2/2   #P:1
> >  #
> >  #                              _-----=> irqs-off
> >  #                             / _----=> need-resched
> >  #                            | / _---=> hardirq/softirq
> >  #                            || / _--=> preempt-depth
> >  #                            ||| /     delay
> >  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> >  #              | |       |   ||||       |         |
> >             iwpan-2663  [000] ....   170.369142: 802154_rdev_set_pan_id: phy0, wpan_dev(1), pan id: 0xbeef
> >             iwpan-2663  [000] ....   170.369177: 802154_rdev_return_int: phy0, returned: 0
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> Acked-by: Alexander Aring <alex.aring@gmail.com>

Thanks for reviewing!  Is there any procedure to get these queued for
bluetooth-next? Are you forwarding such patches to Marcel?
Cheers,
 -- Guido
