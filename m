Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36054 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaJ2GHX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 02:07:23 -0400
Received: by mail-lb0-f171.google.com with SMTP id z11so1896173lbi.30
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 23:07:21 -0700 (PDT)
Date: Wed, 29 Oct 2014 07:07:18 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 14/17] mac802154: remove channel
 attributes from sdata
Message-ID: <20141029060716.GD4709@omega>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
 <1414516892-4107-15-git-send-email-alex.aring@gmail.com>
 <54506471.40007@gmail.com>
 <20141029052247.GA4709@omega>
 <54507C98.4060804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54507C98.4060804@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Oct 29, 2014 at 11:05:20AM +0530, Varka Bhadram wrote:
> On 10/29/2014 10:52 AM, Alexander Aring wrote:
> >>>-	    sdata->local->phy->current_page != sdata->page) {
> >>>-		mutex_unlock(&sdata->local->phy->pib_lock);
> >>>-
> >>>-		work = kzalloc(sizeof(*work), GFP_ATOMIC);
> >>>-		if (!work)
> >>>-			return;
> >>>-
> >>>-		INIT_WORK(&work->work, phy_chan_notify);
> >>>-		work->dev = dev;
> >>>-		queue_work(sdata->local->workqueue, &work->work);
> >>>+	res = drv_set_channel(local, page, chan);
> >>>+	if (res) {
> >>>+		pr_debug("set_channel failed\n");
> >>Why don't we use netdev_dbg() here...?
> >>
> >>>  	} else {
> >because there comming more patches and I am not at the finally cleanup.
> >This code will be part of the deprecated netlink interface. I don't want
> >to fix anything here. It should only work for the things which we
> >support in the official userspace software and that is. Channel setting,
> >interface add/del and setting address filter.
> >
> >I don't want to send a patch series which contains more than 20 patches.
> >
> >This patch I could also add an another patch for removing the worker
> >here and I really don't have an idea why we have a worker here. This
> >channel setting patch is more a rework. In further all phy settings are
> >directly  calls to the driver. MAC settings are stored at each interface
> >and setted by a open/close or rather ifup and ifdown.
> 
> I think when we do ifup the open function will be called..?
> 

Yes, we have these multiple interfaces and these "can" have different
MAC settings. When I say MAC here then it's something which needs an
algorithmn. PHY settings doesn't need to run a algorithmn, like channel
page settings.

Later if we do a ifup we should set all MAC settings which is handled by
PHY. It's handled by phy because it's very time critical like ARET or
CSMA. Also address filtering is a MAC settings which is handled by phy.

In the next patches we also remove the pib/mib lock and make locking via
netif_running. That means we can't set MAC which are handled by PHY while
netif is running. This is usual principle in netdev, like you can't
change ethernet address while netif is running. Now when netif is
running then the rx/tx paths are called and these variables becomes read
only. We simple don't need any locking mechanism in hotpaths then.

If somebody want to change addresses short/extended/pan_id, ARET, CSMA.
He need to do a ifdown first and then the user can change it.

On ifup all interfaces should be have the same MAC settings which are
handled by PHY. I need to see if we really need the multiple interface
thing or just implement a netlink call to change the interface type.

Only one use case for me is that we can have more than one monitor
interface at the same time.

> >There will come a new netlink interface which use the framework like
> >wireless. The old one will also be functional but we will remove it some
> >or later.
> 
> What is the New netlink interface..?
> 
> I would like to know.

The current netlink interface is the most weird code in the current
implementation and the official userspace software doesn't support all
netlink commands. I tried to implement it but I gave up. The new one
should be look like:

https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/nl802154.c

mostly grab the framework from wireless.

Userspace tools are:

https://github.com/linux-wpan/wpan-tools

mostly grab the framework from iw wireless tools.

- Alex
