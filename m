Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44960 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeHFMZG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Aug 2018 08:25:06 -0400
Subject: Re: [PATCHv2 wpan-next 2/2] ieee802154: fakelb: add deprecated msg
 while probe
References: <20180714163306.5629-1-aring@mojatatu.com>
 <20180714163306.5629-3-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <bf76081e-890c-f2f2-138c-47d1afdb8e21@datenfreihafen.org>
Date: Mon, 6 Aug 2018 12:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180714163306.5629-3-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org

Hello.

On 07/14/2018 06:33 PM, Alexander Aring wrote:
> Since mac802154_hwsim the fakelb driver will get deprecated. This patch will
> notifier all users of fakelb to switch to the new mac802154_hwsim driver.
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  drivers/net/ieee802154/fakelb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
> index 0d673f7682ee..3136278b10be 100644
> --- a/drivers/net/ieee802154/fakelb.c
> +++ b/drivers/net/ieee802154/fakelb.c
> @@ -254,6 +254,9 @@ static __init int fakelb_init_module(void)
>  {
>  	ieee802154fake_dev = platform_device_register_simple(
>  			     "ieee802154fakelb", -1, NULL, 0);
> +
> +	pr_warn("fakelb driver is marked as deprecated, please use mac802154_hwsim!\n");
> +
>  	return platform_driver_register(&ieee802154fake_driver);
>  }
>  
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
