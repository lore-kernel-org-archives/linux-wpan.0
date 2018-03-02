Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:36826 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424220AbeCBKlG (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 2 Mar 2018 05:41:06 -0500
Subject: Re: [PATCH][next] ieee802154: remove unused variable 'val'
References: <20180301144019.14321-1-colin.king@canonical.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <dc14d4c6-e58a-ab13-ad75-efc71ff454e8@osg.samsung.com>
Date: Fri, 2 Mar 2018 11:41:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180301144019.14321-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Colin King <colin.king@canonical.com>, Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.


On 03/01/2018 03:40 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable 'val' is not being initialized and is later being logically
> or'd with DAR_PHY_CTRL4_PROMISCUOUS. Considering this variable is never
> being read anyway we may as well remove val altogether.
>
> Cleans up error detected by cppcheck:
> drivers/net/ieee802154/mcr20a.c:732: (error) Uninitialized variable: val
>
> Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ieee802154/mcr20a.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index d9eb22a52551..55a22c761808 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -723,13 +723,11 @@ mcr20a_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
>  	struct mcr20a_local *lp = hw->priv;
>  	int ret;
>  	u8 rx_frame_filter_reg = 0x0;
> -	u8 val;
>  
>  	dev_dbg(printdev(lp), "%s(%d)\n", __func__, on);
>  
>  	if (on) {
>  		/* All frame types accepted*/
> -		val |= DAR_PHY_CTRL4_PROMISCUOUS;
>  		rx_frame_filter_reg &= ~(IAR_RX_FRAME_FLT_FRM_VER);
>  		rx_frame_filter_reg |= (IAR_RX_FRAME_FLT_ACK_FT |
>  				  IAR_RX_FRAME_FLT_NS_FT);

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
