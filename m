Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33143 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbbDYGp7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Apr 2015 02:45:59 -0400
Received: by wiax7 with SMTP id x7so48617586wia.0
        for <linux-wpan@vger.kernel.org>; Fri, 24 Apr 2015 23:45:58 -0700 (PDT)
Date: Sat, 25 Apr 2015 08:45:51 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2] ieee802154: Add trace events for rdev->ops
Message-ID: <20150425064550.GA3395@omega>
References: <20150420183656.GC5248@bogon.m.sigxcpu.org>
 <20150422080936.GA946@omega>
 <20150423194532.GA2902@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150423194532.GA2902@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Apr 23, 2015 at 09:45:32PM +0200, Guido Günther wrote:
> Hi,
> On Wed, Apr 22, 2015 at 10:09:37AM +0200, Alexander Aring wrote:
> > On Mon, Apr 20, 2015 at 08:36:56PM +0200, Guido Günther wrote:
> > > Enabling tracing via
> > > 
> > >  echo 1 > /sys/kernel/debug/tracing/events/cfg802154/enable
> > > 
> > > enables event tracing like
> > > 
> > >  iwpan dev wpan0 set pan_id 0xbeef
> > >  cat /sys/kernel/debug/tracing/trace
> > >  # tracer: nop
> > >  #
> > >  # entries-in-buffer/entries-written: 2/2   #P:1
> > >  #
> > >  #                              _-----=> irqs-off
> > >  #                             / _----=> need-resched
> > >  #                            | / _---=> hardirq/softirq
> > >  #                            || / _--=> preempt-depth
> > >  #                            ||| /     delay
> > >  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > >  #              | |       |   ||||       |         |
> > >             iwpan-2663  [000] ....   170.369142: 802154_rdev_set_pan_id: phy0, wpan_dev(1), pan id: 0xbeef
> > >             iwpan-2663  [000] ....   170.369177: 802154_rdev_return_int: phy0, returned: 0
> > > 
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > 
> > Acked-by: Alexander Aring <alex.aring@gmail.com>
> 
> Thanks for reviewing!  Is there any procedure to get these queued for
> bluetooth-next? Are you forwarding such patches to Marcel?

no. The current situation was a conclusion that we had massive changes
inside the generic 6LoWPAN branch (net/6lowpan) which is used by
ble/802.15.4 . For easier applying without conflicts marcel offers his
help to apply everything and I think he has actual a nice setup with:

 - some creat testing evironment which checks if patch apply and run
   tests on it.

 - klick one button to send "thanks applied" mail and apply the patch on
   his bluetooth branch and send a push. (maybe on his iPad ;-))

Currently I don't have such setup environment, but I need something like
that. When the time allows then I will try to build something like that.


What I do now is to have a private queue, if Marcel doesn't repsond ~2
weeks after the "Acked-by" then I will send a "ping". I think every
maintainer have a timeslot to making his/her "rounds" on the mailinglist
to grab patches. I am not forwarding the patches to marcel, he will
apply the patches from linux-wpan or netdev mailinglist.

The time will come when linux-wpan have his own repository and send then
pull-request to Marcel (if there are too many shared code between
802.15.4 and bt) or netdev.

- Alex
