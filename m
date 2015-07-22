Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33491 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbbGVRfr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Jul 2015 13:35:47 -0400
Received: by wicmv11 with SMTP id mv11so91077061wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2015 10:35:45 -0700 (PDT)
Date: Wed, 22 Jul 2015 19:35:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: fakelb: sleeping under a spinlock
Message-ID: <20150722173542.GD9538@omega>
References: <20150721135243.GF20876@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150721135243.GF20876@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

On Tue, Jul 21, 2015 at 04:52:44PM +0300, Lennert Buytenhek wrote:
> Since commit 6fa2cffe8cf9 ("fakelb: move lock out of iteration"),
> fakelb is taking a mutex while holding a spinlock.  The patch does
> this:
> 
> > commit 6fa2cffe8cf937fc10be362a2dcac8a5965f618e
> > Author: Alexander Aring <alex.aring@gmail.com>
> > Date:   Sun May 17 21:45:04 2015 +0200
> > 
> >     fakelb: move lock out of iteration
> >     
> >     The list need to be protected while iteration which is need when other
> >     list iterates at the same time over this list.
> >     
> >     Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > 
> > diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
> > index c7e7d50..e1c0195 100644
> > --- a/drivers/net/ieee802154/fakelb.c
> > +++ b/drivers/net/ieee802154/fakelb.c
> > @@ -193,9 +193,7 @@ err_reg:
> >  
> >  static void fakelb_del(struct fakelb_phy *phy)
> >  {
> > -	write_lock_bh(&fakelb_lock);
> >  	list_del(&phy->list);
> > -	write_unlock_bh(&fakelb_lock);
> >  
> >  	ieee802154_unregister_hw(phy->hw);
> >  	ieee802154_free_hw(phy->hw);
> > @@ -217,8 +215,10 @@ static int fakelb_probe(struct platform_device *pdev)
> >  	return 0;
> >  
> >  err_slave:
> > +	write_lock_bh(&fakelb_lock);
> >  	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
> >  		fakelb_del(phy);
> > +	write_unlock_bh(&fakelb_lock);
> >  	return err;
> >  }
> >  
> > @@ -226,9 +226,10 @@ static int fakelb_remove(struct platform_device *pdev)
> >  {
> >  	struct fakelb_phy *phy, *temp;
> >  
> > +	write_lock_bh(&fakelb_lock);
> >  	list_for_each_entry_safe(phy, temp, &fakelb_phys, list)
> >  		fakelb_del(phy);
> > -
> > +	write_unlock_bh(&fakelb_lock);
> >  	return 0;
> >  }
> 
> Which causes all of fakelb_del() to run under a spinlock, including
> the call to ieee802154_unregister_hw(), which takes a mutex and
> flushes a workqueue.
> 

The above example is from the commit id 6fa2cffe8cf9 ("fakelb: move lock
out of iteration"). The current code looks a lot of different because
some later patches. There we have a mutex and spinlock.

I agree that we hold the spinlock while calling
ieee802154_unregister_hw, if any interfaces are up for a specific hw
then driver stop will be called on unregister the last interface. The stop
of fakelb driver will hold the mutex (rwlock). Also the workqueue will be
flushed.

So far I think this is what you mean here. But I don't get the real
issue what's wrong now. :-)

> The quick fix is probably to drop the lock for each fakelb_del(phy)
> call, i.e. to do something along the lines of:
> 
> 	write_lock_bh(&fakelb_lock);
> 	while (!list_empty(&fakelb_phys)) {
> 		phy = list_first_entry(&fakelb_phys, struct fakelb_phy, list);
> 
> 		write_unlock_bh(&fakelb_lock);
> 		fakelb_del(phy);
> 		write_lock_bh(&fakelb_lock);
> 	}
> 	write_unlock_bh(&fakelb_lock);
> 

The fakelb_lock has nothing to do with the fakelb_phys.

There are two lists in this driver implementation [0].

- fakelb_phys: This list holds all registered virtual phys. Maybe later
  we want to add some interface (sysfs/whatever) to add/del more virtual
  phys during runtime of fakelb module. 

- fakelb_ifup_phys: This lists holds all phys which are used by the
  subsystem. This means some interface is up according to the phy.

Since we have the bool suspended, which should be true when a phy isn't
used anymore I think it's okay to use fakelb_phys as one list only.

We could have some benefits when doing xmit and iterate over all phys,
that we iterate only over phys which are really used. Nevertheless I
think we get not much benefits from it.


Back to your fix is that I believe we run at the end in some issues when
we delete some entries in a list while iterate over. In case of
"fakelb_lock" such case doesn't exist yet because we manipulate the list
while init/exit module. But according the write_lock_bh/write_unlock_bh
I don't get it to use it in combination with fakelb_phys list.


Or:
Do you want to drop the spinlock and then using the rwlock for both
lists only?

Then I would only unlock/lock while calling ieee802154_unregister_hw and
keep the list_del inside while holding the lock.

> I also wonder if the locking here can be converted to RCU or something
> like that, as the writer side locking happens very very infrequently.

Writers are really very unlikely in this case, depends... we also
protect the channel/page attributes because xmit use them to match with
others phys which belongs to these attributes. In case of somebody wants
to do many "channel_switching" inside userspace this could occur quite
often. :-)

Lennert, go ahead and send patches. I think fakelb has potential to
become a well framework for 802.15.4 testing.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/net/ieee802154/fakelb.c
