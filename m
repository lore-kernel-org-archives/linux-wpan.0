Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:44991 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaJ2FW5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 01:22:57 -0400
Received: by mail-la0-f47.google.com with SMTP id gd6so708430lab.34
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 22:22:56 -0700 (PDT)
Date: Wed, 29 Oct 2014 06:22:50 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 14/17] mac802154: remove channel
 attributes from sdata
Message-ID: <20141029052247.GA4709@omega>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
 <1414516892-4107-15-git-send-email-alex.aring@gmail.com>
 <54506471.40007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54506471.40007@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Varka,

On Wed, Oct 29, 2014 at 09:22:17AM +0530, Varka Bhadram wrote:
> On 10/28/2014 10:51 PM, Alexander Aring wrote:
...
> >-	    sdata->local->phy->current_page != sdata->page) {
> >-		mutex_unlock(&sdata->local->phy->pib_lock);
> >-
> >-		work = kzalloc(sizeof(*work), GFP_ATOMIC);
> >-		if (!work)
> >-			return;
> >-
> >-		INIT_WORK(&work->work, phy_chan_notify);
> >-		work->dev = dev;
> >-		queue_work(sdata->local->workqueue, &work->work);
> >+	res = drv_set_channel(local, page, chan);
> >+	if (res) {
> >+		pr_debug("set_channel failed\n");
> 
> Why don't we use netdev_dbg() here...?
> 
> >  	} else {

because there comming more patches and I am not at the finally cleanup.
This code will be part of the deprecated netlink interface. I don't want
to fix anything here. It should only work for the things which we
support in the official userspace software and that is. Channel setting,
interface add/del and setting address filter.

I don't want to send a patch series which contains more than 20 patches.

This patch I could also add an another patch for removing the worker
here and I really don't have an idea why we have a worker here. This
channel setting patch is more a rework. In further all phy settings are
directly  calls to the driver. MAC settings are stored at each interface
and setted by a open/close or rather ifup and ifdown.

There will come a new netlink interface which use the framework like
wireless. The old one will also be functional but we will remove it some
or later.

> >-		mutex_unlock(&sdata->local->phy->pib_lock);
> >+		mutex_lock(&local->phy->pib_lock);
> >+		local->phy->current_channel = chan;
> >+		local->phy->current_page = page;
> >+		mutex_unlock(&local->phy->pib_lock);
> >  	}
> >  }
> 

- Alex
