Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35959 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbDMJZW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Apr 2015 05:25:22 -0400
Received: by pdea3 with SMTP id a3so101166446pde.3
        for <linux-wpan@vger.kernel.org>; Mon, 13 Apr 2015 02:25:22 -0700 (PDT)
Message-ID: <552B8B6E.5060909@gmail.com>
Date: Mon, 13 Apr 2015 14:55:02 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: fix ieee802154_register_hw
 error handling
References: <1428916139-18593-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1428916139-18593-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On 04/13/2015 02:38 PM, Alexander Aring wrote:

> Currently if ieee802154_if_add failed, we don't unregister the wpan phy
> which was registrated before. This patch adds a correct error handling

s/registrated/registered

> for unregister the wpan phy when ieee802154_if_add failed.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/mac802154/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 8500378..beece7b 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -166,13 +166,15 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>  	if (IS_ERR(dev)) {
>  		rtnl_unlock();
>  		rc = PTR_ERR(dev);
> -		goto out_wq;
> +		goto out_phy;
>  	}
>  
>  	rtnl_unlock();
>  
>  	return 0;
>  
> +out_phy:
> +	wpan_phy_unregister(local->phy);
>  out_wq:
>  	destroy_workqueue(local->workqueue);
>  out:

--
Thanks,
Varka Bhadram.

