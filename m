Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46283 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeHHW14 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Aug 2018 18:27:56 -0400
Subject: Re: [PATCH net-next] ieee802154: hwsim: fix missing unlock on error
 in hwsim_add_one()
References: <1533697839-85602-1-git-send-email-weiyongjun1@huawei.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <73fe2c82-3f01-5570-5afc-b24cae4cbc65@datenfreihafen.org>
Date: Wed, 8 Aug 2018 22:06:39 +0200
MIME-Version: 1.0
In-Reply-To: <1533697839-85602-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello Wei.

On 08/08/2018 05:10 AM, Wei Yongjun wrote:
> Add the missing unlock before return from function hwsim_add_one()
> in the error handling case.
> 
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index f4e9205..44d398c 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -810,8 +810,10 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
>  	mutex_lock(&hwsim_phys_lock);
>  	if (init) {
>  		err = hwsim_subscribe_all_others(phy);
> -		if (err < 0)
> +		if (err < 0) {
> +			mutex_unlock(&hwsim_phys_lock);
>  			goto err_reg;
> +		}
>  	}
>  	list_add_tail(&phy->list, &hwsim_phys);
>  	mutex_unlock(&hwsim_phys_lock);
> 

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
