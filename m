Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45683 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGRnh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Aug 2018 13:43:37 -0400
Subject: Re: [PATCH net-next] ieee802154: hwsim: fix rcu address annotation
References: <20180807143444.32224-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <2c0316a5-30bb-3064-a992-8152232df94f@datenfreihafen.org>
Date: Tue, 7 Aug 2018 17:28:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180807143444.32224-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, netdev@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hello Dave.

On 08/07/2018 04:34 PM, Alexander Aring wrote:
> This patch fixes the following sparse warning about mismatch rcu
> attribute for address space annotation:
> 
> ...
> error: incompatible types in comparison expression (different modifiers)
> error: incompatible types in comparison expression (different address spaces)
> ...
> 
> Some __rcu annotation was at non-pointers list head structures and one was
> missing in edge information which is used by rcu_assign_pointer() to
> update edge setting information.
> 
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
> Hopefully I did it right now. Sorry again.
> 
>  drivers/net/ieee802154/mac802154_hwsim.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index 1982308b9b1c..f4e92054f7df 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -36,7 +36,7 @@ MODULE_LICENSE("GPL");
>  static LIST_HEAD(hwsim_phys);
>  static DEFINE_MUTEX(hwsim_phys_lock);
>  
> -static __rcu LIST_HEAD(hwsim_ifup_phys);
> +static LIST_HEAD(hwsim_ifup_phys);
>  
>  static struct platform_device *mac802154hwsim_dev;
>  
> @@ -68,7 +68,7 @@ struct hwsim_edge_info {
>  
>  struct hwsim_edge {
>  	struct hwsim_phy *endpoint;
> -	struct hwsim_edge_info *info;
> +	struct hwsim_edge_info __rcu *info;
>  
>  	struct list_head list;
>  	struct rcu_head rcu;
> @@ -81,7 +81,7 @@ struct hwsim_phy {
>  	struct hwsim_pib __rcu *pib;
>  
>  	bool suspended;
> -	struct list_head __rcu edges;
> +	struct list_head edges;
>  
>  	struct list_head list;
>  	struct list_head list_ifup;
> 


Could you apply this patch directly to net-next?
It fixes an issue introduced with my pull request from two days ago. I
have nothing else to submit so I would appreciate if you could apply it
directly.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
