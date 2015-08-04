Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55974 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbbHDQ3J (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 4 Aug 2015 12:29:09 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFCv3 bluetooth-next 1/6] mac802154: cfg: remove test and set
 checks
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-2-git-send-email-alex.aring@gmail.com>
Message-ID: <55C0E852.9080909@osg.samsung.com>
Date: Tue, 4 Aug 2015 18:29:06 +0200
MIME-Version: 1.0
In-Reply-To: <1438246542-17633-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 30/07/15 10:55, Alexander Aring wrote:
> This patch removes several checks if a value is really changed. This
> makes only sense if we have another layer call e.g. calling the
> driver_ops which is done by callbacks like "set_channel".
>
> For MAC settings which need to be set by phy registers (if the phy
> supports that handling) this is set by doing an interface up currently
> and are not direct driver_ops calls, so we remove the checks from these
> configuration callbacks.
>
> Suggested-by: Phoebe Buckheister<phoebe.buckheister@itwm.fraunhofer.de>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---

I always found these checks comforting so see. But given that we don't 
really need them and are only double checking here when we already did I 
think its fine to remove them.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt

>   net/mac802154/cfg.c | 16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index f7ba51e..cecfcda 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -209,10 +209,6 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
>   {
>   	ASSERT_RTNL();
>   
> -	if (wpan_dev->min_be == min_be &&
> -	    wpan_dev->max_be == max_be)
> -		return 0;
> -
>   	wpan_dev->min_be = min_be;
>   	wpan_dev->max_be = max_be;
>   	return 0;
> @@ -224,9 +220,6 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
>   {
>   	ASSERT_RTNL();
>   
> -	if (wpan_dev->short_addr == short_addr)
> -		return 0;
> -
>   	wpan_dev->short_addr = short_addr;
>   	return 0;
>   }
> @@ -238,9 +231,6 @@ ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
>   {
>   	ASSERT_RTNL();
>   
> -	if (wpan_dev->csma_retries == max_csma_backoffs)
> -		return 0;
> -
>   	wpan_dev->csma_retries = max_csma_backoffs;
>   	return 0;
>   }
> @@ -252,9 +242,6 @@ ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
>   {
>   	ASSERT_RTNL();
>   
> -	if (wpan_dev->frame_retries == max_frame_retries)
> -		return 0;
> -
>   	wpan_dev->frame_retries = max_frame_retries;
>   	return 0;
>   }
> @@ -265,9 +252,6 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
>   {
>   	ASSERT_RTNL();
>   
> -	if (wpan_dev->lbt == mode)
> -		return 0;
> -
>   	wpan_dev->lbt = mode;
>   	return 0;
>   }

