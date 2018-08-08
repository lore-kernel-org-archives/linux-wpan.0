Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46278 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbeHHW1N (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Aug 2018 18:27:13 -0400
Subject: Re: [PATCH net-next] ieee802154: hwsim: fix rcu handling
References: <20180807233249.28572-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <0a1c05ae-b329-1053-d394-111e78348180@datenfreihafen.org>
Date: Wed, 8 Aug 2018 22:05:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180807233249.28572-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, netdev@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hello David.

I want to apologize how the submission of the ieee802154_hwsim driver
worked out. The sparse warning finally fixed by this commit came due to
an outdated sparse used on our side while kbuild was up to date. I fixed
this now and sparse has no warnings for the ieee802154_hwsim driver
anymore with this patch applied.

The other two fixes from Wei Yongjun are problems I should have spotted
during code review, but did not. No excuse, I just overlooked them.

I would, once again, ask you to apply these three directly to net-next.
I you would prefer for me to pick them up and send you a pull request
this time just let me know and I will do so tomorrow.

On 08/08/2018 01:32 AM, Alexander Aring wrote:
> This patch adds missing rcu_assign_pointer()/rcu_dereference() to used rcu
> pointers. There was already a previous commit c5d99d2b35da ("ieee802154:
> hwsim: fix rcu address annotation"), but there was more which was
> pointed out on my side by using newest sparse version.
> 
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
> After I installed finally the newest sparse version I found more what kbuild
> was pointed out.
> 
> I hope I did it right, not sure if I really need rcu functionality in these
> case because protection by mutex but I make sparse silent.
> At some places the resource isn't a shared resource at this moment.
> 
> Anyway in my case I want to use this driver to create easily multi-hop
> scenarios, if somebody report things (or I hit it) which smells like some
> memory in this area - I will try and help to fix it.
> 
> Newest sparse version from git is happy now and I hope kbuild bot as well.
> 
> I tested this patch with RPOVE_RCU enabled and tried to update these settings
> while heavy loading in rcu protected xmit hotpath is occured, without any
> issues so far.
> 
> Sorry again.
> 
>  drivers/net/ieee802154/mac802154_hwsim.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index f4e92054f7df..53f39435321e 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/timer.h>
>  #include <linux/platform_device.h>
> +#include <linux/rtnetlink.h>
>  #include <linux/netdevice.h>
>  #include <linux/device.h>
>  #include <linux/spinlock.h>
> @@ -110,7 +111,7 @@ static int hwsim_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>  	pib->page = page;
>  	pib->channel = channel;
>  
> -	pib_old = phy->pib;
> +	pib_old = rtnl_dereference(phy->pib);
>  	rcu_assign_pointer(phy->pib, pib);
>  	kfree_rcu(pib_old, rcu);
>  	return 0;
> @@ -406,7 +407,7 @@ static struct hwsim_edge *hwsim_alloc_edge(struct hwsim_phy *endpoint, u8 lqi)
>  	}
>  
>  	einfo->lqi = 0xff;
> -	e->info = einfo;
> +	rcu_assign_pointer(e->info, einfo);
>  	e->endpoint = endpoint;
>  
>  	return e;
> @@ -414,7 +415,13 @@ static struct hwsim_edge *hwsim_alloc_edge(struct hwsim_phy *endpoint, u8 lqi)
>  
>  static void hwsim_free_edge(struct hwsim_edge *e)
>  {
> -	kfree_rcu(e->info, rcu);
> +	struct hwsim_edge_info *einfo;
> +
> +	rcu_read_lock();
> +	einfo = rcu_dereference(e->info);
> +	rcu_read_unlock();
> +
> +	kfree_rcu(einfo, rcu);
>  	kfree_rcu(e, rcu);
>  }
>  
> @@ -796,7 +803,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
>  		goto err_pib;
>  	}
>  
> -	phy->pib = pib;
> +	rcu_assign_pointer(phy->pib, pib);
>  	phy->idx = idx;
>  	INIT_LIST_HEAD(&phy->edges);
>  
> @@ -829,10 +836,17 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
>  
>  static void hwsim_del(struct hwsim_phy *phy)
>  {
> +	struct hwsim_pib *pib;
> +
>  	hwsim_edge_unsubscribe_me(phy);
>  
>  	list_del(&phy->list);
> -	kfree_rcu(phy->pib, rcu);
> +
> +	rcu_read_lock();
> +	pib = rcu_dereference(phy->pib);
> +	rcu_read_unlock();
> +
> +	kfree_rcu(pib, rcu);
>  
>  	ieee802154_unregister_hw(phy->hw);
>  	ieee802154_free_hw(phy->hw);
> 

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
