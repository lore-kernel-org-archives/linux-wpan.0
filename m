Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:54694 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeEQUkh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 May 2018 16:40:37 -0400
Received: by mail-it0-f67.google.com with SMTP id z6-v6so10518690iti.4
        for <linux-wpan@vger.kernel.org>; Thu, 17 May 2018 13:40:36 -0700 (PDT)
Date: Thu, 17 May 2018 16:40:29 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC PATCH wpan-next 2/2] ieee802154: fakelb: add deprecated msg
 while probe
Message-ID: <20180517204029.r447wupg22qvof6w@x220t>
References: <20180427212154.29582-1-aring@mojatatu.com>
 <20180427212154.29582-3-aring@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427212154.29582-3-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Fri, Apr 27, 2018 at 05:21:54PM -0400, Alexander Aring wrote:
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

I can mess up the smallest patches, there is a missing newline. :-)

- Alex
