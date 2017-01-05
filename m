Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47961 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032109AbdAEM51 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 5 Jan 2017 07:57:27 -0500
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Subject: RE: Bluetooth 6lowpan ping6 slab corruption
Date: Thu, 5 Jan 2017 12:57:17 +0000
Message-ID: <E3B98393E6037849B63EA428240A65135D34C4@PGSMSX103.gar.corp.intel.com>
References: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
 <c70d7129-be2d-4764-6f09-1153192c49be@pengutronix.de>
 <E3B98393E6037849B63EA428240A65135BCA89@PGSMSX103.gar.corp.intel.com>
 <efdc1a54-7fdc-80b8-f46d-d663addae509@pengutronix.de>
 <E3B98393E6037849B63EA428240A65135C42A6@PGSMSX103.gar.corp.intel.com>
 <E3B98393E6037849B63EA428240A65135C6C50@PGSMSX103.gar.corp.intel.com>
 <3205921b-4971-6617-223b-9b003ac28cac@pengutronix.de>
In-Reply-To: <3205921b-4971-6617-223b-9b003ac28cac@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: "'alex.aring@gmail.com'" <alex.aring@gmail.com>, "'jukka.rissanen@linux.intel.com'" <jukka.rissanen@linux.intel.com>, "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>, "'linux-wpan@vger.kernel.org'" <linux-wpan@vger.kernel.org>

> Hi,
> 
> sorry for the delay...
> 
> On 12/22/2016 12:38 AM, Wong, Joshua Weng Onn wrote:
> ...
> >
> > I have discussed this with my technical lead and that he mentioned that we will
> not be able to pursue to bring it to Linux mainline and also not able to backport
> the drivers due to resource limitation. We have pending tasks/projects that are
> upcoming.
> >
> ok.
> 
> > Just curious, can we know the estimated timeline that it will take for an
> inexperienced person in Linux kernel development to complete this task?
> >
> 
> it would take so long until everything is fine and every reviewer has no
> comments on it what it could be made better...
> 
> But one issue at my patch series is that bluetooth L2CAP code has not
> asynchronous Transmit function, which is not that what it's expected by netdev
> xmit callback...
> 
> So I queued it into a workqueue -> some people would say it's a bug, some
> people would say "it's works for now".
> 
> I think it's also very difficult to add such behaviour because l2cap_chan mutex
> need to be replaced by some different fast locking mechanism - if linux-
> bluetooth really want such behaviour...
> 
> Anyway, queueing into a workqueue is "okay" for me, because the way to do it
> right would be complicated. :-/
> 
> Also there exists still the question about which L2 address should be really be
> used and when we need to set it.
> 
> - Alex

Hi Alex,

Thank you for your reply. I will forward this to my technical lead so that he is informed of this.

Best regards,
Joshua


