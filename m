Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34708 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbE1H2T (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 03:28:19 -0400
Received: by pabru16 with SMTP id ru16so17229861pab.1
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 00:28:19 -0700 (PDT)
Message-ID: <5566C37A.6060508@gmail.com>
Date: Thu, 28 May 2015 12:57:54 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: update initial transmit power
 value
References: <1432795860-16462-1-git-send-email-varkab@cdac.in> <1432795860-16462-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1432795860-16462-2-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

On 05/28/2015 12:20 PM, Varka Bhadram wrote:

> CC2520 has the default 0dBm transmit power level  on reset.
> This patch update initial value of transmit power with 0dBm value.

CC2520 has the 0dBm value on reset, but in the driver we are setting
tx power value to 5dBm.

> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   drivers/net/ieee802154/cc2520.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index a20e6d4..94347d4 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -708,6 +708,8 @@ static int cc2520_register(struct cc2520_private *priv)
>   	priv->hw->phy->supported.tx_powers = cc2520_powers;
>   	priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_powers);
>   
> +	priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[4];
> +

This has to be:

priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[0];

>   	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
>   	ret = ieee802154_register_hw(priv->hw);
>   	if (ret)

-- 
Varka Bhadram

