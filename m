Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38819 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521AbbFPKIP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 06:08:15 -0400
Received: by wibdq8 with SMTP id dq8so14306986wib.1
        for <linux-wpan@vger.kernel.org>; Tue, 16 Jun 2015 03:08:13 -0700 (PDT)
Date: Tue, 16 Jun 2015 12:08:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/3] at86rf230: fix phy settings while
 sleeping
Message-ID: <20150616100806.GB17255@omega>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
 <1434446394.3559.21.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434446394.3559.21.camel@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi,

On Tue, Jun 16, 2015 at 11:19:54AM +0200, Lucas Stach wrote:
> Am Dienstag, den 16.06.2015, 11:07 +0200 schrieb Alexander Aring:
> > While in sleep state then we can't access the at86rf2xx registers. This
> > patch checks if the transceiver is in sleep state before sending spi
> > messages via regmap. Regmap is used on every driver ops callback except
> > for receive and xmit handling, but while receive and xmit handling the
> > phy should not be inside the sleep state.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> > change since v2:
> >  - I detect an issue with cca ed level setting in v1, there was a return in the
> >    middle of awake and sleep transceiver. This results that the transceiver
> >    wasn't again turn into sleep state afterwards.
> >    To avoid such behaviour I moved the awake and sleep into lowlevel register io
> >    functions. These functions "could" be called only when the phy is in sleep
> >    state.
> > 
> > 
> >  drivers/net/ieee802154/at86rf230.c | 88 +++++++++++++++++++++++++++++---------
> >  1 file changed, 68 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> > index 6b31f47..b839bbd 100644
> > --- a/drivers/net/ieee802154/at86rf230.c
> > +++ b/drivers/net/ieee802154/at86rf230.c
> > @@ -90,6 +90,7 @@ struct at86rf230_local {
> >  	struct at86rf2xx_chip_data *data;
> >  	struct regmap *regmap;
> >  	int slp_tr;
> > +	bool sleep;
> 
> This should probably be a reference count instead of a simple bool. I
> suppose there are more locations in the driver where you want to keep
> the PHY awake.
> 

Yes, I want that e.g. for this case:

For example the regmap register dump is on sleep state invalid. I can't
dump the registers, because they returning zero's (In case of volatile).

Doing handling this by refcount does not solve this issue. What I need
is to overwrite then the regmap lowlevel spi io callbacks to do that,
but I simple leave the state that it's invalid to do a register dump on
it. (It's also only for debugfs and then people should know what they
doing).

Normally the driver should also read the registers which are registered
in the 802.15.4 subsystem. Regmap simple doesn't know the state of the
transceiver.

> Also this would allow you to throw away all those "if (sleep)" checks at
> the callers. Just call at86rf230_phy_wake_get() before you do something
> that needs the phy to be awake and increment the refcount there and have
> a similar ..._put() function to decrement the refcount. Then toggle the
> GPIO when the refcount is going 0->1 and the other way around.
> 

I agree this is the common kernel soltution. I think is what we need is
to put this logic then into 802.15.4 subsystem.

In the wpan_phy we put a refcounter and let them increment when the phy
is "used by susbsytem" -> if was 0 then awake and decrement
"when it's not used" -> if reach 0 then subsystem.

Currently all ops (except the xmit op, but this should not called when
sleeping) are protected by rtnl mutex so the refcount can't be greater
than one.

I will put it to my ToDo List, then we have some driver_ops
resume/suspsend when the susbsystem will use the wpan_phy when it's
sleeping and the driver needs to do something.

Nevertheless this patch looks for _now_ valid and introducing a refcount
in 802.15.4 for the wpan_phy is better. At the moment I broke the
behaviour when introduced the sleep state some days ago.

At Wednesday Marcel will send the last push request to net-next and I
need to decide now if we do this fix OR reverting the introducing of
sleep state.

I would leave this patch and when the times comes we introduce a better
802.15.4 wpan behaviour with refcounts later. The logic is just
completely in driver layer right now.

- Alex
