Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46280 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbeHHW1j (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Aug 2018 18:27:39 -0400
Subject: Re: [PATCH net-next] ieee802154: hwsim: fix copy-paste error in
 hwsim_set_edge_lqi()
References: <1533696226-26445-1-git-send-email-weiyongjun1@huawei.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <7c8364e5-fba3-7aaa-28e2-14cd564ec1b3@datenfreihafen.org>
Date: Wed, 8 Aug 2018 22:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <1533696226-26445-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello Wei.

On 08/08/2018 04:43 AM, Wei Yongjun wrote:
> The return value from kzalloc() is not checked correctly. The
> test is done against a wrong variable. This patch fix it.
> 
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index 1982308..04f4100 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -564,7 +564,7 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
>  	}
>  
>  	einfo = kzalloc(sizeof(*einfo), GFP_KERNEL);
> -	if (!info) {
> +	if (!einfo) {
>  		mutex_unlock(&hwsim_phys_lock);
>  		return -ENOMEM;
>  	}
> 

Thanks a lot for finding and fixing these two bugs!

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
