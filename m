Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:49712 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeGEJih (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Jul 2018 05:38:37 -0400
Subject: Re: [PATCH] net: ieee802154: adf7242: Fix erroneous RX enable
References: <20180625134951.14227-1-alexandru.ardelean@analog.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <1a000597-d474-a5c8-7a03-e852d6ca08e0@datenfreihafen.org>
Date: Thu, 5 Jul 2018 11:30:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180625134951.14227-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>, linux-wpan@vger.kernel.org, Michael.Hennerich@analog.com, stefan@osg.samsung.com

Hello.

[Just back from a a few weeks leave and catching up]

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

What is the difference between the CMD_RC_PHY_RDY and the CMD_RC_RX
command here. From the commit log I would have expected the if check but
not a change in the issued command?

regards
Stefan Schmidt
