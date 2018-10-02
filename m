Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53141 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbeJBWCK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Oct 2018 18:02:10 -0400
Subject: Re: [PATCH wpan-next] ieee802154: hwsim: remove not used ifup list
References: <20180930214129.2600-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <939e719e-eb31-a5c1-ee0f-56d204176a7c@datenfreihafen.org>
Date: Tue, 2 Oct 2018 17:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180930214129.2600-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 30/09/2018 23:41, Alexander Aring wrote:
> This list is a leftover from fakelb driver which had always a full mesh
> topology. Idea was to remember all phy's which are currently used by the
> subsystem and deliver everything out. The hwsim driver works differently
> each phy has a list of other phy's to deliver frames which allows a
> own mesh topology.
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index bf70ab892e69..51b5198d5943 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -37,8 +37,6 @@ MODULE_LICENSE("GPL");
>  static LIST_HEAD(hwsim_phys);
>  static DEFINE_MUTEX(hwsim_phys_lock);
>  
> -static LIST_HEAD(hwsim_ifup_phys);
> -
>  static struct platform_device *mac802154hwsim_dev;
>  
>  /* MAC802154_HWSIM netlink family */
> @@ -85,7 +83,6 @@ struct hwsim_phy {
>  	struct list_head edges;
>  
>  	struct list_head list;
> -	struct list_head list_ifup;
>  };
>  
>  static int hwsim_add_one(struct genl_info *info, struct device *dev,
> @@ -159,9 +156,6 @@ static int hwsim_hw_start(struct ieee802154_hw *hw)
>  	struct hwsim_phy *phy = hw->priv;
>  
>  	phy->suspended = false;
> -	list_add_rcu(&phy->list_ifup, &hwsim_ifup_phys);
> -	synchronize_rcu();
> -
>  	return 0;
>  }
>  
> @@ -170,8 +164,6 @@ static void hwsim_hw_stop(struct ieee802154_hw *hw)
>  	struct hwsim_phy *phy = hw->priv;
>  
>  	phy->suspended = true;
> -	list_del_rcu(&phy->list_ifup);
> -	synchronize_rcu();
>  }
>  
>  static int
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
