Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:48244 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbbGUNwp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Jul 2015 09:52:45 -0400
Date: Tue, 21 Jul 2015 16:52:44 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: fakelb: sleeping under a spinlock
Message-ID: <20150721135243.GF20876@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Since commit 6fa2cffe8cf9 ("fakelb: move lock out of iteration"),
fakelb is taking a mutex while holding a spinlock.  The patch does
this:

> commit 6fa2cffe8cf937fc10be362a2dcac8a5965f618e
> Author: Alexander Aring <alex.aring@gmail.com>
> Date:   Sun May 17 21:45:04 2015 +0200
> 
>     fakelb: move lock out of iteration
>     
>     The list need to be protected while iteration which is need when other
>     list iterates at the same time over this list.
>     
>     Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
> index c7e7d50..e1c0195 100644
> --- a/drivers/net/ieee802154/fakelb.c
> +++ b/drivers/net/ieee802154/fakelb.c
> @@ -193,9 +193,7 @@ err_reg:
>  
>  static void fakelb_del(struct fakelb_phy *phy)
>  {
> -	write_lock_bh(&fakelb_lock);
>  	list_del(&phy->list);
> -	write_unlock_bh(&fakelb_lock);
>  
>  	ieee802154_unregister_hw(phy->hw);
>  	ieee802154_free_hw(phy->hw);
> @@ -217,8 +215,10 @@ static int fakelb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_slave:
> +	write_lock_bh(&fakelb_lock);
>  	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
>  		fakelb_del(phy);
> +	write_unlock_bh(&fakelb_lock);
>  	return err;
>  }
>  
> @@ -226,9 +226,10 @@ static int fakelb_remove(struct platform_device *pdev)
>  {
>  	struct fakelb_phy *phy, *temp;
>  
> +	write_lock_bh(&fakelb_lock);
>  	list_for_each_entry_safe(phy, temp, &fakelb_phys, list)
>  		fakelb_del(phy);
> -
> +	write_unlock_bh(&fakelb_lock);
>  	return 0;
>  }

Which causes all of fakelb_del() to run under a spinlock, including
the call to ieee802154_unregister_hw(), which takes a mutex and
flushes a workqueue.

The quick fix is probably to drop the lock for each fakelb_del(phy)
call, i.e. to do something along the lines of:

	write_lock_bh(&fakelb_lock);
	while (!list_empty(&fakelb_phys)) {
		phy = list_first_entry(&fakelb_phys, struct fakelb_phy, list);

		write_unlock_bh(&fakelb_lock);
		fakelb_del(phy);
		write_lock_bh(&fakelb_lock);
	}
	write_unlock_bh(&fakelb_lock);

I also wonder if the locking here can be converted to RCU or something
like that, as the writer side locking happens very very infrequently.

Any thoughts?
