Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53443 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754214AbeGIJBd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Jul 2018 05:01:33 -0400
Subject: Re: [PATCH] net: ieee802154: adf7242: Fix erroneous RX enable
References: <20180625134951.14227-1-alexandru.ardelean@analog.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <3028fa25-12c2-2182-b98e-22e165f2ec22@datenfreihafen.org>
Date: Mon, 9 Jul 2018 11:01:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180625134951.14227-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>, linux-wpan@vger.kernel.org, Michael.Hennerich@analog.com, stefan@osg.samsung.com

Hello Alexandru.

On 25.06.2018 15:49, Alexandru Ardelean wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Only enable RX mode if the netdev is opened.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/net/ieee802154/adf7242.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index 3e85e9500233..0a240a3f7817 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -739,7 +739,10 @@ static int adf7242_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>  	adf7242_write_reg(lp, REG_CH_FREQ1, freq >> 8);
>  	adf7242_write_reg(lp, REG_CH_FREQ2, freq >> 16);
>  
> -	return adf7242_cmd(lp, CMD_RC_RX);
> +	if (test_bit(FLAG_START, &lp->flags))
> +		return adf7242_cmd_rx(lp);
> +	else
> +		return adf7242_cmd(lp, CMD_RC_PHY_RDY);
>  }
>  
>  static int adf7242_set_hw_addr_filt(struct ieee802154_hw *hw,
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
