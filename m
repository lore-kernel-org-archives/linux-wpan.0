Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:34730 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbdKFPdB (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 6 Nov 2017 10:33:01 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH 10/14] ieee802154: ca8210: use __func__ macro for debug
 messages
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-11-stefan@osg.samsung.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <4af3a24a-65a9-2116-2712-fe544a3ef89a@cascoda.com>
Date: Mon, 6 Nov 2017 15:32:55 +0000
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-11-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, varkabhadram@gmail.com, alan@signal11.us

On 22/09/2017 13:14, Stefan Schmidt wrote:
> Instead of having the function name hard-coded (it might change and we
> forgot to update them in the debug output) we can use __func__ instead
> and also shorter the line so we do not need to break it.
> Found by checkpatch.
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   drivers/net/ieee802154/ca8210.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 66829055aa8b..26e04c9176a4 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -924,7 +924,7 @@ static int ca8210_spi_transfer(
>   	priv = spi_get_drvdata(spi);
>   	reinit_completion(&priv->spi_transfer_complete);
>   
> -	dev_dbg(&spi->dev, "ca8210_spi_transfer called\n");
> +	dev_dbg(&spi->dev, "%s called\n", __func__);
>   
>   	cas_ctl = kmalloc(sizeof(*cas_ctl), GFP_ATOMIC);
>   	if (!cas_ctl)
> @@ -1898,7 +1898,7 @@ static int ca8210_net_rx(struct ieee802154_hw *hw, u8 *command, size_t len)
>   	unsigned long flags;
>   	u8 status;
>   
> -	dev_dbg(&priv->spi->dev, "ca8210_net_rx(), CmdID = %d\n", command[0]);
> +	dev_dbg(&priv->spi->dev, "%s: CmdID = %d\n", __func__, command[0]);
>   
>   	if (command[0] == SPI_MCPS_DATA_INDICATION) {
>   		/* Received data */
> @@ -1948,7 +1948,7 @@ static int ca8210_skb_tx(
>   	struct secspec secspec;
>   	unsigned int mac_len;
>   
> -	dev_dbg(&priv->spi->dev, "ca8210_skb_tx() called\n");
> +	dev_dbg(&priv->spi->dev, "%s called\n", __func__);
>   
>   	/* Get addressing info from skb - ieee802154 layer creates a full
>   	 * packet
> @@ -2051,7 +2051,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>   	struct ca8210_priv *priv = hw->priv;
>   	int status;
>   
> -	dev_dbg(&priv->spi->dev, "calling ca8210_xmit_async()\n");
> +	dev_dbg(&priv->spi->dev, "calling %s\n", __func__);
>   
>   	priv->tx_skb = skb;
>   	priv->async_tx_pending = true;

Acked-by: Harry Morris <h.morris@cascoda.com>
