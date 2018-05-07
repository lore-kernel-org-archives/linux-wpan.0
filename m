Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:46016 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeEGOBo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 7 May 2018 10:01:44 -0400
Subject: Re: [RFC PATCH wpan-next 2/2] ieee802154: fakelb: add deprecated msg
 while probe
References: <20180427212154.29582-1-aring@mojatatu.com>
 <20180427212154.29582-3-aring@mojatatu.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <cc5ec28d-c59a-6cf2-480f-fad87125fc31@osg.samsung.com>
Date: Mon, 7 May 2018 16:01:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180427212154.29582-3-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hello.


On 04/27/2018 11:21 PM, Alexander Aring wrote:
> Since mac802154_hwsim the fakelb driver will get deprecated. This patch will
> notifier all users of fakelb to switch to the new mac802154_hwsim driver.
>
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  drivers/net/ieee802154/fakelb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
> index 0d673f7682ee..d44cc27a13c7 100644
> --- a/drivers/net/ieee802154/fakelb.c
> +++ b/drivers/net/ieee802154/fakelb.c
> @@ -254,6 +254,9 @@ static __init int fakelb_init_module(void)
>  {
>  	ieee802154fake_dev = platform_device_register_simple(
>  			     "ieee802154fakelb", -1, NULL, 0);
> +
> +	pr_warn("fakelb driver is marked as deprecated, please use mac802154_hwsim!");
> +
>  	return platform_driver_register(&ieee802154fake_driver);
>  }
>  

I am fine with this patch once the hwsim driver is merged.

regards
Stefan Schmidt
