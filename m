Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60414 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbH0NZ0 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 09:25:26 -0400
Subject: Re: [RFC bluetooth-next 07/21] mrf24j40: add random extended addr
 generation
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-8-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF0FC3.7070108@osg.samsung.com>
Date: Thu, 27 Aug 2015 15:25:23 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-8-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> The mrf24j40 has no source to get a permanent extended address. This
> patch will add a random generated permanent extended address source.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 4051310..e92b29a 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -722,6 +722,7 @@ err_ret:
>   
>   static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
>   {
> +	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
>   	devrec->hw->phy->current_channel = 11;
>   }
>   

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
